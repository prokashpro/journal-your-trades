// api/auth/google.js — POST /api/auth/google
// Returns Supabase Google OAuth redirect URL
const { supabase } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const redirectTo = process.env.SITE_URL
      ? `${process.env.SITE_URL}/auth/callback`
      : `https://journal-your-trades.vercel.app/auth/callback`;

    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: { redirectTo }
    });

    if (error) return res.status(400).json({ error: error.message });
    return res.status(200).json({ url: data.url });
  } catch (e) {
    return res.status(500).json({ error: 'Google auth unavailable' });
  }
};
