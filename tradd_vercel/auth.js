const { supabaseAdmin } = require('../../lib/supabase');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  res.setHeader('Set-Cookie', 'tf_session=; Path=/; HttpOnly; SameSite=Strict; Max-Age=0');
  return res.status(200).json({ success: true });
};
