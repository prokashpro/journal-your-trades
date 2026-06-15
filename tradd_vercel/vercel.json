// api/config/index.js — site configuration (hero, theme, pricing, seo, nav, sections)
// GET /api/config            → all config (public)
// GET /api/config?key=hero   → one config key (public)
// PUT /api/config             → upsert a key (admin only)
const { supabaseAdmin } = require('../../lib/supabase');
const { verifyToken } = require('../../lib/auth');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method === 'GET') {
    const { key } = req.query;
    if (key) {
      const { data, error } = await supabaseAdmin
        .from('site_config').select('key,value').eq('key', key).single();
      if (error || !data) return res.status(404).json({ error: 'Not found' });
      return res.status(200).json({ key: data.key, value: data.value });
    }
    const { data, error } = await supabaseAdmin.from('site_config').select('key,value');
    if (error) return res.status(500).json({ error: error.message });
    const config = {};
    (data || []).forEach(row => { config[row.key] = row.value; });
    return res.status(200).json({ config });
  }

  if (req.method === 'PUT') {
    const user = await verifyToken(req);
    if (!user) return res.status(401).json({ error: 'Unauthorized' });

    const { data: profile } = await supabaseAdmin
      .from('profiles').select('role').eq('id', user.id).single();
    if (profile?.role !== 'admin') return res.status(403).json({ error: 'Admin only' });

    const { key, value } = req.body || {};
    if (!key) return res.status(400).json({ error: 'Missing key' });

    const { error } = await supabaseAdmin
      .from('site_config')
      .upsert({ key, value, updated_at: new Date().toISOString(), updated_by: user.id });

    if (error) return res.status(500).json({ error: error.message });
    return res.status(200).json({ success: true });
  }

  return res.status(405).json({ error: 'Method not allowed' });
};
