# MVP Fields

## Field status values

- missing
- imported_current_unconfirmed
- imported_historical
- imported_uncertain
- duplicate
- contradictory
- incomplete
- skipped
- unknown
- confirmed_current
- confirmed_history_only

## MVP field matrix

| Field | Category | Purpose | Data type | Repeatable | Possible FHIR source | Import reliability | Confirmation requirement | Manual question | Skip/unknown behavior | Current or history-only | Date/status rules | Sensitivity | MVP inclusion |
|---|---|---:|---|---|---|---|---|---|---|---|---|---|---|
| Legal name | Demographics | Identify patient on forms | string | no | Patient.name | high when patient matched | confirm if imported differs from account entry | What name should appear on medical forms? | unknown not allowed; skip allowed only before finish as incomplete | current | current profile only; audit changes | moderate | yes |
| Date of birth | Demographics | Identity matching | date | no | Patient.birthDate | high | confirm if missing or conflicting | What is your date of birth? | unknown not allowed; skip leaves missing | current | immutable except corrected by patient | moderate | yes |
| Sex assigned at birth | Demographics | Common intake requirement | enum | no | Patient.extension or Patient.gender depending source | medium | confirm | What sex were you assigned at birth, if asked on medical forms? | skip/unknown allowed | current | store source wording separately | sensitive | yes |
| Gender identity | Demographics | Patient-centered profile | string/enum | no | Patient.extension | low to medium | confirm or manual | What is your gender identity? | skip/unknown allowed | current | patient-entered value wins after confirmation | sensitive | yes |
| Phone | Demographics | Contact | phone string | repeatable but one primary | Patient.telecom | medium | confirm if imported | What phone number should forms use? | skip leaves missing | current | mark one primary | moderate | yes |
| Email | Demographics | Account/contact | email string | no | Patient.telecom/account | high for account email | account-confirmed | What email should forms use? | unknown not allowed for account | current | account email can differ from medical contact email | moderate | yes |
| Address | Demographics | Intake forms | structured address | repeatable but one primary | Patient.address | medium | confirm | What address should forms use? | skip/unknown allowed | current | mark effective date if known | moderate | yes |
| Emergency contact | Contacts | Safety/intake forms | structured contact | repeatable | Patient.contact | low to medium | confirm/manual | Who should be listed as your emergency contact? | skip/unknown allowed but flagged | current | require name; phone optional if unknown | sensitive | yes |
| Active medications | Medications | Current intake list | medication objects | yes | MedicationRequest, MedicationStatement | medium | always confirm if imported | Are you currently taking this medication? | unknown keeps unconfirmed; skip defers | current plus history | historical meds stay history-only until confirmed current | high | yes |
| Medication dose | Medications | Form detail | string/quantity | per medication | MedicationRequest.dosageInstruction, MedicationStatement.dosage | medium | confirm if present; ask if missing | What dose do you take? | unknown allowed; incomplete field status | current plus history | do not infer dose from old record | high | yes |
| Medication frequency | Medications | Form detail | string | per medication | dosageInstruction.timing | medium | confirm if present; ask if missing | How often do you take it? | unknown allowed; incomplete field status | current plus history | current only after medication current confirmed | high | yes |
| Medication start date | Medications | Context | date or partial date | per medication | MedicationRequest.authoredOn, MedicationStatement.effective | low | optional confirmation | When did you start taking it? | skip/unknown allowed | history supporting current | use partial date when exact unknown | high | yes |
| Allergies | Allergies | Safety/intake forms | allergy objects | yes | AllergyIntolerance | medium to high | always confirm imported allergies | Do you have this allergy or reaction? | unknown keeps unconfirmed and flagged | current plus history | inactive/resolved allergies stay history unless patient confirms current relevance | high | yes |
| Allergy reaction | Allergies | Safety detail | string/list | per allergy | AllergyIntolerance.reaction | medium | confirm if present; ask if missing | What reaction do you have? | unknown allowed; incomplete | current plus history | preserve source reaction text | high | yes |
| Conditions | Conditions | Medical history/current problems | condition objects | yes | Condition | medium | confirm current/active status | Do you currently have this condition? | unknown keeps unconfirmed | current plus history | clinicalStatus active may suggest question, not current truth | high | yes |
| Condition diagnosis date | Conditions | Timeline | date or partial date | per condition | Condition.onsetDateTime/onsetPeriod | low to medium | optional confirmation | When were you diagnosed? | skip/unknown allowed | history supporting current | store approximate dates separately | high | yes |
| Procedures | Procedures | Medical/surgical history | procedure objects | yes | Procedure | medium | confirm if patient-facing profile includes it | Have you had this procedure? | unknown keeps unconfirmed | history-only for MVP | procedure date required when known | high | yes |
| Immunizations | Immunizations | Common intake history | immunization objects | yes | Immunization | medium | confirm if imported ambiguous | Did you receive this immunization? | unknown keeps unconfirmed | history-only for MVP | occurrence date required when known | high | yes |
| Lab results | Labs | Dated medical record history | observation objects | yes | Observation, DiagnosticReport | medium | no current profile promotion; confirm only when needed for display corrections | Do you recognize this lab result? | unknown leaves history unconfirmed | history-only for MVP | store value, unit, reference range, abnormal flag, effective date | high | yes |
| Encounters | Encounters | Visit history context | encounter objects | yes | Encounter | medium | usually no direct confirmation unless contradictory | Do you recognize this visit? | unknown leaves history unconfirmed | history-only | store date, organization, type | high | yes |
| Primary care clinician | Care context | Intake context only | string/contact | no | PractitionerRole, CareTeam, Encounter.participant | low | manual/confirm | Who is your primary care clinician, if you have one? | skip/unknown allowed | current | do not build provider feature | moderate | maybe |
| Preferred pharmacy | Medications | Useful medication context | string/contact | no | not reliably available in common FHIR patient access | low | manual | What pharmacy do you usually use? | skip/unknown allowed | current | no pharmacy integration | moderate | maybe |

## Current versus history rule

Imported data can populate history immediately after normalization because history is dated and source-attributed. Imported data cannot populate the current profile unless:

- the source clearly represents a current state and the MVP rule still requires patient confirmation, or
- the patient manually enters it, or
- the patient confirms an imported proposal.

Old information remains in history. It may create a confirmation question when it is relevant to the current profile.
