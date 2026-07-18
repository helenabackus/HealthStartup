-- Proposed PostgreSQL schema for planning only.
-- Use synthetic data only. Do not deploy as production infrastructure.

CREATE TYPE imported_data_state AS ENUM (
  'current',
  'historical',
  'uncertain',
  'duplicate',
  'contradictory',
  'incomplete',
  'unconfirmed'
);

CREATE TYPE field_status_state AS ENUM (
  'missing',
  'imported_current_unconfirmed',
  'imported_historical',
  'imported_uncertain',
  'duplicate',
  'contradictory',
  'incomplete',
  'skipped',
  'unknown',
  'confirmed_current',
  'confirmed_history_only'
);

CREATE TYPE answer_state AS ENUM (
  'answered',
  'skipped',
  'unknown'
);

CREATE TYPE ai_proposal_status AS ENUM (
  'proposed',
  'accepted_by_rule',
  'presented_to_patient',
  'confirmed_by_patient',
  'rejected_by_patient',
  'expired',
  'superseded'
);

CREATE TABLE users (
  id uuid PRIMARY KEY,
  email text NOT NULL UNIQUE,
  password_hash text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE patient_profiles (
  id uuid PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES users(id),
  legal_name text,
  birth_date date,
  sex_assigned_at_birth text,
  gender_identity text,
  phone text,
  email text,
  address jsonb,
  emergency_contact jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE source_organizations (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  source_type text NOT NULL,
  fhir_base_url text,
  is_synthetic boolean NOT NULL DEFAULT true
);

CREATE TABLE source_connections (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  source_organization_id uuid NOT NULL REFERENCES source_organizations(id),
  connection_state text NOT NULL,
  connected_at timestamptz,
  revoked_at timestamptz,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb
);

CREATE TABLE import_batches (
  id uuid PRIMARY KEY,
  source_connection_id uuid NOT NULL REFERENCES source_connections(id),
  status text NOT NULL,
  started_at timestamptz NOT NULL DEFAULT now(),
  completed_at timestamptz,
  imported_record_count integer NOT NULL DEFAULT 0,
  summary jsonb NOT NULL DEFAULT '{}'::jsonb
);

CREATE TABLE raw_source_records (
  id uuid PRIMARY KEY,
  import_batch_id uuid NOT NULL REFERENCES import_batches(id),
  source_organization_id uuid NOT NULL REFERENCES source_organizations(id),
  source_record_id text,
  fhir_resource_type text,
  source_updated_at timestamptz,
  raw_payload jsonb NOT NULL,
  content_hash text NOT NULL,
  imported_state imported_data_state NOT NULL DEFAULT 'unconfirmed',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE medications (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  raw_source_record_id uuid REFERENCES raw_source_records(id),
  medication_name text NOT NULL,
  code_system text,
  code text,
  dose text,
  route text,
  frequency text,
  start_date date,
  end_date date,
  source_status text,
  imported_state imported_data_state NOT NULL,
  is_current boolean NOT NULL DEFAULT false,
  confirmed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE allergies (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  raw_source_record_id uuid REFERENCES raw_source_records(id),
  substance text NOT NULL,
  reaction text,
  severity text,
  clinical_status text,
  verification_status text,
  recorded_date date,
  imported_state imported_data_state NOT NULL,
  is_current boolean NOT NULL DEFAULT false,
  confirmed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE conditions (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  raw_source_record_id uuid REFERENCES raw_source_records(id),
  condition_name text NOT NULL,
  code_system text,
  code text,
  clinical_status text,
  verification_status text,
  onset_date date,
  abatement_date date,
  recorded_date date,
  imported_state imported_data_state NOT NULL,
  is_current boolean NOT NULL DEFAULT false,
  confirmed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE laboratory_results (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  raw_source_record_id uuid REFERENCES raw_source_records(id),
  test_name text NOT NULL,
  code_system text,
  code text,
  value_text text,
  value_number numeric,
  unit text,
  reference_range text,
  interpretation text,
  result_date timestamptz,
  imported_state imported_data_state NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE procedures (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  raw_source_record_id uuid REFERENCES raw_source_records(id),
  procedure_name text NOT NULL,
  code_system text,
  code text,
  status text,
  performed_date date,
  imported_state imported_data_state NOT NULL,
  confirmed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE immunizations (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  raw_source_record_id uuid REFERENCES raw_source_records(id),
  vaccine_name text NOT NULL,
  code_system text,
  code text,
  status text,
  occurrence_date date,
  imported_state imported_data_state NOT NULL,
  confirmed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE encounters (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  raw_source_record_id uuid REFERENCES raw_source_records(id),
  encounter_type text,
  encounter_class text,
  source_organization_id uuid REFERENCES source_organizations(id),
  started_at timestamptz,
  ended_at timestamptz,
  imported_state imported_data_state NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE questionnaire_questions (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  category text NOT NULL,
  question_type text NOT NULL,
  prompt text NOT NULL,
  context text,
  progress_label text,
  source_record_id uuid REFERENCES raw_source_records(id),
  field_key text,
  required boolean NOT NULL DEFAULT false,
  status text NOT NULL DEFAULT 'open',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE patient_answers (
  id uuid PRIMARY KEY,
  question_id uuid NOT NULL REFERENCES questionnaire_questions(id),
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  answer_state answer_state NOT NULL,
  answer_value jsonb NOT NULL DEFAULT '{}'::jsonb,
  answered_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE confirmation_events (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  patient_answer_id uuid REFERENCES patient_answers(id),
  target_table text NOT NULL,
  target_id uuid,
  event_type text NOT NULL,
  previous_value jsonb,
  confirmed_value jsonb,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE field_statuses (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  category text NOT NULL,
  field_key text NOT NULL,
  status field_status_state NOT NULL,
  status_reason text,
  updated_by_confirmation_event_id uuid REFERENCES confirmation_events(id),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (patient_profile_id, field_key)
);

CREATE TABLE audit_events (
  id uuid PRIMARY KEY,
  patient_profile_id uuid REFERENCES patient_profiles(id),
  actor_type text NOT NULL,
  actor_id uuid,
  event_type text NOT NULL,
  target_table text,
  target_id uuid,
  details jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE ai_proposals (
  id uuid PRIMARY KEY,
  patient_profile_id uuid NOT NULL REFERENCES patient_profiles(id),
  source_record_id uuid REFERENCES raw_source_records(id),
  proposal_type text NOT NULL,
  proposed_value jsonb NOT NULL,
  confidence_label text,
  reason text,
  prompt_version text NOT NULL,
  model_label text NOT NULL,
  status ai_proposal_status NOT NULL DEFAULT 'proposed',
  created_at timestamptz NOT NULL DEFAULT now(),
  resolved_at timestamptz
);

CREATE INDEX idx_raw_source_records_batch ON raw_source_records(import_batch_id);
CREATE INDEX idx_medications_profile_current ON medications(patient_profile_id, is_current);
CREATE INDEX idx_allergies_profile_current ON allergies(patient_profile_id, is_current);
CREATE INDEX idx_conditions_profile_current ON conditions(patient_profile_id, is_current);
CREATE INDEX idx_labs_profile_date ON laboratory_results(patient_profile_id, result_date);
CREATE INDEX idx_immunizations_profile_date ON immunizations(patient_profile_id, occurrence_date);
CREATE INDEX idx_encounters_profile_date ON encounters(patient_profile_id, started_at);
CREATE INDEX idx_questions_profile_status ON questionnaire_questions(patient_profile_id, status);
CREATE INDEX idx_field_status_profile ON field_statuses(patient_profile_id, category, status);
