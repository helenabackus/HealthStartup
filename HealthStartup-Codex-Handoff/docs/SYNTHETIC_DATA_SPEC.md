# Synthetic Data Specification

## Goal

The connected-source demo contains exactly 42 immutable raw records. Every displayed count is derived from these records.

| Resource group | Raw count |
|---|---:|
| MedicationRequest / MedicationStatement | 6 |
| AllergyIntolerance | 2 |
| Condition | 4 |
| Observation / DiagnosticReport | 12 |
| Procedure | 3 |
| Immunization | 4 |
| Encounter | 5 |
| Patient and other demographic/context records | 6 |
| Total | 42 |

## Required cases

The fixture must generate:

- an old medication with an apparently active source status
- a current-looking medication missing dose or frequency
- a stopped historical medication
- possible duplicate medication records
- possible duplicate allergy descriptions from different synthetic sources
- a condition marked active by one source and resolved by another
- a clearly historical condition
- normal and abnormal-flagged labs that remain dated history only
- procedures with known and incomplete dates
- immunization and encounter history
- a conflicting demographic value
- a missing emergency contact

## Integrity rules

- Use obviously fictional people and organizations.
- Give every raw record a unique synthetic source-record ID.
- Reference an import batch and synthetic organization from every raw record.
- Keep raw payloads unchanged during the demo.
- Reference originating raw records from normalized records.
- Calculate import-summary counts from the fixture.
- Keep duplicate raw records separate.
- Keep historical and rejected-current candidates in history.
- Never turn a lab into a diagnosis or recommendation.

The checked-in `synthetic_test_data.json` is the canonical fixture. It must contain all 42 raw records and satisfy this specification before implementation is accepted.
