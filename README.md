# Microsoft 365 Secure Hybrid Workplace Lab

A hands-on Microsoft 365 administration project that designs, implements, tests, and documents a secure cloud workplace for a simulated 25-user organisation.

> **Status:** In progress — identity, Conditional Access, and Intune pilot phases completed; Microsoft Graph automation paused after the first successful joiner execution.

## Project objective

This project goes beyond basic portal configuration. Each control is linked to a business requirement, validated through positive and negative tests, and supported by sanitised evidence.

The lab currently covers:

- Microsoft Entra ID tenant baseline and security defaults
- Cloud-only identity onboarding
- Security-group-based access design
- Microsoft 365 Business Premium licensing
- Multifactor authentication registration
- Least-privilege administrative role delegation
- Password-reset support workflow
- Access-control testing and audit-evidence planning
- Identity mover and leaver workflows
- Emergency-access accounts and Conditional Access exclusions
- Report-only and enforced MFA/compliant-device policies
- Windows 11 enrollment, compliance, BitLocker, and security baselines
- Microsoft Graph PowerShell with delegated least-privilege scopes
- CSV-driven user creation and security-group assignment

Remaining phases include completing Microsoft Graph automation, hybrid identity integration with Windows Server Active Directory, and final recruiter-focused documentation.

## Business scenario

**Northstar Fitness Group** is a fictional 25-user organisation adopting Microsoft 365 Business Premium. It needs secure employee onboarding, role-based access, auditable support operations, managed Windows endpoints, and a controlled path between on-premises Active Directory and Microsoft Entra ID.

This is a personal lab project. It does not represent production work performed for a real client.

## Current architecture

```mermaid
flowchart TD
    A["Microsoft Entra ID"] --> U["Cloud users"]
    A --> G["Security groups"]
    A --> R["Admin roles"]
    U --> M["Microsoft 365 services"]
    G --> X["Resource access"]
    R --> H["Delegated support"]
    I["Intune and endpoints"] --> A
    P["Conditional Access"] --> A
    GPH["Graph PowerShell"] --> A
    D["On-premises AD DS"] -. planned hybrid identity .-> A
```

## Implemented controls

| Control | Implementation | Validation |
|---|---|---|
| Administrative account protection | MFA registered for the initial Global Administrator | Authenticator registration completed |
| Baseline tenant protection | Security Defaults enabled | Configuration reviewed without modification |
| Cloud employee onboarding | HR Coordinator account created as a cloud-only member | User type and sync state verified |
| Group-based access | `SG-HR-Employees` security group created | HR employee membership verified |
| Service entitlement | Business Premium licence assigned to HR user | Microsoft 365 sign-in completed |
| First-sign-in protection | Temporary password change and MFA registration completed | User onboarding tested |
| Standard-user restriction | HR user attempted to open Microsoft 365 Admin Center | Access denied — `AC-001 PASS` |
| Delegated support | Helpdesk Administrator role assigned to an IT support identity | Exactly one admin role verified |
| Password reset | Helpdesk identity reset a standard user's password | Operation completed — `HD-001 PASS`; audit evidence pending |
| Privileged reset protection | Helpdesk attempted to reset a Global Administrator | Operation denied — `HD-002 PASS` |
| Mover workflow | Employee transferred from HR to IT using controlled overlapping membership | Before, transition, and after states validated |
| Conditional Access | MFA and compliant-device controls tested before enforcement | Report-only decisions and enforced allow/block paths validated |
| Intune compliance | Windows 11 VirtualBox pilot enrolled and evaluated | BitLocker, Secure Boot, firewall, antimalware, and OS controls compliant |
| Endpoint baseline | Windows security baseline assigned to pilot group | Initial VBS error remediated; final deployment succeeded |
| Graph automation | Delegated Graph session used for a CSV joiner | User created and added to the requested security group; licensing paused |

## Documentation

- [Project scenario and requirements](docs/01-project-scenario.md)
- [Tenant baseline](docs/02-tenant-baseline.md)
- [Identity and RBAC implementation](docs/03-identity-and-rbac.md)
- [Test register](docs/04-test-register.md)
- [Roadmap](docs/05-roadmap.md)
- [Conditional Access and Intune implementation](docs/06-conditional-access-and-intune.md)
- [Microsoft Graph automation progress](docs/07-graph-automation.md)
- [Evidence-handling rules](evidence/README.md)

## Security and privacy

No passwords, temporary credentials, MFA QR codes, tenant IDs, object IDs, billing details, private IP addresses, correlation IDs, or real employee data are stored in this repository. All users and business details used in demonstrations are fictional.

## Skills demonstrated

Microsoft Entra ID · Microsoft 365 Admin Center · Identity lifecycle · RBAC · Least privilege · MFA · Conditional Access · Microsoft Intune · Windows 11 · BitLocker · Security baselines · Microsoft Graph PowerShell · CSV automation · Troubleshooting · Technical documentation
