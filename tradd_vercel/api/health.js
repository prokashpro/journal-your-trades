// api/health.js — GET /api/health (diagnostic: checks env vars + Supabase connectivity)
module.exports = async (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');

  const checks = {
    SUPABASE_URL: !!process.env.SUPABASE_URL,
    SUPABASE_ANON_KEY: !!process.env.SUPABASE_ANON_KEY,
    SUPABASE_SERVICE_KEY: !!process.env.SUPABASE_SERVICE_KEY,
    JWT_SECRET: !!process.env.JWT_SECRET
  };

  let supabaseConnected = false;
  let supabaseError = null;

  if (checks.SUPABASE_URL && checks.SUPABASE_ANON_KEY) {
    try {
      const { createClient } = require('@supabase/supabase-js');
      const sb = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);
      const { error } = await sb.from('profiles').select('id').limit(1);
      if (error) {
        supabaseError = error.message;
      } else {
        supabaseConnected = true;
      }
    } catch (e) {
      supabaseError = e.message;
    }
  } else {
    supabaseError = 'Missing SUPABASE_URL or SUPABASE_ANON_KEY environment variable';
  }

  res.status(200).json({
    ok: true,
    ts: Date.now(),
    env: 'vercel',
    env_vars: checks,
    supabase_connected: supabaseConnected,
    supabase_error: supabaseError
  });
};
