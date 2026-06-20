// api/auth/logout.js — POST /api/auth/logout
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

  try {
    // Extract token from Authorization header or cookie
    const authHeader = req.headers['authorization'] || '';
    const token = authHeader.startsWith('Bearer ') ? authHeader.slice(7) : null;

    if (token) {
      // Sign out the user server-side via Supabase admin
      await supabaseAdmin.auth.admin.signOut(token).catch(() => {});
    }

    // Clear session cookie
    res.setHeader('Set-Cookie', 'tf_session=; Path=/; HttpOnly; SameSite=Strict; Max-Age=0');
    return res.status(200).json({ success: true });
  } catch (e) {
    // Always return 200 on logout — client should clear local state regardless
    return res.status(200).json({ success: true });
  }
};
