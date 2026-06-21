// api/admin/users.js — GET all users (admin only)
const { supabaseAdmin } = require('../../lib/supabase');
const { verifyToken } = require('../../lib/auth');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
}

module.exports = async (req, res) => {
  cors(res);
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'GET') return res.status(405).json({ error: 'Method not allowed' });

  // Get profiles with trade stats
  const { data: profiles, error } = await supabaseAdmin
    .from('profiles')
    .select('id, email, name, plan, role, created_at, updated_at')
    .order('created_at', { ascending: false });

  if (error) return res.status(500).json({ error: error.message });

  // Get trade counts per user
  const { data: tradeCounts } = await supabaseAdmin
    .from('trades')
    .select('user_id, pnl');

  const statsMap = {};
  (tradeCounts || []).forEach(t => {
    if (!statsMap[t.user_id]) statsMap[t.user_id] = { count: 0, pnl: 0, wins: 0 };
    statsMap[t.user_id].count++;
    statsMap[t.user_id].pnl += parseFloat(t.pnl || 0);
    if (parseFloat(t.pnl || 0) > 0) statsMap[t.user_id].wins++;
  });

  const users = (profiles || []).map(p => ({
    id: p.id,
    name: p.name || p.email?.split('@')[0] || 'User',
    email: p.email,
    plan: p.plan || 'free',
    role: p.role || 'user',
    createdAt: p.created_at,
    trades: statsMap[p.id]?.count || 0,
    pnl: statsMap[p.id]?.pnl || 0,
    winRate: statsMap[p.id]?.count
      ? Math.round((statsMap[p.id].wins / statsMap[p.id].count) * 100)
      : 0
  }));

  return res.status(200).json({ users });
};
