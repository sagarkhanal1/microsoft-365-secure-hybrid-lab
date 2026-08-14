# Evidence Handling

Only sanitised evidence may be committed to this repository.

## Never publish

- Passwords or temporary passwords
- MFA QR codes, recovery codes, or approval details
- Payment cards, billing profiles, addresses, or phone numbers
- Tenant IDs, object IDs, application IDs, or subscription IDs
- Full user principal names or personal email addresses
- IP addresses or device serial numbers
- Correlation IDs or diagnostic tokens
- Browser profiles, bookmarks, or unrelated personal tabs
- Real employer, colleague, client, or child information

## Filename convention

Use:

`<TEST-ID>-<short-description>.<extension>`

Examples:

- `AC-001-standard-user-admin-access-denied.png`
- `RBAC-001-helpdesk-role-assignment.png`
- `HD-001-password-reset-audit-success.png`

## Recommended folders

- `evidence/identity/`
- `evidence/access-control/`
- `evidence/audit-logs/`
- `evidence/conditional-access/`
- `evidence/intune/`
- `evidence/hybrid-identity/`

Folders will appear in Git after the first sanitised file is added.

## Sanitisation checklist

1. Duplicate the original screenshot; never edit the only copy.
2. Crop unrelated content.
3. Apply opaque redaction—not transparent blur—to sensitive values.
4. Check the entire image, including browser chrome and side panels.
5. Export the sanitised copy.
6. Reopen it and inspect at full resolution.
7. Commit only the sanitised copy.
8. Keep raw evidence outside the Git repository.

A private repository is not a substitute for sanitisation because sensitive files remain in Git history if the repository is later made public.
