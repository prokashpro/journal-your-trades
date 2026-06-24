const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method === 'GET') {
    const { data, error } = await supabaseAdmin.from('feature_flags').select('key,enabled');
    if (error) return res.status(500).json({ error: error.message });
    const flags = {};
    (data || []).forEach(r => { flags[r.key] = r.enabled; });
    return res.status(200).json({ flags });
  }

  if (req.method === 'PUT') {
    const { key, enabled } = req.body || {};
    if (!key) return res.status(400).json({ error: 'Missing key' });
    const { error } = await supabaseAdmin
      .from('feature_flags')
      .upsert({ key, enabled: !!enabled, updated_at: new Date().toISOString() });
    if (error) return res.status(500).json({ error: error.message });
    return res.status(200).json({ success: true });
  }

  return res.status(405).json({ error: 'Method not allowed' });
};
