-- ═══════════════════════════════════════════════════════════
--  Journal Your Trades — Admin Panel Connection Migration
--  Run this AFTER 001_initial.sql in Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════

-- ── Site Config (key-value store for landing page settings) ──
-- Used for: hero text, theme colors, pricing, SEO, nav links, sections order
create table if not exists public.site_config (
  key          text primary key,
  value        jsonb not null default '{}',
  updated_at   timestamptz default now(),
  updated_by   uuid references public.profiles(id)
);

alter table public.site_config enable row level security;

-- Anyone (including anonymous visitors) can READ site config
create policy "Anyone can read site config"
  on public.site_config for select using (true);

-- Only admins can write
create policy "Admins can write site config"
  on public.site_config for insert with check (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

create policy "Admins can update site config"
  on public.site_config for update using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- ── Blog Posts ────────────────────────────────────────────
create table if not exists public.blog_posts (
  id           text primary key default ('post_' || extract(epoch from now())::text),
  slug         text unique not null,
  title        text not null,
  subtitle     text,
  category     text,
  cover_image  text,
  body         text,
  excerpt      text,
  seo_title    text,
  seo_meta     text,
  author       text default 'Journal Your Trades Team',
  status       text default 'draft' check (status in ('draft','published')),
  read_time    text,
  published_at timestamptz,
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

alter table public.blog_posts enable row level security;

-- Anyone can read PUBLISHED posts
create policy "Anyone can read published posts"
  on public.blog_posts for select using (status = 'published' or
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- Only admins can write
create policy "Admins can insert posts"
  on public.blog_posts for insert with check (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

create policy "Admins can update posts"
  on public.blog_posts for update using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

create policy "Admins can delete posts"
  on public.blog_posts for delete using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- ── Announcements ─────────────────────────────────────────
create table if not exists public.announcements (
  id           text primary key default ('ann_' || extract(epoch from now())::text),
  message      text not null,
  link         text,
  type         text default 'info' check (type in ('info','success','warning','error')),
  active       boolean default true,
  expires_at   timestamptz,
  created_at   timestamptz default now()
);

alter table public.announcements enable row level security;

create policy "Anyone can read active announcements"
  on public.announcements for select using (true);

create policy "Admins can manage announcements"
  on public.announcements for all using (
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

-- ── Custom Pages (About, Pricing extras, etc) ─────────────
create table if not exists public.custom_pages (
  id           text primary key default ('page_' || extract(epoch from now())::text),
  slug         text unique not null,
  title        text not null,
  body         text,
  seo_title    text,
  seo_meta     text,
  published    boolean default true,
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

alter table public.custom_pages enable row level security;

create policy "Anyone can read published custom pages"
  on public.custom_pages for select using (published = true or
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

create policy "Admins can manage custom pages"
  on public.custom_pages for all using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- ── Seed default site_config values ───────────────────────
insert into public.site_config (key, value) values
  ('hero', '{"title":"The market is the teacher.","subtitle":"Your journal is the textbook.","cta":"Start journaling free"}'),
  ('theme', '{"accent":"#6366f1","accent2":"#8b5cf6","headFont":"Montserrat"}'),
  ('pricing', '{"plans":[]}'),
  ('seo', '{"title":"Journal Your Trades — AI-Powered Trading Journal","desc":"The AI-powered trading journal that finds your blind spots.","url":"https://journal-your-trades.vercel.app","og":""}'),
  ('nav_links', '{"links":[]}'),
  ('sections_config', '{"order":[]}')
on conflict (key) do nothing;

-- ── Make YOUR account an admin ─────────────────────────────
-- IMPORTANT: Replace 'your-email@example.com' with your actual signup email
-- Run this AFTER you've signed up on the live site at least once
-- update public.profiles set role = 'admin' where email = 'your-email@example.com';
