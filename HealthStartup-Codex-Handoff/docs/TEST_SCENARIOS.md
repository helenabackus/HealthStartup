# MVP Test Scenarios

All scenarios use synthetic data only.

## Connection and account

1. **Successful connection:** sandbox success loads exactly 42 raw records and displays computed counts.
2. **Failed connection:** failure offers Try again, Choose another source, and Skip; no completed import exists.
3. **Cancelled connection:** cancellation returns to source selection and makes no import claim.
4. **Skip connection:** Skip enters manual questions and never displays “We imported 42 records.”
5. **Demo account:** Continue with demo account loads the single synthetic patient without accepting a password.

## Persistence

6. **Back:** a saved answer remains selected and navigation alone creates no duplicate answer.
7. **Refresh:** progress and prior answers restore after refresh.
8. **Reset:** Reset demo clears local progress/events and restores the original fixture.

## Current versus historical

9. **Old medication becomes current:** Yes creates current state and a confirmation event without changing raw data.
10. **Old medication stays historical:** No retains history, removes current state, and sets `confirmed_history_only`.
11. **Missing dose:** a current medication without dose creates a follow-up; Unknown keeps the dose incomplete.
12. **Historical lab:** a lab remains dated history and never becomes a condition or current fact.

## Duplicate and contradiction handling

13. **Same allergy:** Same allergy links normalized candidates and preserves both raw records.
14. **Different allergies:** Different allergies retains both normalized candidates.
15. **Unresolved duplicate:** Unknown or Skip keeps the duplicate unresolved and produces Needs review.
16. **Contradictory condition:** no source wins automatically; the patient selection becomes effective while both source records remain.
17. **Conflicting demographic:** the patient selects an imported value or enters a new one without modifying raw values.

## Skip, unknown, and answer changes

18. **Unknown:** closes the question for this intake, promotes nothing to current, and leaves an unresolved profile status.
19. **Skip:** records skipped status, infers nothing, and permits continuation.
20. **Changed answer:** changing current to historical appends a new event, supersedes effective state, and recomputes the profile without deleting history.

## Manual entry

21. **No medications:** None creates a confirmed empty category rather than a missing category.
22. **Manual medication:** creates a patient-entered normalized record and confirmation event but no imported raw record.
23. **Partial emergency contact:** known name plus Unknown phone retains the name and marks the contact incomplete.

## Completion and invariants

24. **All good:** all core categories confirmed or explicitly None produces “You’re all good.”
25. **Needs review:** missing, skipped, unknown, incomplete, contradictory, or unconfirmed core data produces “Needs review.”
26. **Queue completion:** intake finishes after every question is answered, skipped, unknown, or superseded; no health answer is forced.
27. **Raw immutability:** raw payloads and content hashes match before and after the full flow.
28. **Computed counts:** changing fixture contents changes the import summary automatically.
29. **Audit trail:** material answers, confirmations, and answer changes append expected audit events.
30. **No forbidden behavior:** no real connection, password collection, diagnosis, treatment, secrets, real PHI, or HIPAA-compliance claim exists.
