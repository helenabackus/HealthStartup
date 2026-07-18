# User Flow

## Linear MVP flow

1. Welcome / explanation
   - Explain patient-owned intake.
   - Explain that imported records may need confirmation.
   - Primary action: Create account.

2. Create account
   - Collect email and password only.
   - Do not collect real medical information at account creation.

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

6. Loading screen
   - Copy: "Importing and organizing records."
   - Explain that raw records are preserved unchanged.
   - Explain that unclear data will be confirmed with the patient.

7. Import summary
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

9. Profile home
   - If required MVP fields are confirmed or intentionally skipped/unknown, show "You're all good."
   - If required categories are missing or unconfirmed, flag them.
   - Include "View my medical information."
   - No QR code.

## Navigation rules

- Back returns to the previous step without losing saved answers.
- Continue requires a selected answer when a question is marked required for completion.
- Skip is allowed for non-critical MVP questions and stores a skipped status.
- Unknown is allowed for questions where the patient may not know the answer and stores an unknown status.
- The app must never infer a medical fact from Back, Skip, or Unknown.

## Wireframe file

Editable low-fidelity desktop wireframes are available in Figma:

https://www.figma.com/design/Mll4YENMGunDl2oidQSDm3
