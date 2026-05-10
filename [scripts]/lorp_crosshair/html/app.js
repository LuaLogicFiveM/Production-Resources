const $ = (s) => document.querySelector(s);

const panel = $('#panel');
const crosshair = $('#crosshair');
// const previewBox = $('#preview'); // unused
const previewRoot = $('#previewCross');
const el = {
  mode: $('#mode'),
  type: $('#type'),
  style: $('#style'),
  color: $('#color'),
  size: $('#size'),
  thickness: $('#thickness'),
  gap: $('#gap'),
  outline: $('#outline'),
  dotInCenter: $('#dotInCenter'),
  pngGrid: $('#pngGrid'),
  pngScale: $('#pngScale'),
  pngOpacity: $('#pngOpacity'),
  save: $('#save'),
  close: $('#close'),
};

// (brand badge is now styled text; no image init needed)

let current = {
  mode: 'armed',
  settings: {
    type: 'vector',
    style: 'classic',
    color: { r: 0, g: 255, b: 140, a: 255 },
    size: 8,
    thickness: 2,
    gap: 6,
    outline: true,
    dotInCenter: false,
  pngPreset: '1',
    pngScale: 100,
    pngOpacity: 100,
  }
};
let overrideColor = null; // used for enemy highlight

function rgba(c){ return `rgba(${c.r}, ${c.g}, ${c.b}, ${Math.max(0, Math.min(1, (c.a ?? 255)/255))})`; }
function hexToRgb(hex){
  const m = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return m ? { r: parseInt(m[1],16), g: parseInt(m[2],16), b: parseInt(m[3],16), a: 255 } : {r:255,g:255,b:255,a:255};
}
function rgbToHex({r,g,b}){
  const h = (n)=> n.toString(16).padStart(2,'0');
  return `#${h(r)}${h(g)}${h(b)}`;
}

