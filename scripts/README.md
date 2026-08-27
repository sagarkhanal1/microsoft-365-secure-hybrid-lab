# Automation Scripts

## Joiner provisioning draft

`Invoke-JoinerProvisioning.ps1` is a learning-focused Microsoft Graph PowerShell script. It reads fictional joiner data from `joiners.csv`, validates the environment, and previews onboarding decisions.

The script currently supports:

- Mandatory parameters and a default licence SKU
- CSV existence, header, row, and empty-value validation
- Microsoft Graph scope validation
- Licence SKU lookup and availability calculation
- Normalised UPN generation
- Existing-user detection and duplicate prevention
- Exact target-group validation
- Existing group-membership detection
- `ShouldProcess` and `-WhatIf`
- An additional safety lock that prevents live execution

Group changes and licence assignment are not complete. Do not remove the safety lock until those stages have been implemented and reviewed.

## Safe example

```powershell
& ".\scripts\Invoke-JoinerProvisioning.ps1" `
    -CsvPath ".\scripts\joiners.csv" `
    -TenantDomain "contoso.onmicrosoft.com" `
    -WhatIf
```

Replace the example domain locally. Do not commit a real tenant domain, password, authentication code, access token, or object ID.

## Planned scripts

- Completed joiner provisioning with group and licence assignment
- Mover workflow
- Leaver workflow with session revocation and access removal
- Reporting and validation helpers
