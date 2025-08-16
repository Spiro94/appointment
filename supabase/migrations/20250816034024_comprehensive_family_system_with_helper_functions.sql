-- Comprehensive Family System Implementation
-- This migration combines all previous attempts into one working solution
-- with helper functions to avoid RLS recursion issues

-- Create families table
CREATE TABLE IF NOT EXISTS public.families (
    -- Primary identifier
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Family details
    name TEXT NOT NULL,
    
    -- Unique family code for invitations (6 characters, alphanumeric)
    invite_code TEXT UNIQUE NOT NULL,
    
    -- Family owner (creator)
    owner_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT families_name_not_empty CHECK (length(trim(name)) > 0),
    CONSTRAINT families_invite_code_format CHECK (invite_code ~ '^[A-Z0-9]{6}$')
);

-- Create user profiles table
CREATE TABLE IF NOT EXISTS public.user_profiles (
    -- Primary identifier (matches auth.users.id)
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    
    -- Family membership
    family_id UUID REFERENCES families(id) ON DELETE SET NULL,
    
    -- User details
    email TEXT,
    display_name TEXT,
    
    -- Family setup status
    has_completed_family_setup BOOLEAN DEFAULT FALSE,
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_families_owner_id ON families(owner_id);
CREATE INDEX IF NOT EXISTS idx_families_invite_code ON families(invite_code);
CREATE INDEX IF NOT EXISTS idx_user_profiles_family_id ON user_profiles(family_id);
CREATE INDEX IF NOT EXISTS idx_user_profiles_has_completed_family_setup ON user_profiles(has_completed_family_setup);

-- Enable Row Level Security (RLS)
ALTER TABLE families ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;

-- Drop all existing policies to start fresh
DROP POLICY IF EXISTS "families_all_access" ON families;
DROP POLICY IF EXISTS "families_select_policy" ON families;
DROP POLICY IF EXISTS "families_insert_policy" ON families;
DROP POLICY IF EXISTS "families_update_policy" ON families;
DROP POLICY IF EXISTS "families_delete_policy" ON families;

DROP POLICY IF EXISTS "user_profiles_own_access" ON user_profiles;
DROP POLICY IF EXISTS "user_profiles_family_access" ON user_profiles;
DROP POLICY IF EXISTS "user_profiles_select_policy" ON user_profiles;
DROP POLICY IF EXISTS "user_profiles_insert_policy" ON user_profiles;
DROP POLICY IF EXISTS "user_profiles_update_policy" ON user_profiles;
DROP POLICY IF EXISTS "user_profiles_delete_policy" ON user_profiles;

DROP POLICY IF EXISTS "appointments_own_access" ON appointments;
DROP POLICY IF EXISTS "appointments_family_select" ON appointments;
DROP POLICY IF EXISTS "appointments_family_modify" ON appointments;
DROP POLICY IF EXISTS "appointments_family_delete" ON appointments;
DROP POLICY IF EXISTS "appointments_family_insert" ON appointments;
DROP POLICY IF EXISTS "appt_family_select" ON appointments;
DROP POLICY IF EXISTS "appt_family_insert" ON appointments;
DROP POLICY IF EXISTS "appt_family_update" ON appointments;
DROP POLICY IF EXISTS "appt_family_delete" ON appointments;
DROP POLICY IF EXISTS "Users can view their own appointments" ON appointments;
DROP POLICY IF EXISTS "Users can view family appointments" ON appointments;
DROP POLICY IF EXISTS "Users can insert their own appointments" ON appointments;
DROP POLICY IF EXISTS "Users can update their own appointments" ON appointments;
DROP POLICY IF EXISTS "Users can delete their own appointments" ON appointments;

-- Helper function: get current user's family_id
CREATE OR REPLACE FUNCTION get_my_family_id()
RETURNS UUID
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT family_id
  FROM user_profiles
  WHERE id = auth.uid()
$$;

-- Revoke and grant proper permissions
REVOKE ALL ON FUNCTION get_my_family_id() FROM public;
GRANT EXECUTE ON FUNCTION get_my_family_id() TO authenticated;

-- Helper function: get all family member IDs
CREATE OR REPLACE FUNCTION family_member_ids()
RETURNS SETOF UUID
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT u.id
  FROM user_profiles u
  WHERE u.family_id = get_my_family_id()
    AND u.family_id IS NOT NULL
$$;

-- Revoke and grant proper permissions
REVOKE ALL ON FUNCTION family_member_ids() FROM public;
GRANT EXECUTE ON FUNCTION family_member_ids() TO authenticated;

-- RLS Policies for families table
CREATE POLICY "families_select" ON families
    FOR SELECT TO authenticated
    USING (
        -- Users can see families they own
        auth.uid() = owner_id
        OR
        -- Users can see families they belong to
        id = get_my_family_id()
    );

CREATE POLICY "families_insert" ON families
    FOR INSERT TO authenticated
    WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "families_update" ON families
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner_id);

