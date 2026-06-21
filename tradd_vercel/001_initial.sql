// api/blog/index.js — GET (list) + POST/PUT/DELETE (admin only)
const { supabaseAdmin } = require('../../lib/supabase');
const { verifyToken } = require('../../lib/auth');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

async function requireAdmin(req) {
  const user = await verifyToken(req);
  if (!user) return null;
  const { data: profile } = await supabaseAdmin
    .from('profiles').select('role').eq('id', user.id).single();
  if (profile?.role !== 'admin') return null;
  return user;
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method === 'GET') {
    if (req.query.admin === '1') {
            const { data, error } = await supabaseAdmin
        .from('blog_posts').select('*').order('created_at', { ascending: false });
      if (error) return res.status(500).json({ error: error.message });
      return res.status(200).json(data || []);
    }
    const { data, error } = await supabaseAdmin
      .from('blog_posts')
      .select('id,title,slug,category,excerpt,cover_image,read_time,author,created_at,updated_at,tags')
      .eq('published', true)
      .order('created_at', { ascending: false });
    if (error) return res.status(500).json({ error: error.message });
    return res.status(200).json(data || []);
  }

  if (req.method === 'POST') {

    const post = {
      ...req.body,
      author_id: user.id,
      published: req.body.published !== false,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString()
    };
    const { data, error } = await supabaseAdmin.from('blog_posts').insert(post).select().single();
    if (error) return res.status(400).json({ error: error.message });
    return res.status(201).json(data);
  }

  if (req.method === 'PUT') {

    const { id, ...fields } = req.body || {};
    if (!id) return res.status(400).json({ error: 'Missing id' });
    fields.updated_at = new Date().toISOString();

    const { data, error } = await supabaseAdmin
      .from('blog_posts').update(fields).eq('id', id).select().single();
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
