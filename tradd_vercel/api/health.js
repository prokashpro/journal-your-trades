// api/health.js — GET /api/health (used by frontend to detect backend)
module.exports = (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.status(200).json({ ok: true, ts: Date.now(), env: 'vercel' });
};
