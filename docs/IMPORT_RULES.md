# Import Rules

## Import pipeline

1. Create an import batch.
2. Store every source payload unchanged in `raw_source_records`.
3. Parse known FHIR resource types into normalized history tables.
4. Preserve source identifiers and coding systems.
5. Assign imported data state.
6. Detect missing, duplicate, contradictory, old, or uncertain items.
7. Create questionnaire questions for anything that needs patient confirmation.
8. Do not update confirmed current profile fields without a patient confirmation event.

## Imported data states

| State | Meaning | MVP action |
|---|---|---|
| current | Source appears to represent active/current information | Create confirmation question before current profile update. |
| historical | Source appears dated or inactive | Store in history; do not put in current profile automatically. |
| uncertain | Source does not clearly indicate current/history | Store in history and ask if important. |
| duplicate | Multiple records may represent same fact | Ask patient or use deterministic matching for display grouping only. |
| contradictory | Sources disagree | Ask patient; do not silently choose. |
| incomplete | Required detail is missing | Ask for missing detail or mark incomplete. |
| unconfirmed | Imported fact has not been patient-confirmed | Keep out of confirmed current profile. |

## Duplicate detection

Potential duplicates can be identified using:

- same source identifier
- same FHIR resource id within same source
- same normalized code and overlapping dates
- same medication name, dose, and route
- same allergy substance and reaction
- same condition code/display and onset date
- same lab code, value, unit, and result date

Duplicate detection may group records for review, but raw records remain separate and unchanged.

## Contradiction detection

Contradictions include:

- one source says a medication is active while another suggests stopped
- allergy present in one source and marked inactive/resolved in another
- conflicting demographic values
- different lab units for same test without conversion confidence
- conditions marked active and resolved across sources

Contradictions create confirmation questions. The app must not silently prefer one source.

## Current profile promotion

Allowed:

- patient manually enters a current fact
- patient confirms an imported current candidate
- patient resolves contradiction explicitly

Not allowed:

- AI marks a fact current
- old record becomes current because it exists
- active source status becomes current without patient confirmation
- duplicate resolution overwrites a confirmed patient value

## History retention

Old or rejected current candidates remain in medical history with status and source attribution. For example, a medication from five years ago remains in medication history and may trigger a question, but it does not appear as an active medication unless the patient confirms it.

## Synthetic import summary

The MVP planning data uses a synthetic batch:

- 42 imported raw records
- 6 medication candidates
- 2 allergy candidates
- 4 condition records
- 12 lab observations
- 3 procedures
- 4 immunizations
- 5 encounters
- 6 other/demographic records
