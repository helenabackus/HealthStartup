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
- Primary action: Create account.
- Secondary action: I already have one.
- Scope note: planning prototype only, synthetic data only, no diagnosis/insurance/provider/appointment/QR/document-sharing.

### 2. Create account

Purpose: minimal account creation before intake.

Fields:
- Email
- Password
- Confirm password

Actions:
- Back
- Continue

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

### 5. Import loading

Purpose: show import and organization activity.

Content:
- "Importing and organizing records"
- Progress bar placeholder
- "Preserving raw records, normalizing history, and finding details that need your confirmation."
- Guardrail note: "AI can organize and flag records, but cannot silently decide medical facts or mark old information current."

### 6. Import summary

Purpose: show what was imported and what still needs review.

Content:
- "We imported 42 records."
- "We still need a few details before your current profile is ready."
- Summary rows:
  - Medications: 3 need confirmation
  - Allergies: 1 possible duplicate
  - Conditions: 2 historical items
  - Labs: 12 stored in history

Actions:
- Back
- Review questions

### 7. Question one at a time

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

### 8. Profile home

Purpose: clean finish state and profile entry point.

States:
- "You're all good" when MVP categories are confirmed or intentionally marked skipped/unknown.
- "Needs review" when categories remain missing or unconfirmed.

Rows:
- Active medications
- Allergies
- Conditions
- Demographics
- Emergency contact

Action:
- View my medical information

### 9. Data and AI guardrails

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