function applyToOverlay(){
  const s = current.settings;
  const pngImg = $('#pngCross');
  const setDisplay = (elem, show) => elem.style.display = show ? 'block' : 'none';

  if (s.type === 'png') {
    // Hide vector, show png
    crosshair.querySelectorAll('.line, .dot').forEach(d => d.style.display = 'none');
    // Also hide extra vector elements
    const ringEl = document.getElementById('ring');
    const d1El = document.getElementById('diag1');
    const d2El = document.getElementById('diag2');
    if (ringEl) ringEl.style.display = 'none';
    if (d1El) d1El.style.display = 'none';
    if (d2El) d2El.style.display = 'none';
    setDisplay(pngImg, true);
    pngImg.classList.remove('hidden');
    pngImg.src = `cross/${s.pngPreset}.png`;
    const scale = Math.max(20, Math.min(200, Number(s.pngScale))) / 100;
    pngImg.style.width = `${32 * scale}px`;
    pngImg.style.height = `${32 * scale}px`;
    pngImg.style.opacity = `${Math.max(0.1, Math.min(1, Number(s.pngOpacity)/100))}`;
    // tinting via CSS filter approximation to match color/overrideColor (compute only when needed)
    const c = overrideColor || s.color;
    const key = `${c.r},${c.g},${c.b}`;
    if (pngImg.dataset.tintKey !== key) {
      const r = c.r/255, g = c.g/255, b = c.b/255;
      const avg = (r+g+b)/3;
      const saturate = 2;
      const brightness = 0.6 + avg * 0.8;
      pngImg.style.filter = `saturate(${saturate}) brightness(${brightness})`;
      pngImg.dataset.tintKey = key;
    }
    return;
  }

  // Vector mode
  setDisplay(pngImg, false);
  pngImg.classList.add('hidden');

  const color = rgba(overrideColor || s.color);
  const outlineShadow = s.outline ? '0 0 0 1px rgba(0,0,0,0.7)' : 'none';

  crosshair.querySelectorAll('.line, .dot').forEach(d => {
    d.style.background = color;
    d.style.boxShadow = outlineShadow;
  });

  const size = Number(s.size);
  const thick = Number(s.thickness);
  const gap = Number(s.gap);

  const up = crosshair.querySelector('.line.up');
  const down = crosshair.querySelector('.line.down');
  const left = crosshair.querySelector('.line.left');
  const right = crosshair.querySelector('.line.right');
  const dot = crosshair.querySelector('.dot');
  const ring = document.getElementById('ring');
  const d1 = document.getElementById('diag1');
  const d2 = document.getElementById('diag2');

  up.style.width = `${thick}px`;
  down.style.width = `${thick}px`;
  left.style.height = `${thick}px`;
  right.style.height = `${thick}px`;

  up.style.height = `${size}px`;
  down.style.height = `${size}px`;
  left.style.width = `${size}px`;
  right.style.width = `${size}px`;

  up.style.bottom = `calc(100% + ${gap}px)`;
  down.style.top = `calc(100% + ${gap}px)`;
  left.style.right = `calc(100% + ${gap}px)`;
  right.style.left = `calc(100% + ${gap}px)`;

  ring.style.display = 'none'; d1.style.display = 'none'; d2.style.display = 'none';
  if (s.style === 'dot') {
    setDisplay(up, false); setDisplay(down, false); setDisplay(left, false); setDisplay(right, false);
    setDisplay(dot, true);
    dot.style.width = `${thick + 2}px`;
    dot.style.height = `${thick + 2}px`;
  } else if (s.style === 't') {
    setDisplay(up, false); setDisplay(down, true); setDisplay(left, true); setDisplay(right, true);
    setDisplay(dot, !!s.dotInCenter);
  } else if (s.style === 'circle') {
    setDisplay(up, false); setDisplay(down, false); setDisplay(left, false); setDisplay(right, false);
    setDisplay(dot, !!s.dotInCenter);
    ring.style.display = 'block';
    ring.style.borderColor = color;
    ring.style.boxShadow = outlineShadow;
    const dia = gap + size; // ring diameter roughly gap+size
    ring.style.width = `${dia * 2}px`;
    ring.style.height = `${dia * 2}px`;
    ring.style.borderWidth = `${Math.max(1, Math.min(6, thick))}px`;
  } else if (s.style === 'x') {
    setDisplay(up, false); setDisplay(down, false); setDisplay(left, false); setDisplay(right, false);
    setDisplay(dot, !!s.dotInCenter);
    d1.style.display = 'block'; d2.style.display = 'block';
    d1.style.background = color; d2.style.background = color;
    d1.style.boxShadow = outlineShadow; d2.style.boxShadow = outlineShadow;
  const len = gap + size; // half length from center to each tip
    const total = len * 2;
    const thickPx = `${thick}px`;
    d1.style.width = `${total}px`; d1.style.height = thickPx;
    d2.style.width = `${total}px`; d2.style.height = thickPx;
  // With centered transform-origin, rotate 45/-45; translate(-50%, -50%) keeps it centered
    d1.style.transform = 'translate(-50%, -50%) rotate(45deg)';
    d2.style.transform = 'translate(-50%, -50%) rotate(-45deg)';
  } else { // classic
    setDisplay(up, true); setDisplay(down, true); setDisplay(left, true); setDisplay(right, true);
    setDisplay(dot, !!s.dotInCenter);
  }
}

