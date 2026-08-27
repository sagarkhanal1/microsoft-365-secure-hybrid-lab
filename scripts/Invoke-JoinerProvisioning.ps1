[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$CsvPath,

    [Parameter(Mandatory)]
    [string]$TenantDomain,

    [string]$LicenseSku = "SPB"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Remove accidental spaces or a leading @ from the tenant domain.
$TenantDomain =
    $TenantDomain.Trim().TrimStart("@").ToLowerInvariant()

# Confirm that the CSV file exists.
if (-not (Test-Path -LiteralPath $CsvPath -PathType Leaf)) {
    throw "CSV file not found: $CsvPath"
}

# @() guarantees that Count works even when the CSV has one row.
$joiners = @(Import-Csv -LiteralPath $CsvPath)

if ($joiners.Count -eq 0) {
    throw "The CSV contains no employee records."
}

# Columns that must exist in the CSV.
$requiredHeaders = @(
    "FirstName"
    "LastName"
    "Department"
    "JobTitle"
    "GroupName"
    "UsageLocation"
)

$actualHeaders = $joiners[0].PSObject.Properties.Name

$missingHeaders = @(
    $requiredHeaders |
        Where-Object { $_ -notin $actualHeaders }
)

if ($missingHeaders.Count -gt 0) {
    throw "Missing CSV columns: $($missingHeaders -join ', ')"
}

Write-Host `
    "CSV validation passed: $($joiners.Count) employee record(s)." `
    -ForegroundColor Green

# Microsoft Graph permissions required by the finished script.
$requiredScopes = @(
    "User.ReadWrite.All"
    "GroupMember.ReadWrite.All"
    "Organization.Read.All"
    "LicenseAssignment.ReadWrite.All"
)

$context = Get-MgContext
$currentScopes = @()

if ($null -ne $context) {
    $currentScopes = @($context.Scopes)
}

$missingScopes = @(
    $requiredScopes |
        Where-Object { $_ -notin $currentScopes }
)

if ($missingScopes.Count -gt 0) {
    Write-Host `
        "Connecting to Microsoft Graph..." `
        -ForegroundColor Cyan

    Connect-MgGraph `
        -Scopes $requiredScopes `
        -UseDeviceAuthentication `
        -NoWelcome

    $context = Get-MgContext
    $currentScopes = @($context.Scopes)

    $missingScopes = @(
        $requiredScopes |
            Where-Object { $_ -notin $currentScopes }
    )
}

if ($missingScopes.Count -gt 0) {
    throw "Missing Graph permissions: $($missingScopes -join ', ')"
}

Write-Host `
    "Microsoft Graph permission validation passed." `
    -ForegroundColor Green

# Safety lock while we are constructing and testing the script.
if (-not $WhatIfPreference) {
    throw "Script construction is not complete. Run it with -WhatIf."
}

# Find the requested licence SKU.
$skuMatches = @(
    Get-MgSubscribedSku -All |
        Where-Object {
            $_.SkuPartNumber -eq $LicenseSku
        }
)

if ($skuMatches.Count -eq 0) {
    throw "Licence SKU not found: $LicenseSku"
}

if ($skuMatches.Count -gt 1) {
    throw "More than one licence SKU matched: $LicenseSku"
}

$license = $skuMatches[0]

$availableLicences =
    $license.PrepaidUnits.Enabled - $license.ConsumedUnits

Write-Host `
    "Licence validation passed." `
    -ForegroundColor Green

Write-Host "SKU: $LicenseSku"
Write-Host "Available licences: $availableLicences"

# Build a preview for every employee in the CSV.
$preview = foreach ($joiner in $joiners) {

    # Check for empty fields in the current row.
    $missingValues = @(
        $requiredHeaders |
            Where-Object {
                [string]::IsNullOrWhiteSpace(
                    [string]$joiner.$_
                )
            }
    )

    if ($missingValues.Count -gt 0) {
        throw `
            "Employee row has empty values: $($missingValues -join ', ')"
    }

    $displayName =
        "$($joiner.FirstName.Trim()) $($joiner.LastName.Trim())"

    # Build an alias such as noah.wilson.
    $alias = (
        "{0}.{1}" -f `
            $joiner.FirstName.Trim(),
            $joiner.LastName.Trim()
    ).ToLowerInvariant() -replace "[^a-z0-9.-]", ""

    # Build the complete Microsoft 365 username.
    $userPrincipalName = "$alias@$TenantDomain"

    # Escape apostrophes before using a value in an OData filter.
    $safeDisplayName =
        $displayName.Replace("'", "''")

    $safeGroupName =
        $joiner.GroupName.Trim().Replace("'", "''")

    # Directly look for an existing user using the generated UPN.
    $existingUsers = @(
        Get-MgUser `
            -UserId $userPrincipalName `
            -Property Id,DisplayName,UserPrincipalName `
            -ErrorAction SilentlyContinue
    )

    # Diagnostic lookup using the employee's display name.
    $displayNameMatches = @(
        Get-MgUser `
            -Filter "displayName eq '$safeDisplayName'" `
            -Property Id,DisplayName,UserPrincipalName
    )

    # Find the requested security group.
    $matchingGroups = @(
        Get-MgGroup `
            -Filter "displayName eq '$safeGroupName'"
    )

    $actualAlias = ""
    $actualUpnLength = 0
    $exactUpnMatch = $false

    if ($matchingGroups.Count -eq 0) {
        throw "Target group not found: $($joiner.GroupName)"
    }

    if ($matchingGroups.Count -gt 1) {
        throw "Multiple groups found with the name: $($joiner.GroupName)"
    }

    $targetGroup = $matchingGroups[0]
    $isGroupMember = $false

    if ($existingUsers.Count -eq 1) {
        $groupMembers = @(
            Get-MgGroupMember `
                -GroupId $targetGroup.Id `
                -All
        )

        $isGroupMember =
            $existingUsers[0].Id -in $groupMembers.Id
    }
    if ($displayNameMatches.Count -eq 1) {
        $actualUpn =
            $displayNameMatches[0].UserPrincipalName

        $actualAlias =
            ($actualUpn -split "@")[0]

        $actualUpnLength =
            $actualUpn.Length

        $exactUpnMatch =
            $userPrincipalName -ieq $actualUpn
    }

    if ($existingUsers.Count -eq 0) {
        if (
            $PSCmdlet.ShouldProcess(
                $userPrincipalName,
                "Create Microsoft 365 user"
            )
        ) {
            $temporaryPassword =
                [System.Web.Security.Membership]::GeneratePassword(16, 4)

            $passwordProfile = @{
                Password                      = $temporaryPassword
                ForceChangePasswordNextSignIn = $true
            }

            New-MgUser `
                -AccountEnabled `
                -DisplayName $displayName `
                -UserPrincipalName $userPrincipalName `
                -MailNickname $alias `
                -Department $joiner.Department `
                -JobTitle $joiner.JobTitle `
                -UsageLocation $joiner.UsageLocation `
                -PasswordProfile $passwordProfile
        }
    }
    else {
        Write-Host `
            "Skipping $displayName because the user already exists." `
            -ForegroundColor Yellow
    }

    # These fields help diagnose the UPN without displaying the domain.
    [PSCustomObject]@{
        DisplayName       = $displayName
        GeneratedAlias    = $alias
        ActualAlias       = $actualAlias
        GeneratedLength   = $userPrincipalName.Length
        ActualLength      = $actualUpnLength
        ExactUpnMatch     = $exactUpnMatch
        Department        = $joiner.Department
        TargetGroup       = $joiner.GroupName
        UserExists        = ($existingUsers.Count -eq 1)
        GroupExists       = ($matchingGroups.Count -eq 1)
        AlreadyInGroup    = $isGroupMember
        PlannedAction     = if ($existingUsers.Count -eq 1) {
            "Skip - user already exists"
        }
        else {
            "Create user"
        }
    }
}

$preview | Format-Table -AutoSize
