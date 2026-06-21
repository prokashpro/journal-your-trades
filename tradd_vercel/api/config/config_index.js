// api/config/index.js — site configuration
// GET /api/config            → all config (public)
// GET /api/config?key=hero   → one config key (public)
// PUT /api/config            → upsert a key (uses admin password, no token needed)
const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization,X-Admin-Key');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method === 'GET') {
    try {
      const { key } = req.query;
      if (key) {
        const { data, error } = await supabaseAdmin
          .from('site_config').select('key,value').eq('key', key).single();
        if (error || !data) return res.status(200).json({ key, value: {} });
        return res.status(200).json({ key: data.key, value: data.value });
      }
      const { data, error } = await supabaseAdmin.from('site_config').select('key,value');
      if (error) return res.status(500).json({ error: error.message });
      const config = {};
      (data || []).forEach(row => { config[row.key] = row.value; });
      return res.status(200).json({ config });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  if (req.method === 'PUT') {
    try {
      // Check admin key from header instead of JWT token
      const adminKey = req.headers['x-admin-key'] || '';
      const validKey = process.env.JWT_SECRET || 'jut-admin-2025';
      if (adminKey !== validKey) {
        return res.status(403).json({ error: 'Invalid admin key' });
      }

      const { key, value } = req.body || {};
      if (!key) return res.status(400).json({ error: 'Missing key' });

      const { error } = await supabaseAdmin
        .from('site_config')
        .upsert({ key, value, updated_at: new Date().toISOString() });

      if (error) return res.status(500).json({ error: error.message });
      return res.status(200).json({ success: true });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  return res.status(405).json({ error: 'Method not allowed' });
};