function applyToPreview(){
  const s = current.settings;
  const root = previewRoot;
  const pngImg = $('#previewPngCross');
  const setDisplay = (elem, show) => elem.style.display = show ? 'block' : 'none';

  if (s.type === 'png') {
    root.querySelectorAll('.line, .dot').forEach(d => d.style.display = 'none');
    const ringEl = document.getElementById('previewRing');
    const d1El = document.getElementById('previewDiag1');
    const d2El = document.getElementById('previewDiag2');
    if (ringEl) ringEl.style.display = 'none';
    if (d1El) d1El.style.display = 'none';
    if (d2El) d2El.style.display = 'none';
    setDisplay(pngImg, true);
    pngImg.src = `cross/${s.pngPreset}.png`;
    const scale = Math.max(20, Math.min(200, Number(s.pngScale))) / 100;
    pngImg.style.width = `${32 * scale}px`;
    pngImg.style.height = `${32 * scale}px`;
    pngImg.style.opacity = `${Math.max(0.1, Math.min(1, Number(s.pngOpacity)/100))}`;
    pngImg.style.left = '0';
    pngImg.style.top = '0';
    pngImg.style.transform = 'translate(-50%, -50%)';
    return;
  }

  // Vector mode
  setDisplay(pngImg, false);
  const color = rgba(overrideColor || s.color);
  const outlineShadow = s.outline ? '0 0 0 1px rgba(0,0,0,0.7)' : 'none';

  root.querySelectorAll('.line, .dot').forEach(d => {
    d.style.background = color;
    d.style.boxShadow = outlineShadow;
  });

  const size = Number(s.size);
  const thick = Number(s.thickness);
  const gap = Number(s.gap);

  const up = root.querySelector('.line.up');
  const down = root.querySelector('.line.down');
  const left = root.querySelector('.line.left');
  const right = root.querySelector('.line.right');
  const dot = root.querySelector('.dot');
  const ring = document.getElementById('previewRing');
  const d1 = document.getElementById('previewDiag1');
  const d2 = document.getElementById('previewDiag2');

  up.style.width = `${thick}px`;
  down.style.width = `${thick}px`;
  left.style.height = `${thick}px`;
  right.style.height = `${thick}px`;

  up.style.height = `${size}px`;
  down.style.height = `${size}px`;
  left.style.width = `${size}px`;
  right.style.width = `${size}px`;

  up.style.bottom = `calc(100% + ${gap}px)`;
  down.style.top = `calc(100% + ${gap}px)`;
  left.style.right = `calc(100% + ${gap}px)`;
  right.style.left = `calc(100% + ${gap}px)`;

  ring.style.display = 'none'; d1.style.display = 'none'; d2.style.display = 'none';
  if (s.style === 'dot') {
    up.style.display = 'none'; down.style.display = 'none'; left.style.display = 'none'; right.style.display = 'none';
    dot.style.display = 'block';
    dot.style.width = `${thick + 2}px`;
    dot.style.height = `${thick + 2}px`;
  } else if (s.style === 't') {
    up.style.display = 'none'; down.style.display = 'block'; left.style.display = 'block'; right.style.display = 'block';
    dot.style.display = current.settings.dotInCenter ? 'block' : 'none';
  } else if (s.style === 'circle') {
    up.style.display = 'none'; down.style.display = 'none'; left.style.display = 'none'; right.style.display = 'none';
    dot.style.display = current.settings.dotInCenter ? 'block' : 'none';
    ring.style.display = 'block';
    ring.style.borderColor = color;
    ring.style.boxShadow = outlineShadow;
    const dia = gap + size;
    ring.style.width = `${dia * 2}px`;
    ring.style.height = `${dia * 2}px`;
    ring.style.borderWidth = `${Math.max(1, Math.min(6, thick))}px`;
  } else if (s.style === 'x') {
    up.style.display = 'none'; down.style.display = 'none'; left.style.display = 'none'; right.style.display = 'none';
    dot.style.display = current.settings.dotInCenter ? 'block' : 'none';
    d1.style.display = 'block'; d2.style.display = 'block';
    d1.style.background = color; d2.style.background = color;
    d1.style.boxShadow = outlineShadow; d2.style.boxShadow = outlineShadow;
    const len = gap + size; const total = len * 2; const thickPx = `${thick}px`;
    d1.style.width = `${total}px`; d1.style.height = thickPx;
    d2.style.width = `${total}px`; d2.style.height = thickPx;
    d1.style.transform = 'translate(-50%, -50%) rotate(45deg)';
    d2.style.transform = 'translate(-50%, -50%) rotate(-45deg)';
  } else { // classic
    up.style.display = 'block'; down.style.display = 'block'; left.style.display = 'block'; right.style.display = 'block';
    dot.style.display = current.settings.dotInCenter ? 'block' : 'none';
  }
}

