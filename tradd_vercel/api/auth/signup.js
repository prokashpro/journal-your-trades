// api/auth/signup.js — POST /api/auth/signup
const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const { email, password, name } = req.body || {};
  if (!email || !password) return res.status(400).json({ error: 'Email and password required' });
  if (password.length < 6) return res.status(400).json({ error: 'Password must be at least 6 characters' });

  try {
    const { data: authData, error: authErr } = await supabaseAdmin.auth.admin.createUser({
      email, password, email_confirm: true,
      user_metadata: { name: name || email.split('@')[0] }
    });
    if (authErr) return res.status(400).json({ error: authErr.message });

    await supabaseAdmin.from('profiles').upsert({
      id: authData.user.id, email,
      name: name || email.split('@')[0],
      plan: 'free', created_at: new Date().toISOString()
    });

    const { data: signIn, error: signInErr } = await supabaseAdmin.auth.signInWithPassword({ email, password });
    if (signInErr) return res.status(400).json({ error: signInErr.message });

    return res.status(200).json({
      token: signIn.session.access_token,
      user: { id: authData.user.id, email, name: name || email.split('@')[0], plan: 'free' }
    });
  } catch (e) {
    console.error('Signup error:', e);
    return res.status(500).json({ error: 'Server error' });
  }
};
