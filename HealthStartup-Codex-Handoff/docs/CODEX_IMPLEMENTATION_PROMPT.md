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
- Do not implement a medical-information viewer.

Build:

- Low-fidelity desktop website flow:
  1. Welcome/explanation
  2. Continue with demo account (no password fields)
  3. Intake start copy
  4. Connect records source buttons
  5. Synthetic source-authorization explanation with success/failure/cancel states
  6. Loading screen for successful synthetic connection only
  7. Import summary computed from the 42-record fixture
  8. One-question-at-a-time imported confirmation or manual-entry questionnaire
  9. Profile home with all-good or missing/unconfirmed flags, answer review, resume, and Reset demo
- Use the Figma wireframes as visual reference: https://www.figma.com/design/Mll4YENMGunDl2oidQSDm3
- Keep UI grayscale, plain, and minimal.
- Implement data using local synthetic fixtures only.
- Persist demo progress in browser-local storage behind an isolated storage adapter.
- Preserve the three-layer mental model:
  - raw imported records
  - medical history
  - current profile
- Never let AI or import logic silently decide current medical facts.
- Ambiguous imported data creates patient confirmation questions.
- Implement `IMPLEMENTATION_RULES.md` as deterministic business logic.
- Use the complete fixture required by `SYNTHETIC_DATA_SPEC.md`.
- Implement and verify `TEST_SCENARIOS.md` and `VERIFICATION_PLAN.md`.

Acceptance checks:

- No application code connects to external health systems.
- No secrets or real PHI exist in the repo.
- Raw synthetic records remain unchanged.
- Current profile values require manual entry or confirmation event.
- Every question has Back, Continue, Skip, and Unknown where appropriate.
- Profile home can show both "You're all good" and missing/unconfirmed states.
- Skip source enters manual questions without showing an import claim.
- Back and refresh preserve saved answers.
- The UI never accepts a password.
- No "View my medical information" screen or button exists.
