<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<title>Journal Your Trades — Admin Panel</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Space+Grotesk:wght@500;600;700;800&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
  /* Backgrounds */
  --bg:#0a0c14;--bg2:#0f1219;--bg3:#141720;--bg4:#1a1e2a;--bg5:#1f2433;--bg6:#252a38;
  /* Borders */
  --b1:rgba(255,255,255,0.055);--b2:rgba(255,255,255,0.09);--b3:rgba(255,255,255,0.15);
  /* Text */
  --t1:#f0f2f8;--t2:#8892a4;--t3:#4a5568;--t4:#2d3748;
  /* Accent */
  --blue:#3b82f6;--indigo:#6366f1;--green:#10b981;--red:#ef4444;
  --amber:#f59e0b;--purple:#8b5cf6;--cyan:#06b6d4;--pink:#ec4899;
  --grad:linear-gradient(135deg,#3b82f6,#6366f1);
  --grad2:linear-gradient(135deg,#6366f1,#8b5cf6);
  /* Fonts */
  --fh:'Space Grotesk',system-ui,sans-serif;
  --fb:'Inter',system-ui,sans-serif;
  --fm:'Fira Code',monospace;
  /* Sizes */
  --topbar-h:48px;--sidebar-w:256px;--sidebar-coll:60px;
  --r:12px;--rs:8px;--rl:18px;
  /* Shadows */
  --shadow:0 1px 3px rgba(0,0,0,.4),0 4px 16px rgba(0,0,0,.3);
  --shadow-lg:0 8px 32px rgba(0,0,0,.5),0 2px 8px rgba(0,0,0,.3);
}
html{scroll-behavior:smooth;height:100%}
body{font-family:var(--fb);background:var(--bg);color:var(--t1);min-height:100vh;
  font-size:13.5px;line-height:1.55;-webkit-font-smoothing:antialiased}
::-webkit-scrollbar{width:5px;height:5px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:rgba(255,255,255,.08);border-radius:3px}
::-webkit-scrollbar-thumb:hover{background:rgba(255,255,255,.15)}
input,select,textarea,button{font-family:inherit}

/* ═══════════════════════════════════════════
   TOP ADMIN BAR (WordPress-style)
═══════════════════════════════════════════ */
#wpadminbar{
  position:fixed;top:0;left:0;right:0;height:var(--topbar-h);z-index:9999;
  background:rgba(8,10,18,.98);backdrop-filter:blur(24px);
  border-bottom:1px solid var(--b1);
  display:flex;align-items:center;justify-content:space-between;padding:0 16px 0 0;
  box-shadow:0 1px 0 var(--b1),0 2px 12px rgba(0,0,0,.4);
}
.wpbar-left{display:flex;align-items:center;gap:0;height:100%}
.wpbar-logo{display:flex;align-items:center;gap:10px;padding:0 16px;height:100%;
  border-right:1px solid var(--b1);cursor:pointer;transition:background .15s}
