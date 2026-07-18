# FHIR Mapping

## Primary references

- SMART App Launch: https://hl7.org/fhir/smart-app-launch/
- SMART App Launch scopes and launch context: https://hl7.org/fhir/smart-app-launch/scopes-and-launch-context.html
- Epic on FHIR documentation: https://fhir.epic.com/
- Epic patient-facing authentication overview: https://fhir.epic.com/Documentation?docId=oauth2
- HL7 FHIR R4 Patient: https://hl7.org/fhir/R4/patient.html
- HL7 FHIR R4 MedicationRequest: https://hl7.org/fhir/R4/medicationrequest.html
- HL7 FHIR R4 MedicationStatement: https://hl7.org/fhir/R4/medicationstatement.html
- HL7 FHIR R4 AllergyIntolerance: https://hl7.org/fhir/R4/allergyintolerance.html
- HL7 FHIR R4 Condition: https://hl7.org/fhir/R4/condition.html
- HL7 FHIR R4 Observation: https://hl7.org/fhir/R4/observation.html
- HL7 FHIR R4 DiagnosticReport: https://hl7.org/fhir/R4/diagnosticreport.html
- HL7 FHIR R4 Procedure: https://hl7.org/fhir/R4/procedure.html
- HL7 FHIR R4 Immunization: https://hl7.org/fhir/R4/immunization.html
- HL7 FHIR R4 Encounter: https://hl7.org/fhir/R4/encounter.html

## Authorization support

SMART on FHIR patient authorization is the likely standard route for patient-facing record access where supported. A production implementation would register an app with each supported source, redirect the patient to the source authorization screen, request patient-level scopes, and receive authorization results from the source. This planning MVP must not implement real OAuth, store tokens, or connect real accounts.

Epic/MyChart support should be treated as a future source integration using Epic on FHIR documentation and app registration requirements. The MVP should show MyChart / health system as a source option, but the current planning branch must use synthetic source records only.

## Common intake resources

| MVP concept | FHIR resource | Useful fields | MVP behavior |
|---|---|---|---|
| Patient identity | Patient | name, birthDate, gender, telecom, address, contact | Use as demographic candidate; confirm patient-facing fields. |
| Active or historical medication | MedicationRequest | medicationCodeableConcept, dosageInstruction, status, intent, authoredOn | Store dated medication history; ask before current profile. |
| Patient-reported medication | MedicationStatement | medicationCodeableConcept, status, effective, dosage | Store history; ask before current profile. |
| Allergy | AllergyIntolerance | code, clinicalStatus, verificationStatus, reaction | Store history/current candidate; confirm safety-sensitive fields. |
| Condition/problem | Condition | code, clinicalStatus, verificationStatus, onset, abatement, recordedDate | Store history; active status can trigger confirmation but not silently set current. |
| Lab result | Observation | code, value, unit, referenceRange, interpretation, effectiveDateTime | Store dated history only in MVP. |
| Lab panel/report | DiagnosticReport | code, result references, effectiveDateTime, conclusion | Link related observations; do not summarize as diagnosis. |
| Procedure/surgery | Procedure | code, status, performedDateTime, bodySite | Store dated history; confirm if shown in profile. |
| Immunization | Immunization | vaccineCode, occurrenceDateTime, status | Store dated history. |
| Encounter/visit | Encounter | class, type, period, serviceProvider | Store dated history context. |

## Mapping rules

- Preserve raw FHIR JSON in `raw_source_records.raw_payload`.
- Normalize only into separate history/current tables.
- Keep original coding systems and codes where present.
- Keep display text from source separately from normalized display text.
- Store source organization, import batch, and source record reference on every normalized row.
- Store units for lab values.
- Store reference ranges when available.
- Store status and date fields as source-provided values plus MVP-derived imported data state.
- Do not infer a diagnosis from labs, medication, or procedures.

## Current versus historical medication logic

Medication resources can contain status and dates, but the MVP must treat them as candidates, not final current medication truth. A medication from years ago remains in history and may create a confirmation question. A source status that appears active can prioritize the item in the questionnaire, but the current profile should only update after confirmation.

## Lab-result storage

Labs are dated history in the MVP. Store:

- test name
- code and coding system when available
- value
- unit
- reference range
- interpretation/abnormal flag when available
- specimen or panel context when available
- source organization
- result date
- raw record reference

Do not convert a lab result into a condition, diagnosis, or recommendation.
