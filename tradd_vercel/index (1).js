-- ═══════════════════════════════════════════════════════════
--  Journal Your Trades — Migration 002: Admin Panel Extras
--  Run AFTER 001_initial.sql in Supabase SQL Editor
--  Adds: site_config, feature_flags tables only
--  (profiles, trades, blog_posts, announcements already exist)
-- ═══════════════════════════════════════════════════════════

-- ── Site Config (landing page settings: hero, theme, pricing, seo, nav) ──
create table if not exists public.site_config (
  key          text primary key,
  value        jsonb not null default '{}',
  updated_at   timestamptz default now(),
  updated_by   uuid references public.profiles(id)
);

alter table public.site_config enable row level security;

create policy "Anyone can read site config"
  on public.site_config for select using (true);

create policy "Admins can manage site config"
  on public.site_config for all using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- ── Feature Flags ─────────────────────────────────────────
create table if not exists public.feature_flags (
  key          text primary key,
  enabled      boolean default true,
  updated_at   timestamptz default now()
);

alter table public.feature_flags enable row level security;

create policy "Anyone can read feature flags"
  on public.feature_flags for select using (true);

create policy "Admins can manage feature flags"
  on public.feature_flags for all using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- ── Seed default config values ────────────────────────────
insert into public.site_config (key, value) values
  ('hero', '{"title":"The market is the teacher.","subtitle":"Your journal is the textbook.","cta":"Start journaling free"}'),
  ('theme', '{"accent":"#6366f1","accent2":"#8b5cf6","headFont":"Montserrat"}'),
  ('pricing', '{"plans":[]}'),
  ('seo', '{"title":"Journal Your Trades — AI-Powered Trading Journal","desc":"The AI-powered trading journal that finds your blind spots, tracks your edge, and helps you grow as a trader.","url":"https://journal-your-trades.vercel.app","og":""}'),
  ('nav_links', '{"links":[]}'),
  ('sections_config', '{"order":[]}'),
  ('announcement_bar', '{"enabled":false}')
on conflict (key) do nothing;

-- ── IMPORTANT — make yourself an admin ────────────────────
-- 1. Sign up on your live site first (creates your profile row)
-- 2. Then run this with YOUR email:
-- update public.profiles set role = 'admin' where email = 'your-email@example.com';
