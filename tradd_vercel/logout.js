// api/user/profile.js — GET + PUT /api/user/profile
const { requireAuth } = require('../../lib/auth');
const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = requireAuth(async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  const uid = req.user.id;

  if (req.method === 'GET') {
    const { data, error } = await supabaseAdmin
      .from('profiles').select('*').eq('id', uid).single();
    if (error) return res.status(404).json({ error: 'Profile not found' });
    return res.status(200).json(data);
  }

  if (req.method === 'PUT') {
    const allowed = ['name', 'avatar_url', 'timezone', 'default_currency', 'preferred_market'];
    const update = {};
    allowed.forEach(k => { if (req.body[k] !== undefined) update[k] = req.body[k]; });
    update.updated_at = new Date().toISOString();

    const { data, error } = await supabaseAdmin
      .from('profiles').update(update).eq('id', uid).select().single();
    if (error) return res.status(400).json({ error: error.message });
    return res.status(200).json(data);
  }

  return res.status(405).json({ error: 'Method not allowed' });
});
