-- ═══════════════════════════════════════════════════════════
--  TradeFlow — Supabase Database Schema
--  Run this in Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- ── Profiles ──────────────────────────────────────────────
create table if not exists public.profiles (
  id           uuid primary key references auth.users(id) on delete cascade,
  email        text unique not null,
  name         text,
  avatar_url   text,
  plan         text default 'free' check (plan in ('free','pro','team')),
  role         text default 'user' check (role in ('user','admin')),
  timezone     text default 'UTC',
  default_currency text default 'USD',
  preferred_market text default 'Stocks',
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

alter table public.profiles enable row level security;

create policy "Users can view own profile"
  on public.profiles for select using (auth.uid() = id);

create policy "Users can update own profile"
  on public.profiles for update using (auth.uid() = id);

-- Admins can view all profiles
create policy "Admins can view all profiles"
  on public.profiles for select using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- ── Trades ────────────────────────────────────────────────
create table if not exists public.trades (
  id           text primary key default ('t_' || extract(epoch from now())::text),
  user_id      uuid not null references public.profiles(id) on delete cascade,
  symbol       text not null,
  direction    text check (direction in ('Long','Short')),
  entry        numeric,
  exit         numeric,
  qty          numeric,
  pnl          numeric default 0,
  date         date default current_date,
  strategy     text,
  setup        text,
  tags         text[] default '{}',
  notes        text,
  emotions     text,
  rating       int check (rating between 1 and 10),
  mistakes     text[] default '{}',
  screenshots  text[] default '{}',
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

alter table public.trades enable row level security;

create policy "Users can CRUD own trades"
  on public.trades for all using (auth.uid() = user_id);

create policy "Admins can view all trades"
  on public.trades for select using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

create index trades_user_id_idx on public.trades(user_id);
create index trades_date_idx on public.trades(date desc);
create index trades_symbol_idx on public.trades(symbol);

-- ── Blog Posts ────────────────────────────────────────────
create table if not exists public.blog_posts (
  id           uuid primary key default uuid_generate_v4(),
  author_id    uuid references public.profiles(id) on delete set null,
  title        text not null,
  slug         text unique not null,
  category     text default 'Strategy',
  excerpt      text,
  content      text,
  cover_image  text,
  read_time    text,
  author       text default 'TradeFlow Team',
  tags         text[] default '{}',
  seo_title    text,
  meta_desc    text,
  published    boolean default true,
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

alter table public.blog_posts enable row level security;

create policy "Anyone can read published posts"
  on public.blog_posts for select using (published = true);

create policy "Admins can manage posts"
  on public.blog_posts for all using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

create index blog_posts_slug_idx on public.blog_posts(slug);
create index blog_posts_created_idx on public.blog_posts(created_at desc);

-- ── User Goals ────────────────────────────────────────────
create table if not exists public.user_goals (
  id           uuid primary key default uuid_generate_v4(),
  user_id      uuid not null references public.profiles(id) on delete cascade,
  title        text not null,
  target       numeric,
  current_val  numeric default 0,
  type         text default 'custom',
  period       text default 'monthly',
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

alter table public.user_goals enable row level security;
create policy "Users can CRUD own goals" on public.user_goals for all using (auth.uid() = user_id);

-- ── Playbook Rules ────────────────────────────────────────
create table if not exists public.playbook_rules (
  id           uuid primary key default uuid_generate_v4(),
  user_id      uuid not null references public.profiles(id) on delete cascade,
  title        text not null,
  description  text,
  category     text default 'Entry',
  active       boolean default true,
  created_at   timestamptz default now()
);

alter table public.playbook_rules enable row level security;
create policy "Users can CRUD own rules" on public.playbook_rules for all using (auth.uid() = user_id);

-- ── Announcements ─────────────────────────────────────────
create table if not exists public.announcements (
  id           uuid primary key default uuid_generate_v4(),
  message      text not null,
  type         text default 'info' check (type in ('info','success','warning','error')),
  link         text,
  expires_at   timestamptz,
  active       boolean default true,
  created_at   timestamptz default now()
);

alter table public.announcements enable row level security;
create policy "Anyone can read active announcements"
  on public.announcements for select using (active = true);
create policy "Admins can manage announcements"
  on public.announcements for all using (
    exists (select 1 from public.profiles where id = auth.uid() and role = 'admin')
  );

-- ── Auto-update updated_at trigger ────────────────────────
create or replace function update_updated_at()
returns trigger as $$
begin new.updated_at = now(); return new; end;
$$ language plpgsql;

create trigger trg_profiles_updated_at   before update on public.profiles   for each row execute function update_updated_at();
create trigger trg_trades_updated_at     before update on public.trades      for each row execute function update_updated_at();
create trigger trg_blog_updated_at       before update on public.blog_posts  for each row execute function update_updated_at();
create trigger trg_goals_updated_at      before update on public.user_goals  for each row execute function update_updated_at();

-- ── Seed: first admin user (update email after creation) ──
-- UPDATE public.profiles SET role = 'admin' WHERE email = 'your@email.com';
