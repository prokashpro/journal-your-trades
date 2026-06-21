// api/auth/me.js — GET /api/auth/me
const { requireAuth } = require('../../lib/auth');
const { supabaseAdmin } = require('../../lib/supabase');

module.exports = requireAuth(async (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
  if (req.method === 'OPTIONS') return res.status(200).end();

  const { data: profile } = await supabaseAdmin
    .from('profiles').select('*').eq('id', req.user.id).single();

  return res.status(200).json({
    id: req.user.id, email: req.user.email,
    name: profile?.name || req.user.user_metadata?.name,
    plan: profile?.plan || 'free',
    role: profile?.role || 'user',
    created_at: profile?.created_at
  });
});
