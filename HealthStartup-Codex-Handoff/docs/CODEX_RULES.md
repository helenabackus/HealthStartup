# Codex Rules

## Before writing application code

Complete and review:

- `PRODUCT_SCOPE.md`
- `USER_FLOW.md`
- `SCREEN_SPECS.md`
- `MVP_FIELDS.md`
- `QUESTIONNAIRE.md`
- `DATA_MODEL.md`
- `FHIR_MAPPING.md`
- `IMPORT_RULES.md`
- `IMPLEMENTATION_RULES.md`
- `AI_RULES.md`
- `SECURITY_REQUIREMENTS.md`
- `LEGAL_QUESTIONS.md`
- `OPEN_DECISIONS.md`
- `SYNTHETIC_DATA_SPEC.md`
- `TEST_SCENARIOS.md`
- `VERIFICATION_PLAN.md`
- `SCHEMA.sql`
- `synthetic_test_data.json`
- `CODEX_IMPLEMENTATION_PROMPT.md`

## Repository rules

- Do not add production infrastructure.
- Do not deploy.
- Do not add API keys or secrets.
- Do not connect real health accounts.
- Do not collect a password; use the synthetic demo account.
- Do not store real health information.
- Do not claim HIPAA compliance.
- Do not build diagnosis, provider, insurance, appointment, document-sharing, or QR features.
- Do not materially expand scope without asking.
- Prefer the smallest workable MVP.

## App-code rules for future implementation

- Read `AGENTS.md` first.
- Read the local Next.js docs under `node_modules/next/dist/docs/` before writing Next.js code, as required by `AGENTS.md`.
- Implement only the screens and synthetic flows specified here.
- Use synthetic seed data.
- Keep source integrations mocked.
- Keep raw records immutable.
- Keep current profile updates behind patient confirmation events.
- Store AI outputs as proposals, never as confirmed medical facts.
- Implement deterministic state transitions before any AI behavior.
- Use browser-local persistence only for the structural demo.
- Do not build a medical-information viewer in this MVP.
- Verify all test scenarios after implementation.

## Test data rules

- Use only synthetic patients, organizations, source records, and answers.
- Use obvious fake names and organizations.
- Do not include real MRNs, portal IDs, access tokens, emails, phone numbers, or addresses.

## Commit scope

Planning branch commits may include only:

- planning Markdown files
- schema proposals
- synthetic data
- wireframe references

No application code should be changed before the planning artifacts are accepted.
