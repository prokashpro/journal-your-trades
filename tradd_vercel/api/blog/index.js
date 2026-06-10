// api/blog/index.js — GET (list) + POST (create, admin only) /api/blog
const { supabaseAdmin } = require('../../lib/supabase');
const { verifyToken } = require('../../lib/auth');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method === 'GET') {
    // Public: list published posts
    const { data, error } = await supabaseAdmin
      .from('blog_posts').select('id,title,slug,category,excerpt,cover_image,read_time,author,created_at,updated_at,tags')
      .eq('published', true)
      .order('created_at', { ascending: false });
    if (error) return res.status(500).json({ error: error.message });
    return res.status(200).json(data);
  }

  if (req.method === 'POST') {
    const user = await verifyToken(req);
    if (!user) return res.status(401).json({ error: 'Unauthorized' });

    // Check admin role
    const { data: profile } = await supabaseAdmin
      .from('profiles').select('role').eq('id', user.id).single();
    if (profile?.role !== 'admin') return res.status(403).json({ error: 'Admin only' });

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

  return res.status(405).json({ error: 'Method not allowed' });
};
