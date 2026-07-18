# Concise Codex Implementation Prompt

Use the existing `HealthStartup` repository to build only the structural MVP screens described in `/docs`. Before writing app code, read `AGENTS.md` and the relevant local Next.js docs under `node_modules/next/dist/docs/`.

Constraints:

- Use synthetic data only.
- Do not connect real MyChart, Epic, Apple Health, Health Connect, or other portal accounts.
- Do not create production infrastructure.
- Do not add API keys or secrets.
- Do not deploy.
- Do not claim HIPAA compliance.
- Do not build diagnosis, treatment, provider, insurance, appointment, document-sharing, or QR features.
- Do not materially expand scope without asking.

Build:

- Low-fidelity desktop website flow:
  1. Welcome/explanation
  2. Create account
  3. Intake start copy
  4. Connect records source buttons
  5. Source sign-in explanation
  6. Loading screen
  7. Import summary
  8. One-question-at-a-time questionnaire
  9. Profile home with all-good or missing/unconfirmed flags
  10. View my medical information entry point
- Use the Figma wireframes as visual reference: https://www.figma.com/design/Mll4YENMGunDl2oidQSDm3
- Keep UI grayscale, plain, and minimal.
- Implement data using local synthetic fixtures only.
- Preserve the three-layer mental model:
  - raw imported records
  - medical history
  - current profile
- Never let AI or import logic silently decide current medical facts.
- Ambiguous imported data creates patient confirmation questions.

Acceptance checks:

- No application code connects to external health systems.
- No secrets or real PHI exist in the repo.
- Raw synthetic records remain unchanged.
- Current profile values require manual entry or confirmation event.
- Every question has Back, Continue, Skip, and Unknown where appropriate.
- Profile home can show both "You're all good" and missing/unconfirmed states.
