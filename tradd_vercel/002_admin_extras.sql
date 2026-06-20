// api/blog/[slug].js — GET /api/blog/:slug
const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  const { slug } = req.query;

  if (req.method === 'GET') {
    const { data, error } = await supabaseAdmin
      .from('blog_posts').select('*').eq('slug', slug).eq('published', true).single();
    if (error || !data) return res.status(404).json({ error: 'Post not found' });
    return res.status(200).json(data);
  }

  return res.status(405).json({ error: 'Method not allowed' });
};
