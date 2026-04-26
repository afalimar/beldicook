-- ============================================================
-- AUTH SETUP - Sync m3a Supabase Auth
-- ============================================================
-- Had SQL kay-rabbet bin auth.users (Supabase Auth) ou public.users
-- Bach mnin n-zid user f'auth, automatic kay-tcrée f'public.users

-- ============================================================
-- 1. Update users table bach t-correspondi m3a auth.users
-- ============================================================

-- Awel, drop trigger qadim ila kayn
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP FUNCTION IF EXISTS public.handle_new_user();

-- Update users table bach id ykoun reference l'auth.users
-- ⚠️ Ila 3andek déjà data f'users, sauvegard'h qbel
ALTER TABLE public.users 
  DROP CONSTRAINT IF EXISTS users_pkey CASCADE;

ALTER TABLE public.users 
  ADD CONSTRAINT users_pkey PRIMARY KEY (id);

-- Reference l'auth.users
-- (Ma kay-derni-ch ila déjà kayn)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'users_id_fkey' AND table_name = 'users'
    ) THEN
        ALTER TABLE public.users 
        ADD CONSTRAINT users_id_fkey 
        FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- ============================================================
-- 2. Trigger: Mnin t-crée user f'auth, automatic f'public.users
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    -- Khdem metadata li dkhol b'admin mnin signupti
    INSERT INTO public.users (
        id, 
        email, 
        full_name, 
        phone, 
        role, 
        restaurant_id,
        is_active
    )
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', 'Staff'),
        NEW.raw_user_meta_data->>'phone',
        COALESCE(NEW.raw_user_meta_data->>'role', 'cashier'),
        COALESCE(
            (NEW.raw_user_meta_data->>'restaurant_id')::uuid, 
            '11111111-1111-1111-1111-111111111111'::uuid
        ),
        true
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================
-- 3. View: All staff (l'admin panel)
-- ============================================================
CREATE OR REPLACE VIEW v_staff_with_auth AS
SELECT 
    u.id,
    u.full_name,
    u.email,
    u.phone,
    u.role,
    u.is_active,
    u.created_at,
    u.last_login,
    au.email_confirmed_at IS NOT NULL AS email_verified,
    au.last_sign_in_at AS last_auth_signin
FROM public.users u
LEFT JOIN auth.users au ON au.id = u.id
WHERE u.role != 'customer'
ORDER BY u.created_at DESC;

-- ============================================================
-- 4. RLS Policies (basita, l'auth)
-- ============================================================
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Drop old policies
DROP POLICY IF EXISTS "Users see own profile" ON public.users;

-- Helper: Khdem role dyal user current
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS TEXT AS $$
    SELECT role FROM public.users WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

CREATE OR REPLACE FUNCTION public.get_my_restaurant()
RETURNS UUID AS $$
    SELECT restaurant_id FROM public.users WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- Policies l'users table
CREATE POLICY "Users read own profile"
ON public.users FOR SELECT
USING (id = auth.uid());

CREATE POLICY "Admin reads all staff"
ON public.users FOR SELECT
USING (public.get_my_role() = 'admin');

CREATE POLICY "Admin manages staff"
ON public.users FOR ALL
USING (public.get_my_role() = 'admin');

-- ============================================================
-- 5. Update last_login automatic
-- ============================================================
CREATE OR REPLACE FUNCTION public.update_last_login()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.users 
    SET last_login = NOW() 
    WHERE id = NEW.user_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- IMPORTANT: Sample admin user 
-- ============================================================
-- Ma tqder-ch t-créerih hna directly!
-- Khass t-mch f'Supabase → Authentication → Users → "Add user"
-- Ou f'metadata zid: {"role": "admin", "full_name": "Boss"}
-- 
-- Wla men SQL editor:
-- (Hadi ma-ghadi-ch t-khdem ila ma kontich super-admin)
-- 
-- L'tariqa l'sahla:
-- 1. Sir l Authentication → Users
-- 2. Click "Add user" → "Create new user"  
-- 3. Email: ton-email@domain.com
-- 4. Password: choisi password strong
-- 5. Auto Confirm User: ✓ (oui)
-- 6. Click "Create user"
-- 7. Ba3d, sir l Table Editor → users → khdem row dyalek
-- 8. Update role l 'admin'
