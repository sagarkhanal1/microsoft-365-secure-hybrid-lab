# Identity and RBAC Implementation

## Naming convention

| Prefix or pattern | Purpose | Example |
|---|---|---|
| `firstname.lastname` | User principal-name alias | Fictional employee identity |
| `SG-` | Security group | `SG-HR-Employees` |
| Department attribute | Organisational classification | Human Resources |
| Job title attribute | Business role | HR Coordinator |

## Joiner implementation: HR Coordinator

A fictional HR Coordinator identity was created directly in Microsoft Entra ID.

Confirmed properties:

- User type: Member
- On-premises sync: No
- Department: Human Resources
- Job title: HR Coordinator
- Usage location: Australia
- Administrative roles: None
- Group membership: `SG-HR-Employees`
- Microsoft 365 Business Premium licence: Assigned
- Temporary password change at first sign-in: Completed
- Microsoft Authenticator registration: Completed

Because the identity was created directly in Entra ID and is not synchronised, Microsoft Entra ID is its current source of authority.

## Group-based access design

The `SG-HR-Employees` security group represents HR workforce membership. Access should be granted to the group rather than individually to each employee. During a mover event, removing a transferred employee from this group removes the access paths tied to the group without requiring administrators to find every individual assignment.

## Delegated helpdesk role

A fictional IT Support Technician identity was created as a cloud-only member and assigned exactly one administrative role: **Helpdesk Administrator**.

The role was selected to support common service-desk actions while avoiding Global Administrator privileges. The technician successfully processed a simulated password-reset request for a standard employee.

## Role-versus-group distinction

- A **security group** represents membership or resource access.
- An **administrative role** grants permission to manage part of the tenant.

Placing IT personnel in a general group does not automatically provide administrative authority. Conversely, assigning a broad administrative role solely to solve an application-access issue violates least privilege.

## Offboarding sequence

A future leaver workflow will test this order:

1. Block sign-in.
2. Revoke active sessions.
3. Reset the password where required by procedure.
4. Preserve or transfer mailbox and OneDrive data.
5. Remove group memberships and application access.
6. Remove or reassign the licence.
7. Record and verify every action.
