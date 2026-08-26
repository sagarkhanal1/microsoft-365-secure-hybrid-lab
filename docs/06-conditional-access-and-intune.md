# Conditional Access and Intune Pilot

## Design

The endpoint pilot uses a deliberately limited scope. `SG-Intune-Pilot` controls MDM enrollment and policy assignment, while `SG-Emergency-Access` is excluded from restrictive Conditional Access policies to reduce tenant-lockout risk.

The Conditional Access rollout followed a safe sequence:

1. Review Security Defaults.
2. Create two cloud-only emergency administrator identities.
3. Place emergency identities in the exclusion group.
4. Build custom policies in report-only mode.
5. Review standard-user and excluded-account evaluations.
6. Validate managed and unmanaged device paths.
7. Enable the compliant-device policy only for the pilot group.
8. Repeat positive and negative tests after enforcement.

## Windows 11 pilot

`PC1` is a Windows 11 Pro VirtualBox test device configured with UEFI, Secure Boot, and TPM 2.0. The device was Microsoft Entra joined and enrolled in Intune as a corporate device.

The `WIN11-Pilot-Compliance` policy requires:

- BitLocker
- Secure Boot
- Code integrity
- Minimum OS version `10.0.26200.0`
- Firewall
- Antivirus and antispyware
- Microsoft Defender Antimalware

All configured settings eventually reported compliant.

## Security baseline remediation

The `WIN11-Pilot-Security-Baseline` profile was assigned only to `SG-Intune-Pilot`. The first deployment reported error `65000` for Virtualization Based Security. The VM firmware/security configuration and baseline setting were reviewed, the device was synchronized, and the final assignment status reported success.

A BitLocker recovery prompt occurred after a Secure Boot policy change. The recovery key was retrieved through the authorized lab process. Recovery-key material and its identifier were deliberately excluded from the repository.

## Conditional Access validation

The `CA002-Require-Compliant-Device-Pilot` policy targets the pilot group, excludes emergency access, and requires a compliant device for the selected Microsoft 365 browser resource.

Observed results:

- Managed Edge work profile on compliant `PC1`: success.
- Edge InPrivate/unmanaged session: failure in report-only mode.
- Edge InPrivate/unmanaged session after enforcement: blocked.
- Managed Edge work profile after enforcement: success.

An early managed-browser test lacked a device claim even though Windows, Entra, and Intune device IDs matched. Creating a clean managed Edge profile for the same work identity restored device-identity presentation and allowed the compliant-device control to succeed.

## Evidence

Sanitized screenshots in `evidence/` document the baseline, pilot scope, Windows security prerequisites, device enrollment, compliance evaluation, baseline remediation, report-only decisions, and enforced allow/block paths.
