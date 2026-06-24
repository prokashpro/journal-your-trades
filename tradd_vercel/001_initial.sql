const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method === 'GET') {
    const isAdmin = req.query.admin === '1';
    let query = supabaseAdmin.from('blog_posts').select('*').order('created_at', { ascending: false });
    if (!isAdmin) query = query.eq('published', true);
    const { data, error } = await query;
    if (error) return res.status(500).json({ error: error.message });
    return res.status(200).json(data || []);
  }

  if (req.method === 'POST') {
    const post = { ...req.body, updated_at: new Date().toISOString() };
    const { data, error } = await supabaseAdmin.from('blog_posts').insert(post).select().single();
    if (error) return res.status(400).json({ error: error.message });
    return res.status(201).json(data);
  }

  if (req.method === 'PUT') {
    const { id, ...fields } = req.body || {};
    if (!id) return res.status(400).json({ error: 'Missing id' });
    fields.updated_at = new Date().toISOString();
    const { data, error } = await supabaseAdmin.from('blog_posts').update(fields).eq('id', id).select().single();
    if (error) return res.status(400).json({ error: error.message });
    return res.status(200).json(data);
  }

  if (req.method === 'DELETE') {
    const { id } = req.query;
    if (!id) return res.status(400).json({ error: 'Missing id' });
    const { error } = await supabaseAdmin.from('blog_posts').delete().eq('id', id);
    if (error) return res.status(400).json({ error: error.message });
    return res.status(200).json({ success: true });
  }

  return res.status(405).json({ error: 'Method not allowed' });
};
