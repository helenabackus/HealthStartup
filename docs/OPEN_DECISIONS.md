# Open Decisions

## Product decisions

- Which MVP fields are required to finish versus allowed to remain skipped/unknown?
- Should emergency contact be required or only flagged when missing?
- Should preferred pharmacy be included in MVP or postponed?
- Should primary care clinician be included as a manual field or postponed?
- How much medical history should be visible on profile home versus behind "View my medical information"?
- Should users be able to edit normalized history directly, or only add corrections/confirmation events?

## Source integration decisions

- Which first real source should be evaluated after synthetic MVP: Epic/MyChart, Apple Health, Health Connect, or generic SMART on FHIR sandbox?
- What app registration path is required for each source?
- Which SMART scopes are needed for the smallest patient-facing import?
- How should failed, partial, revoked, and expired source connections appear to the user?

## Data decisions

- What retention policy applies to raw source records?
- Should raw records be encrypted with separate keys from normalized/current data?
- How should source deletions or patient deletion requests cascade across raw, history, current profile, AI proposals, and audit events?
- Should current profile records keep snapshots or only point to confirmation events?
- What confidence labels, if any, should appear in the patient UI?

## AI decisions

- Which normalization tasks are deterministic enough to run without review?
- What proposal confidence labels are acceptable without implying medical certainty?
- Who reviews AI prompts before production?
- How long should AI proposals be retained?

## Legal/security decisions

- HIPAA role analysis.
- FTC Health Breach Notification Rule applicability.
- State consumer health privacy law applicability.
- Required consent language.
- Required source integration terms and notices.
- Business associate agreement requirements.
- Production hosting, encryption, logging, backup, and incident-response obligations.

## Design decisions

- Should the MVP remain desktop-first for planning or add mobile wireframes before implementation?
- What level of detail should the "View my medical information" screen include in the first build?
- Should the import summary be category counts only or include source-level details?
