# Implementation Roadmap

## Phase 1 — Foundation and baseline

- [x] Provision isolated Microsoft 365 Business Premium lab tenant
- [x] Disable recurring billing
- [x] Register MFA for the initial Global Administrator
- [x] Review Security Defaults
- [x] Document the tenant baseline

## Phase 2 — Identity lifecycle and RBAC

- [x] Create cloud-only employee identity
- [x] Create departmental security group
- [x] Assign Microsoft 365 licence
- [x] Validate first-sign-in password change and MFA registration
- [x] Validate standard-user administrative denial
- [x] Delegate Helpdesk Administrator role
- [x] Execute standard-user password-reset ticket
- [ ] Validate privileged-account reset restrictions
- [ ] Design and test mover workflow
- [ ] Design and test leaver workflow

## Phase 3 — Conditional Access

- [ ] Create emergency-access design and rollback procedure
- [ ] Map Security Defaults controls to planned policies
- [ ] Build policies in report-only mode
- [ ] Require MFA for appropriate users and applications
- [ ] Evaluate compliant-device access
- [ ] Review sign-in logs before enforcement

## Phase 4 — Intune endpoint management

- [ ] Define enrolment scope
- [ ] Enrol a Windows test device
- [ ] Create configuration profiles
- [ ] Create compliance policy
- [ ] Deploy security baseline
- [ ] Test compliant and noncompliant access paths
- [ ] Document remediation workflow

## Phase 5 — Automation

- [ ] Connect with Microsoft Graph PowerShell using least privilege
- [ ] Build CSV-driven joiner workflow
- [ ] Add validation, error handling, and audit output
- [ ] Build mover and leaver functions
- [ ] Test idempotency and rollback behaviour
- [ ] Publish sanitised scripts

## Phase 6 — Hybrid identity

- [ ] Assess existing Windows Server AD lab
- [ ] Plan namespace and identity-matching strategy
- [ ] Confirm current Microsoft synchronisation prerequisites
- [ ] Implement a limited pilot
- [ ] Validate source of authority and sign-in behaviour
- [ ] Document failure and recovery tests

## Phase 7 — Recruiter presentation

- [ ] Complete evidence sanitisation review
- [ ] Add final architecture and workflow diagrams
- [ ] Write executive summary and lessons learned
- [ ] Map project evidence to SysAdmin job requirements
- [ ] Publish repository after security review
- [ ] Prepare concise LinkedIn case-study post
