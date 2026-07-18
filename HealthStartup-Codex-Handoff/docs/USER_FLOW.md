# User Flow

## Linear MVP flow

1. Welcome / explanation
   - Explain patient-owned intake.
   - Explain that imported records may need confirmation.
   - Primary action: Continue to demo.

2. Demo account
   - Show the synthetic account identity.
   - Primary action: Continue with demo account.
   - Do not collect email, password, or real medical information.

3. Intake start
   - Copy: "Let's get started. This takes about 5-10 minutes and can make future medical forms faster."
   - Primary action: Continue.
   - Secondary action: Back.

4. Connect records
   - Show source buttons:
     - MyChart / health system
     - Apple Health
     - Health Connect
     - Another portal
     - Skip for now
   - Explain: "You sign in through the source. We never collect portal passwords."
   - In this planning MVP, source connection screens are placeholders only.

5. Source authorization placeholder
   - Future implementation redirects to the source's authorization flow.
   - For this MVP, use synthetic connection states only:
     - connected_sandbox
     - skipped
     - failed_placeholder
     - cancelled_placeholder
   - Failure offers retry, another source, or skip.
   - Cancellation returns to source selection.
   - Skip enters the manual-entry question queue and bypasses loading/import summary.

6. Loading screen
   - Copy: "Importing and organizing records."
   - Explain that raw records are preserved unchanged.
   - Explain that unclear data will be confirmed with the patient.

7. Import summary
   - Compute the 42-record total and category counts from the canonical fixture.
   - Copy: "We imported 42 records. We still need a few details."
   - Show high-level counts by category.
   - Show categories needing review.

8. Missing or uncertain questions
   - Ask one question at a time.
   - Show section progress, for example "Medications: 3 of 5."
   - Every question has Back, Continue, and Skip.
   - Unknown appears where the patient may not know the answer.
   - Answers create confirmation events.
   - Skips and unknown answers create field statuses rather than silently resolving data.
   - The skip-source path uses the same one-question layout for manual entry.
   - Repeatable medical categories offer None.

9. Profile home
   - Show "You're all good" only when core categories are confirmed or explicitly answered None.
   - Show "Needs review" when a core category is missing, skipped, unknown, incomplete, contradictory, or unconfirmed.
   - Include Resume review, Change an answer, and Reset demo controls.
   - This is the final MVP destination; do not build a medical-information viewer.
   - No QR code.

## Navigation rules

- Back returns to the previous step without losing saved answers.
- Required means important and visibly unresolved, not impossible to skip.
- Skip is allowed for every health question and stores a skipped status.
- Unknown is allowed for questions where the patient may not know the answer and stores an unknown status.
- The app must never infer a medical fact from Back, Skip, or Unknown.
- Back and refresh retain saved answers through browser-local demo persistence.

Detailed transitions and completion rules are authoritative in `IMPLEMENTATION_RULES.md`.

## Wireframe file

Editable low-fidelity desktop wireframes are available in Figma:

https://www.figma.com/design/Mll4YENMGunDl2oidQSDm3
