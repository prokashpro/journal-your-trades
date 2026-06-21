# TradeFlow — Vercel + Supabase Deployment Guide

## 📁 Project Structure

```
tradd_vercel/
├── api/                    ← Vercel serverless functions
│   ├── health.js           ← GET /api/health
│   ├── auth/
│   │   ├── signup.js       ← POST /api/auth/signup
│   │   ├── signin.js       ← POST /api/auth/signin
│   │   └── me.js           ← GET /api/auth/me
│   ├── trades/
│   │   ├── index.js        ← GET + POST /api/trades
│   │   └── [id].js         ← PUT + DELETE /api/trades/:id
│   ├── blog/
│   │   ├── index.js        ← GET + POST /api/blog
│   │   └── [slug].js       ← GET /api/blog/:slug
│   └── user/
│       └── profile.js      ← GET + PUT /api/user/profile
├── lib/
│   ├── supabase.js         ← Supabase client
│   └── auth.js             ← JWT verification
├── public/
│   ├── index.html          ← Main app (tradd.html)
│   └── admin.html          ← Admin panel
├── supabase/
│   └── migrations/
│       └── 001_initial.sql ← Database schema
├── vercel.json             ← Vercel config
├── package.json
└── .env.example            ← Copy to .env.local
```

---

## 🚀 Step-by-Step Deployment

### Step 1 — Set up Supabase

1. Go to [supabase.com](https://supabase.com) → Create new project
2. Wait for it to finish (takes ~2 min)
3. Go to **SQL Editor** → paste the full contents of `supabase/migrations/001_initial.sql` → Run
4. Go to **Settings → API** and copy:
   - **Project URL** → `SUPABASE_URL`
   - **anon public key** → `SUPABASE_ANON_KEY`
   - **service_role secret key** → `SUPABASE_SERVICE_KEY`
5. Go to **Authentication → Providers** → enable **Email** (already on by default)
6. *(Optional)* To enable Google OAuth: Authentication → Providers → Google → add your Google OAuth credentials

---

### Step 2 — Deploy to Vercel

#### Option A — Vercel CLI (recommended)

```bash
# Install Vercel CLI
npm install -g vercel

# Clone or unzip this project, then:
cd tradd_vercel
npm install

# Add your environment variables to Vercel
vercel env add SUPABASE_URL
vercel env add SUPABASE_ANON_KEY
vercel env add SUPABASE_SERVICE_KEY
vercel env add JWT_SECRET    # any random 32+ char string

# Deploy
vercel --prod
```

#### Option B — Vercel Dashboard (no CLI)

1. Go to [vercel.com](https://vercel.com) → New Project → Import Git Repository
2. Push this folder to a GitHub repo first, then import it
3. In Vercel project settings → **Environment Variables**, add:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_KEY`
   - `JWT_SECRET`
4. Click **Deploy**

---

### Step 3 — Make yourself Admin

After your first sign up:

1. Go to Supabase Dashboard → **Table Editor** → `profiles`
2. Find your row → click edit → change `role` from `user` to `admin`
3. Now you can access `/admin.html` with full control

Or run in SQL Editor:
```sql
UPDATE public.profiles SET role = 'admin' WHERE email = 'your@email.com';
```

---

### Step 4 — Test locally

```bash
# Copy env file
cp .env.example .env.local
# Fill in your Supabase values in .env.local

# Run locally
npm run dev
# Opens at http://localhost:3000
```

---

## 🔌 API Reference

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| GET | `/api/health` | None | Health check |
| POST | `/api/auth/signup` | None | Create account |
| POST | `/api/auth/signin` | None | Login |
| GET | `/api/auth/me` | Bearer | Get current user |
| GET | `/api/trades` | Bearer | List user's trades |
| POST | `/api/trades` | Bearer | Create/update trade |
| PUT | `/api/trades/:id` | Bearer | Update a trade |
| DELETE | `/api/trades/:id` | Bearer | Delete a trade |
| GET | `/api/blog` | None | List published posts |
| GET | `/api/blog/:slug` | None | Get single post |
| POST | `/api/blog` | Admin | Create post |
| GET | `/api/user/profile` | Bearer | Get profile |
| PUT | `/api/user/profile` | Bearer | Update profile |

---

## 🗄️ Database Tables

| Table | Purpose |
|-------|---------|
| `profiles` | User accounts (extends Supabase auth.users) |
| `trades` | All trade entries |
| `blog_posts` | Blog articles |
| `user_goals` | Trading goals |
| `playbook_rules` | Trading rules |
| `announcements` | Site-wide banners |

---

## 🔒 Security Notes

- **Service key** (`SUPABASE_SERVICE_KEY`) is only used server-side in API routes — never exposed to browser
- **Row Level Security (RLS)** is enabled on all tables — users can only see their own data
- **Admin role** is required to manage blog posts and view all users
- All API routes validate the Supabase JWT before processing

---

## 🧩 How it connects

The frontend (`public/index.html`) calls `/api/health` on load.
- **If `/api/health` returns `ok: true`** → uses server API for auth + data (Supabase mode)
- **If offline / no backend** → falls back to localStorage (demo mode)

This means the app works both as a **standalone HTML file** (localStorage only) and as a **full Supabase-backed app** (when deployed to Vercel).
