# Tenant Baseline

**Assessment date:** 14 August 2026  
**Environment:** New Microsoft 365 Business Premium trial tenant  
**Region:** Australia

## Confirmed baseline

| Area | Observed state |
|---|---|
| Subscription | Microsoft 365 Business Premium trial |
| Trial capacity | 25 user licences |
| Recurring billing | Disabled |
| Initial administrator | Cloud-only Global Administrator |
| Administrator MFA | Registered with Microsoft Authenticator |
| Security Defaults | Enabled |
| Custom domain | Not configured |
| Initial domain | Microsoft-provided `onmicrosoft.com` domain |
| On-premises synchronisation | Not configured |
| Intune enrolment | Not configured |
| Conditional Access | Not configured |
| Hybrid identity | Not configured |

## Baseline interpretation

Security Defaults supplies an initial identity-security baseline while the tenant is new. It remains enabled until replacement Conditional Access policies, exclusions, test identities, and rollback steps are designed and validated. Disabling it without a tested replacement could create an MFA enforcement gap.

The initial Global Administrator is used only for tenant setup and privileged configuration. Standard user and delegated administrator identities are tested separately to avoid using broad privileges for ordinary tasks.

## Data-handling decision

Tenant IDs, object IDs, administrator usernames, billing details, phone numbers, addresses, passwords, MFA material, and other unique identifiers are intentionally excluded from this document.

## Evidence status

Baseline screenshots will be added only after sanitisation. A screenshot is supporting evidence; the configuration rationale and validation steps remain the primary documentation.
