-- Journal Your Trades — Migration 003
-- Fix infinite recursion in RLS policies

CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean LANGUAGE sql SECURITY DEFINER SET search_path = public STABLE AS $$
  SELECT EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin');
$$;

DROP POLICY IF EXISTS "Admins can view all profiles" ON public.profiles;
CREATE POLICY "Admins can view all profiles" ON public.profiles FOR SELECT USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can view all trades" ON public.trades;
CREATE POLICY "Admins can view all trades" ON public.trades FOR SELECT USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can manage posts" ON public.blog_posts;
CREATE POLICY "Admins can manage posts" ON public.blog_posts FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can manage announcements" ON public.announcements;
CREATE POLICY "Admins can manage announcements" ON public.announcements FOR ALL USING (public.is_admin());
