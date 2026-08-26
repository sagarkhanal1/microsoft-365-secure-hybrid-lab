# Test Register

## Status definitions

- **PASS:** Actual result matches the expected result.
- **FAIL:** Actual result differs from the expected result.
- **PENDING:** Test has not been executed.
- **EVIDENCE PENDING:** Functional result confirmed; supporting log or screenshot is not yet available.

## Tests

| Test ID | Control | Expected result | Actual result | Status |
|---|---|---|---|---|
| `ID-001` | Cloud-only user creation | User is a Member and on-premises sync is No | Expected properties observed | PASS |
| `ID-002` | First sign-in password control | User must replace temporary password | Password change required and completed | PASS |
| `MFA-001` | Employee MFA registration | Authenticator can be registered for the employee identity | Registration completed | PASS |
| `GRP-001` | HR security-group membership | HR employee appears as a member of `SG-HR-Employees` | Membership verified | PASS |
| `LIC-001` | Business Premium entitlement | Licensed employee can reach Microsoft 365 services | Microsoft 365 home reached | PASS |
| `AC-001` | Standard user admin restriction | Standard HR user cannot administer Microsoft 365 | Admin Center returned a permission-denied message | PASS |
| `RBAC-001` | Delegated helpdesk role | Technician has Helpdesk Administrator and no additional admin role | Exactly one role verified | PASS |
| `HD-001` | Helpdesk password reset | Helpdesk Administrator can reset a standard employee password | Password reset completed | PASS — EVIDENCE PENDING |
| `HD-002` | Privileged-account restriction | Helpdesk Administrator cannot reset a Global Administrator password | Password reset was denied | PASS |
| `MOV-001` | Mover workflow | Department access changes without an unintended access gap | HR-only, overlapping transition, and IT-only states verified | PASS |
| `CA-001` | MFA report-only pilot | Report-only policy records expected decisions without blocking users | Standard-user evaluation succeeded; emergency account exclusion was not applied | PASS |
| `CA-002` | Compliant-device report-only positive path | Compliant managed browser session satisfies the control | Report-only evaluation succeeded | PASS |
| `CA-003` | Compliant-device report-only negative path | Unmanaged/private session fails the control | Report-only evaluation failed as expected | PASS |
| `CA-004` | Compliant-device enforced negative path | Unmanaged/private session is blocked | Access was blocked | PASS |
| `CA-005` | Compliant-device enforced positive path | Managed compliant session is allowed | Access succeeded and policy result was Success | PASS |
| `INT-001` | Device enrollment | Windows 11 pilot appears as an Intune-managed corporate device | Device `PC1` enrolled successfully | PASS |
| `INT-002` | Device compliance | Pilot evaluates against the compliance policy | All configured settings reported compliant | PASS |
| `INT-003` | Security baseline | Pilot receives the Windows security baseline | Initial VBS error remediated; final deployment succeeded | PASS |
| `AUT-001` | Graph delegated connection | Requested Graph scopes are available after interactive authentication | Read-only and scoped write sessions connected successfully | PASS |
| `AUT-002` | CSV joiner validation | CSV row, target group, and username are validated before creation | Noah Wilson row, group, and available username validated | PASS |
| `AUT-003` | CSV joiner execution | New user is created and added to the requested group | User created and membership verified | PASS — LICENSING PENDING |
| `HYB-001` | Hybrid identity | Selected on-premises identity synchronises with correct source-of-authority behaviour | Not implemented | PENDING |

## HD-001 evidence note

The password reset succeeded, but no screenshot was captured during execution. The tenant was newly provisioned and the relevant audit event was not yet visible when checked. The action will not be repeated solely to manufacture evidence. Audit availability will be checked after the new-tenant reporting delay; if the original event is unavailable, a separate legitimate simulated ticket will be executed and documented.

This evidence-pending state preserves the distinction between a confirmed functional result and an independently reviewable audit record.
