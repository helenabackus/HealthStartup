# Questionnaire

## Question principles

- Ask one question at a time.
- Show section progress.
- Use the source and date as context, not as a conclusion.
- Every question has Back, Continue, and Skip.
- Unknown appears where the patient may not know the answer.
- Answers create confirmation events.
- AI can suggest question wording but cannot answer on behalf of the patient.

## Question types

| Type | Use | Controls | Stored result |
|---|---|---|---|
| confirm_current | Imported item might be current | Back, Continue, Skip, Unknown | confirmation event plus field status |
| confirm_history | Imported item belongs in history | Back, Continue, Skip, Unknown | history confirmation |
| fill_missing | Required detail missing | Back, Continue, Skip, Unknown when appropriate | patient answer |
| resolve_duplicate | Two records may describe same item | Back, Continue, Skip, Unknown | duplicate resolution event |
| resolve_contradiction | Sources disagree | Back, Continue, Skip, Unknown | contradiction event; no silent overwrite |
| manual_entry | No source data found | Back, Continue, Skip, Unknown when appropriate | patient-created record |

## Question queue priority

1. Safety-sensitive current profile blockers:
   - allergies
   - active medications
   - emergency contact
2. Contradictory records.
3. Incomplete current-profile candidates.
4. Historical items likely to appear on intake forms:
   - major procedures
   - chronic conditions
   - immunizations
5. Optional demographics and care context.

## Example questions

### Medication current confirmation

Prompt: Are you currently taking Lisinopril 10 mg?

Context: Imported from Riverbend Health. Last seen in records on 2021-04-12. No recent refill was imported.

Answers:
- Yes, current
- No, historical
- Not sure

Controls:
- Back
- Continue
- Skip
- Unknown

Storage:
- Yes creates a confirmed_current active medication.
- No keeps the medication in history and marks it confirmed_history_only.
- Not sure/Unknown marks current status unconfirmed.
- Skip closes the question for this intake, records skipped status, and leaves the category unresolved on profile home.

### Medication missing dose

Prompt: What dose of Metformin do you take?

Context: Imported medication name did not include a dose.

Answers:
- Free text dose
- Unknown

Storage:
- Free text updates medication dose only after patient confirmation.
- Unknown marks dose incomplete.

### Allergy duplicate

Prompt: Are these the same allergy?

Context:
- Penicillin, imported from Riverbend Health
- Penicillin antibiotics, imported from Eastside Clinic

Answers:
- Same allergy
- Different allergies
- Not sure

Storage:
- Same allergy links the records as duplicates and keeps both raw records.
- Different allergies keeps both normalized allergy records.
- Not sure leaves duplicate status unresolved.

### Condition active status

Prompt: Do you currently have asthma?

Context: Imported condition was marked active by Valley Clinic on 2020-03-02.

Answers:
- Yes, current
- No, past condition
- Not sure

Storage:
- Yes creates confirmed current condition.
- No keeps condition in history.
- Not sure keeps current status unconfirmed.

### Emergency contact

Prompt: Who should be listed as your emergency contact?

Fields:
- Name
- Relationship
- Phone

Controls:
- Back
- Continue
- Skip
- Unknown for phone only

Storage:
- Missing emergency contact is flagged on profile home until answered, skipped, or unknown.

## Completion behavior

No health question traps the patient. Required means important and visibly unresolved, not impossible to skip. The patient reaches profile home after every open question is answered, skipped, unknown, or superseded. Skipped or unknown core categories remain visible as unresolved flags.

“You're all good” requires every core category to be confirmed or explicitly answered None. Any missing, skipped, unknown, contradictory, incomplete, or unconfirmed core category produces “Needs review.”

The exact answer transitions, change-answer behavior, manual-entry queue, and duplicate/contradiction resolution rules are authoritative in `IMPLEMENTATION_RULES.md`.
