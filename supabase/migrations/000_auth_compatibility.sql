-- ============================================================================
-- 000_auth_compatibility.sql: Standalone PostgreSQL Auth Compatibility Layer
-- Ensures seamless operation in local Docker PostgreSQL as well as Supabase.
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SCHEMA IF NOT EXISTS auth;

CREATE TABLE IF NOT EXISTS auth.users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Compatibility function for auth.uid() when running in standalone PostgreSQL
CREATE OR REPLACE FUNCTION auth.uid()
RETURNS UUID AS $$
BEGIN
    RETURN NULLIF(current_setting('request.jwt.claim.sub', true), '')::UUID;
EXCEPTION WHEN OTHERS THEN
    RETURN NULL;
END;
$$ LANGUAGE plpgsql STABLE;

-- Insert default demo accounts into auth.users if not present
INSERT INTO auth.users (id, email)
VALUES 
    ('a0000000-0000-0000-0000-000000000001', 'anitha.class10@tnschools.gov.in'),
    ('a0000000-0000-0000-0000-000000000002', 'admin.curriculum@tnschools.gov.in')
ON CONFLICT (id) DO NOTHING;
