# Open Decisions

## Product decisions

- Which non-core fields should be added after the structural MVP?
- Should preferred pharmacy be included in MVP or postponed?
- Should primary care clinician be included as a manual field or postponed?
- When a later medical-information viewer is designed, should users edit normalized history or append corrections/confirmation events?

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
- Should the import summary be category counts only or include source-level details?