.wpbar-logo:hover{background:rgba(255,255,255,.04)}
.wpbar-logobox{width:32px;height:32px;background:var(--grad);border-radius:8px;
  display:flex;align-items:center;justify-content:center;font-family:var(--fh);
  font-size:13px;font-weight:800;color:#fff;box-shadow:0 0 12px rgba(59,130,246,.4)}
.wpbar-logotext{font-family:var(--fh);font-size:14px;font-weight:700;color:var(--t1)}
.wpbar-site-badge{font-size:10px;font-weight:700;padding:2px 7px;background:rgba(239,68,68,.12);
  color:#f87171;border:1px solid rgba(239,68,68,.2);border-radius:4px;letter-spacing:.8px;text-transform:uppercase}
.wpbar-nav{display:flex;align-items:center;height:100%}
.wpbar-navitem{display:flex;align-items:center;gap:6px;height:100%;padding:0 14px;
  font-size:12.5px;color:var(--t2);cursor:pointer;transition:all .15s;border-right:1px solid var(--b1);
  text-decoration:none;white-space:nowrap}
.wpbar-navitem:hover{background:rgba(255,255,255,.04);color:var(--t1)}
.wpbar-navitem.active{color:var(--t1);background:rgba(255,255,255,.03)}
.wpbar-right{display:flex;align-items:center;gap:8px}
.wpbar-search{display:flex;align-items:center;gap:7px;background:var(--bg4);
  border:1px solid var(--b2);border-radius:7px;padding:6px 12px;width:220px;transition:all .2s}
.wpbar-search:focus-within{border-color:var(--blue);box-shadow:0 0 0 2.5px rgba(59,130,246,.15)}
.wpbar-search input{background:none;border:none;outline:none;font-size:12.5px;color:var(--t1);width:100%;font-family:var(--fb)}
.wpbar-search input::placeholder{color:var(--t3)}
.wpbar-btn{display:flex;align-items:center;gap:6px;padding:6px 14px;border-radius:7px;
  font-size:12.5px;font-weight:500;cursor:pointer;border:none;transition:all .15s;
  font-family:var(--fb);white-space:nowrap;text-decoration:none}
.wpbar-btn-primary{background:var(--grad);color:#fff;box-shadow:0 2px 8px rgba(59,130,246,.3)}
.wpbar-btn-primary:hover{opacity:.9;transform:translateY(-1px)}
.wpbar-btn-ghost{background:rgba(255,255,255,.06);color:var(--t2);border:1px solid var(--b2)}
.wpbar-btn-ghost:hover{background:rgba(255,255,255,.1);color:var(--t1)}
.wpbar-avatar{width:30px;height:30px;border-radius:50%;background:linear-gradient(135deg,var(--red),var(--amber));
  display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;
  color:#fff;cursor:pointer;flex-shrink:0;border:2px solid var(--b2);transition:border-color .15s}
.wpbar-avatar:hover{border-color:var(--b3)}
.wpbar-notif-dot{width:8px;height:8px;background:var(--red);border-radius:50%;
  position:absolute;top:8px;right:8px;border:2px solid var(--bg)}

/* ═══════════════════════════════════════════
   LAYOUT
═══════════════════════════════════════════ */
.admin-layout{display:flex;padding-top:var(--topbar-h);min-height:100vh}

/* ═══════════════════════════════════════════
   SIDEBAR (WordPress-style collapsible)
═══════════════════════════════════════════ */
#sidebar{
  width:var(--sidebar-w);background:rgba(8,10,18,.97);border-right:1px solid var(--b1);
  position:fixed;top:var(--topbar-h);bottom:0;left:0;z-index:100;overflow-y:auto;overflow-x:hidden;
  display:flex;flex-direction:column;transition:width .25s cubic-bezier(.4,0,.2,1);
}
#sidebar.collapsed{width:var(--sidebar-coll)}
#sidebar.collapsed .sb-label,#sidebar.collapsed .sb-section-lbl,
#sidebar.collapsed .sb-badge,#sidebar.collapsed .sb-arrow{display:none!important}
#sidebar.collapsed .sb-item{justify-content:center;padding:10px 0}
#sidebar.collapsed .sb-ico{margin:0}
.sb-collapse-btn{display:flex;align-items:center;justify-content:center;padding:12px;
  cursor:pointer;border-top:1px solid var(--b1);color:var(--t3);transition:all .15s;
  background:none;border-bottom:none;border-left:none;border-right:none;width:100%;
  font-family:var(--fb);font-size:12px;gap:8px;color:var(--t2)}
.sb-collapse-btn:hover{background:rgba(255,255,255,.04);color:var(--t1)}
.sb-top{padding:14px 10px 8px;flex-shrink:0}
.sb-section-lbl{font-size:10px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;
  color:var(--t4);padding:10px 10px 4px;display:block;white-space:nowrap}
.sb-item{display:flex;align-items:center;gap:9px;padding:8px 10px;border-radius:var(--rs);
  cursor:pointer;margin-bottom:1px;font-size:13px;font-weight:500;color:var(--t3);
  transition:all .12s;border:none;background:transparent;width:100%;text-align:left;
  font-family:var(--fb);position:relative;white-space:nowrap}
.sb-item:hover{background:rgba(255,255,255,.045);color:var(--t2)}
.sb-item.on{background:rgba(59,130,246,.12);color:var(--t1);font-weight:600}
.sb-item.on::before{content:'';position:absolute;left:0;top:50%;transform:translateY(-50%);
  height:20px;width:3px;background:var(--blue);border-radius:0 3px 3px 0}
.sb-ico{font-size:15px;width:20px;text-align:center;flex-shrink:0;transition:opacity .12s;opacity:.65}
.sb-item:hover .sb-ico,.sb-item.on .sb-ico{opacity:1}
.sb-label{flex:1;overflow:hidden;text-overflow:ellipsis}
.sb-badge{margin-left:auto;font-size:10px;font-weight:700;padding:1px 7px;border-radius:10px;
  background:rgba(59,130,246,.15);color:var(--blue);flex-shrink:0}
.sb-badge-red{background:rgba(239,68,68,.15);color:var(--red)}
.sb-arrow{font-size:10px;color:var(--t4);flex-shrink:0;transition:transform .2s}
.sb-item.open .sb-arrow{transform:rotate(90deg)}
.sb-sub{padding-left:28px;display:none}
.sb-sub.open{display:block}
.sb-subitem{display:flex;align-items:center;gap:7px;padding:6px 10px 6px 12px;border-radius:6px;
  cursor:pointer;font-size:12.5px;color:var(--t3);transition:all .12s;border-left:1px solid var(--b1);
  border-radius:0 6px 6px 0;margin-bottom:1px;background:none;border-top:none;border-bottom:none;
  border-right:none;width:100%;text-align:left;font-family:var(--fb);white-space:nowrap}
.sb-subitem:hover{color:var(--t2);background:rgba(255,255,255,.03)}
.sb-subitem.on{color:var(--blue);border-left-color:var(--blue)}
.sb-foot{padding:8px 10px;border-top:1px solid var(--b1);flex-shrink:0;margin-top:auto}
.sb-user-card{background:var(--bg4);border:1px solid var(--b1);border-radius:var(--rs);
  padding:10px 12px;display:flex;align-items:center;gap:9px;margin-bottom:6px}
.sb-user-av{width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,var(--red),var(--amber));
  display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:700;color:#fff;flex-shrink:0}
.sb-user-name{font-size:12px;font-weight:600;color:var(--t1)}
.sb-user-role{font-size:10px;color:#f87171;margin-top:1px}

/* ═══════════════════════════════════════════
   MAIN CONTENT
═══════════════════════════════════════════ */
#main-content{margin-left:var(--sidebar-w);flex:1;min-height:calc(100vh - var(--topbar-h));
  transition:margin-left .25s cubic-bezier(.4,0,.2,1);display:flex;flex-direction:column}
body.sb-coll #main-content{margin-left:var(--sidebar-coll)}
body.sb-coll #sidebar{width:var(--sidebar-coll)}

/* PAGE HEADER BAR */
.page-hbar{background:rgba(10,12,20,.9);border-bottom:1px solid var(--b1);
  padding:14px 28px;display:flex;align-items:center;justify-content:space-between;
  flex-wrap:wrap;gap:10px;flex-shrink:0}
.page-hbar-left{}
.page-breadcrumb{font-size:11.5px;color:var(--t3);margin-bottom:3px;display:flex;align-items:center;gap:4px}
.page-breadcrumb span{color:var(--t2)}
.page-h1{font-family:var(--fh);font-size:20px;font-weight:700;color:var(--t1);letter-spacing:-.2px}
.page-h1-sub{font-size:12px;color:var(--t3);margin-top:2px}
.page-hbar-right{display:flex;align-items:center;gap:8px;flex-wrap:wrap}

/* PAGE BODY */
.page-body{padding:22px 28px 48px;flex:1}

/* PAGES */
.pg{display:none}.pg.on{display:block}

/* ═══════════════════════════════════════════
   COMPONENTS
═══════════════════════════════════════════ */
/* Stat cards */
.stat-row{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:12px;margin-bottom:20px}
.stat-card{background:var(--bg3);border:1px solid var(--b1);border-radius:var(--r);
  padding:16px 18px;transition:all .2s;position:relative;overflow:hidden}
.stat-card:hover{border-color:var(--b2);transform:translateY(-1px);box-shadow:var(--shadow)}
.stat-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;
  background:var(--grad);opacity:0;transition:opacity .2s}
.stat-card:hover::before{opacity:1}
.stat-label{font-size:11px;font-weight:600;letter-spacing:.7px;text-transform:uppercase;
  color:var(--t3);margin-bottom:7px;display:flex;align-items:center;gap:5px}
.stat-val{font-family:var(--fh);font-size:26px;font-weight:800;color:var(--t1);line-height:1;margin-bottom:3px}
.stat-sub{font-size:11.5px;color:var(--t3)}
.stat-up{color:var(--green)}.stat-dn{color:var(--red)}
.stat-ico{font-size:22px;position:absolute;top:14px;right:14px;opacity:.15}

/* Cards */
.card{background:var(--bg3);border:1px solid var(--b1);border-radius:var(--r);overflow:hidden}
.card-head{display:flex;align-items:center;justify-content:space-between;padding:14px 18px;
  border-bottom:1px solid var(--b1)}
.card-title{font-family:var(--fh);font-size:13.5px;font-weight:700;color:var(--t1);
  display:flex;align-items:center;gap:8px}
.card-body{padding:16px 18px}
.card-footer{padding:12px 18px;border-top:1px solid var(--b1);background:rgba(0,0,0,.1)}

/* Buttons */
.btn{display:inline-flex;align-items:center;gap:6px;padding:7px 16px;border-radius:var(--rs);
  font-size:12.5px;font-weight:500;cursor:pointer;border:none;transition:all .15s;
  font-family:var(--fb);line-height:1;white-space:nowrap}
.btn-primary{background:var(--grad);color:#fff;box-shadow:0 2px 8px rgba(59,130,246,.3)}
.btn-primary:hover{opacity:.9;transform:translateY(-1px);box-shadow:0 4px 14px rgba(59,130,246,.4)}
.btn-secondary{background:var(--bg5);color:var(--t1);border:1px solid var(--b2)}
.btn-secondary:hover{background:var(--bg6);border-color:var(--b3)}
.btn-danger{background:rgba(239,68,68,.1);color:var(--red);border:1px solid rgba(239,68,68,.2)}
.btn-danger:hover{background:rgba(239,68,68,.18)}
.btn-success{background:rgba(16,185,129,.1);color:var(--green);border:1px solid rgba(16,185,129,.2)}
.btn-success:hover{background:rgba(16,185,129,.18)}
.btn-warning{background:rgba(245,158,11,.1);color:var(--amber);border:1px solid rgba(245,158,11,.2)}
.btn-sm{padding:5px 12px;font-size:11.5px}
.btn-lg{padding:10px 22px;font-size:14px}
.btn-icon{padding:7px;border-radius:var(--rs);background:var(--bg4);border:1px solid var(--b1);
  color:var(--t2);cursor:pointer;transition:all .15s;font-size:14px;display:flex;align-items:center;justify-content:center}
.btn-icon:hover{background:var(--bg5);color:var(--t1);border-color:var(--b2)}

/* Badges */
.badge{display:inline-flex;align-items:center;gap:4px;padding:3px 8px;border-radius:5px;
  font-size:11px;font-weight:600;letter-spacing:.2px}
.badge-blue{background:rgba(59,130,246,.15);color:var(--blue)}
.badge-green{background:rgba(16,185,129,.15);color:var(--green)}
.badge-red{background:rgba(239,68,68,.15);color:var(--red)}
.badge-amber{background:rgba(245,158,11,.15);color:var(--amber)}
.badge-purple{background:rgba(139,92,246,.15);color:var(--purple)}
.badge-gray{background:var(--bg5);color:var(--t2);border:1px solid var(--b1)}

/* Divider */
.divider{height:1px;background:var(--b1);margin:16px 0}
.divider-text{display:flex;align-items:center;gap:10px;color:var(--t3);font-size:12px;margin:16px 0}
.divider-text::before,.divider-text::after{content:'';flex:1;height:1px;background:var(--b1)}

/* Grid */
.g2{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.g3{display:grid;grid-template-columns:1fr 1fr 1fr;gap:14px}
.g4{display:grid;grid-template-columns:repeat(4,1fr);gap:12px}
@media(max-width:1100px){.g4{grid-template-columns:1fr 1fr}}
@media(max-width:900px){.g2,.g3,.g4{grid-template-columns:1fr}}

/* Table */
.table-wrap{overflow-x:auto;border-radius:var(--rs)}
table{width:100%;border-collapse:collapse;font-size:13px}
thead th{padding:9px 14px;text-align:left;font-size:10.5px;font-weight:700;letter-spacing:.6px;
  text-transform:uppercase;color:var(--t3);border-bottom:1px solid var(--b1);
  background:rgba(0,0,0,.15);white-space:nowrap}
tbody tr{border-bottom:1px solid rgba(255,255,255,.03);transition:background .1s}
tbody tr:last-child{border-bottom:none}
tbody tr:hover{background:rgba(255,255,255,.025)}
tbody td{padding:11px 14px;vertical-align:middle;color:var(--t1)}
.tr-act{display:flex;gap:6px;align-items:center;flex-wrap:nowrap}

/* Form elements */
.form-group{margin-bottom:14px}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.form-row3{display:grid;grid-template-columns:1fr 1fr 1fr;gap:12px}
.form-label{font-size:11px;font-weight:600;color:var(--t2);margin-bottom:5px;display:flex;
  align-items:center;gap:6px;letter-spacing:.3px;text-transform:uppercase}
.form-label-hint{font-weight:400;text-transform:none;color:var(--t3)}
.form-input,.form-select,.form-textarea{
  width:100%;background:var(--bg4);border:1px solid var(--b2);border-radius:var(--rs);
  padding:9px 12px;font-size:13px;color:var(--t1);font-family:var(--fb);
  outline:none;transition:border-color .15s,box-shadow .15s}
.form-input:focus,.form-select:focus,.form-textarea:focus{
  border-color:var(--blue);box-shadow:0 0 0 3px rgba(59,130,246,.12)}
.form-input:hover,.form-select:hover,.form-textarea:hover{border-color:var(--b3)}
.form-textarea{resize:vertical;min-height:90px;line-height:1.65}
.form-input::placeholder,.form-textarea::placeholder{color:var(--t4)}
.form-hint{font-size:11px;color:var(--t3);margin-top:4px}
.form-counter{font-size:11px;color:var(--t3);float:right}
.form-counter.warn{color:var(--amber)}.form-counter.err{color:var(--red)}
input[type=color].form-input{padding:4px 6px;height:40px;cursor:pointer}

/* Rich editor toolbar */
.editor-toolbar{display:flex;gap:4px;flex-wrap:wrap;padding:8px 10px;background:var(--bg4);
  border:1px solid var(--b2);border-bottom:none;border-radius:var(--rs) var(--rs) 0 0}
.et-btn{padding:4px 9px;border-radius:5px;background:var(--bg3);border:1px solid var(--b1);
  color:var(--t2);cursor:pointer;font-size:11.5px;font-family:var(--fm);transition:all .12s}
.et-btn:hover{background:var(--bg2);color:var(--t1);border-color:var(--b2)}
.et-sep{width:1px;height:18px;background:var(--b2);align-self:center;margin:0 2px}
.form-textarea.with-toolbar{border-top:none!important;border-radius:0 0 var(--rs) var(--rs)!important}

/* Tabs */
.tab-bar{display:flex;gap:2px;background:var(--bg4);border-radius:10px;padding:3px;
  width:fit-content;margin-bottom:18px;border:1px solid var(--b1)}
.tab-btn{padding:6px 16px;border-radius:8px;border:none;background:transparent;
  color:var(--t3);font-size:13px;font-weight:500;cursor:pointer;font-family:var(--fb);
  transition:all .15s;display:flex;align-items:center;gap:5px}
.tab-btn.on{background:var(--bg6);color:var(--t1);box-shadow:0 1px 4px rgba(0,0,0,.4);font-weight:600}

/* Toggle switch */
.toggle{width:38px;height:20px;background:var(--bg5);border-radius:10px;position:relative;
  cursor:pointer;border:1px solid var(--b2);transition:background .2s;flex-shrink:0}
.toggle.on{background:var(--green);border-color:var(--green)}
.toggle::after{content:'';position:absolute;top:2px;left:2px;width:14px;height:14px;
  background:#fff;border-radius:50%;transition:transform .2s;box-shadow:0 1px 3px rgba(0,0,0,.3)}
.toggle.on::after{transform:translateX(18px)}

/* Modals */
.modal-overlay{position:fixed;inset:0;background:rgba(0,0,8,.85);z-index:10000;
  display:none;align-items:center;justify-content:center;backdrop-filter:blur(10px);padding:20px}
.modal-overlay.open{display:flex}
.modal{background:var(--bg2);border:1px solid var(--b2);border-radius:var(--rl);
  width:100%;max-width:560px;max-height:90vh;overflow-y:auto;box-shadow:var(--shadow-lg)}
.modal-lg{max-width:800px}
.modal-head{padding:18px 22px 14px;border-bottom:1px solid var(--b1);display:flex;
  align-items:center;justify-content:space-between;position:sticky;top:0;
  background:var(--bg2);z-index:1}
.modal-title{font-family:var(--fh);font-size:16px;font-weight:700;display:flex;align-items:center;gap:8px}
.modal-close{background:var(--bg4);border:1px solid var(--b1);color:var(--t2);cursor:pointer;
  font-size:16px;border-radius:6px;width:28px;height:28px;display:flex;align-items:center;
  justify-content:center;transition:all .12s}
.modal-close:hover{background:var(--bg5);color:var(--t1)}
.modal-body{padding:20px 22px}
.modal-footer{padding:14px 22px;border-top:1px solid var(--b1);display:flex;
  justify-content:flex-end;gap:8px;background:var(--bg2);position:sticky;bottom:0}

/* Toast notifications */
.toast{position:fixed;bottom:20px;right:20px;background:var(--bg2);border:1px solid var(--b2);
  border-radius:11px;padding:12px 16px;font-size:13px;color:var(--t1);z-index:99999;
  display:none;max-width:320px;box-shadow:var(--shadow-lg);gap:10px;align-items:center}
.toast.show{display:flex;animation:slideIn .25s ease}
.toast-s{border-color:rgba(16,185,129,.35)}
.toast-e{border-color:rgba(239,68,68,.35)}
.toast-w{border-color:rgba(245,158,11,.35)}
@keyframes slideIn{from{transform:translateY(16px);opacity:0}to{transform:translateY(0);opacity:1}}

/* SERP Preview */
.serp-wrap{background:#fff;border-radius:10px;padding:16px 18px;max-width:560px;box-shadow:var(--shadow)}
.serp-url{font-size:12px;color:#202124;font-family:Arial,sans-serif;margin-bottom:2px}
.serp-title{font-size:18px;color:#1558d6;font-family:Arial,sans-serif;margin-bottom:4px;line-height:1.3;
  white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.serp-desc{font-size:13.5px;color:#4d5156;font-family:Arial,sans-serif;line-height:1.58}

/* Activity */
.activity-item{display:flex;align-items:flex-start;gap:10px;padding:10px 0;border-bottom:1px solid var(--b1)}
.activity-item:last-child{border-bottom:none}
.act-ico{width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;
  font-size:13px;flex-shrink:0;background:rgba(59,130,246,.1)}
.act-txt{flex:1;font-size:13px;color:var(--t2);line-height:1.5}
.act-time{font-size:11px;color:var(--t3);white-space:nowrap;flex-shrink:0}

/* Nav link editor */
.nl-item{display:flex;align-items:center;gap:8px;padding:9px 12px;background:var(--bg4);
  border:1px solid var(--b1);border-radius:var(--rs);margin-bottom:6px;transition:border-color .15s}
.nl-item:hover{border-color:var(--b2)}

/* Feature flag row */
.flag-row{display:flex;align-items:center;justify-content:space-between;padding:13px 0;
  border-bottom:1px solid var(--b1)}
.flag-row:last-child{border-bottom:none}
.flag-name{font-size:13.5px;font-weight:600;color:var(--t1);margin-bottom:2px}
.flag-desc{font-size:12px;color:var(--t3)}

/* Colour swatches */
.palette{display:flex;gap:6px;flex-wrap:wrap;margin-top:6px}
.swatch{width:28px;height:28px;border-radius:7px;cursor:pointer;border:2px solid transparent;
  transition:all .15s}
.swatch:hover,.swatch.on{border-color:#fff;transform:scale(1.12)}

/* Code editor */
.code-area{background:#0d0f17;border:1px solid var(--b2);border-radius:var(--rs);
  padding:14px;font-family:var(--fm);font-size:12.5px;color:#a9b7d0;
  min-height:180px;resize:vertical;width:100%;outline:none;line-height:1.65;
  transition:border-color .15s}
.code-area:focus{border-color:var(--blue);box-shadow:0 0 0 3px rgba(59,130,246,.1)}

/* Empty states */
.empty-state{text-align:center;padding:48px 24px}
.empty-ico{font-size:40px;margin-bottom:14px;opacity:.3;display:block}
.empty-title{font-family:var(--fh);font-size:16px;font-weight:700;color:var(--t1);margin-bottom:5px}
.empty-sub{font-size:13px;color:var(--t3);max-width:280px;margin:0 auto 16px;line-height:1.6}

/* Search bar */
.search-bar{display:flex;align-items:center;gap:8px;background:var(--bg4);
  border:1px solid var(--b1);border-radius:var(--rs);padding:7px 12px}
.search-bar:focus-within{border-color:var(--blue)}
.search-bar input{background:none;border:none;outline:none;font-size:13px;color:var(--t1);
  font-family:var(--fb);flex:1;min-width:0}
.search-bar input::placeholder{color:var(--t4)}

/* Progress bar */
.progress{height:6px;background:var(--bg5);border-radius:3px;overflow:hidden}
.progress-fill{height:100%;border-radius:3px;transition:width .6s ease}

/* Preview box */
.preview-box{background:var(--bg4);border:1px solid var(--b1);border-radius:var(--r);padding:20px;
  min-height:80px}

/* Collapse section */
.collapse-hd{display:flex;align-items:center;gap:10px;padding:14px 16px;cursor:pointer;
  background:var(--bg4);border-radius:var(--rs);margin-bottom:4px;transition:background .12s;
  border:1px solid var(--b1)}
.collapse-hd:hover{background:var(--bg5)}
.collapse-hd-ico{font-size:16px}
.collapse-hd-lbl{font-size:13.5px;font-weight:600;color:var(--t1);flex:1}
.collapse-hd-arr{font-size:11px;color:var(--t3);transition:transform .2s}
.collapse-hd.open .collapse-hd-arr{transform:rotate(90deg)}
.collapse-body{padding:14px 0;display:none}
.collapse-body.open{display:block}

/* Live preview header */
.preview-label{font-size:11px;font-weight:700;letter-spacing:.8px;text-transform:uppercase;
  color:var(--t3);margin-bottom:10px;display:flex;align-items:center;gap:7px}
.preview-label::before{content:'';width:6px;height:6px;border-radius:50%;background:var(--green);
  box-shadow:0 0 6px var(--green)}

/* Danger zone */
.danger-card{background:rgba(239,68,68,.04);border:1px solid rgba(239,68,68,.15);
  border-radius:var(--r);padding:14px 16px;margin-bottom:10px}
.danger-title{font-size:13px;font-weight:600;color:var(--t1);margin-bottom:3px}
.danger-desc{font-size:12px;color:var(--t3);margin-bottom:10px}

/* Responsive */
@media(max-width:768px){
  :root{--sidebar-w:0px}
  #sidebar{transform:translateX(-100%);width:256px!important}
  #sidebar.mob-open{transform:translateX(0)}
  #main-content{margin-left:0!important}
}
</style>
</head>
<body>

<!-- ═══════════════ PASSWORD GATE ═══════════════ -->
<div id="admin-gate" style="position:fixed;inset:0;z-index:99999;background:#0a0c14;display:flex;align-items:center;justify-content:center;font-family:'Montserrat',sans-serif;">
  <div style="background:#141720;border:1px solid rgba(255,255,255,0.09);border-radius:16px;padding:40px;width:100%;max-width:380px;text-align:center;">
    <div style="width:48px;height:48px;border-radius:12px;background:linear-gradient(135deg,#6366f1,#8b5cf6);display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:22px;">🔐</div>
    <div style="font-size:18px;font-weight:600;color:#fff;margin-bottom:6px;">Admin Access</div>
    <div style="font-size:13px;color:#888;margin-bottom:20px;">Enter the admin password to continue</div>
    <input id="gate-pass" type="password" placeholder="Password" style="width:100%;padding:12px 14px;border-radius:8px;border:1px solid rgba(255,255,255,0.09);background:#1a1e2a;color:#fff;font-size:14px;margin-bottom:12px;box-sizing:border-box;" onkeydown="if(event.key==='Enter')checkAdminPass()">
    <div id="gate-error" style="color:#ef4444;font-size:12px;margin-bottom:12px;display:none;">Incorrect password. Try again.</div>
    <button onclick="checkAdminPass()" style="width:100%;padding:12px;border-radius:8px;border:none;background:linear-gradient(135deg,#6366f1,#8b5cf6);color:#fff;font-weight:600;font-size:14px;cursor:pointer;">Unlock</button>
  </div>
</div>
<script>
  const ADMIN_PASSWORD = 'jut-admin-2025'; // ← CHANGE THIS to your own password
  function checkAdminPass() {
    const val = document.getElementById('gate-pass').value;
    if (val === ADMIN_PASSWORD) {
      sessionStorage.setItem('jut_admin_ok', '1');
      document.getElementById('admin-gate').style.display = 'none';
    } else {
      document.getElementById('gate-error').style.display = 'block';
    }
  }
  if (sessionStorage.getItem('jut_admin_ok') === '1') {
    document.addEventListener('DOMContentLoaded', () => {
      document.getElementById('admin-gate').style.display = 'none';
    });
  }
</script>


<!-- ═══════════════ TOP ADMIN BAR ═══════════════ -->
<div id="wpadminbar">
  <div class="wpbar-left">
    <div class="wpbar-logo" onclick="go('dash')">
      <div class="wpbar-logobox">TF</div>
      <span class="wpbar-logotext">Journal Your Trades</span>
      <span class="wpbar-site-badge">ADMIN</span>
    </div>
    <nav class="wpbar-nav">
      <a class="wpbar-navitem" href="tradd.html" target="_blank">🔗 View Site</a>
      <span class="wpbar-navitem" onclick="go('blog-new');resetBE()">+ New Post</span>
      <span class="wpbar-navitem" onclick="go('lp-pages');openPM(null)">+ New Page</span>
      <span class="wpbar-navitem" onclick="go('announce');openAnn()">+ Announcement</span>
    </nav>
  </div>
  <div class="wpbar-right">
    <div class="wpbar-search">
      <span style="color:var(--t3);font-size:13px">🔍</span>
      <input type="text" placeholder="Search posts, users, trades…" oninput="globalSearch(this.value)"/>
    </div>
    <button class="wpbar-btn wpbar-btn-ghost bsm" onclick="refresh()">↺ Refresh</button>
    <button class="wpbar-btn wpbar-btn-primary" onclick="go('blog-new');resetBE()">✏️ New Post</button>
    <div class="wpbar-avatar" title="Admin" style="position:relative">AD
      <span class="wpbar-notif-dot" id="notif-dot" style="display:none"></span>
    </div>
  </div>
</div>

<!-- ═══════════════ LAYOUT ═══════════════ -->
<div class="admin-layout">

<!-- ═══════════════ SIDEBAR ═══════════════ -->
<nav id="sidebar">
  <div class="sb-top">

    <span class="sb-section-lbl">Overview</span>
    <button class="sb-item on" onclick="go('dash')"><span class="sb-ico">📊</span><span class="sb-label">Dashboard</span></button>
    <button class="sb-item" onclick="go('analytics')"><span class="sb-ico">📈</span><span class="sb-label">Analytics</span></button>

    <span class="sb-section-lbl">🌐 Landing Page</span>
    <button class="sb-item" onclick="go('lp-hero')"><span class="sb-ico">🏠</span><span class="sb-label">Hero Section</span></button>
    <button class="sb-item" onclick="go('lp-nav')"><span class="sb-ico">🧭</span><span class="sb-label">Navigation</span></button>
    <button class="sb-item" onclick="go('lp-sections')"><span class="sb-ico">📐</span><span class="sb-label">Page Sections</span></button>
    <button class="sb-item" onclick="go('lp-pages')"><span class="sb-ico">📄</span><span class="sb-label">Custom Pages</span></button>
    <button class="sb-item" onclick="go('lp-seo')"><span class="sb-ico">🔍</span><span class="sb-label">SEO</span></button>
    <button class="sb-item" onclick="go('lp-theme')"><span class="sb-ico">🎨</span><span class="sb-label">Theme &amp; Colours</span></button>
    <button class="sb-item" onclick="go('lp-pricing')"><span class="sb-ico">💰</span><span class="sb-label">Pricing Table</span></button>

    <span class="sb-section-lbl">Auth</span>
    <button class="sb-item" onclick="go('auth-ed')"><span class="sb-ico">🔐</span><span class="sb-label">Signup Page</span></button>

    <span class="sb-section-lbl">Users</span>
    <button class="sb-item" onclick="go('users')"><span class="sb-ico">👥</span><span class="sb-label">All Users</span><span class="sb-badge" id="nb-u">0</span></button>
    <button class="sb-item" onclick="go('sessions')"><span class="sb-ico">🔑</span><span class="sb-label">Sessions</span></button>
    <button class="sb-item" onclick="go('activity')"><span class="sb-ico">⚡</span><span class="sb-label">Activity Log</span></button>

    <span class="sb-section-lbl">Content</span>
    <button class="sb-item" onclick="go('blog')"><span class="sb-ico">📝</span><span class="sb-label">Blog Posts</span><span class="sb-badge" id="nb-p">0</span></button>
    <button class="sb-item" onclick="go('blog-new');resetBE()"><span class="sb-ico">✏️</span><span class="sb-label">New Post</span></button>

    <span class="sb-section-lbl">Data</span>
    <button class="sb-item" onclick="go('trades')"><span class="sb-ico">💹</span><span class="sb-label">All Trades</span><span class="sb-badge" id="nb-t">0</span></button>
    <button class="sb-item" onclick="go('export')"><span class="sb-ico">📤</span><span class="sb-label">Export</span></button>

    <span class="sb-section-lbl">Platform</span>
    <button class="sb-item" onclick="go('flags')"><span class="sb-ico">🚩</span><span class="sb-label">Feature Flags</span></button>
    <button class="sb-item" onclick="go('announce')"><span class="sb-ico">📢</span><span class="sb-label">Announcements</span><span class="sb-badge sb-badge-red" id="nb-ann">0</span></button>
    <button class="sb-item" onclick="go('settings')"><span class="sb-ico">⚙️</span><span class="sb-label">Settings</span></button>

  </div>
  <div class="sb-foot">
    <div class="sb-user-card">
      <div class="sb-user-av">AD</div>
      <div><div class="sb-user-name">Admin</div><div class="sb-user-role">Super Admin</div></div>
    </div>
    <button class="sb-collapse-btn" onclick="toggleSidebar()" id="sb-coll-btn">
      <span id="sb-coll-ico">◀</span><span class="sb-label" id="sb-coll-lbl">Collapse</span>
    </button>
  </div>
</nav>

<!-- ═══════════════ MAIN ═══════════════ -->
<div id="main-content">

<!-- ═══════════════ DASHBOARD ═══════════════ -->
<div class="pg on" id="pg-dash">
  <div class="page-hbar">
    <div class="page-hbar-left">
      <div class="page-breadcrumb">Journal Your Trades <span>›</span> Admin</div>
      <div class="page-h1">Dashboard</div>
      <div class="page-h1-sub">Real-time platform overview — data from browser localStorage</div>
    </div>
    <div class="page-hbar-right">
      <button class="btn btn-secondary btn-sm" onclick="refresh()">↺ Refresh All</button>
    </div>
  </div>
  <div class="page-body">
    <div class="stat-row">
      <div class="stat-card"><span class="stat-ico">👥</span><div class="stat-label">Users</div><div class="stat-val" id="s-u">0</div><div class="stat-sub">Registered accounts</div></div>
      <div class="stat-card"><span class="stat-ico">💹</span><div class="stat-label">Trades Logged</div><div class="stat-val" id="s-t">0</div><div class="stat-sub">All time</div></div>
      <div class="stat-card"><span class="stat-ico">📝</span><div class="stat-label">Blog Posts</div><div class="stat-val" id="s-p">0</div><div class="stat-sub stat-up" id="s-p-sub">Published</div></div>
      <div class="stat-card"><span class="stat-ico">💰</span><div class="stat-label">Total P&amp;L</div><div class="stat-val" id="s-pnl">$0</div><div class="stat-sub" id="s-pnl-sub">Across all trades</div></div>
      <div class="stat-card"><span class="stat-ico">🏆</span><div class="stat-label">Win Rate</div><div class="stat-val" id="s-wr">0%</div><div class="stat-sub">Platform average</div></div>
      <div class="stat-card"><span class="stat-ico">📢</span><div class="stat-label">Active Banners</div><div class="stat-val" id="s-ann">0</div><div class="stat-sub">Live announcements</div></div>
    </div>
    <div class="g2" style="margin-bottom:16px">
      <div class="card">
        <div class="card-head"><div class="card-title">📊 Trades Last 7 Days</div></div>
        <div class="card-body">
          <div style="display:flex;align-items:flex-end;gap:6px;height:120px;padding-bottom:4px" id="dash-chart"></div>
        </div>
      </div>
      <div class="card">
        <div class="card-head"><div class="card-title">⚡ Recent Activity</div><button class="btn btn-secondary btn-sm" onclick="go('activity')">View All →</button></div>
        <div class="card-body" id="dash-acts" style="max-height:160px;overflow-y:auto;padding-top:0"></div>
      </div>
    </div>
    <div class="card">
      <div class="card-head"><div class="card-title">👥 User Overview</div><button class="btn btn-secondary btn-sm" onclick="go('users')">All Users →</button></div>
      <div class="table-wrap"><table>
        <thead><tr><th>Name</th><th>Email</th><th>Plan</th><th>Trades</th><th>Win Rate</th><th>P&amp;L</th><th>Joined</th></tr></thead>
        <tbody id="dash-tb"><tr><td colspan="7" style="text-align:center;color:var(--t3);padding:24px">No users yet</td></tr></tbody>
      </table></div>
    </div>
  </div>
</div>

<!-- ANALYTICS -->
<div class="pg" id="pg-analytics">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Overview</div><div class="page-h1">Analytics</div></div></div>
  <div class="page-body">
    <div class="stat-row">
      <div class="stat-card"><div class="stat-label">Avg Trades/User</div><div class="stat-val" id="an-at">0</div></div>
      <div class="stat-card"><div class="stat-label">Avg Win Rate</div><div class="stat-val" id="an-wr">0%</div></div>
      <div class="stat-card"><div class="stat-label">Long / Short</div><div class="stat-val" id="an-ls">—</div></div>
      <div class="stat-card"><div class="stat-label">Top Strategy</div><div class="stat-val" style="font-size:15px" id="an-ts">—</div></div>
    </div>
    <div class="g2">
      <div class="card"><div class="card-head"><div class="card-title">P&amp;L Distribution</div></div><div class="card-body" id="an-pnl" style="display:flex;flex-direction:column;gap:9px;min-height:60px"></div></div>
      <div class="card"><div class="card-head"><div class="card-title">Top Symbols</div></div><div class="card-body" id="an-sym" style="display:flex;flex-direction:column;gap:7px;min-height:60px"></div></div>
    </div>
  </div>
</div>

<!-- HERO EDITOR -->
<div class="pg" id="pg-lp-hero">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Landing Page</div><div class="page-h1">Hero Section Editor</div><div class="page-h1-sub">Edit headline, subheadline, CTA buttons — live preview updates instantly</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="saveHero()">💾 Save Hero</button></div>
  </div>
  <div class="page-body">
    <div class="g2">
      <div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">✏️ Headlines</div></div>
          <div class="card-body">
            <div class="form-group"><label class="form-label">Badge Pill (above H1)</label><input id="h-badge" class="form-input" placeholder="🚀 Now with AI Coach" oninput="upHP()"/></div>
            <div class="form-group"><label class="form-label">Main Headline H1 <span class="form-label-hint">*</span></label><input id="h-h1" class="form-input" placeholder="AI-Powered Trading Journal" oninput="upHP()"/></div>
            <div class="form-group"><label class="form-label">Sub-headline</label><input id="h-h2" class="form-input" placeholder="Track, analyse and improve every trade" oninput="upHP()"/></div>
            <div class="form-group"><label class="form-label">Description</label><textarea id="h-desc" class="form-textarea" style="min-height:70px" placeholder="The journal serious traders use…" oninput="upHP()"></textarea></div>
          </div>
        </div>
        <div class="card">
          <div class="card-head"><div class="card-title">🔘 CTA &amp; Trust</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group"><label class="form-label">Primary CTA</label><input id="h-cta1" class="form-input" placeholder="Get Started Free →" oninput="upHP()"/></div>
              <div class="form-group"><label class="form-label">Secondary CTA</label><input id="h-cta2" class="form-input" placeholder="Watch Demo" oninput="upHP()"/></div>
            </div>
            <div class="form-group"><label class="form-label">Trust Line</label><input id="h-trust" class="form-input" placeholder="Free forever · No credit card" oninput="upHP()"/></div>
            <div class="form-group"><label class="form-label">Social Proof Stat</label><input id="h-stat" class="form-input" placeholder="12,000+ traders" oninput="upHP()"/></div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-head"><div class="card-title"><span style="color:var(--green);margin-right:4px">●</span> Live Preview</div></div>
        <div class="card-body">
          <div style="background:linear-gradient(135deg,#07090f,#0d1020);border-radius:10px;padding:28px 22px;min-height:300px">
            <div id="hp-badge" style="font-size:11px;font-weight:700;padding:4px 12px;border-radius:20px;background:rgba(59,130,246,.1);border:1px solid rgba(59,130,246,.2);color:#7aa3ff;display:inline-block;margin-bottom:14px"></div>
            <div id="hp-h1" style="font-family:var(--fh);font-size:24px;font-weight:800;color:#e8eaf0;margin-bottom:8px;line-height:1.15;letter-spacing:-.3px"></div>
            <div id="hp-h2" style="font-size:14px;color:#6b7280;margin-bottom:8px;font-weight:500"></div>
            <div id="hp-desc" style="font-size:12.5px;color:#4b5563;margin-bottom:18px;line-height:1.6;max-width:380px"></div>
            <div style="display:flex;gap:10px;flex-wrap:wrap;margin-bottom:12px">
              <div id="hp-cta1" style="background:linear-gradient(135deg,#3b82f6,#6366f1);color:#fff;padding:9px 16px;border-radius:8px;font-size:12.5px;font-weight:700;font-family:var(--fh)"></div>
              <div id="hp-cta2" style="background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.12);color:#9ca3af;padding:9px 16px;border-radius:8px;font-size:12.5px;font-weight:600"></div>
            </div>
            <div id="hp-trust" style="font-size:11px;color:#374151"></div>
            <div id="hp-stat" style="font-size:11.5px;color:#4b5563;margin-top:4px"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- NAV EDITOR -->
<div class="pg" id="pg-lp-nav">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Landing Page</div><div class="page-h1">Navigation Editor</div><div class="page-h1-sub">Edit logo, nav links, CTA buttons. Saved to localStorage — reload tradd.html to apply.</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="saveNav()">💾 Save Navigation</button></div>
  </div>
  <div class="page-body">
    <div class="g2">
      <div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">🏷️ Logo</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group"><label class="form-label">Site Name</label><input id="n-nm" class="form-input" placeholder="Journal Your Trades" oninput="upNP()"/></div>
              <div class="form-group"><label class="form-label">Icon (2 letters or emoji)</label><input id="n-ico" class="form-input" placeholder="TF" oninput="upNP()"/></div>
            </div>
            <div class="form-group"><label class="form-label">Badge Text</label><input id="n-badge" class="form-input" placeholder="Beta" oninput="upNP()"/></div>
          </div>
        </div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">🔗 Nav Links</div><button class="btn btn-secondary btn-sm" onclick="addNL()">+ Add Link</button></div>
          <div class="card-body">
            <div id="nav-le"></div>
            <div class="form-hint">Click × to remove · Labels are editable inline</div>
          </div>
        </div>
        <div class="card">
          <div class="card-head"><div class="card-title">🔘 CTA Buttons</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group"><label class="form-label">Primary Button</label><input id="n-cta1" class="form-input" placeholder="Get Started Free →" oninput="upNP()"/></div>
              <div class="form-group"><label class="form-label">Ghost Button</label><input id="n-cta2" class="form-input" placeholder="Sign In" oninput="upNP()"/></div>
            </div>
          </div>
        </div>
      </div>
      <div>
        <div class="card">
          <div class="card-head"><div class="card-title"><span style="color:var(--green);margin-right:4px">●</span> Nav Preview</div></div>
          <div class="card-body">
            <div style="background:#070911;border-radius:9px;padding:12px 16px;display:grid;grid-template-columns:auto 1fr auto;align-items:center;gap:10px">
              <div style="display:flex;align-items:center;gap:8px">
                <div id="np-ico" style="width:30px;height:30px;border-radius:8px;background:linear-gradient(135deg,#3b82f6,#6366f1);display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:800;color:#fff;font-family:var(--fh)">TF</div>
                <span id="np-nm" style="font-family:var(--fh);font-size:14px;font-weight:700;color:#e8eaf0"></span>
                <span id="np-badge" style="font-size:9px;font-weight:700;padding:2px 6px;background:rgba(59,130,246,.15);color:#7aa3ff;border-radius:4px"></span>
              </div>
              <div id="np-links" style="display:flex;gap:2px;flex-wrap:wrap;justify-content:center"></div>
              <div style="display:flex;gap:5px">
                <div id="np-cta2" style="border:1px solid rgba(255,255,255,.12);border-radius:6px;padding:5px 11px;font-size:11.5px;color:#d1d5db"></div>
                <div id="np-cta1" style="background:linear-gradient(135deg,#3b82f6,#4f46e5);border-radius:6px;padding:5px 11px;font-size:11.5px;color:#fff;font-weight:600"></div>
              </div>
            </div>
          </div>
          <div class="card-footer" style="font-size:11px;color:var(--t3)">Changes apply after reloading tradd.html</div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- PAGE SECTIONS -->
<div class="pg" id="pg-lp-sections">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Landing Page</div><div class="page-h1">Page Sections</div><div class="page-h1-sub">Toggle visibility and reorder each section of your landing page</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="saveSecs()">💾 Save Order</button></div>
  </div>
  <div class="page-body"><div id="secs-list"></div></div>
</div>

<!-- CUSTOM PAGES -->
<div class="pg" id="pg-lp-pages">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Landing Page</div><div class="page-h1">Custom Pages</div><div class="page-h1-sub">Build standalone pages that appear in your nav (About, Contact, Terms…)</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="openPM(null)">+ New Page</button></div>
  </div>
  <div class="page-body"><div id="pages-list"></div></div>
</div>

<!-- LANDING SEO -->
<div class="pg" id="pg-lp-seo">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Landing Page</div><div class="page-h1">Landing SEO</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="saveSeo()">💾 Save SEO</button></div>
  </div>
  <div class="page-body">
    <div class="g2">
      <div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">🔍 Meta Tags</div></div>
          <div class="card-body">
            <div class="form-group"><label class="form-label">Page Title <span class="form-counter" id="seo-tc">(0/60)</span></label><input id="ls-title" class="form-input" placeholder="Journal Your Trades — AI Trading Journal" oninput="upSeoC();upSerp()"/></div>
            <div class="form-group"><label class="form-label">Meta Description <span class="form-counter" id="seo-mc">(0/160)</span></label><textarea id="ls-desc" class="form-textarea" style="min-height:70px" placeholder="AI-powered trading journal…" oninput="upSeoC();upSerp()"></textarea></div>
            <div class="form-group"><label class="form-label">Canonical URL</label><input id="ls-url" class="form-input" placeholder="https://journalyourtrades.app"/></div>
            <div class="form-group"><label class="form-label">OG Image URL (1200×630)</label><input id="ls-og" class="form-input" placeholder="https://journalyourtrades.app/og.png"/></div>
            <div class="form-group"><label class="form-label">Twitter Card</label><select id="ls-tw" class="form-select"><option>summary_large_image</option><option>summary</option></select></div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-head"><div class="card-title">Google Preview</div></div>
        <div class="card-body">
          <div class="serp-wrap">
            <div class="serp-url" id="serp-url">https://journalyourtrades.app</div>
            <div class="serp-title" id="serp-ttl">Journal Your Trades — AI Trading Journal</div>
            <div class="serp-desc" id="serp-dsc">Meta description will appear here…</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- THEME -->
<div class="pg" id="pg-lp-theme">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Landing Page</div><div class="page-h1">Theme &amp; Colours</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="saveTheme()">💾 Save Theme</button></div>
  </div>
  <div class="page-body">
    <div class="g2">
      <div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">🎨 Accent Colours</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group"><label class="form-label">Primary Accent</label><input type="color" id="tc-a1" value="#3b82f6" class="form-input" oninput="upTP()"/></div>
              <div class="form-group"><label class="form-label">Secondary Accent</label><input type="color" id="tc-a2" value="#6366f1" class="form-input" oninput="upTP()"/></div>
            </div>
            <div class="form-group"><label class="form-label">Quick Palettes</label>
              <div class="palette">
                <div class="swatch on" style="background:linear-gradient(135deg,#3b82f6,#6366f1)" onclick="pal('#3b82f6','#6366f1')" title="Blue-Indigo"></div>
                <div class="swatch" style="background:linear-gradient(135deg,#8b5cf6,#ec4899)" onclick="pal('#8b5cf6','#ec4899')" title="Purple-Pink"></div>
                <div class="swatch" style="background:linear-gradient(135deg,#10b981,#3b82f6)" onclick="pal('#10b981','#3b82f6')" title="Green-Blue"></div>
                <div class="swatch" style="background:linear-gradient(135deg,#f59e0b,#ef4444)" onclick="pal('#f59e0b','#ef4444')" title="Amber-Red"></div>
                <div class="swatch" style="background:linear-gradient(135deg,#06b6d4,#6366f1)" onclick="pal('#06b6d4','#6366f1')" title="Cyan-Indigo"></div>
                <div class="swatch" style="background:linear-gradient(135deg,#f97316,#8b5cf6)" onclick="pal('#f97316','#8b5cf6')" title="Orange-Purple"></div>
              </div>
            </div>
          </div>
        </div>
        <div class="card">
          <div class="card-head"><div class="card-title">🔤 Typography</div></div>
          <div class="card-body">
            <div class="form-group"><label class="form-label">Heading Font</label>
              <select id="tc-hf" class="form-select"><option value="Syne">Syne (default)</option><option value="Space Grotesk">Space Grotesk</option><option value="Outfit">Outfit</option><option value="Plus Jakarta Sans">Plus Jakarta Sans</option></select></div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-head"><div class="card-title"><span style="color:var(--green);margin-right:4px">●</span> Button Preview</div></div>
        <div class="card-body">
          <div style="background:var(--bg4);border-radius:10px;padding:24px;display:flex;flex-direction:column;gap:12px">
            <div id="tp-b1" style="text-align:center;padding:12px 24px;border-radius:9px;color:#fff;font-size:14px;font-weight:700;font-family:var(--fh);background:linear-gradient(135deg,#3b82f6,#6366f1)">Get Started Free →</div>
            <div id="tp-b2" style="text-align:center;padding:12px 24px;border-radius:9px;color:#d1d5db;font-size:14px;border:1px solid rgba(255,255,255,.12)">Sign In</div>
            <div id="tp-lnk" style="text-align:center;font-size:14px;color:var(--blue);cursor:pointer;font-weight:500">Learn More →</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- PRICING TABLE EDITOR -->
<div class="pg" id="pg-lp-pricing">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Landing Page</div><div class="page-h1">Pricing Table</div><div class="page-h1-sub">Edit plan names, prices, features and CTA buttons</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="savePricing()">💾 Save Pricing</button></div>
  </div>
  <div class="page-body">
    <div class="g3" id="pricing-editor"></div>
  </div>
</div>

<!-- AUTH EDITOR -->
<div class="pg" id="pg-auth-ed">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Auth</div><div class="page-h1">Signup Page Editor</div><div class="page-h1-sub">Customise every element of the auth screen — live preview included</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="saveAuth()">💾 Save Auth Page</button></div>
  </div>
  <div class="page-body">
    <div class="g2">
      <div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">🦁 Logo &amp; Headings</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group"><label class="form-label">Logo Icon (emoji)</label><input id="ae-ico" class="form-input" placeholder="🦁" oninput="upAP()"/></div>
              <div class="form-group"><label class="form-label">Logo Gradient</label><input type="color" id="ae-lc" value="#7c3aed" class="form-input" oninput="upAP()"/></div>
            </div>
            <div class="form-group"><label class="form-label">Sign Up — Heading</label><input id="ae-su-h" class="form-input" placeholder="Welcome to Journal Your Trades" oninput="upAP()"/></div>
            <div class="form-group"><label class="form-label">Sign Up — Sub-heading</label><input id="ae-su-s" class="form-input" placeholder="We help traders become profitable!" oninput="upAP()"/></div>
            <div class="form-group"><label class="form-label">Sign In — Heading</label><input id="ae-si-h" class="form-input" placeholder="Sign in to Journal Your Trades" oninput="upAP()"/></div>
            <div class="form-group"><label class="form-label">Sign In — Sub-heading</label><input id="ae-si-s" class="form-input" placeholder="Welcome back, trader!" oninput="upAP()"/></div>
          </div>
        </div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">🔘 Buttons &amp; Labels</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group"><label class="form-label">Sign Up Button</label><input id="ae-su-b" class="form-input" placeholder="Sign up" oninput="upAP()"/></div>
              <div class="form-group"><label class="form-label">Sign In Button</label><input id="ae-si-b" class="form-input" placeholder="Sign in →" oninput="upAP()"/></div>
            </div>
            <div class="form-group"><label class="form-label">Google Button Text</label><input id="ae-goog" class="form-input" placeholder="Sign up with Google" oninput="upAP()"/></div>
            <div class="form-group"><label class="form-label">Demo Button Text</label><input id="ae-demo" class="form-input" placeholder="Explore demo — no account needed" oninput="upAP()"/></div>
            <div class="form-group"><label class="form-label">Trust Bar Text</label><input id="ae-trust" class="form-input" placeholder="🔒 Free forever · No credit card" oninput="upAP()"/></div>
          </div>
        </div>
        <div class="card">
          <div class="card-head"><div class="card-title">🎨 Background Gradient</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group"><label class="form-label">From</label><input type="color" id="ae-bg1" value="#ede9fe" class="form-input" oninput="upAP()"/></div>
              <div class="form-group"><label class="form-label">To</label><input type="color" id="ae-bg2" value="#eff6ff" class="form-input" oninput="upAP()"/></div>
            </div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-head"><div class="card-title"><span style="color:var(--green);margin-right:4px">●</span> Live Card Preview</div></div>
        <div class="card-body" style="padding:0">
          <div id="ae-bg-wrap" style="padding:20px;display:flex;align-items:center;justify-content:center;background:linear-gradient(145deg,#ede9fe,#eff6ff);min-height:520px;border-radius:0 0 12px 12px">
            <div style="background:#fff;border-radius:20px;box-shadow:0 8px 40px rgba(99,102,241,.15);padding:30px 24px;width:100%;max-width:310px">
              <div style="text-align:center;margin-bottom:18px">
                <div id="ae-prev-ico" style="width:62px;height:62px;border-radius:17px;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;box-shadow:0 6px 20px rgba(109,68,246,.4);background:linear-gradient(145deg,#7c3aed,#818cf8)">🦁</div>
                <div id="ae-prev-h" style="font-family:var(--fh);font-size:18px;font-weight:800;color:#111827;margin-bottom:3px">Welcome to Journal Your Trades</div>
                <div id="ae-prev-s" style="font-size:12.5px;color:#6b7280">We help traders become profitable!</div>
              </div>
              <div id="ae-prev-g" style="border:1.5px solid #e5e7eb;border-radius:10px;padding:10px;text-align:center;font-size:12.5px;color:#374151;margin-bottom:12px;display:flex;align-items:center;justify-content:center;gap:7px">
                <span style="font-size:16px">G</span> Sign up with Google
              </div>
              <div style="height:36px;border-radius:10px;background:linear-gradient(135deg,#6366f1,#8b5cf6);display:flex;align-items:center;justify-content:center;margin-bottom:10px">
                <span id="ae-prev-b" style="color:#fff;font-size:13.5px;font-weight:700">Sign up</span>
              </div>
              <div id="ae-prev-t" style="text-align:center;font-size:10.5px;color:#9ca3af">🔒 Free forever · No credit card</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- USERS -->
<div class="pg" id="pg-users">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Users</div><div class="page-h1">All Users</div></div>
    <div class="page-hbar-right"><button class="btn btn-secondary" onclick="expUsers()">📤 Export CSV</button></div>
  </div>
  <div class="page-body">
    <div style="margin-bottom:14px;display:flex;gap:10px;flex-wrap:wrap;align-items:center">
      <div class="search-bar" style="max-width:300px"><span style="color:var(--t3)">🔍</span><input type="text" placeholder="Search name or email…" oninput="filtU(this.value)"/></div>
    </div>
    <div class="card" style="padding:0">
      <div class="table-wrap"><table>
        <thead><tr><th>Name</th><th>Email</th><th>Plan</th><th>Trades</th><th>Win Rate</th><th>P&amp;L</th><th>Joined</th><th></th></tr></thead>
        <tbody id="u-tb"><tr><td colspan="8" style="text-align:center;color:var(--t3);padding:28px">Loading…</td></tr></tbody>
      </table></div>
    </div>
  </div>
</div>

<!-- SESSIONS -->
<div class="pg" id="pg-sessions">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Users</div><div class="page-h1">Sessions</div></div></div>
  <div class="page-body">
    <div class="card" style="padding:0"><div class="table-wrap"><table>
      <thead><tr><th>User</th><th>Token</th><th>Created</th><th>Status</th><th></th></tr></thead>
      <tbody id="sess-tb"><tr><td colspan="5" style="text-align:center;color:var(--t3);padding:28px">No sessions</td></tr></tbody>
    </table></div></div>
  </div>
</div>

<!-- ACTIVITY -->
<div class="pg" id="pg-activity">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Users</div><div class="page-h1">Activity Log</div></div>
    <div class="page-hbar-right"><button class="btn btn-danger" onclick="clearAct()">🗑 Clear Log</button></div>
  </div>
  <div class="page-body"><div class="card" id="act-el"></div></div>
</div>

<!-- BLOG LIST -->
<div class="pg" id="pg-blog">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Content</div><div class="page-h1">Blog Posts</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="go('blog-new');resetBE()">+ New Post</button></div>
  </div>
  <div class="page-body">
    <div class="stat-row" style="grid-template-columns:repeat(3,1fr)">
      <div class="stat-card"><div class="stat-label">Total Posts</div><div class="stat-val" id="bl-tot">0</div></div>
      <div class="stat-card"><div class="stat-label">With SEO Meta</div><div class="stat-val" id="bl-seo" style="color:var(--green)">0</div></div>
      <div class="stat-card"><div class="stat-label">With Cover Image</div><div class="stat-val" id="bl-img" style="color:var(--blue)">0</div></div>
    </div>
    <div id="blog-list"></div>
  </div>
</div>

<!-- BLOG EDITOR -->
<div class="pg" id="pg-blog-new">
  <div class="page-hbar">
    <div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Content</div><div class="page-h1" id="be-ttl">New Blog Post</div></div>
    <div class="page-hbar-right">
      <button class="btn btn-secondary btn-sm" onclick="go('blog')">← Back to Posts</button>
      <button class="btn btn-danger btn-sm" id="be-del" style="display:none" onclick="delCurPost()">🗑 Delete</button>
      <button class="btn btn-primary" onclick="savePost()">💾 Publish</button>
    </div>
  </div>
  <div class="page-body">
    <div class="tab-bar">
      <button class="tab-btn on" onclick="bTab('write',this)">✏️ Write</button>
      <button class="tab-btn" onclick="bTab('seo',this)">🔍 SEO</button>
      <button class="tab-btn" onclick="bTab('prev',this)">👁 Preview</button>
    </div>
    <div id="bt-write">
      <div class="form-row" style="margin-bottom:14px">
        <div class="form-group" style="margin-bottom:0"><label class="form-label">Title <span style="color:var(--red)">*</span></label><input type="text" id="bp-ti" class="form-input" placeholder="Post title…" oninput="bSlug(this.value);bWC()"/></div>
        <div class="form-group" style="margin-bottom:0"><label class="form-label">Category</label><select id="bp-cat" class="form-select"><option>Psychology</option><option>Risk Management</option><option>Strategy</option><option>Mistakes</option><option>Journaling</option><option>Market Analysis</option></select></div>
      </div>
      <div class="form-row" style="margin-bottom:14px">
        <div class="form-group" style="margin-bottom:0"><label class="form-label">Author</label><input type="text" id="bp-auth" class="form-input" value="JournalYourTrades Team"/></div>
        <div class="form-group" style="margin-bottom:0"><label class="form-label">Read Time</label><input type="text" id="bp-rt" class="form-input" placeholder="Auto-calculated"/></div>
      </div>
      <div class="form-group"><label class="form-label">Cover Image (drag &amp; drop or click)</label>
        <div id="cv-zone" onclick="document.getElementById('cv-file').click()" ondragover="event.preventDefault();this.style.borderColor='var(--blue)'" ondragleave="this.style.borderColor='var(--b2)'" ondrop="cvDrop(event)"
          style="border:2px dashed var(--b2);border-radius:var(--rs);padding:18px;text-align:center;cursor:pointer;background:var(--bg4);transition:all .2s;min-height:70px;display:flex;align-items:center;justify-content:center">
          <div id="cv-ph"><div style="font-size:20px;margin-bottom:4px">🖼️</div><div style="font-size:13px;color:var(--t2)">Drop image or <span style="color:var(--blue)">click to upload</span></div><div style="font-size:11px;color:var(--t3);margin-top:2px">PNG · JPG · WebP · Recommended 1200×630</div></div>
          <div id="cv-pr" style="display:none;position:relative;width:100%"><img id="cv-img" style="max-height:180px;border-radius:8px;object-fit:cover;width:100%"/><button onclick="event.stopPropagation();clrCover()" style="position:absolute;top:6px;right:6px;background:rgba(0,0,0,.7);border:none;color:#fff;border-radius:50%;width:24px;height:24px;cursor:pointer;font-size:13px">×</button></div>
        </div>
        <input type="file" id="cv-file" accept="image/*" style="display:none" onchange="cvFile(this)"/>
      </div>
      <div class="form-group"><label class="form-label">Excerpt <span class="form-label-hint">(shown on blog card)</span></label><textarea id="bp-exc" class="form-textarea" style="min-height:60px;resize:vertical" placeholder="2–3 sentence hook…"></textarea></div>
      <div class="form-group">
        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:5px">
          <label class="form-label" style="margin-bottom:0">Content <span class="form-label-hint">(HTML supported)</span></label>
          <div class="editor-toolbar" style="border:none;background:none;padding:0">
            <button class="et-btn" onclick="ins('h2')">H2</button><button class="et-btn" onclick="ins('h3')">H3</button>
            <span class="et-sep"></span>
            <button class="et-btn" onclick="ins('p')">P</button><button class="et-btn" onclick="ins('strong')"><b>B</b></button><button class="et-btn" onclick="ins('em')"><i>I</i></button>
            <span class="et-sep"></span>
            <button class="et-btn" onclick="ins('ul')">UL</button><button class="et-btn" onclick="ins('ol')">OL</button>
            <span class="et-sep"></span>
            <button class="et-btn" onclick="ins('blockquote')">"</button><button class="et-btn" onclick="ins('code')">{ }</button><button class="et-btn" onclick="ins('hr')">—</button>
          </div>
        </div>
        <textarea id="bp-body" class="code-area" style="min-height:360px;border-radius:var(--rs)" oninput="bWC()" placeholder="&lt;h2&gt;Introduction&lt;/h2&gt;&#10;&lt;p&gt;Start writing here...&lt;/p&gt;&#10;&lt;h3&gt;Key Point&lt;/h3&gt;&#10;&lt;p&gt;Expand on it...&lt;/p&gt;"></textarea>
        <div style="display:flex;justify-content:space-between;margin-top:5px">
          <span class="form-hint" id="bp-wc">0 chars · 0 words</span>
          <span class="form-hint">HTML tags supported</span>
        </div>
      </div>
      <div class="form-group"><label class="form-label">Tags <span class="form-label-hint">(comma separated)</span></label><input type="text" id="bp-tags" class="form-input" placeholder="psychology, win rate, discipline…"/></div>
    </div>
    <div id="bt-seo" style="display:none">
      <div class="form-group"><label class="form-label">URL Slug <span style="color:var(--red)">*</span></label>
        <div style="display:flex"><span style="padding:9px 12px;background:var(--bg4);border:1px solid var(--b2);border-right:none;border-radius:var(--rs) 0 0 var(--rs);font-size:12px;color:var(--t3);font-family:var(--fm);white-space:nowrap">/blog/</span>
        <input type="text" id="bp-slug" class="form-input" style="border-radius:0 var(--rs) var(--rs) 0;font-family:var(--fm)" placeholder="post-slug" oninput="spUpd()"/></div></div>
      <div class="form-row">
        <div class="form-group"><label class="form-label">SEO Title <span class="form-counter" id="stc">(0/60)</span></label><input type="text" id="bp-st" class="form-input" placeholder="Leave blank to use post title" oninput="spUpd();sCnt()"/></div>
        <div class="form-group"><label class="form-label">Focus Keyword</label><input type="text" id="bp-kw" class="form-input" placeholder="e.g. trading psychology"/></div>
      </div>
      <div class="form-group"><label class="form-label">Meta Description <span class="form-counter" id="smc">(0/160)</span></label><textarea id="bp-meta" class="form-textarea" style="min-height:75px;resize:vertical" placeholder="120–160 chars for Google results…" oninput="spUpd();sCnt()"></textarea></div>
      <div class="form-group"><label class="form-label">Google SERP Preview</label>
        <div class="serp-wrap"><div class="serp-url">journalyourtrades.app › blog › <span id="sp-sl">slug</span></div>
          <div class="serp-title" id="sp-ttl">Post Title | Journal Your Trades</div>
          <div class="serp-desc" id="sp-dsc">Description here…</div></div></div>
    </div>
    <div id="bt-prev" style="display:none">
      <div style="background:var(--bg3);border-radius:var(--r);padding:28px 32px;max-height:600px;overflow-y:auto">
        <div id="bp-prv" style="font-size:14px;color:#9ca3af;line-height:1.85;max-width:680px;margin:0 auto"></div>
      </div>
    </div>
  </div>
</div>

<!-- TRADES -->
<div class="pg" id="pg-trades">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Data</div><div class="page-h1">All Trades</div></div>
    <div class="page-hbar-right"><button class="btn btn-secondary" onclick="expTrades()">📤 Export CSV</button></div>
  </div>
  <div class="page-body">
    <div style="margin-bottom:14px;display:flex;gap:10px;flex-wrap:wrap;align-items:center">
      <div class="search-bar" style="max-width:260px"><span style="color:var(--t3)">🔍</span><input type="text" placeholder="Symbol, strategy…" oninput="filtT(this.value)"/></div>
      <select class="form-select" style="width:auto;padding:7px 12px;font-size:12.5px" onchange="_dF=this.value;filtT('')"><option value="">All Directions</option><option>Long</option><option>Short</option></select>
      <select class="form-select" style="width:auto;padding:7px 12px;font-size:12.5px" onchange="_oF=this.value;filtT('')"><option value="">All Outcomes</option><option value="win">Wins</option><option value="loss">Losses</option></select>
    </div>
    <div class="card" style="padding:0"><div class="table-wrap"><table>
      <thead><tr><th>Date</th><th>Symbol</th><th>Direction</th><th>Entry</th><th>Exit</th><th>Qty</th><th>P&amp;L</th><th>Strategy</th><th>Notes</th></tr></thead>
      <tbody id="tr-tb"><tr><td colspan="9" style="text-align:center;color:var(--t3);padding:28px">No trades</td></tr></tbody>
    </table></div></div>
  </div>
</div>

<!-- EXPORT -->
<div class="pg" id="pg-export">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Data</div><div class="page-h1">Export Data</div></div></div>
  <div class="page-body">
    <div class="g2">
      <div class="card"><div class="card-head"><div class="card-title">📥 Export Options</div></div>
        <div class="card-body" style="display:flex;flex-direction:column;gap:10px">
          <button class="btn btn-secondary" style="justify-content:flex-start;gap:12px;padding:12px 14px" onclick="expTrades()"><span style="font-size:20px">💹</span><div><div style="font-weight:600;color:var(--t1);font-size:13px">All Trades (CSV)</div><div style="font-size:11px;color:var(--t3)">Every trade with full data</div></div></button>
          <button class="btn btn-secondary" style="justify-content:flex-start;gap:12px;padding:12px 14px" onclick="expUsers()"><span style="font-size:20px">👥</span><div><div style="font-weight:600;color:var(--t1);font-size:13px">Users List (CSV)</div><div style="font-size:11px;color:var(--t3)">All registered accounts</div></div></button>
          <button class="btn btn-secondary" style="justify-content:flex-start;gap:12px;padding:12px 14px" onclick="expBlog()"><span style="font-size:20px">📝</span><div><div style="font-weight:600;color:var(--t1);font-size:13px">Blog Posts (JSON)</div><div style="font-size:11px;color:var(--t3)">All articles with content</div></div></button>
          <button class="btn btn-secondary" style="justify-content:flex-start;gap:12px;padding:12px 14px" onclick="expAll()"><span style="font-size:20px">🗄️</span><div><div style="font-weight:600;color:var(--t1);font-size:13px">Full Backup (JSON)</div><div style="font-size:11px;color:var(--t3)">Complete localStorage snapshot</div></div></button>
        </div>
      </div>
      <div class="card"><div class="card-head"><div class="card-title">📊 Data Summary</div></div><div class="card-body" id="exp-sum"></div></div>
    </div>
  </div>
</div>

<!-- FEATURE FLAGS -->
<div class="pg" id="pg-flags">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Platform</div><div class="page-h1">Feature Flags</div><div class="page-h1-sub">Toggle platform features on/off — changes saved to localStorage and read by tradd.html</div></div></div>
  <div class="page-body"><div class="card"><div class="card-body" id="fl-list"></div></div></div>
</div>

<!-- ANNOUNCEMENTS -->
<div class="pg" id="pg-announce">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Platform</div><div class="page-h1">Announcements</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="openAnn()">+ New Announcement</button></div>
  </div>
  <div class="page-body"><div id="ann-list"></div></div>
</div>

<!-- SETTINGS -->
<div class="pg" id="pg-settings">
  <div class="page-hbar"><div class="page-hbar-left"><div class="page-breadcrumb">Admin <span>›</span> Platform</div><div class="page-h1">Settings</div></div>
    <div class="page-hbar-right"><button class="btn btn-primary" onclick="saveSettings()">💾 Save Settings</button></div>
  </div>
  <div class="page-body">
    <div class="g2">
      <div>
        <div class="card" style="margin-bottom:14px">
          <div class="card-head"><div class="card-title">⚙️ General</div></div>
          <div class="card-body">
            <div class="form-group"><label class="form-label">Site Name</label><input type="text" id="s-nm" class="form-input" value="Journal Your Trades"/></div>
            <div class="form-group"><label class="form-label">Tagline</label><input type="text" id="s-tg" class="form-input" value="AI-Powered Trading Journal"/></div>
            <div class="form-group"><label class="form-label">Support Email</label><input type="email" id="s-em" class="form-input" value="support@journalyourtrades.app"/></div>
            <div class="form-group"><label class="form-label">Footer Copyright Text</label><input type="text" id="s-copy" class="form-input" value="© 2025 Journal Your Trades. All rights reserved."/></div>
          </div>
        </div>
      </div>
      <div>
        <div class="card">
          <div class="card-head"><div class="card-title" style="color:var(--red)">⚠️ Danger Zone</div></div>
          <div class="card-body" style="display:flex;flex-direction:column;gap:10px">
            <div class="danger-card"><div class="danger-title">Clear All Trades</div><div class="danger-desc">Permanently deletes all trade data from localStorage. Cannot be undone.</div><button class="btn btn-danger btn-sm" onclick="dangerT()">Delete All Trades</button></div>
            <div class="danger-card"><div class="danger-title">Clear All Blog Posts</div><div class="danger-desc">Deletes all custom blog posts you have created.</div><button class="btn btn-danger btn-sm" onclick="dangerB()">Delete All Posts</button></div>
            <div class="danger-card"><div class="danger-title">Factory Reset</div><div class="danger-desc">Clears ALL localStorage data including settings, users, trades, posts. Cannot be undone.</div><button class="btn btn-danger btn-sm" onclick="dangerR()">Full Factory Reset</button></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

</div><!-- /main-content -->
</div><!-- /admin-layout -->

<!-- TOAST -->
<div class="toast" id="toast"></div>

<!-- USER MODAL -->
<div class="modal-overlay" id="um"><div class="modal">
  <div class="modal-head"><h3 class="modal-title" id="um-ttl">👤 User Details</h3><button class="modal-close" onclick="cm('um')">×</button></div>
  <div class="modal-body" id="um-body"></div>
  <div class="modal-footer"><button class="btn btn-secondary" onclick="cm('um')">Close</button><button class="btn btn-danger btn-sm" onclick="banUser()">Ban User</button></div>
</div></div>

<!-- ANN MODAL -->
<div class="modal-overlay" id="ann-mo"><div class="modal" style="max-width:460px">
  <div class="modal-head"><h3 class="modal-title">📢 New Announcement</h3><button class="modal-close" onclick="cm('ann-mo')">×</button></div>
  <div class="modal-body">
    <div class="form-group"><label class="form-label">Message <span style="color:var(--red)">*</span></label><input type="text" id="an-msg" class="form-input" placeholder="🚀 New feature launched!"/></div>
    <div class="form-row">
      <div class="form-group"><label class="form-label">Type</label><select id="an-type" class="form-select"><option value="info">ℹ️ Info</option><option value="success">✅ Success</option><option value="warning">⚠️ Warning</option><option value="error">🔴 Alert</option></select></div>
      <div class="form-group"><label class="form-label">Expires</label><input type="date" id="an-exp" class="form-input"/></div>
    </div>
    <div class="form-group"><label class="form-label">Link URL (optional)</label><input type="text" id="an-lnk" class="form-input" placeholder="https://…"/></div>
  </div>
  <div class="modal-footer"><button class="btn btn-secondary" onclick="cm('ann-mo')">Cancel</button><button class="btn btn-primary" onclick="saveAnn()">Publish</button></div>
</div></div>

<!-- PAGE EDITOR MODAL -->
<div class="modal-overlay" id="pem"><div class="modal modal-lg">
  <div class="modal-head"><h3 class="modal-title" id="pem-ttl">📄 New Page</h3><button class="modal-close" onclick="cm('pem')">×</button></div>
  <div class="modal-body">
    <div class="form-row">
      <div class="form-group"><label class="form-label">Page Title <span style="color:var(--red)">*</span></label><input type="text" id="pm-ti" class="form-input" placeholder="About Us" oninput="pmSlug()"/></div>
      <div class="form-group"><label class="form-label">URL Slug</label>
        <div style="display:flex"><span style="padding:9px 12px;background:var(--bg4);border:1px solid var(--b2);border-right:none;border-radius:var(--rs) 0 0 var(--rs);font-size:12px;color:var(--t3);font-family:var(--fm);white-space:nowrap">/</span>
        <input type="text" id="pm-sl" class="form-input" style="border-radius:0 var(--rs) var(--rs) 0;font-family:var(--fm)" placeholder="about"/></div>
      </div>
    </div>
    <div class="form-row">
      <div class="form-group"><label class="form-label">Show in Nav?</label><select id="pm-nav" class="form-select"><option value="1">Yes</option><option value="0">No</option></select></div>
      <div class="form-group"><label class="form-label">Page Type</label><select id="pm-type" class="form-select"><option value="content">Content Page</option><option value="redirect">Redirect URL</option></select></div>
    </div>
    <div class="form-group"><label class="form-label">Content (HTML)</label>
      <div class="editor-toolbar">
        <button class="et-btn" onclick="pIns('h2')">H2</button><button class="et-btn" onclick="pIns('h3')">H3</button>
        <span class="et-sep"></span>
        <button class="et-btn" onclick="pIns('p')">P</button><button class="et-btn" onclick="pIns('ul')">UL</button>
        <button class="et-btn" onclick="pIns('strong')"><b>B</b></button><button class="et-btn" onclick="pIns('em')"><i>I</i></button>
        <button class="et-btn" onclick="pIns('a')">Link</button>
      </div>
      <textarea id="pm-body" class="code-area with-toolbar" style="min-height:280px;line-height:1.7" placeholder="<h2>About Journal Your Trades</h2>&#10;<p>Your content here...</p>"></textarea>
    </div>
    <div class="form-group"><label class="form-label">SEO Meta Description</label><input type="text" id="pm-meta" class="form-input" placeholder="Short description for search engines…"/></div>
  </div>
  <div class="modal-footer">
    <button class="btn btn-danger btn-sm" id="pem-del" style="display:none;margin-right:auto" onclick="delPage()">🗑 Delete Page</button>
    <button class="btn btn-secondary" onclick="cm('pem')">Cancel</button>
    <button class="btn btn-primary" onclick="savePage()">Save Page</button>
  </div>
</div></div>

<script>
// ═══════════════════════════════════════════════════════════════
//  TRADD ADMIN PANEL — Full JavaScript
// ═══════════════════════════════════════════════════════════════
var CUR='dash',_ep=null,_editPid=null,_dF='',_oF='';
var _allU=[],_allT=[],_allP=[],_allAnn=[];

var NAV_LINKS=[
  {l:'Features',a:"lpScrollTo('features')",t:'scroll'},
  {l:'How it works',a:"lpScrollTo('how')",t:'scroll'},
  {l:'Pricing',a:"lpScrollTo('pricing')",t:'scroll'},
  {l:'Blog',a:"showLpPage('blog')",t:'page'},
  {l:'About',a:"showLpPage('about')",t:'page'},
  {l:'Contact',a:"showLpPage('contact')",t:'page'}
];

var DEF_SECS=[
  {id:'features',lbl:'Features Grid',ico:'📊',vis:true},
  {id:'how',lbl:'How It Works',ico:'🔧',vis:true},
  {id:'pricing',lbl:'Pricing Table',ico:'💰',vis:true},
  {id:'testimonials',lbl:'Testimonials',ico:'⭐',vis:true},
  {id:'stats',lbl:'Stats / Numbers',ico:'📈',vis:true},
  {id:'faq',lbl:'FAQ Accordion',ico:'❓',vis:true},
  {id:'cta-banner',lbl:'CTA Banner',ico:'🚀',vis:true},
  {id:'integrations',lbl:'Integrations',ico:'🔌',vis:false}
];

var DEF_FLAGS=[
  {k:'ai_coach',n:'AI Coach',d:'Enable the AI trading coach for all users'},
  {k:'blog',n:'Public Blog',d:'Show the blog section on the landing page'},
  {k:'risk_calc',n:'Risk Calculator',d:'Enable the risk calculator tool'},
  {k:'simulator',n:'Trade Simulator',d:'Paper trading simulator'},
  {k:'csv_import',n:'CSV Import',d:'Bulk trade import via CSV upload'},
  {k:'goals',n:'Goals Tracking',d:'Enable the goals and tracking system'},
  {k:'maintenance',n:'Maintenance Mode',d:'Show a maintenance banner to all users'},
  {k:'ai_insights',n:'AI Insights',d:'Show AI-generated trade insights on dashboard'}
];

var DEF_PRICING=[
  {name:'Free',price:'$0',period:'forever',color:'#6b7280',features:['Up to 50 trades/month','Basic analytics','Journal entries','Mobile friendly'],cta:'Get Started',highlight:false},
  {name:'Pro',price:'$19',period:'month',color:'#3b82f6',features:['Unlimited trades','Advanced analytics','AI Coach','CSV import/export','Priority support','Custom tags'],cta:'Start Free Trial',highlight:true},
  {name:'Team',price:'$49',period:'month',color:'#8b5cf6',features:['Everything in Pro','5 team members','Shared playbooks','Team analytics','Slack integration','Dedicated support'],cta:'Contact Sales',highlight:false}
];

// ── Helpers ──────────────────────────────────────────────────
function E(id){return document.getElementById(id)}

// ── API helpers ───────────────────────────────────────────────
function getToken(){return localStorage.getItem('tf_access_token')||''}
function authHeaders(){return{'Content-Type':'application/json','Authorization':'Bearer '+getToken()}}

async function apiGet(url){
  try{const r=await fetch(url,{headers:authHeaders()});if(!r.ok)return null;return await r.json();}catch(e){return null;}
}
async function apiPost(url,body){
  try{const r=await fetch(url,{method:'POST',headers:authHeaders(),body:JSON.stringify(body)});return await r.json();}catch(e){return{error:e.message};}
}
async function apiPut(url,body){
  try{const r=await fetch(url,{method:'PUT',headers:authHeaders(),body:JSON.stringify(body)});return await r.json();}catch(e){return{error:e.message};}
}
async function apiDel(url){
  try{const r=await fetch(url,{method:'DELETE',headers:authHeaders()});return await r.json();}catch(e){return{error:e.message};}
}
// ── Check admin token is valid ────────────────────────────────
async function checkAdminAccess(){
  const tok=getToken();
  if(!tok){E('admin-gate').style.display='flex';return false;}
  const d=await apiGet('/api/auth/me');
  if(!d||d.role!=='admin'){
    toast('⚠️ You need admin access. Make sure your account role is "admin" in Supabase.','e');
    return false;
  }
  return true;
}

function esc(s){return(s||'').toString().replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')}
function gls(k,d){try{var v=localStorage.getItem(k);return v?JSON.parse(v):d}catch(e){return d}}
function sls(k,v){localStorage.setItem(k,JSON.stringify(v))}
function toast(msg,t){
  var n=E('toast');n.textContent=msg;
  n.className='toast show toast-'+(t||'s');
  clearTimeout(n._x);n._x=setTimeout(()=>n.classList.remove('show'),3200)
}
function cm(id){E(id).classList.remove('open')}
function om(id){E(id).classList.add('open')}
function logA(ico,txt){
  var a=gls('tf_admin_activity',[]);
  a.push({ico,txt,time:new Date().toLocaleTimeString()});
  if(a.length>300)a=a.slice(-300);
  sls('tf_admin_activity',a);
}
function dlCSV(rows,fn){
  var csv=rows.map(r=>r.map(c=>'"'+(c||'').toString().replace(/"/g,'""')+'"').join(',')).join('\n');
  var b=new Blob([csv],{type:'text/csv'});
  var a=document.createElement('a');a.href=URL.createObjectURL(b);a.download=fn;a.click();
}

// ── Sidebar toggle ───────────────────────────────────────────
function toggleSidebar(){
  document.body.classList.toggle('sb-coll');
  var coll=document.body.classList.contains('sb-coll');
  E('sb-coll-ico').textContent=coll?'▶':'◀';
  var lbl=E('sb-coll-lbl');if(lbl)lbl.textContent=coll?'Expand':'Collapse';
  sls('tf_admin_sb_coll',coll);
}

// ── Page navigation ──────────────────────────────────────────
function go(id){
  document.querySelectorAll('.pg').forEach(p=>p.classList.remove('on'));
  var pg=E('pg-'+id);if(pg)pg.classList.add('on');
  document.querySelectorAll('.sb-item').forEach(n=>n.classList.remove('on'));
  document.querySelectorAll('.sb-item').forEach(n=>{
    if((n.getAttribute('onclick')||'').includes("'"+id+"'"))n.classList.add('on');
  });
  var T={
    dash:'Dashboard',analytics:'Analytics',
    'lp-hero':'Hero Section','lp-nav':'Navigation','lp-sections':'Page Sections',
    'lp-pages':'Custom Pages','lp-seo':'Landing SEO','lp-theme':'Theme',
    'lp-pricing':'Pricing Table','auth-ed':'Signup Page Editor',
    users:'All Users',sessions:'Sessions',activity:'Activity Log',
    blog:'Blog Posts','blog-new':'Blog Editor',
    trades:'All Trades',export:'Export','flags':'Feature Flags',
    announce:'Announcements',settings:'Settings'
  };
  E('tb-ttl')?E('tb-ttl').textContent=T[id]||id:null;
  CUR=id;
  if(id==='dash')rdDash();
  if(id==='analytics')rdAnaly();
  if(id==='users')rdUsers();
  if(id==='sessions')rdSess();
  if(id==='activity')rdAct();
  if(id==='blog')rdBlog();
  if(id==='trades')rdTrades();
  if(id==='export')rdExport();
  if(id==='flags')rdFlags();
  if(id==='announce')rdAnn();
  if(id==='lp-nav')initNav();
  if(id==='lp-hero')initHero();
  if(id==='lp-sections'){var sc=gls('tf_sections_config',null);if(sc)DEF_SECS=sc;rdSecs()}
  if(id==='lp-pages')rdPages();
  if(id==='lp-seo')initSeo();
  if(id==='lp-theme')initTheme();
  if(id==='lp-pricing')rdPricing();
  if(id==='auth-ed')initAuth();
}

function refresh(){loadData();go(CUR);toast('↺ Data refreshed')}

// ── Data loading ─────────────────────────────────────────────
async function loadData(){
  // Load from Supabase API
  try {
    const [uRes, tRes, pRes, annRes] = await Promise.all([
      apiGet('/api/admin/users').catch(()=>null),
      apiGet('/api/trades').catch(()=>null),
      apiGet('/api/blog?admin=1').catch(()=>null),
      apiGet('/api/announcements?admin=1').catch(()=>null)
    ]);
    _allU = (uRes && uRes.users) ? uRes.users : gls('tf_users',[]);
    _allT = (tRes && Array.isArray(tRes)) ? tRes : (tRes && tRes.trades) ? tRes.trades : gls('tf_trades',[]);
    _allP = (pRes && Array.isArray(pRes)) ? pRes : gls('tf_blog_posts',[]);
    var annArr = (annRes && annRes.announcements) ? annRes.announcements : gls('tf_announcements',[]);
    var anns = annArr.filter(a=>a.active).length;
    if(E('nb-ann'))E('nb-ann').textContent=anns;
    if(anns>0&&E('notif-dot'))E('notif-dot').style.display='block';
  } catch(err) {
    // Fallback to localStorage
    _allU=gls('tf_users',[]);
    _allT=gls('tf_trades',[]);
    _allP=gls('tf_blog_posts',[]);
    var anns=gls('tf_announcements',[]).filter(a=>a.active).length;
    if(E('nb-ann'))E('nb-ann').textContent=anns;
  }
  var wins=_allT.filter(t=>parseFloat(t.pnl||0)>0).length;
  var pnl=_allT.reduce((a,t)=>a+parseFloat(t.pnl||0),0);
  _allU=_allU.map(u=>({...u,trades:u.trades||_allT.filter(t=>t.user_id===u.id).length,
    winRate:u.winRate||(_allT.length?Math.round(wins/_allT.length*100):0),pnl:u.pnl||pnl}));
  if(E('nb-u'))E('nb-u').textContent=_allU.length;
  if(E('nb-p'))E('nb-p').textContent=_allP.length;
  if(E('nb-t'))E('nb-t').textContent=_allT.length;
}

// ── Dashboard ────────────────────────────────────────────────
function rdDash(){
  loadData();
  var wins=_allT.filter(t=>parseFloat(t.pnl||0)>0).length;
  var pnl=_allT.reduce((a,t)=>a+parseFloat(t.pnl||0),0);
  var wr=_allT.length?Math.round(wins/_allT.length*100):0;
  E('s-u').textContent=_allU.length;
  E('s-t').textContent=_allT.length.toLocaleString();
  E('s-p').textContent=_allP.length;
  E('s-pnl').textContent='$'+pnl.toFixed(0);
  E('s-pnl').style.color=pnl>=0?'var(--green)':'var(--red)';
  E('s-wr').textContent=wr+'%';
  E('s-wr').style.color=wr>=50?'var(--green)':'var(--red)';
  E('s-ann').textContent=gls('tf_announcements',[]).filter(a=>a.active).length;
  // Chart
  var ch=E('dash-chart'),days=[],today=new Date();
  for(var i=6;i>=0;i--){
    var d=new Date(today);d.setDate(today.getDate()-i);
    var ds=d.toISOString().slice(0,10);
    days.push({l:['S','M','T','W','T','F','S'][d.getDay()],c:_allT.filter(t=>(t.date||'').slice(0,10)===ds).length});
  }
  var mx=Math.max(1,...days.map(d=>d.c));
  ch.innerHTML=days.map(d=>`<div style="display:flex;flex-direction:column;align-items:center;gap:4px;flex:1">
    <div style="width:100%;max-width:36px;height:${Math.max(4,Math.round(d.c/mx*100))}px;background:linear-gradient(to top,var(--blue),var(--indigo));border-radius:3px 3px 0 0;margin:0 auto;transition:height .4s"></div>
    <div style="font-size:10px;color:var(--t3)">${d.l}</div></div>`).join('');
  // Activity
  var acts=gls('tf_admin_activity',[]).slice(-6).reverse();
  E('dash-acts').innerHTML=acts.length
    ?acts.map(a=>`<div class="activity-item"><div class="act-ico">${a.ico}</div><div class="act-txt">${esc(a.txt)}</div><div class="act-time">${a.time}</div></div>`).join('')
    :'<div class="empty-state" style="padding:16px"><span class="empty-ico">⚡</span><div class="empty-sub">No activity recorded yet</div></div>';
  // Users table
  var tb=E('dash-tb');
  if(!_allU.length){tb.innerHTML='<tr><td colspan="7" style="text-align:center;color:var(--t3);padding:20px">No users yet</td></tr>';return}
  tb.innerHTML=_allU.slice(0,8).map(u=>`<tr>
    <td><span style="font-weight:600">${esc(u.name||'—')}</span></td>
    <td style="color:var(--t2);font-size:12px">${esc(u.email||'—')}</td>
    <td>${u.trades}</td>
    <td style="color:${u.winRate>=50?'var(--green)':'var(--red)'}">${u.winRate}%</td>
    <td style="color:${u.pnl>=0?'var(--green)':'var(--red)'}">$${(u.pnl||0).toFixed(0)}</td>
    <td style="font-size:11px;color:var(--t3)">${u.createdAt?new Date(u.createdAt).toLocaleDateString():'—'}</td>
    <td><button class="btn btn-secondary btn-sm" onclick="openUM('${u.id}')">View</button></td>
  </tr>`).join('');
}

// ── Analytics ────────────────────────────────────────────────
function rdAnaly(){
  loadData();
  var wins=_allT.filter(t=>parseFloat(t.pnl||0)>0).length;
  var wr=_allT.length?Math.round(wins/_allT.length*100):0;
  var longs=_allT.filter(t=>(t.direction||'').toLowerCase()==='long').length;
  var strats={};_allT.forEach(t=>{if(t.strategy)strats[t.strategy]=(strats[t.strategy]||0)+1});
  var topS=Object.keys(strats).sort((a,b)=>strats[b]-strats[a])[0]||'N/A';
  E('an-at').textContent=_allU.length?Math.round(_allT.length/_allU.length):0;
  E('an-wr').textContent=wr+'%';
  E('an-ls').textContent=longs+'L / '+(_allT.length-longs)+'S';
  E('an-ts').textContent=topS;
  var bkts=[
    {l:'>$500',mn:500,mx:Infinity,c:'var(--green)'},
    {l:'$0–500',mn:0,mx:500,c:'#34d399'},
    {l:'-$100–0',mn:-100,mx:0,c:'var(--amber)'},
    {l:'< -$100',mn:-Infinity,mx:-100,c:'var(--red)'}
  ];
  E('an-pnl').innerHTML=bkts.map(b=>{
    var cnt=_allT.filter(t=>{var p=parseFloat(t.pnl||0);return p>=b.mn&&p<b.mx}).length;
    var pct=_allT.length?Math.round(cnt/_allT.length*100):0;
    return `<div style="display:flex;align-items:center;gap:10px">
      <div style="font-size:12px;color:var(--t2);width:78px;flex-shrink:0">${b.l}</div>
      <div class="progress" style="flex:1"><div class="progress-fill" style="width:${pct}%;background:${b.c}"></div></div>
      <div style="font-size:11px;color:var(--t3);width:22px;text-align:right">${cnt}</div></div>`;
  }).join('');
  var syms={};_allT.forEach(t=>{if(t.symbol)syms[t.symbol]=(syms[t.symbol]||0)+1});
  var topSy=Object.keys(syms).sort((a,b)=>syms[b]-syms[a]).slice(0,8);
  var mc=topSy.length?Math.max(...topSy.map(s=>syms[s])):1;
  E('an-sym').innerHTML=topSy.length
    ?topSy.map(s=>`<div style="display:flex;align-items:center;gap:9px">
      <div style="font-family:var(--fm);font-size:12px;color:var(--t1);width:55px;flex-shrink:0">${esc(s)}</div>
      <div class="progress" style="flex:1"><div class="progress-fill" style="width:${Math.round(syms[s]/mc*100)}%;background:linear-gradient(90deg,var(--blue),var(--indigo))"></div></div>
      <div style="font-size:11px;color:var(--t3);width:20px">${syms[s]}</div></div>`).join('')
    :'<div style="color:var(--t3);font-size:13px;padding:8px 0">No symbol data yet</div>';
}

// ── Hero ─────────────────────────────────────────────────────
function initHero(){
  var h=gls('tf_hero_config',{});
  E('h-badge').value=h.badge||'';E('h-h1').value=h.h1||'';
  E('h-h2').value=h.h2||'';E('h-desc').value=h.desc||'';
  E('h-cta1').value=h.cta1||'';E('h-cta2').value=h.cta2||'';
  E('h-trust').value=h.trust||'';E('h-stat').value=h.stat||'';
  upHP();
}
function upHP(){
  E('hp-badge').textContent=E('h-badge').value||'🚀 Now with AI Coach';
  E('hp-h1').textContent=E('h-h1').value||'AI-Powered Trading Journal';
  E('hp-h2').textContent=E('h-h2').value||'Track, analyse & improve every trade';
  E('hp-desc').textContent=E('h-desc').value||'The journal serious traders use…';
  E('hp-cta1').textContent=E('h-cta1').value||'Get Started Free →';
  E('hp-cta2').textContent=E('h-cta2').value||'Watch Demo';
  E('hp-trust').textContent=E('h-trust').value||'Free forever · No credit card';
  E('hp-stat').textContent=E('h-stat').value||'';
}
function saveHero(){
  sls('tf_hero_config',{badge:E('h-badge').value,h1:E('h-h1').value,h2:E('h-h2').value,
    desc:E('h-desc').value,cta1:E('h-cta1').value,cta2:E('h-cta2').value,
    trust:E('h-trust').value,stat:E('h-stat').value});
  logA('🏠','Updated hero section');toast('✅ Hero saved! Reload tradd.html to see changes.');
}

// ── Nav ──────────────────────────────────────────────────────
function initNav(){
  var cfg=gls('tf_nav_config',null);
  if(cfg){
    E('n-nm').value=cfg.name||'';E('n-ico').value=cfg.icon||'';
    E('n-badge').value=cfg.badge||'';E('n-cta1').value=cfg.cta1||'';
    E('n-cta2').value=cfg.cta2||'';
    if(cfg.links)NAV_LINKS=cfg.links;
  }
  rdNL();upNP();
}
function rdNL(){
  E('nav-le').innerHTML=NAV_LINKS.map((l,i)=>`
    <div class="nl-item">
      <span style="color:var(--t4);cursor:grab;font-size:14px">⠿</span>
      <input type="text" value="${esc(l.l)}" class="form-input" style="flex:1;padding:6px 10px;font-size:12.5px" oninput="NAV_LINKS[${i}].l=this.value;upNP()"/>
      <span class="badge badge-gray">${l.t}</span>
      <button onclick="NAV_LINKS.splice(${i},1);rdNL();upNP()" style="background:none;border:none;color:var(--red);cursor:pointer;font-size:16px;padding:2px 6px;line-height:1">×</button>
    </div>`).join('');
}
function addNL(){NAV_LINKS.push({l:'New Link',a:"showLpPage('new')",t:'page'});rdNL();upNP()}
function upNP(){
  E('np-ico').textContent=E('n-ico')?.value||'TF';
  E('np-nm').textContent=E('n-nm')?.value||'Journal Your Trades';
  E('np-badge').textContent=E('n-badge')?.value||'Beta';
  E('np-cta1').textContent=E('n-cta1')?.value||'Get Started →';
  E('np-cta2').textContent=E('n-cta2')?.value||'Sign In';
  E('np-links').innerHTML=NAV_LINKS.slice(0,6).map(l=>`<span style="padding:4px 10px;border-radius:6px;font-size:11.5px;color:#6b7280">${esc(l.l)}</span>`).join('');
}
function saveNav(){
  sls('tf_nav_config',{name:E('n-nm').value,icon:E('n-ico').value,badge:E('n-badge').value,
    cta1:E('n-cta1').value,cta2:E('n-cta2').value,links:NAV_LINKS});
  logA('🧭','Updated navigation');toast('✅ Navigation saved! Reload tradd.html.');
}

// ── Sections ─────────────────────────────────────────────────
function rdSecs(){
  E('secs-list').innerHTML=DEF_SECS.map((s,i)=>`
    <div class="card" style="display:flex;align-items:center;gap:12px;padding:12px 18px;margin-bottom:8px">
      <span style="font-size:18px">${s.ico}</span>
      <div style="flex:1">
        <div style="font-size:14px;font-weight:600;color:var(--t1)">${s.lbl}</div>
        <div style="font-size:11px;color:var(--t3);font-family:var(--fm)">#${s.id}</div>
      </div>
      <div class="toggle ${s.vis?'on':''}" onclick="DEF_SECS[${i}].vis=!DEF_SECS[${i}].vis;this.classList.toggle('on')" title="${s.vis?'Visible — click to hide':'Hidden — click to show'}"></div>
      <div style="display:flex;gap:4px">
        <button class="btn btn-secondary btn-sm" onclick="mvS(${i},-1)">↑</button>
        <button class="btn btn-secondary btn-sm" onclick="mvS(${i},1)">↓</button>
      </div>
    </div>`).join('');
}
function mvS(i,d){var n=i+d;if(n<0||n>=DEF_SECS.length)return;[DEF_SECS[i],DEF_SECS[n]]=[DEF_SECS[n],DEF_SECS[i]];rdSecs()}
async function saveSecs(){sls('tf_sections_config',DEF_SECS);const r=await apiPut('/api/config',{key:'sections_config',value:{order:DEF_SECS}});logA('📐','Saved sections config');toast(r&&r.success?'✅ Sections saved to Supabase!':'✅ Saved locally');}

// ── Custom Pages ─────────────────────────────────────────────
function rdPages(){
  var pages=gls('tf_custom_pages',[]);var el=E('pages-list');
  if(!pages.length){el.innerHTML='<div class="empty-state"><span class="empty-ico">📄</span><div class="empty-title">No Custom Pages</div><div class="empty-sub">Create standalone pages like About, Contact, or Terms. They appear in your navigation automatically.</div><button class="btn btn-primary" onclick="openPM(null)">+ Create First Page</button></div>';return}
  el.innerHTML='<div style="display:flex;flex-direction:column;gap:8px">'+pages.map(p=>`
    <div class="card" style="display:flex;align-items:center;gap:14px;padding:14px 18px">
      <div style="flex:1">
        <div style="font-size:14px;font-weight:600;color:var(--t1);margin-bottom:3px">${esc(p.title)}</div>
        <div style="font-size:12px;color:var(--t3);display:flex;gap:8px">
          <span>/${p.slug}</span>
          ${p.showInNav?'<span class="badge badge-green">In Nav</span>':'<span class="badge badge-gray">Hidden</span>'}
          <span class="badge badge-blue">${p.type}</span>
        </div>
      </div>
      <div style="font-size:11px;color:var(--t3)">${p.updatedAt?new Date(p.updatedAt).toLocaleDateString():'—'}</div>
      <div style="display:flex;gap:6px">
        <button class="btn btn-secondary btn-sm" onclick="openPM('${p.id}')">✏️ Edit</button>
        <button class="btn btn-danger btn-sm" onclick="delPage2('${p.id}')">🗑</button>
      </div>
    </div>`).join('')+'</div>';
}
function openPM(pid){
  _ep=pid;E('pem-del').style.display=pid?'inline-flex':'none';
  if(pid){
    var p=gls('tf_custom_pages',[]).find(x=>x.id===pid);
    if(p){E('pm-ti').value=p.title;E('pm-sl').value=p.slug;E('pm-nav').value=p.showInNav?'1':'0';
      E('pm-type').value=p.type||'content';E('pm-body').value=p.content||'';E('pm-meta').value=p.meta||'';
      E('pem-ttl').textContent='📝 Edit Page: '+p.title;}
  }else{
    ['pm-ti','pm-sl','pm-body','pm-meta'].forEach(id=>{var e=E(id);if(e)e.value=''});
    E('pm-nav').value='1';E('pm-type').value='content';
    E('pem-ttl').textContent='📄 New Page';
  }
  om('pem');
}
function pmSlug(){var e=E('pm-sl');if(e)e.value=(E('pm-ti')?.value||'').toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'')}
function pIns(tag){var ta=E('pm-body');if(!ta)return;var T={h2:'<h2>Heading</h2>\n',h3:'<h3>Subheading</h3>\n',p:'<p>Your paragraph here.</p>\n',ul:'<ul>\n  <li>Item one</li>\n  <li>Item two</li>\n</ul>\n',strong:'<strong>bold text</strong>',em:'<em>italic text</em>',a:'<a href="#">Link text</a>'};var s=ta.selectionStart;ta.value=ta.value.substring(0,s)+(T[tag]||'');ta.focus()}
function savePage(){
  var ti=(E('pm-ti')?.value||'').trim(),sl=(E('pm-sl')?.value||'').trim();
  if(!ti||!sl){toast('Title and slug are required','e');return}
  var pages=gls('tf_custom_pages',[]);
  var pg={id:_ep||'pg'+Date.now(),title:ti,slug:sl,showInNav:E('pm-nav').value==='1',
    type:E('pm-type').value,content:E('pm-body').value,meta:E('pm-meta')?.value||'',
    updatedAt:new Date().toISOString()};
  if(_ep){var i=pages.findIndex(p=>p.id===_ep);if(i>=0)pages[i]=pg;}
  else{pg.createdAt=new Date().toISOString();pages.push(pg)}
  sls('tf_custom_pages',pages);cm('pem');rdPages();
  logA('📄','Saved page: '+ti);toast('✅ Page saved!');
}
function delPage(){if(_ep)delPage2(_ep);cm('pem')}
function delPage2(pid){if(!confirm('Delete this page?'))return;sls('tf_custom_pages',gls('tf_custom_pages',[]).filter(p=>p.id!==pid));rdPages();toast('Page deleted')}

// ── SEO ──────────────────────────────────────────────────────
function initSeo(){var c=gls('tf_landing_seo',{});E('ls-title').value=c.title||'';E('ls-desc').value=c.desc||'';E('ls-url').value=c.url||'';E('ls-og').value=c.og||'';upSeoC();upSerp()}
function upSeoC(){
  var t=E('ls-title')?.value||'',m=E('ls-desc')?.value||'';
  var tc=E('seo-tc'),mc=E('seo-mc');
  if(tc){tc.textContent='('+t.length+'/60)';tc.className='form-counter'+(t.length>60?' err':t.length>50?' warn':'');}
  if(mc){mc.textContent='('+m.length+'/160)';mc.className='form-counter'+(m.length>160?' err':m.length>140?' warn':'');}
}
function upSerp(){
  var t=E('ls-title')?.value||'Journal Your Trades',d=E('ls-desc')?.value||'Description…',u=E('ls-url')?.value||'https://journalyourtrades.app';
  if(E('serp-url'))E('serp-url').textContent=u;
  if(E('serp-ttl'))E('serp-ttl').textContent=t;
  if(E('serp-dsc'))E('serp-dsc').textContent=d;
}
async function saveSeo(){const v={title:E('ls-title').value,desc:E('ls-desc').value,url:E('ls-url').value,og:E('ls-og').value};sls('tf_landing_seo',v);const r=await apiPut('/api/config',{key:'seo',value:v});logA('🔍','Updated SEO');toast(r&&r.success?'✅ SEO saved to Supabase!':'✅ SEO saved locally');}

// ── Theme ────────────────────────────────────────────────────
function initTheme(){var t=gls('tf_theme_config',{});if(t.accent)E('tc-a1').value=t.accent;if(t.accent2)E('tc-a2').value=t.accent2;upTP()}
function pal(c1,c2){E('tc-a1').value=c1;E('tc-a2').value=c2;upTP();document.querySelectorAll('.swatch').forEach(s=>s.classList.remove('on'));if(event&&event.target)event.target.classList.add('on')}
function upTP(){var c1=E('tc-a1')?.value||'#3b82f6',c2=E('tc-a2')?.value||'#6366f1';var g=`linear-gradient(135deg,${c1},${c2})`;if(E('tp-b1'))E('tp-b1').style.background=g;if(E('tp-lnk'))E('tp-lnk').style.color=c1}
async function saveTheme(){const v={accent:E('tc-a1').value,accent2:E('tc-a2').value,headFont:E('tc-hf').value};sls('tf_theme_config',v);const r=await apiPut('/api/config',{key:'theme',value:v});logA('🎨','Updated theme');toast(r&&r.success?'✅ Theme saved to Supabase!':'✅ Theme saved locally — reload site to apply');}

// ── Pricing ──────────────────────────────────────────────────
function rdPricing(){
  var saved=gls('tf_pricing_config',null);if(saved)DEF_PRICING=saved;
  E('pricing-editor').innerHTML=DEF_PRICING.map((plan,pi)=>`
    <div class="card">
      <div class="card-head"><div class="card-title">${plan.highlight?'⭐ ':''}${plan.name} Plan</div>
        <div class="toggle ${plan.highlight?'on':''}" onclick="DEF_PRICING[${pi}].highlight=!DEF_PRICING[${pi}].highlight;this.classList.toggle('on')" title="Featured plan"></div>
      </div>
      <div class="card-body" style="display:flex;flex-direction:column;gap:10px">
        <div class="form-group" style="margin-bottom:0"><label class="form-label">Plan Name</label><input class="form-input" value="${esc(plan.name)}" oninput="DEF_PRICING[${pi}].name=this.value"/></div>
        <div style="display:flex;gap:8px">
          <div class="form-group" style="margin-bottom:0;flex:1"><label class="form-label">Price</label><input class="form-input" value="${esc(plan.price)}" oninput="DEF_PRICING[${pi}].price=this.value" placeholder="$19"/></div>
          <div class="form-group" style="margin-bottom:0;flex:1"><label class="form-label">Period</label><input class="form-input" value="${esc(plan.period)}" oninput="DEF_PRICING[${pi}].period=this.value" placeholder="month"/></div>
        </div>
        <div class="form-group" style="margin-bottom:0"><label class="form-label">CTA Button</label><input class="form-input" value="${esc(plan.cta)}" oninput="DEF_PRICING[${pi}].cta=this.value"/></div>
        <div class="form-group" style="margin-bottom:0"><label class="form-label">Features (one per line)</label>
          <textarea class="form-textarea" style="min-height:100px;resize:vertical" oninput="DEF_PRICING[${pi}].features=this.value.split('\\n').filter(Boolean)">${plan.features.join('\n')}</textarea></div>
        <div class="form-group" style="margin-bottom:0"><label class="form-label">Accent Colour</label><input type="color" class="form-input" value="${plan.color}" oninput="DEF_PRICING[${pi}].color=this.value" style="height:38px;padding:3px"/></div>
      </div>
    </div>`).join('');
}
async function savePricing(){sls('tf_pricing_config',DEF_PRICING);const r=await apiPut('/api/config',{key:'pricing',value:{plans:DEF_PRICING}});logA('💰','Updated pricing');toast(r&&r.success?'✅ Pricing saved to Supabase!':'✅ Saved locally');}

// ── Auth Editor ──────────────────────────────────────────────
function initAuth(){
  var c=gls('tf_auth_config',{});
  E('ae-ico').value=c.icon||'🦁';E('ae-su-h').value=c.suH||'';E('ae-su-s').value=c.suS||'';
  E('ae-si-h').value=c.siH||'';E('ae-si-s').value=c.siS||'';
  E('ae-su-b').value=c.suB||'';E('ae-si-b').value=c.siB||'';
  E('ae-goog').value=c.goog||'';E('ae-demo').value=c.demo||'';E('ae-trust').value=c.trust||'';
  if(c.bg1)E('ae-bg1').value=c.bg1;if(c.bg2)E('ae-bg2').value=c.bg2;if(c.lc)E('ae-lc').value=c.lc;
  upAP();
}
function upAP(){
  var ico=E('ae-ico')?.value||'🦁',h=E('ae-su-h')?.value||'Welcome to Journal Your Trades';
  var s=E('ae-su-s')?.value||'We help traders become profitable!';
  var b=E('ae-su-b')?.value||'Sign up',g=E('ae-goog')?.value||'Sign up with Google';
  var tr=E('ae-trust')?.value||'🔒 Free forever',bg1=E('ae-bg1')?.value||'#ede9fe',bg2=E('ae-bg2')?.value||'#eff6ff';
  var lc=E('ae-lc')?.value||'#7c3aed';
  if(E('ae-bg-wrap'))E('ae-bg-wrap').style.background=`linear-gradient(145deg,${bg1},${bg2})`;
  if(E('ae-prev-ico')){E('ae-prev-ico').textContent=ico;E('ae-prev-ico').style.background=`linear-gradient(145deg,${lc},#818cf8)`}
  if(E('ae-prev-h'))E('ae-prev-h').textContent=h;
  if(E('ae-prev-s'))E('ae-prev-s').textContent=s;
  if(E('ae-prev-g'))E('ae-prev-g').innerHTML='<span style="font-size:16px">G</span> '+esc(g);
  if(E('ae-prev-b'))E('ae-prev-b').textContent=b;
  if(E('ae-prev-t'))E('ae-prev-t').textContent=tr;
}
function saveAuth(){
  sls('tf_auth_config',{icon:E('ae-ico').value,suH:E('ae-su-h').value,suS:E('ae-su-s').value,
    siH:E('ae-si-h').value,siS:E('ae-si-s').value,suB:E('ae-su-b').value,siB:E('ae-si-b').value,
    goog:E('ae-goog').value,demo:E('ae-demo').value,trust:E('ae-trust').value,
    bg1:E('ae-bg1').value,bg2:E('ae-bg2').value,lc:E('ae-lc').value});
  logA('🔐','Updated auth page');
  // Apply to tradd.html via localStorage — tradd.html reads this on startup
  toast('✅ Auth page saved! Reload tradd.html to apply.');
}

// ── Users ────────────────────────────────────────────────────
function rdUsers(){loadData();renderU(_allU)}
function renderU(u){
  var tb=E('u-tb');
  if(!u.length){tb.innerHTML='<tr><td colspan="8" style="text-align:center;color:var(--t3);padding:28px">No users found</td></tr>';return}
  tb.innerHTML=u.map(u=>`<tr>
    <td><div style="font-weight:600">${esc(u.name||'—')}</div></td>
    <td style="color:var(--t2);font-size:12px">${esc(u.email||'—')}</td>
    <td><span class="badge ${u.plan==='pro'?'badge-purple':'badge-gray'}">${u.plan||'free'}</span></td>
    <td>${u.trades}</td>
    <td style="color:${u.winRate>=50?'var(--green)':'var(--red)'}">${u.winRate}%</td>
    <td style="color:${u.pnl>=0?'var(--green)':'var(--red)'}">$${(u.pnl||0).toFixed(0)}</td>
    <td style="font-size:11px;color:var(--t3)">${u.createdAt?new Date(u.createdAt).toLocaleDateString():'—'}</td>
    <td><button class="btn btn-secondary btn-sm" onclick="openUM('${u.id}')">View</button></td>
  </tr>`).join('');
}
function filtU(q){q=q.toLowerCase();renderU(_allU.filter(u=>(u.name||'').toLowerCase().includes(q)||(u.email||'').toLowerCase().includes(q)))}
function openUM(uid){
  var u=_allU.find(x=>x.id===uid);if(!u)return;
  E('um-ttl').textContent='👤 '+( u.name||u.email);
  var pc=u.pnl>=0?'var(--green)':'var(--red)';
  E('um-body').innerHTML=`
    <div class="form-row" style="gap:10px;margin-bottom:14px">
      <div style="background:var(--bg4);border-radius:8px;padding:12px"><div style="font-size:10px;color:var(--t3);text-transform:uppercase;margin-bottom:2px">Email</div><div style="font-size:13px">${esc(u.email||'—')}</div></div>
      <div style="background:var(--bg4);border-radius:8px;padding:12px"><div style="font-size:10px;color:var(--t3);text-transform:uppercase;margin-bottom:2px">Plan</div><div style="color:var(--purple);font-weight:600">${u.plan||'free'}</div></div>
      <div style="background:var(--bg4);border-radius:8px;padding:12px"><div style="font-size:10px;color:var(--t3);text-transform:uppercase;margin-bottom:2px">Trades</div><div style="font-family:var(--fh);font-size:24px;font-weight:800">${u.trades}</div></div>
      <div style="background:var(--bg4);border-radius:8px;padding:12px"><div style="font-size:10px;color:var(--t3);text-transform:uppercase;margin-bottom:2px">Win Rate</div><div style="font-family:var(--fh);font-size:24px;font-weight:800;color:${u.winRate>=50?'var(--green)':'var(--red)'}">${u.winRate}%</div></div>
    </div>
    <div style="background:var(--bg4);border-radius:8px;padding:14px;margin-bottom:12px">
      <div style="font-size:10px;color:var(--t3);text-transform:uppercase;margin-bottom:4px">Total P&L</div>
      <div style="font-family:var(--fh);font-size:28px;font-weight:800;color:${pc}">${u.pnl>=0?'+':''}$${(u.pnl||0).toFixed(2)}</div>
    </div>
    <div style="font-size:12px;color:var(--t3)">Joined: ${u.createdAt?new Date(u.createdAt).toLocaleString():'—'}</div>`;
  om('um');
}
function banUser(){if(!confirm('Ban this user?'))return;toast('User banned');cm('um')}
function expUsers(){var r=[['Name','Email','Plan','Trades','Win%','P&L','Joined']];_allU.forEach(u=>r.push([u.name||'',u.email||'',u.plan||'free',u.trades,u.winRate+'%','$'+(u.pnl||0).toFixed(2),u.createdAt?new Date(u.createdAt).toLocaleDateString():'']));dlCSV(r,'tradd-users.csv');logA('📤','Exported users')}

// ── Sessions ─────────────────────────────────────────────────
function rdSess(){
  var s=gls('tf_session',null);var tb=E('sess-tb');
  if(!s){tb.innerHTML='<tr><td colspan="5" style="text-align:center;color:var(--t3);padding:28px">No active sessions</td></tr>';return}
  tb.innerHTML=`<tr>
    <td><div style="font-weight:600">${esc(s.name||'User')}</div><div style="font-size:11px;color:var(--t3)">${esc(s.email||'')}</div></td>
    <td style="font-family:var(--fm);font-size:11px;color:var(--t2)">${(s.token||'—').slice(0,20)}…</td>
    <td style="font-size:12px;color:var(--t3)">${s.loginAt?new Date(s.loginAt).toLocaleString():'—'}</td>
    <td><span class="badge badge-green">Active</span></td>
    <td><button class="btn btn-danger btn-sm" onclick="revokeSess()">Revoke</button></td>
  </tr>`;
}
function revokeSess(){if(!confirm('Revoke session?'))return;localStorage.removeItem('tf_session');rdSess();toast('Session revoked')}

// ── Activity ─────────────────────────────────────────────────
function rdAct(){
  var a=gls('tf_admin_activity',[]);var el=E('act-el');
  if(!a.length){el.innerHTML='<div class="empty-state"><span class="empty-ico">⚡</span><div class="empty-title">No Activity Yet</div><div class="empty-sub">Actions are logged here as users interact with Journal Your Trades</div></div>';return}
  el.innerHTML=a.slice().reverse().map(x=>`<div class="activity-item"><div class="act-ico">${x.ico}</div><div class="act-txt">${esc(x.txt)}</div><div class="act-time">${x.time}</div></div>`).join('');
}
function clearAct(){if(!confirm('Clear all activity logs?'))return;sls('tf_admin_activity',[]);rdAct();toast('Log cleared')}

// ── Blog ─────────────────────────────────────────────────────
async function rdBlog(){
  await loadData();
  var ws=_allP.filter(p=>p.meta&&p.meta.length>10).length,wi=_allP.filter(p=>!!p.coverImage).length;
  E('bl-tot').textContent=_allP.length;E('bl-seo').textContent=ws;E('bl-img').textContent=wi;
  var el=E('blog-list');
  if(!_allP.length){el.innerHTML='<div class="empty-state"><span class="empty-ico">📝</span><div class="empty-title">No Posts Yet</div><div class="empty-sub">Create your first blog post to engage your audience and improve SEO.</div><button class="btn btn-primary" onclick="go(\'blog-new\');resetBE()">Write First Post</button></div>';return}
  var cc={'Psychology':'#a78bfa','Risk Management':'#22c55e','Strategy':'#60a5fa','Mistakes':'#f87171','Journaling':'#fbbf24','Market Analysis':'#22d3ee'};
  el.innerHTML='<div style="display:flex;flex-direction:column;gap:8px">'+_allP.map(p=>{
    var hs=p.meta&&p.meta.length>10,hi=!!p.coverImage,c=cc[p.category]||'#60a5fa';
    return `<div class="card" style="display:flex;align-items:center;gap:14px;padding:14px 18px">
      ${hi?`<img src="${p.coverImage}" style="width:52px;height:52px;border-radius:8px;object-fit:cover;flex-shrink:0"/>`:`<div style="width:52px;height:52px;border-radius:8px;background:var(--bg4);border:1px dashed var(--b2);display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0">📄</div>`}
      <div style="flex:1;min-width:0">
        <div style="font-size:14px;font-weight:600;color:var(--t1);margin-bottom:3px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis">${esc(p.title)}</div>
        <div style="font-size:12px;display:flex;gap:7px;align-items:center;flex-wrap:wrap">
          <span style="color:${c}">${esc(p.category)}</span>
          <span style="color:var(--t3)">·</span><span style="color:var(--t3)">${esc(p.readtime||'')}</span>
          <span style="color:var(--t3)">·</span><span style="font-family:var(--fm);font-size:11px;color:var(--t3)">/blog/${esc(p.slug)}</span>
        </div>
        <div style="display:flex;gap:5px;margin-top:5px">
          ${hs?'<span class="badge badge-green" style="font-size:10px">✓ SEO</span>':'<span class="badge badge-amber" style="font-size:10px">⚠ No meta</span>'}
          ${hi?'<span class="badge badge-blue" style="font-size:10px">✓ Image</span>':''}
          ${p.tags?'<span class="badge badge-gray" style="font-size:10px">🏷 Tags</span>':''}
        </div>
      </div>
      <div style="font-size:11px;color:var(--t3);white-space:nowrap">${new Date(p.updatedAt||p.createdAt).toLocaleDateString()}</div>
      <div style="display:flex;gap:6px">
        <button class="btn btn-secondary btn-sm" onclick="editPost('${p.id}')">✏️ Edit</button>
        <button class="btn btn-danger btn-sm" onclick="delPost('${p.id}')">🗑</button>
      </div>
    </div>`;
  }).join('')+'</div>';
}
function resetBE(){
  _editPid=null;E('be-ttl').textContent='New Blog Post';E('be-del').style.display='none';
  ['bp-ti','bp-slug','bp-rt','bp-exc','bp-body','bp-tags','bp-st','bp-meta','bp-kw'].forEach(id=>{var e=E(id);if(e)e.value=''});
  var a=E('bp-auth');if(a)a.value='JYT Team';var c=E('bp-cat');if(c)c.value='Psychology';
  clrCover();bWC();bTab('write',document.querySelector('#pg-blog-new .tab-btn'));
}
function editPost(pid){
  var p=_allP.find(x=>x.id===pid);if(!p)return;
  _editPid=pid;E('be-ttl').textContent='Edit: '+p.title;E('be-del').style.display='inline-flex';
  E('bp-ti').value=p.title||'';E('bp-slug').value=p.slug||'';E('bp-rt').value=p.readtime||'';
  E('bp-auth').value=p.author||'JYT Team';E('bp-cat').value=p.category||'Psychology';
  E('bp-exc').value=p.excerpt||'';E('bp-body').value=p.content||'';E('bp-tags').value=p.tags||'';
  E('bp-st').value=p.seoTitle||'';E('bp-meta').value=p.meta||'';E('bp-kw').value=p.keyword||'';
  if(p.coverImage){E('cv-img').src=p.coverImage;E('cv-img').dataset.data=p.coverImage;E('cv-pr').style.display='block';E('cv-ph').style.display='none';}
  else clrCover();
  bWC();go('blog-new');
}
async function delPost(pid){if(!confirm('Delete this post?'))return;const r=await apiDel('/api/blog?id='+pid);if(r&&r.success){loadData();rdBlog();logA('🗑','Deleted post');toast('Post deleted');}else{// fallback localStorage
sls('tf_blog_posts',_allP.filter(p=>p.id!==pid));loadData();rdBlog();toast('Post deleted (local)');}}
function delCurPost(){if(_editPid)delPost(_editPid);_editPid=null;go('blog')}
async function savePost(){
  var ti=(E('bp-ti')?.value||'').trim(),body=(E('bp-body')?.value||'').trim();
  if(!ti||!body){toast('Title and content are required','e');return}
  var slug=(E('bp-slug')?.value||'').trim()||ti.toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'');
  var cat=E('bp-cat')?.value||'Psychology';
  var ci=E('cv-img');var cov=ci&&ci.dataset.data?ci.dataset.data:'';
  var rt=E('bp-rt')?.value||autoRT(body);
  var post={
    title:ti, slug, category:cat, read_time:rt,
    author:E('bp-auth')?.value||'Journal Your Trades Team',
    excerpt:E('bp-exc')?.value||'', content:body,
    tags:(E('bp-tags')?.value||'').split(',').map(t=>t.trim()).filter(Boolean),
    seo_title:E('bp-st')?.value||'',
    meta_desc:(E('bp-meta')?.value||'').slice(0,160),
    cover_image:cov, published:true,
    updated_at:new Date().toISOString()
  };
  if(_editPid) post.id=_editPid;

  // Try API first
  var r = _editPid
    ? await apiPut('/api/blog', post)
    : await apiPost('/api/blog', post);

  if(r && (r.id || r.success || r.title)){
    logA('📝',(_editPid?'Updated':'Published')+': '+ti);
    toast(_editPid?'✅ Post updated in Supabase!':'🚀 Post published to Supabase!');
  } else {
    // Fallback to localStorage
    var localPost={...post,id:_editPid||('bp'+Date.now()),createdAt:new Date().toISOString(),
      readtime:rt,seoTitle:post.seo_title,meta:post.meta_desc,coverImage:cov,
      tags:(E('bp-tags')?.value||'')};
    await loadData();
    if(_editPid){var i=_allP.findIndex(p=>p.id===_editPid);if(i>=0)_allP[i]={..._allP[i],...localPost};}
    else _allP.unshift(localPost);
    sls('tf_blog_posts',_allP);
    logA('📝',(_editPid?'Updated':'Saved')+' locally: '+ti);
    toast('Saved locally (Supabase not connected)');
  }
  _editPid=null; go('blog');
}
function autoRT(c){var w=c.replace(/<[^>]*>/g,' ').split(/\s+/).filter(Boolean).length;return Math.max(1,Math.round(w/200))+' min read'}
function bTab(t,btn){
  ['write','seo','prev'].forEach(x=>{var e=E('bt-'+x);if(e)e.style.display=x===t?'block':'none'});
  document.querySelectorAll('#pg-blog-new .tab-btn').forEach(b=>b.classList.remove('on'));
  if(btn)btn.classList.add('on');
  if(t==='prev')rdBPrev();if(t==='seo')spUpd();
}
function bSlug(v){var e=E('bp-slug');if(e&&!e.dataset.manual)e.value=v.toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'');spUpd()}
function bWC(){var c=E('bp-body')?.value||'';var w=c.replace(/<[^>]*>/g,' ').split(/\s+/).filter(Boolean).length;var e=E('bp-wc');if(e)e.textContent=c.length.toLocaleString()+' chars · '+w+' words · ~'+Math.max(1,Math.round(w/200))+' min read'}
function spUpd(){if(E('sp-sl'))E('sp-sl').textContent=E('bp-slug')?.value||'slug';if(E('sp-ttl'))E('sp-ttl').textContent=(E('bp-st')?.value||E('bp-ti')?.value||'Title')+'| Journal Your Trades';if(E('sp-dsc'))E('sp-dsc').textContent=E('bp-meta')?.value||'Description…'}
function sCnt(){var t=E('bp-st')?.value||'',m=E('bp-meta')?.value||'';var tc=E('stc'),mc=E('smc');if(tc){tc.textContent='('+t.length+'/60)';tc.className='form-counter'+(t.length>60?' err':'');}if(mc){mc.textContent='('+m.length+'/160)';mc.className='form-counter'+(m.length>160?' err':'');}}
function rdBPrev(){var ti=E('bp-ti')?.value||'',c=E('bp-body')?.value||'',cat=E('bp-cat')?.value||'';var cc={'Psychology':'#a78bfa','Risk Management':'#22c55e','Strategy':'#60a5fa','Mistakes':'#f87171','Journaling':'#fbbf24','Market Analysis':'#22d3ee'};E('bp-prv').innerHTML=`<span style="font-size:10px;font-weight:700;padding:3px 10px;border-radius:20px;background:rgba(255,255,255,.06);color:${cc[cat]||'#60a5fa'};text-transform:uppercase;display:inline-block;margin-bottom:14px">${esc(cat)}</span><h2 style="font-family:var(--fh);font-size:24px;font-weight:800;color:#e8eaf0;margin-bottom:14px;line-height:1.2">${esc(ti||'Post Title')}</h2><div style="font-size:14px;line-height:1.85">${c||'<em style="color:var(--t3)">No content yet.</em>'}</div>`}
function ins(tag){var ta=E('bp-body');if(!ta)return;var T={h2:'<h2>Heading</h2>\n',h3:'<h3>Subheading</h3>\n',p:'<p>Your paragraph here.</p>\n',strong:'<strong>bold text</strong>',em:'<em>italic text</em>',ul:'<ul>\n  <li>Item one</li>\n  <li>Item two</li>\n</ul>\n',ol:'<ol>\n  <li>First item</li>\n  <li>Second item</li>\n</ol>\n',blockquote:'<blockquote style="border-left:3px solid #3b82f6;padding-left:16px;color:#9ca3af;font-style:italic;margin:16px 0">Quote here</blockquote>\n',code:'<code style="background:rgba(255,255,255,.06);padding:2px 6px;border-radius:4px;font-family:monospace">code</code>',hr:'<hr style="border:none;border-top:1px solid rgba(255,255,255,.08);margin:24px 0"/>'};var s=ta.selectionStart;ta.value=ta.value.substring(0,s)+(T[tag]||'<'+tag+'></'+tag+'>');ta.focus();bWC()}
function cvFile(input){if(!input.files||!input.files[0])return;var r=new FileReader();r.onload=ev=>{E('cv-img').src=ev.target.result;E('cv-img').dataset.data=ev.target.result;E('cv-pr').style.display='block';E('cv-ph').style.display='none'};r.readAsDataURL(input.files[0])}
function cvDrop(ev){ev.preventDefault();var f=ev.dataTransfer.files[0];if(!f||!f.type.startsWith('image/'))return;cvFile({files:[f]});E('cv-zone').style.borderColor='var(--b2)'}
function clrCover(){var img=E('cv-img');if(img){img.src='';img.dataset.data=''}E('cv-pr').style.display='none';E('cv-ph').style.display='flex';var fi=E('cv-file');if(fi)fi.value=''}

// ── Trades ───────────────────────────────────────────────────
function rdTrades(){loadData();renderT(_allT)}
function renderT(t){
  var tb=E('tr-tb');
  if(!t.length){tb.innerHTML='<tr><td colspan="9" style="text-align:center;color:var(--t3);padding:28px">No trades logged</td></tr>';return}
  tb.innerHTML=t.slice(0,300).map(t=>{var p=parseFloat(t.pnl||0);return`<tr>
    <td style="font-size:12px;color:var(--t2)">${t.date?new Date(t.date).toLocaleDateString():'—'}</td>
    <td style="font-family:var(--fm);font-weight:600">${esc(t.symbol||'—')}</td>
    <td><span class="badge ${(t.direction||'').toLowerCase()==='long'?'badge-green':'badge-red'}">${t.direction||'—'}</span></td>
    <td style="font-family:var(--fm);font-size:12px">${esc(t.entry||'—')}</td>
    <td style="font-family:var(--fm);font-size:12px">${esc(t.exit||'—')}</td>
    <td style="font-size:12px">${esc(t.qty||'—')}</td>
    <td style="font-family:var(--fm);font-weight:600;color:${p>=0?'var(--green)':'var(--red)'}">${p>=0?'+':''}$${p.toFixed(2)}</td>
    <td style="font-size:12px;color:var(--purple)">${esc(t.strategy||'—')}</td>
    <td style="font-size:11px;color:var(--t3);max-width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">${esc(t.notes||'—')}</td>
  </tr>`}).join('');
}
function filtT(q){
  q=q.toLowerCase();
  var base=_allT.filter(t=>(t.symbol||'').toLowerCase().includes(q)||(t.strategy||'').toLowerCase().includes(q)||(t.notes||'').toLowerCase().includes(q));
  if(_dF)base=base.filter(t=>(t.direction||'').toLowerCase()===_dF.toLowerCase());
  if(_oF==='win')base=base.filter(t=>parseFloat(t.pnl||0)>0);
  if(_oF==='loss')base=base.filter(t=>parseFloat(t.pnl||0)<0);
  renderT(base);
}
function expTrades(){var r=[['Date','Symbol','Direction','Entry','Exit','Qty','P&L','Strategy','Notes']];_allT.forEach(t=>r.push([t.date||'',t.symbol||'',t.direction||'',t.entry||'',t.exit||'',t.qty||'','$'+parseFloat(t.pnl||0).toFixed(2),t.strategy||'',t.notes||'']));dlCSV(r,'tradd-trades.csv');logA('📤','Exported trades CSV')}

// ── Export ───────────────────────────────────────────────────
function rdExport(){
  loadData();var sz=(JSON.stringify(localStorage).length/1024).toFixed(1);
  E('exp-sum').innerHTML=[
    {l:'Trades',v:_allT.length},{l:'Users',v:_allU.length},{l:'Blog Posts',v:_allP.length},
    {l:'Custom Pages',v:gls('tf_custom_pages',[]).length},
    {l:'Announcements',v:gls('tf_announcements',[]).length},
    {l:'Storage Used',v:sz+' KB'},{l:'Session',v:localStorage.getItem('tf_session')?'1 Active':'None'}
  ].map(r=>`<div style="display:flex;justify-content:space-between;padding:9px 0;border-bottom:1px solid var(--b1)">
    <span style="font-size:13px;color:var(--t2)">${r.l}</span>
    <span style="font-size:13px;font-weight:600;color:var(--t1)">${r.v}</span></div>`).join('');
}
function expBlog(){var b=new Blob([JSON.stringify(_allP,null,2)],{type:'application/json'});var a=document.createElement('a');a.href=URL.createObjectURL(b);a.download='tradd-blog.json';a.click();logA('📤','Blog JSON exported')}
function expAll(){var d={};for(var i=0;i<localStorage.length;i++){var k=localStorage.key(i);d[k]=localStorage.getItem(k)}var b=new Blob([JSON.stringify(d,null,2)],{type:'application/json'});var a=document.createElement('a');a.href=URL.createObjectURL(b);a.download='tradd-backup-'+Date.now()+'.json';a.click();logA('📤','Full backup exported')}
function expUsers(){var r=[['Name','Email','Plan','Trades','Win%','P&L','Joined']];_allU.forEach(u=>r.push([u.name||'',u.email||'',u.plan||'free',u.trades,u.winRate+'%','$'+(u.pnl||0).toFixed(2),u.createdAt?new Date(u.createdAt).toLocaleDateString():'']));dlCSV(r,'tradd-users.csv');logA('📤','Users CSV exported')}

// ── Feature Flags ────────────────────────────────────────────
async function rdFlags(){
  var f=gls('tf_feature_flags',{});
  E('fl-list').innerHTML=DEF_FLAGS.map((fl,i)=>`
    <div class="flag-row">
      <div><div class="flag-name">${fl.n}</div><div class="flag-desc">${fl.d}</div></div>
      <div style="display:flex;align-items:center;gap:10px">
        <span style="font-size:11px;color:${f[fl.k]!==false?'var(--green)':'var(--t4)'}">${f[fl.k]!==false?'Enabled':'Disabled'}</span>
        <div class="toggle ${f[fl.k]!==false?'on':''}" onclick="tFlag('${fl.k}')"></div>
      </div>
    </div>`).join('');
}
async function tFlag(k){var f=gls('tf_feature_flags',{});var newVal=f[k]===false?true:false;const r=await apiPut('/api/flags',{key:k,enabled:newVal});if(r&&r.success){logA('🚩','Flag '+k+' → '+(newVal?'ON':'OFF'));toast((newVal?'✅ Enabled':'❌ Disabled')+': '+k);}else{f[k]=newVal;sls('tf_feature_flags',f);toast('Flag updated (local)');}rdFlags();}

// ── Announcements ────────────────────────────────────────────
function openAnn(){E('an-msg').value='';E('an-lnk').value='';E('an-type').value='info';E('an-exp').value='';om('ann-mo')}
async function saveAnn(){
  var msg=(E('an-msg')?.value||'').trim();if(!msg){toast('Message is required','e');return}
  var payload={message:msg,type:E('an-type').value,link:E('an-lnk').value||null,
    expires_at:E('an-exp').value||null,active:true};
  var r=await apiPost('/api/announcements',payload);
  if(r&&r.announcement){cm('ann-mo');rdAnn();logA('📢','Announcement: '+msg);toast('📢 Published to Supabase!');}
  else{var a=gls('tf_announcements',[]);a.unshift({id:'ann'+Date.now(),msg,type:payload.type,
    link:payload.link||'',expires:payload.expires_at||'',active:true,createdAt:new Date().toISOString()});
    sls('tf_announcements',a);cm('ann-mo');rdAnn();toast('📢 Saved locally');}
}
async function rdAnn(){
  var d=await apiGet('/api/announcements?admin=1');
  var a=d&&d.announcements?d.announcements:gls('tf_announcements',[]);
  _allAnn=a;var el=E('ann-list');
  if(!a.length){el.innerHTML='<div class="empty-state"><span class="empty-ico">📢</span><div class="empty-title">No Announcements</div><div class="empty-sub">Create banners to show important info at the top of the site</div><button class="btn btn-primary" onclick="openAnn()">Create First Announcement</button></div>';return}
  var tc={info:'var(--blue)',success:'var(--green)',warning:'var(--amber)',error:'var(--red)'};
  el.innerHTML='<div style="display:flex;flex-direction:column;gap:8px">'+a.map(x=>`
    <div class="card" style="display:flex;align-items:center;gap:14px;padding:12px 18px;border-left:3px solid ${tc[x.type]||'var(--blue)'}">
      <div style="flex:1">
        <div style="font-size:14px;font-weight:600;color:var(--t1);margin-bottom:3px">${esc(x.message||x.msg)}</div>
        <div style="font-size:11px;color:var(--t3);display:flex;gap:8px">
          <span class="badge badge-gray">${x.type}</span>
          ${(x.expires_at||x.expires)?'<span>Expires '+(x.expires_at||x.expires)+'</span>':''}
          ${x.link?'<span>🔗 Link</span>':''}
          <span>${new Date(x.created_at||x.createdAt).toLocaleDateString()}</span>
        </div>
      </div>
      <div style="display:flex;align-items:center;gap:10px">
        <span style="font-size:11px;color:${x.active?'var(--green)':'var(--t3)'}">${x.active?'Live':'Paused'}</span>
        <div class="toggle ${x.active?'on':''}" onclick="togAnn('${x.id}')"></div>
        <button class="btn btn-danger btn-sm" onclick="delAnn('${x.id}')">🗑</button>
      </div>
    </div>`).join('')+'</div>';
}
async function togAnn(id){const cur=_allAnn?_allAnn.find(x=>x.id===id):null;const r=await apiPut('/api/announcements',{id,active:cur?!cur.active:true});if(r&&r.success)rdAnn();else{var a=gls('tf_announcements',[]).map(x=>x.id===id?{...x,active:!x.active}:x);sls('tf_announcements',a);rdAnn();}}
async function delAnn(id){const r=await apiDel('/api/announcements?id='+id);if(r&&r.success){rdAnn();toast('Announcement deleted');}else{sls('tf_announcements',gls('tf_announcements',[]).filter(x=>x.id!==id));rdAnn();toast('Deleted (local)');}}

// ── Settings ─────────────────────────────────────────────────
function saveSettings(){
  sls('tf_site_settings',{siteName:E('s-nm').value,tagline:E('s-tg').value,email:E('s-em').value,copyright:E('s-copy').value});
  logA('⚙️','Settings saved');toast('✅ Settings saved!');
}
function dangerT(){if(!confirm('DELETE ALL TRADES? This cannot be undone.'))return;localStorage.removeItem('tf_trades');logA('💀','Deleted all trades');toast('All trades deleted','e');loadData()}
function dangerB(){if(!confirm('DELETE ALL BLOG POSTS?'))return;localStorage.removeItem('tf_blog_posts');logA('💀','Deleted all posts');toast('All posts deleted','e');loadData()}
function dangerR(){if(!confirm('FACTORY RESET? All data permanently lost.'))return;if(!confirm('Last chance — are you 100% sure?'))return;localStorage.clear();logA('💀','Factory reset');toast('Factory reset complete','e');loadData()}

// ── Global search ────────────────────────────────────────────
function globalSearch(q){
  if(!q||q.length<2)return;loadData();
  var res=0;
  _allT.forEach(t=>{if((t.symbol||'').toLowerCase().includes(q.toLowerCase()))res++});
  _allP.forEach(p=>{if((p.title||'').toLowerCase().includes(q.toLowerCase()))res++});
  _allU.forEach(u=>{if((u.email||'').toLowerCase().includes(q.toLowerCase()))res++});
  if(res)toast('Found ~'+res+' results for "'+q+'"');
}

// ── Init ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded',function(){
  // Restore sidebar state
  if(gls('tf_admin_sb_coll',false)){document.body.classList.add('sb-coll');E('sb-coll-ico').textContent='▶';var l=E('sb-coll-lbl');if(l)l.textContent='Expand'}
  loadData();go('dash');logA('👁','Admin panel opened');
  // Load settings
  var s=gls('tf_site_settings',null);
  if(s){if(E('s-nm')&&s.siteName)E('s-nm').value=s.siteName;if(E('s-tg')&&s.tagline)E('s-tg').value=s.tagline;if(E('s-em')&&s.email)E('s-em').value=s.email;if(E('s-copy')&&s.copyright)E('s-copy').value=s.copyright}
  // Close modals on backdrop click
  document.querySelectorAll('.modal-overlay').forEach(o=>o.addEventListener('click',e=>{if(e.target===o)o.classList.remove('open')}));
  // ESC to close modals
  document.addEventListener('keydown',e=>{if(e.key==='Escape')document.querySelectorAll('.modal-overlay.open').forEach(o=>o.classList.remove('open'))});
});
</script>
</body>
</html>