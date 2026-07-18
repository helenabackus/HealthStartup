# Screen Specs

## Visual direction

- Low-fidelity desktop website wireframes.
- Grayscale only.
- Plain typography.
- Standard inputs, buttons, lists, progress indicators, and rows.
- Simple spacing.
- Almost no decoration.
- Avoid gradients, illustrations, oversized text, excessive cards, and generic AI-style visuals.

## Shared layout

- Desktop frame target: 1360 x 860.
- Header:
  - left: HealthStartup
  - right: step label
- Main content column starts around 96 px from left.
- Primary buttons use dark fill.
- Secondary buttons use white fill with gray border.
- Form fields use standard rectangular inputs.
- Progress uses text plus a simple horizontal bar.

## Screens

### 1. Welcome / explanation

Purpose: establish what the product does and set expectations.

Content:
- H1: "Your medical information, organized for intake forms."
- Body copy: "Connect records you already have, confirm anything unclear, and keep the best current profile separate from your full history."
- Primary action: Continue to demo.
- Scope note: planning prototype only, synthetic data only, no diagnosis/insurance/provider/appointment/QR/document-sharing.

### 2. Demo account

Purpose: enter the synthetic prototype without pretending to provide production authentication.

Content:
- "Continue with a synthetic demo account."
- Display `synthetic.patient@example.invalid`.
- "Do not enter real medical information."

Actions:
- Back
- Continue with demo account

Do not render password, email-entry, sign-in, password-reset, or email-verification controls.

### 3. Getting started

Purpose: set time expectation and reduce friction.

Copy:
- "Let's get started."
- "This takes about 5-10 minutes and can make future medical forms faster."

Checklist:
- Connect records or skip
- Review import summary
- Answer one question at a time
- Finish with a clean profile home

Actions:
- Back
- Continue

### 4. Connect records

Purpose: choose a source or skip.

Source buttons:
- MyChart / health system
- Apple Health
- Health Connect
- Another portal
- Skip for now

Required explanation:
- "Choose a source. You will sign in through that source. We never collect portal passwords."

Actions:
- Back
- Continue

### 5. Synthetic authorization explanation

Purpose: explain the future source handoff without collecting credentials.

Content:
- "In a real connection, you would sign in through this source."
- "We would never receive or store your portal password."
- "This prototype uses synthetic records only."

Actions:
- Back
- Continue with synthetic connection
- Simulate failure
- Cancel

Failure state actions:
- Try again
- Choose another source
- Skip for now

Cancel returns to source selection. Skip enters manual-entry questions and does not show import loading or summary.

### 6. Import loading

Purpose: show import and organization activity.

Content:
- "Importing and organizing records"
- Progress bar placeholder
- "Preserving raw records, normalizing history, and finding details that need your confirmation."
- Guardrail note: "AI can organize and flag records, but cannot silently decide medical facts or mark old information current."

### 7. Import summary

Purpose: show what was imported and what still needs review.

Content:
- "We imported 42 records," where 42 is computed from the fixture.
- "We still need a few details before your current profile is ready."
- Summary rows:
  - Medications: 3 need confirmation
  - Allergies: 1 possible duplicate
  - Conditions: 2 historical items
  - Labs: 12 stored in history

Actions:
- Back
- Review questions

### 8. Question one at a time

Purpose: patient confirmation.

Example:
- Progress: "Medications: 3 of 5"
- Question: "Are you currently taking Lisinopril 10 mg?"
- Context: "Imported from Riverbend Health. Last seen in records on 2021-04-12. No recent refill was imported."
- Answer options:
  - Yes, current
  - No, historical
  - Not sure

Actions:
- Back
- Skip
- Unknown
- Continue

Manual-entry questions use the same layout after Skip for now. Repeatable medical categories include a None option.

### 9. Profile home

Purpose: clean finish state and profile entry point.

States:
- "You're all good" when core categories are confirmed or explicitly answered None.
- "Needs review" when a core category is missing, skipped, unknown, incomplete, contradictory, or unconfirmed.

Rows:
- Active medications
- Allergies
- Conditions
- Demographics
- Emergency contact

Actions:
- Resume unresolved questions when applicable
- Review or change a previous answer
- Reset demo

This is the final MVP screen. Do not add a "View my medical information" action or destination.

### 10. Data and AI guardrails

Purpose: align design with implementation constraints.

Content:
- Raw imported records: preserve unchanged.
- Medical history: normalized dated records.
- Current profile: confirmed best-current view only.
- AI may normalize, identify missing details, flag contradictions, suggest questions, and organize data.
- AI may not diagnose, recommend treatment, overwrite raw records, mark data current without confirmation, or directly modify confirmed patient data.

## Figma

Editable file:

https://www.figma.com/design/Mll4YENMGunDl2oidQSDm3
