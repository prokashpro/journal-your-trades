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
  let urlPreview = null;

  if (process.env.SUPABASE_URL) {
    const url = process.env.SUPABASE_URL;
    // Show first 15 and last 10 chars, mask the middle, reveal length and any whitespace/quotes
    urlPreview = {
      length: url.length,
      startsWithHttps: url.startsWith('https://'),
      hasTrailingSlash: url.endsWith('/'),
      hasQuotes: url.includes('"') || url.includes("'"),
      hasWhitespace: url !== url.trim(),
      preview: url.slice(0, 20) + '...' + url.slice(-15)
    };
  }

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
    url_check: urlPreview,
    supabase_connected: supabaseConnected,
    supabase_error: supabaseError
  });
};
