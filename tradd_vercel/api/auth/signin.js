// api/auth/signin.js — POST /api/auth/signin
const { supabase, supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const { email, password } = req.body || {};
  if (!email || !password) return res.status(400).json({ error: 'Email and password required' });

  try {
    const { data, error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) return res.status(401).json({ error: 'Invalid email or password' });

    const { data: profile } = await supabaseAdmin
      .from('profiles').select('*').eq('id', data.user.id).single();

    return res.status(200).json({
      token: data.session.access_token,
      user: {
        id: data.user.id, email: data.user.email,
        name: profile?.name || data.user.user_metadata?.name || email.split('@')[0],
        plan: profile?.plan || 'free'
      }
    });
  } catch (e) {
    console.error('Signin error:', e);
    return res.status(500).json({ error: 'Server error' });
  }
};
