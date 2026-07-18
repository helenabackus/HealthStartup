# MVP Implementation Rules

## Purpose

These rules turn the planning documents into deterministic prototype behavior. The build remains synthetic and local-only: no real accounts, health-system connections, production database, secrets, or real health information.

## Demo account

- The account screen offers one primary action: **Continue with demo account**.
- It may display the synthetic identity `synthetic.patient@example.invalid`.
- It must not ask for, accept, or store a password.
- Sign-in, password reset, email verification, and production sessions are out of scope.
- Continuing creates or loads one locally persisted synthetic patient profile.

## Prototype persistence

Use browser-local persistence for the demo only. Persist the current step, selected synthetic source, import state, question queue, patient answers, confirmation events, current-profile values, field statuses, and audit events.

- Back never discards a saved answer.
- Refresh restores the last completed step and saved answers.
- A **Reset demo** control clears locally persisted prototype state and reloads the original fixture.
- Never persist real health information.
- Isolate the storage adapter so a later database can replace local persistence without rewriting business rules.

## Source selection and synthetic authorization

Supported selections are MyChart / health system, Apple Health, Health Connect, Another portal, and Skip for now.

Every non-skip source opens a separate authorization-explanation screen:

- “In a real connection, you would sign in through this source.”
- “We would never receive or store your portal password.”
- “This prototype uses synthetic records only.”

Synthetic outcomes:

- `connected_sandbox`: continue to import loading.
- `failed_placeholder`: show Try again, Choose another source, and Skip for now.
- `cancelled_placeholder`: return to source selection without creating an import.
- `skipped`: enter manual-entry questions; never show loading or claim records were imported.

## Import path

For `connected_sandbox`:

1. Load the immutable 42-record synthetic fixture.
2. Compute the import summary from that fixture.
3. Create normalized history candidates.
4. Generate deterministic confirmation questions.
5. Continue to import summary and the question queue.

Never hard-code “42” independently of the fixture.

## Manual-entry path

For `skipped`, ask one question at a time in this order: demographics, emergency contact, active medications, allergies, current conditions, major procedures, and immunizations.

The user can answer **None** for repeatable medical categories. Manual entries create patient-entered records plus confirmation events; they do not create imported raw records.

## Deterministic question queue

Priority:

1. allergies
2. active medications
3. emergency contact
4. contradictions
5. incomplete current candidates
6. conditions and major procedures
7. optional demographics and immunizations

Each question has one status: `open`, `answered`, `skipped`, `unknown`, or `superseded`. Queue order is stable. Returning to a previous question does not create a duplicate question.

## Answer transitions

### Yes/current

- Store the answer and append a confirmation event.
- Promote only the referenced candidate to confirmed current.
- Set its field status to `confirmed_current`.
- Keep every raw record unchanged.

### No/historical

- Store the answer and append a confirmation event.
- Keep the item in dated history and ensure it is not current.
- Set its field status to `confirmed_history_only`.

### Unknown

- Store an unknown answer and confirmation event.
- Do not promote the fact to current.
- Set the field status to `unknown`.
- Close the question for this intake but show the category as unresolved on profile home.

### Skip

- Store a skipped answer and confirmation event.
- Do not infer any medical fact.
- Set the field status to `skipped`.
- Close the question for this intake but show the category as unresolved on profile home.

### Changing an answer

- Never overwrite an earlier answer or confirmation event.
- Append a new answer and confirmation event.
- Supersede the earlier effective state.
- Recompute current profile and field status from the latest effective event.
- Preserve the audit trail.

## Required and completion behavior

No health question traps the user in intake. **Required** means important and visibly unresolved, not impossible to skip.

- The user may finish after every open question is answered, skipped, unknown, or superseded.
- “You’re all good” appears only when all core categories are confirmed or explicitly answered None.
- “Needs review” appears when any core field is missing, skipped, unknown, contradictory, incomplete, or unconfirmed.

Core categories are demographics, emergency contact, active medications, allergies, and current conditions.

## Duplicate resolution

- Same item: link normalized candidates as one duplicate group; preserve all raw records.
- Different items: retain both normalized candidates.
- Unknown or Skip: retain both and keep the duplicate unresolved.

## Contradiction resolution

The patient selects the current value, supplies a new value, chooses Unknown, or skips. No source receives automatic priority. Conflicting source facts remain in history and audit data.

## Profile home

The MVP ends at profile home. Show:

- “You’re all good” or “Needs review”
- summaries for medications, allergies, conditions, demographics, and emergency contact
- missing/unconfirmed status labels
- controls to resume unresolved questions, review/change an answer, and reset the demo

Do not create a “View my medical information” screen or button in this MVP.
