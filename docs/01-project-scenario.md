# Project Scenario and Requirements

## Organisation

Northstar Fitness Group is a fictional 25-user organisation used to model a realistic Microsoft 365 administration engagement. The environment is deliberately small enough for a lab while retaining the identity, endpoint, security, and support requirements common to a growing business.

## Problem statement

The organisation needs to move beyond individually managed accounts and devices. It requires a repeatable employee lifecycle, secure access to Microsoft 365, delegated support responsibilities, auditable administrative activity, and a future integration path from on-premises Active Directory.

## Business requirements

1. Employees must receive access according to job function.
2. Administrative privileges must follow least privilege.
3. Multifactor authentication must protect identities.
4. Joiner, mover, and leaver actions must be repeatable and auditable.
5. Company devices must eventually be enrolled, configured, and evaluated for compliance.
6. Access policies must be tested before enforcement to reduce lockout risk.
7. Routine identity tasks should be automated with Microsoft Graph PowerShell.
8. On-premises identities should eventually have a controlled hybrid identity path.
9. Every implemented control must have an expected result, actual result, and sanitised evidence.

## Success criteria

- A standard employee can access licensed services but not tenant administration.
- A delegated helpdesk technician can perform approved support tasks without Global Administrator access.
- Conditional Access policies are tested in report-only mode before enforcement.
- A managed Windows test device reports compliance through Intune.
- Joiner and leaver workflows produce consistent, reviewable results.
- Hybrid identity behaviour and source of authority are clearly documented.
- No sensitive tenant data or credentials are exposed in the public repository.

## Scope statement

This is a simulated personal lab, not a production deployment or representation of client work. Configuration choices are evaluated for educational purposes and would require organisational approval, change control, backup, and rollback planning before production use.