function openPanel(payload){
  panel.classList.remove('hidden');
  // allow a frame so CSS transition runs
  requestAnimationFrame(() => panel.classList.add('open'));
  document.body.classList.remove('type-png','type-vector');
  panel.focus();
  // load payload
  if (payload?.settings) current.settings = payload.settings;
  if (payload?.mode) current.mode = payload.mode;

  el.mode.value = current.mode;
  el.type.value = current.settings.type ?? 'vector';
  el.style.value = current.settings.style;
  el.color.value = rgbToHex(current.settings.color);
  el.size.value = current.settings.size;
  el.thickness.value = current.settings.thickness;
  el.gap.value = current.settings.gap;
  el.outline.checked = !!current.settings.outline;
  el.dotInCenter.checked = !!current.settings.dotInCenter;
  el.pngScale.value = current.settings.pngScale ?? 100;
  el.pngOpacity.value = current.settings.pngOpacity ?? 100;
  buildPngGrid(current.settings.pngPreset || '1');
  toggleTypeSections();
  applyToOverlay();
  applyToPreview();
}

function closePanel(){
  panel.classList.remove('open');
  // wait for animation to finish before hiding
  setTimeout(() => { panel.classList.add('hidden'); }, 200);
}

function post(action, data){
  fetch(`https://${GetParentResourceName()}/${action}`, {
    method: 'POST',
    headers: {'Content-Type':'application/json'},
    body: JSON.stringify(data || {})
  });
}

window.addEventListener('message', (e) => {
  const { action, data } = e.data || {};
  if (action === 'open') return openPanel(data);
  if (action === 'show') {
    // Unhide overlay; panel sits above via z-index, so no flicker even if open
    crosshair.classList.remove('hidden');
    if (data?.settings) { current.settings = data.settings; applyToOverlay(); applyToPreview(); }
  }
  if (action === 'settings') {
    if (data?.settings) { current.settings = data.settings; applyToOverlay(); applyToPreview(); }
  }
  if (action === 'hide') {
    crosshair.classList.add('hidden');
  }
  if (action === 'highlight') {
    // color false clears override
    overrideColor = (data?.color && typeof data.color === 'object') ? data.color : null;
    applyToOverlay();
    applyToPreview();
  }
});

// inputs
function onChange(){
  current.mode = el.mode.value;
  current.settings.type = el.type.value;
  current.settings.style = el.style.value;
  current.settings.color = hexToRgb(el.color.value);
  current.settings.size = Number(el.size.value);
  current.settings.thickness = Number(el.thickness.value);
  current.settings.gap = Number(el.gap.value);
  current.settings.outline = !!el.outline.checked;
  current.settings.dotInCenter = !!el.dotInCenter.checked;
  current.settings.pngScale = Number(el.pngScale.value);
  current.settings.pngOpacity = Number(el.pngOpacity.value);
  applyToOverlay();
  applyToPreview();
  post('update', current);
}

['mode','type','style','color','size','thickness','gap','outline','dotInCenter','pngScale','pngOpacity'].forEach(id => {
  el[id].addEventListener(id==='outline'||id==='dotInCenter' ? 'change' : 'input', onChange);
});

el.save.addEventListener('click', () => { post('save', current); closePanel(); });
el.close.addEventListener('click', () => { post('close', {}); closePanel(); });

// Escape to close
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') { post('close', {}); closePanel(); }
});

// Initial state
crosshair.classList.add('hidden');
panel.classList.add('hidden');

// PNG Presets
const PNG_PRESETS = [
  { id: '1', label: '1' },
  { id: '2', label: '2' },
  { id: '3', label: '3' },
  { id: '4', label: '4' },
  { id: '5', label: '5' },
  { id: '6', label: '6' },
  { id: '7', label: '7' },
];

function buildPngGrid(selected){
  el.pngGrid.innerHTML = '';
  PNG_PRESETS.forEach(p => {
    const item = document.createElement('div');
    item.className = 'item' + (p.id === selected ? ' selected' : '');
    item.title = p.label;
    const img = document.createElement('img');
    img.src = `cross/${p.id}.png`;
    img.alt = p.label;
    item.appendChild(img);
    item.addEventListener('click', () => {
      current.settings.pngPreset = p.id;
      buildPngGrid(p.id);
      applyToOverlay();
      applyToPreview();
      post('update', current);
    });
    el.pngGrid.appendChild(item);
  });
}

function toggleTypeSections(){
  const t = el.type.value;
  document.body.classList.toggle('type-png', t === 'png');
  document.body.classList.toggle('type-vector', t === 'vector');
}

el.type.addEventListener('change', () => { toggleTypeSections(); onChange(); });
