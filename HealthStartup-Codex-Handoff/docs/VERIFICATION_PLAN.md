# Post-Build Verification Plan

Run this plan after the structural MVP is implemented.

## Automated checks

Dependency installation, lint, TypeScript checking, production build, and automated tests must succeed. Add a dedicated `test` script and, if build does not cover it, a `typecheck` script.

Test business rules separately from UI components:

- question ordering and every answer transition
- answer changes and supersession
- current-versus-history derivation
- duplicate and contradiction outcomes
- completion-state calculation
- synthetic source outcomes and manual-entry branching
- persistence restoration
- raw-record immutability
- import-summary calculation from fixture data

Every scenario in `TEST_SCENARIOS.md` maps to an automated test or an explicitly identified manual check.

## Browser walkthroughs

1. Demo account → source success → mixed answers → Needs review.
2. Demo account → source success → resolve core categories → You’re all good.
3. Demo account → source failure → another source → success.
4. Demo account → Skip for now → manual entry → profile home.
5. Answer questions → refresh → resume with answers preserved.
6. Answer current → change to historical → verify recomputation.
7. Complete a flow → Reset demo → verify original fixture.

## Repository inspection

Confirm there is no real PHI, secret, production OAuth/source call, portal-password input, diagnosis, treatment output, HIPAA-compliance claim, “View my medical information” screen/button, or import total hard-coded independently from the fixture.

## Evidence

Record commands and results, failed checks and fixes, completed or deferred scenarios, and the final commit SHA. The MVP is not complete while required checks fail or core scenarios remain unverified.
