# Microsoft Graph PowerShell Automation

## Current status

The automation phase is paused after a successful first CSV-driven joiner execution. User creation and security-group assignment work; licence assignment and conversion into a reusable script remain pending.

## Least-privilege progression

The Graph SDK was installed for the current Windows user. Authentication used delegated device-code flow.

Permissions were introduced in stages:

1. `User.Read.All` and `Group.Read.All` for inventory and validation.
2. `User.ReadWrite.All` and `GroupMember.ReadWrite.All` for joiner execution.
3. Licence-related scopes were planned but not used before the pause.

Broad `Directory.ReadWrite.All` permission was intentionally avoided.

## CSV input

`scripts/joiners.csv` contains fictional onboarding data only:

- First and last name
- Department
- Job title
- Target security group
- Usage location

Passwords, tenant identifiers, object identifiers, and licence GUIDs are not stored in the CSV.

## Validation performed

The interactive PowerShell exercise demonstrated:

- Variables and object properties
- CSV import
- Arrays and the `@(...)` array operator
- `foreach` loops
- String formatting and username construction
- Microsoft Graph filters
- `if`/`else` decisions
- `$null` checks
- Pipeline filtering with `Where-Object`
- Duplicate-user prevention for idempotency

Before the write operation, the workflow confirmed that the CSV row was readable, the requested group existed, and the proposed username was available.

## Joiner execution

The first fictional joiner was created with:

- Enabled account
- Generated temporary password held only in memory
- Mandatory password change at first sign-in
- Department, job title, and Australian usage location
- Membership in `SG-IT-Employees`

The temporary password was not stored in the repository. Graph object IDs and authentication/device codes were also excluded from evidence.

## Remaining automation work

- Add licence availability checks and assignment.
- Consolidate the interactive commands into a reusable `.ps1` script.
- Add `-WhatIf` or dry-run behaviour.
- Add structured error handling and audit output.
- Test repeat execution and rollback.
- Extend the pattern to mover and leaver functions.