CREATE POLICY "families_delete" ON families
    FOR DELETE TO authenticated
    USING (auth.uid() = owner_id);

-- RLS Policies for user_profiles table
CREATE POLICY "user_profiles_own" ON user_profiles
    FOR ALL TO authenticated
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

CREATE POLICY "user_profiles_family_select" ON user_profiles
    FOR SELECT TO authenticated
    USING (
        family_id IS NOT NULL
        AND id IN (SELECT family_member_ids())
    );

-- RLS Policies for appointments table using helper functions
CREATE POLICY "appt_family_select" ON appointments
    FOR SELECT TO authenticated
    USING (user_id IN (SELECT family_member_ids()));

CREATE POLICY "appt_family_insert" ON appointments
    FOR INSERT TO authenticated
    WITH CHECK (user_id IN (SELECT family_member_ids()));

CREATE POLICY "appt_family_update" ON appointments
    FOR UPDATE TO authenticated
    USING (user_id IN (SELECT family_member_ids()))
    WITH CHECK (user_id IN (SELECT family_member_ids()));

CREATE POLICY "appt_family_delete" ON appointments
    FOR DELETE TO authenticated
    USING (user_id IN (SELECT family_member_ids()));

-- Function to generate unique invite codes
CREATE OR REPLACE FUNCTION generate_family_invite_code()
RETURNS TEXT AS $$
DECLARE
    new_code TEXT;
    code_exists BOOLEAN;
BEGIN
    LOOP
        -- Generate a 6-character alphanumeric code
        new_code := upper(substring(md5(random()::text || clock_timestamp()::text) from 1 for 6));
        -- Replace numbers with letters to avoid confusion
        new_code := translate(new_code, '0123456789', 'ABCDEFGHIJ');
        
        -- Check if code already exists
        SELECT EXISTS(SELECT 1 FROM families WHERE invite_code = new_code) INTO code_exists;
        
        -- If code is unique, exit loop
        IF NOT code_exists THEN
            EXIT;
        END IF;
    END LOOP;
    
    RETURN new_code;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to automatically create user profile on user registration
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.user_profiles (id, email)
    VALUES (NEW.id, NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create user profile when user signs up
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers to automatically update updated_at
DROP TRIGGER IF EXISTS update_families_updated_at ON families;
CREATE TRIGGER update_families_updated_at 
    BEFORE UPDATE ON families 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_user_profiles_updated_at ON user_profiles;
CREATE TRIGGER update_user_profiles_updated_at 
    BEFORE UPDATE ON user_profiles 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Add helpful comments
COMMENT ON TABLE families IS 'Stores family groups that users can belong to';
COMMENT ON COLUMN families.invite_code IS 'Unique 6-character code for inviting users to join the family';
COMMENT ON COLUMN families.owner_id IS 'User who created the family (has admin privileges)';

COMMENT ON TABLE user_profiles IS 'Extended user profile information linked to auth.users';
COMMENT ON COLUMN user_profiles.has_completed_family_setup IS 'Whether user has completed the family setup flow';
COMMENT ON COLUMN user_profiles.family_id IS 'Family the user belongs to (NULL if not in a family yet)';

COMMENT ON FUNCTION get_my_family_id() IS 'Helper function to get current user family ID, avoiding RLS recursion';
COMMENT ON FUNCTION family_member_ids() IS 'Helper function to get all family member IDs, avoiding RLS recursion';
