// api/config/index.js
const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization,X-Admin-Key');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();

  // GET — public, no auth needed
  if (req.method === 'GET') {
    try {
      const { key } = req.query;
      if (key) {
        const { data } = await supabaseAdmin
          .from('site_config').select('key,value').eq('key', key).single();
        return res.status(200).json({ key, value: data?.value || {} });
      }
      const { data, error } = await supabaseAdmin.from('site_config').select('key,value');
      if (error) return res.status(500).json({ error: error.message });
      const config = {};
      (data || []).forEach(r => { config[r.key] = r.value; });
      return res.status(200).json({ config });
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }

  // PUT — save config (no auth check — protected by admin.html password gate)
  if (req.method === 'PUT') {
    try {
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
