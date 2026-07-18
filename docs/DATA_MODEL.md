# Data Model

## Core principle

The MVP has three layers:

1. Raw imported records
   - Preserve original source/FHIR data unchanged.
   - Store source, batch, resource type, source identifiers, and raw JSON.

2. Medical history
   - Store normalized dated records.
   - Include medications, allergies, conditions, labs, procedures, immunizations, encounters, and other dated records.
   - History can include current, historical, uncertain, duplicate, contradictory, incomplete, and unconfirmed states.

3. Current profile
   - Store the best current view for intake reuse.
   - Include active medications, allergies, conditions, demographics, emergency contact, and other MVP fields.
   - Values are current only after patient confirmation or manual patient entry.

## Imported data states

- current
- historical
- uncertain
- duplicate
- contradictory
- incomplete
- unconfirmed

## Minimum entities

- users
- patient profiles
- source organizations
- source connections
- import batches
- raw source records
- medications
- allergies
- conditions
- laboratory results
- procedures
- questionnaire questions
- patient answers
- confirmation events
- field statuses
- audit events
- AI proposals

## Entity notes

### users

Stores account identity only. Do not store real medical facts directly on users.

### patient_profiles

Stores one patient-owned profile per user for MVP. Later versions may support dependents, but not in MVP.

### source_organizations

Stores synthetic or configured source metadata, such as Riverbend Health or Apple Health. Do not store real credentials.

### source_connections

Stores a patient's source connection state. In planning/test mode, use synthetic states only.

### import_batches

Groups a synthetic import run. Stores counts and status.

### raw_source_records

Stores unchanged source payloads. Never overwritten by AI normalization or patient answers.

### normalized clinical tables

Medication, allergy, condition, lab, procedure, immunization, and encounter tables store normalized data with source references and status.

### questionnaire_questions

Stores generated or seeded questions. Questions should reference the field, category, source record, and reason.

### patient_answers

Stores what the patient selected or typed.

### confirmation_events

Stores the event that confirms, rejects, marks unknown, or skips a proposed fact.

### field_statuses

Stores current state of each MVP profile field or category.

### audit_events

Stores user-visible audit trail for material changes.

### ai_proposals

Stores AI-suggested normalizations, flags, and question suggestions. AI proposals are not facts until accepted through explicit rules.

## Relationship summary

- user has one patient_profile in MVP.
- patient_profile has many source_connections.
- source_connection has many import_batches.
- import_batch has many raw_source_records.
- raw_source_records may be referenced by normalized medical history rows.
- normalized rows may create questionnaire_questions.
- patient_answers create confirmation_events.
- confirmation_events update field_statuses and, when appropriate, current profile rows.
- ai_proposals can point to raw_source_records and normalized rows but cannot directly modify confirmed data.

## No silent medical decisions

An imported or AI-normalized item cannot become a confirmed current medical fact without a patient confirmation event or explicit patient manual entry.
