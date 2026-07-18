# AI Rules

## AI may

- Normalize text.
- Identify missing details.
- Flag contradictions.
- Suggest clarification questions.
- Organize imported data.
- Propose duplicate groupings.
- Propose FHIR-to-MVP mappings.
- Explain source context in patient-friendly language.

## AI may not

- Diagnose.
- Recommend treatment.
- Overwrite raw records.
- Mark information current without confirmation.
- Directly modify confirmed patient data.
- Resolve contradictions without patient input.
- Convert lab results into diagnoses.
- Generate clinical advice.
- Hide uncertainty from the patient.

## Required implementation pattern

AI output must be stored as `ai_proposals`, not as medical facts. A proposal can have these statuses:

- proposed
- accepted_by_rule
- presented_to_patient
- confirmed_by_patient
- rejected_by_patient
- expired
- superseded

Only deterministic application logic and patient confirmation events can update current profile data. AI proposals may create suggested questions, but those questions must be answered or skipped by the patient.

## Prompting guardrails

AI prompts must include:

- "Use synthetic data only."
- "Do not diagnose."
- "Do not recommend treatment."
- "Do not infer current medical facts."
- "Return uncertainty explicitly."
- "Preserve raw source data unchanged."

## Auditability

Every AI proposal should store:

- source record references
- model name or processing label
- prompt version
- proposal type
- proposed normalized value
- confidence label if used
- reason
- created timestamp
- final disposition

Do not store hidden clinical reasoning as confirmed data.
