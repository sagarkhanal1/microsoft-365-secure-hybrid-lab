# Microsoft Graph PowerShell Automation

## Current status

The automation phase is intentionally paused at the safe preview stage. A fictional joiner was previously created interactively and added to `SG-IT-Employees`. The reusable script now validates its input, Graph permissions, licence availability, user identity, and target group, but it is locked to `-WhatIf` and has not yet automated group or licence changes.

## What Microsoft Graph is

Microsoft Graph is the API used to work with Microsoft 365 and Microsoft Entra resources. The Microsoft Graph PowerShell SDK provides commands such as `Get-MgUser`, `New-MgUser`, and `Get-MgGroup`, which send authenticated requests to that API.

## Least-privilege connection

The Graph SDK was installed for the current Windows user. Authentication uses delegated device-code flow and requests these scopes:

- `User.ReadWrite.All`
- `GroupMember.ReadWrite.All`
- `Organization.Read.All`
- `LicenseAssignment.ReadWrite.All`

The script checks the current Graph context and reconnects only when a required scope is missing. Broad `Directory.ReadWrite.All` permission was intentionally avoided.

## CSV input

`scripts/joiners.csv` contains fictional onboarding data only: name, department, job title, target security group, and usage location. Passwords, tenant identifiers, object identifiers, and licence GUIDs are not stored in the CSV.

## PowerShell concepts learned

### Parameters

The `param()` block accepts values when the script starts. `CsvPath` and `TenantDomain` are mandatory; `LicenseSku` defaults to `SPB`. Keeping the tenant domain as a parameter makes the script reusable and prevents a real tenant name from being published.

### Arrays and `@(...)`

`@(...)` always produces an array. This makes `.Count` reliable even when a CSV or Graph query returns zero or one item.

### Pipelines and filtering

The pipeline sends objects from one command to the next. `Where-Object` keeps only objects matching a condition, such as a requested licence SKU or a missing Graph permission.

### Objects and properties

PowerShell passes structured objects rather than only text. Properties are accessed with dot notation, for example `$license.SkuId`. `[PSCustomObject]` creates a clean preview containing selected results.

### Conditional logic

`if`, `else`, `-eq`, `-gt`, `-in`, and `$null` checks control what the script does. These checks prevent duplicate users, reject missing or ambiguous groups, and verify group membership using unique object IDs.

### String construction

The script trims CSV values, builds a lowercase alias, removes unsupported characters, and combines the alias with the tenant-domain parameter to form a UPN. A troubleshooting test demonstrated that a correct alias with the wrong domain is still a different identity.

### Error handling and strict mode

`Set-StrictMode -Version Latest` catches unsafe variable usage. `$ErrorActionPreference = "Stop"` turns command errors into terminating errors. Explicit `throw` statements stop processing when validation fails.

### Idempotency

The script looks up a user by the generated UPN before planning creation. If the user already exists, it reports `Skip - user already exists`. This allows repeat execution without creating duplicate accounts.

### `SupportsShouldProcess` and `-WhatIf`

`[CmdletBinding(SupportsShouldProcess)]` enables PowerShell's standard change-preview mechanism. The script also contains a temporary construction lock that refuses to run unless `-WhatIf` is supplied. This keeps the unfinished automation read-only.

## Validation implemented

The reusable script currently:

1. Confirms that the CSV exists and contains records.
2. Checks all required CSV headers and values.
3. Validates the Microsoft Graph connection and delegated scopes.
4. Finds exactly one requested licence SKU and calculates available units.
5. Normalises the supplied tenant domain.
6. Generates the display name, alias, and UPN.
7. Looks for an existing user using the unique UPN.
8. Diagnoses alias or domain mismatches without displaying the tenant domain.
9. Requires exactly one matching target group.
10. Checks existing group membership using object IDs.
11. Plans either user creation or a safe skip.

The test row for Noah Wilson now reports that the generated identity matches the existing fictional user. The earlier false result was traced to running the script with the placeholder tenant domain rather than the real tenant domain parameter.

## Security controls in the draft

- The temporary password is generated in memory only.
- First sign-in requires a password change.
- Passwords, access tokens, tenant domains, and object IDs are not printed or committed.
- Existing users are not recreated.
- Missing and duplicate group matches stop execution.
- The current script cannot run without `-WhatIf`.

## Example using placeholders

```powershell
& ".\scripts\Invoke-JoinerProvisioning.ps1" `
    -CsvPath ".\scripts\joiners.csv" `
    -TenantDomain "contoso.onmicrosoft.com" `
    -WhatIf
```

`contoso.onmicrosoft.com` is a placeholder. Supply the correct tenant domain locally; do not hard-code it into the public script.

## Remaining automation work

- Complete idempotent group assignment.
- Complete licence-assignment detection and assignment.
- Add structured result and error output.
- Test a new fictional user entirely through `-WhatIf` before enabling writes.
- Remove the temporary `-WhatIf` construction lock only after review.
- Test repeat execution and recovery behaviour.
- Extend the pattern to mover and leaver functions.
