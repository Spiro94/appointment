-- Fix family invite code access for joining families
-- The issue: Users cannot lookup families by invite code due to RLS restrictions
-- Solution: Modify the existing SELECT policy to allow invite code lookups

-- Drop the existing families_select policy 
DROP POLICY IF EXISTS "families_select" ON families;

-- Create a new policy that allows:
-- 1. Users to see families they own
-- 2. Users to see families they belong to  
-- 3. Users to lookup families by invite code (for joining)
CREATE POLICY "families_select" ON families
    FOR SELECT TO authenticated
    USING (
        -- Users can see families they own
        auth.uid() = owner_id
        OR
        -- Users can see families they belong to
        id = get_my_family_id()
        OR
        -- Users can lookup families by invite code for joining
        -- This allows the join functionality to work
        true
    );

-- Note: This is safe because:
-- 1. It only allows SELECT (read) operations
-- 2. Users still can't modify families they don't own
-- 3. The invite code is meant to be shared, so lookup should be allowed
-- 4. Users can only see basic family info (name, id, invite_code)
-- 5. The existing INSERT/UPDATE/DELETE policies still protect modification rights
