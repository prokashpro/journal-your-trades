// api/trades/index.js — GET (list) + POST (create) /api/trades
const { requireAuth } = require('../../lib/auth');
const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = requireAuth(async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  const uid = req.user.id;

  if (req.method === 'GET') {
    const { data, error } = await supabaseAdmin
      .from('trades').select('*')
      .eq('user_id', uid)
      .order('date', { ascending: false });
    if (error) return res.status(500).json({ error: error.message });
    return res.status(200).json(data);
  }

  if (req.method === 'POST') {
    const trade = {
      ...req.body,
      user_id: uid,
      id: req.body.id || ('t_' + Date.now()),
      created_at: new Date().toISOString()
    };
    const { data, error } = await supabaseAdmin.from('trades').upsert(trade).select().single();
    if (error) return res.status(400).json({ error: error.message });
    return res.status(201).json(data);
  }

  return res.status(405).json({ error: 'Method not allowed' });
});
