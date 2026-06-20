// api/test_admin.js — temporary debug endpoint
// Visit: /api/test_admin (while logged in via admin panel)
const { supabaseAdmin } = require('../lib/supabase');
const { verifyToken } = require('../lib/auth');

module.exports = async (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');

  const result = { steps: [] };

  // Step 1: Check token
  const user = await verifyToken(req);
  if (!user) {
    result.steps.push({ step: 1, name: 'Token check', ok: false, error: 'No valid token — you are not logged in' });
    return res.status(200).json(result);
  }
  result.steps.push({ step: 1, name: 'Token check', ok: true, user_id: user.id, email: user.email });

  // Step 2: Check profile role
  const { data: profile, error: profileErr } = await supabaseAdmin
    .from('profiles').select('role,email').eq('id', user.id).single();
  if (profileErr) {
    result.steps.push({ step: 2, name: 'Profile check', ok: false, error: profileErr.message });
    return res.status(200).json(result);
  }
  result.steps.push({ step: 2, name: 'Profile check', ok: true, role: profile?.role, email: profile?.email });

  // Step 3: Check if admin
  if (profile?.role !== 'admin') {
    result.steps.push({ step: 3, name: 'Admin check', ok: false,
      error: `Your role is "${profile?.role}" — needs to be "admin". Run this SQL in Supabase: UPDATE public.profiles SET role='admin' WHERE email='${profile?.email}';`
    });
    return res.status(200).json(result);
  }
  result.steps.push({ step: 3, name: 'Admin check', ok: true });

  // Step 4: Check site_config table exists
  const { data: configData, error: configErr } = await supabaseAdmin
    .from('site_config').select('key').limit(1);
  if (configErr) {
    result.steps.push({ step: 4, name: 'site_config table', ok: false,
      error: configErr.message + ' — Run 002_admin_extras.sql in Supabase SQL Editor'
    });
    return res.status(200).json(result);
  }
  result.steps.push({ step: 4, name: 'site_config table', ok: true, rows: configData?.length });

  // Step 5: Try writing a test config
  const { error: writeErr } = await supabaseAdmin
    .from('site_config')
    .upsert({ key: '_test', value: { ok: true, ts: Date.now() }, updated_at: new Date().toISOString() });
  if (writeErr) {
    result.steps.push({ step: 5, name: 'Write test', ok: false, error: writeErr.message });
    return res.status(200).json(result);
  }
  result.steps.push({ step: 5, name: 'Write test', ok: true, message: 'Admin panel CAN save to Supabase!' });

  result.all_ok = true;
  return res.status(200).json(result);
};
