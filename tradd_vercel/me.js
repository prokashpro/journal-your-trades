// api/trades/[id].js — PUT + DELETE /api/trades/:id
const { requireAuth } = require('../../lib/auth');
const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = requireAuth(async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  const { id } = req.query;
  const uid = req.user.id;

  if (req.method === 'PUT') {
    const { data, error } = await supabaseAdmin
      .from('trades').update({ ...req.body, updated_at: new Date().toISOString() })
      .eq('id', id).eq('user_id', uid).select().single();
    if (error) return res.status(400).json({ error: error.message });
    return res.status(200).json(data);
  }

  if (req.method === 'DELETE') {
    const { error } = await supabaseAdmin
      .from('trades').delete().eq('id', id).eq('user_id', uid);
    if (error) return res.status(400).json({ error: error.message });
    return res.status(204).end();
  }

  return res.status(405).json({ error: 'Method not allowed' });
});
