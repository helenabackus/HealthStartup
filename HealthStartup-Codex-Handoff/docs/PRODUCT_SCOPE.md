# Product Scope

## MVP purpose

Build the simplest structural MVP for a patient-owned medical intake website. The product helps a patient connect or manually enter medical information, review uncertain imported data, and finish with a clean current profile that can make future medical forms faster.

This is a planning-only scope. Use synthetic data only. Do not connect real health accounts, create production infrastructure, store real health information, deploy, or claim HIPAA compliance.

## In scope

- Welcome and plain-language explanation.
- Demo-account entry screen with no password collection.
- Intake-start screen: "Let's get started. This takes about 5-10 minutes and can make future medical forms faster."
- Record connection choice screen with source buttons:
  - MyChart / health system
  - Apple Health
  - Health Connect
  - Another portal
  - Skip for now
- Explanation that source sign-in happens through the source and the product never collects portal passwords.
- Synthetic authorization success, failure, cancellation, retry, and skip states.
- Loading screen while imported records are preserved, normalized, deduplicated, and organized.
- Import summary computed from the canonical 42-record synthetic fixture.
- One-question-at-a-time confirmation questionnaire.
- Manual-entry questionnaire when source connection is skipped.
- Back, Continue, Skip, and Unknown controls where appropriate.
- Section progress such as "Medications: 3 of 5."
- Profile home screen with either "You're all good" or missing/unconfirmed category flags.
- Resume-review, change-answer, and Reset demo actions on profile home.
- Browser-local prototype persistence.
- Three-layer data model:
  - raw imported records
  - medical history
  - current profile
- AI proposal logging and patient confirmation workflow.

## Out of scope

- Production database or production infrastructure.
- Production authentication, passwords, email verification, or password reset.
- Real MyChart, Epic, Apple Health, Health Connect, or other portal connections.
- API keys, OAuth client secrets, or production tokens.
- Diagnosis, treatment recommendation, clinical triage, or decision support.
- Provider search, appointment scheduling, insurance workflows, billing, document sharing, or QR codes.
- Automatic patient matching across providers beyond storing source-provided identifiers.
- Claims of HIPAA compliance.
- Any real patient data.

## MVP success criteria

- A user can understand what the product does before creating an account.
- A user can choose to connect a source or skip.
- A user who skips enters information manually and never sees a false import claim.
- Imported records are stored unchanged in the raw layer.
- Normalized dated records are stored in history.
- Current profile values are only set when they are confirmed or manually entered by the patient.
- Ambiguous, incomplete, contradictory, duplicate, old, or unconfirmed data creates a confirmation question.
- A patient can finish intake even when some fields are skipped or unknown.
- The profile home clearly separates confirmed information from missing or unconfirmed categories.
- Refresh and Back preserve saved prototype progress.
- Import counts match the actual synthetic fixture.
- The MVP ends at profile home; no separate medical-information viewer is included.

## Research basis

- SMART App Launch supports OAuth 2.0 authorization patterns for apps requesting access to FHIR resources.
- Epic supports patient-facing FHIR access through OAuth-style authorization for supported applications.
- Common patient-intake data maps to FHIR resources such as Patient, MedicationRequest, MedicationStatement, AllergyIntolerance, Condition, Observation, DiagnosticReport, Procedure, Immunization, and Encounter.
- HIPAA Security Rule themes that matter for later legal and technical planning include administrative, physical, and technical safeguards for electronic protected health information.
- Consumer health applications may raise FTC Health Breach Notification Rule questions depending on the business model, integrations, and data handling.

Primary references are listed in `FHIR_MAPPING.md`, `SECURITY_REQUIREMENTS.md`, and `LEGAL_QUESTIONS.md`.
