#!/usr/bin/env node
/* ============================================================
   validate.mjs · NeuroDynamics Design System

   Confere se a ds-bundle/ cumpre o contrato do Claude Design
   antes de subir. Roda sem instalar nada; se playwright-core
   estiver disponível, acrescenta a prova de render.

   Uso:  node validate.mjs
   ============================================================ */
import { readFileSync, readdirSync, existsSync, writeFileSync, rmSync } from 'node:fs';
import { join, dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const B = join(dirname(fileURLToPath(import.meta.url)), '..', 'ds-bundle');
let falhas = 0;
const erro = (m) => { console.log('✗ ' + m); falhas++; };
const ok = (m) => console.log('✓ ' + m);

if (!existsSync(B)) erro('ds-bundle/ não existe. Rode: node build.mjs && node bundle.mjs');
if (falhas) process.exit(1);

/* ------------------------------------------------------------
   1. o fecho de @import do styles.css
   Os designs que o agente renderiza recebem SÓ este fecho —
   CSS fora dele não existe para eles.
   ------------------------------------------------------------ */
const styles = readFileSync(join(B, 'styles.css'), 'utf8');
const imports = [...styles.matchAll(/@import\s+"([^"]+)"/g)].map(m => m[1]);
const semArquivo = imports.filter(i => !existsSync(resolve(B, i)));
if (!imports.length) erro('styles.css não importa nada — os designs sairiam sem estilo');
else if (semArquivo.length) erro(`styles.css importa arquivo inexistente: ${semArquivo.join(', ')}`);
else ok(`styles.css: ${imports.length} @imports, todos resolvem`);

/* o CSS de componente precisa ser alcançável a partir do styles.css */
const bundleCss = readFileSync(join(B, '_ds_bundle.css'), 'utf8');
if (bundleCss.trim().length > 200 && !imports.some(i => i.includes('_ds_bundle.css')))
  erro('_ds_bundle.css tem CSS real mas styles.css não o importa');

/* ------------------------------------------------------------
   2. cabeçalho do bundle JS
   ------------------------------------------------------------ */
const js = readFileSync(join(B, '_ds_bundle.js'), 'utf8');
if (!/^\/\* @ds-bundle: \{/.test(js)) erro('_ds_bundle.js: primeira linha sem o cabeçalho @ds-bundle');
else ok('_ds_bundle.js: cabeçalho @ds-bundle na primeira linha');

/* ------------------------------------------------------------
   3. cards
   ------------------------------------------------------------ */
const walk = (d, p = '') => readdirSync(d, { withFileTypes: true })
  .flatMap(e => e.isDirectory() ? walk(join(d, e.name), p + e.name + '/') : [p + e.name]);

const cards = walk(join(B, 'components')).filter(f => f.endsWith('.html'));
let cardsOk = 0;
for (const rel of cards) {
  const abs = join(B, 'components', rel);
  const html = readFileSync(abs, 'utf8');
  if (!/^<!--\s*@dsCard\s+[^>]*group="[^"]+"/.test(html)) {
    erro(`${rel}: primeira linha não é um @dsCard com group`); continue;
  }
  const link = html.match(/<link rel="stylesheet" href="([^"]+)"/);
  if (!link) { erro(`${rel}: sem <link> para styles.css`); continue; }
  if (!existsSync(resolve(dirname(abs), link[1]))) {
    erro(`${rel}: o link ${link[1]} não resolve a partir do arquivo`); continue;
  }
  const prompt = abs.replace(/\.html$/, '.prompt.md');
  if (!existsSync(prompt)) { erro(`${rel}: .prompt.md ausente`); continue; }
  if (!readFileSync(prompt, 'utf8').split('\n')[0].trim()) {
    erro(`${rel}: .prompt.md com primeira linha vazia (é o resumo que o agente lê)`); continue;
  }
  cardsOk++;
}
if (cardsOk === cards.length && cards.length) ok(`${cards.length} cards: @dsCard, link e resumo do prompt`);

/* ------------------------------------------------------------
   4. prova de render (opcional — precisa de playwright-core)
   Uma página que SÓ linka styles.css, como um design do agente.
   ------------------------------------------------------------ */
let chromium;
try { ({ chromium } = await import('playwright-core')); } catch { /* opcional */ }

if (!chromium) {
  console.log('· prova de render pulada (sem playwright-core — `npm i playwright-core` para rodar)');
} else {
  const provaPath = join(B, '.prova.html');
  writeFileSync(provaPath, `<!DOCTYPE html><html><head><meta charset="utf-8">
<link rel="stylesheet" href="./styles.css"></head><body>
<div class="nd-bg"><div class="blob b1"></div></div>
<main class="container">
  <span class="eyebrow" id="eb">01 / Prova</span>
  <h1 class="display">Título <em id="em">Synapse</em></h1>
  <div class="card" id="card"><p>Cartão</p></div>
  <button class="btn solid" id="btn">Ação</button>
  <span class="pill st-vital" id="pill"><span class="dt"></span>Ativo</span>
  <section class="band" id="band"><h2>Banda</h2></section>
</main></body></html>`);

  const exe = process.env.CHROMIUM_PATH || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome';
  const browser = await chromium.launch({ executablePath: exe }).catch(() => chromium.launch());
  const page = await browser.newPage();
  await page.goto('file://' + provaPath, { waitUntil: 'load' });
  const r = await page.evaluate(() => {
    const cs = getComputedStyle(document.documentElement);
    const g = (id, p) => getComputedStyle(document.getElementById(id))[p];
    return {
      synapse: cs.getPropertyValue('--synapse').trim(),
      raio: cs.getPropertyValue('--r').trim(),
      fundo: getComputedStyle(document.body).backgroundColor,
      botao: g('btn', 'backgroundColor'),
      botaoRaio: g('btn', 'borderTopLeftRadius'),
      cartao: g('card', 'borderTopWidth'),
      acento: g('em', 'color'),
      status: g('pill', 'color'),
      banda: g('band', 'backgroundImage'),
    };
  });
  await browser.close();
  rmSync(provaPath, { force: true });

  const esperado = {
    synapse: '#CEDC00', raio: '18px', fundo: 'rgb(5, 8, 7)',
    botao: 'rgb(206, 220, 0)', botaoRaio: '11px', cartao: '1px',
    acento: 'rgb(206, 220, 0)', status: 'rgb(74, 222, 151)',
  };
  const ruins = Object.entries(esperado).filter(([k, v]) => r[k] !== v);
  if (!r.banda.includes('gradient')) ruins.push(['banda', 'sem gradiente']);
  if (ruins.length) for (const [k, v] of ruins) erro(`prova: ${k} = ${r[k]} (esperado ${v})`);
  else ok('prova: só com styles.css, um design recebe tokens, botão, cartão, status, banda e acento');
}

console.log(falhas ? `\n✗ ${falhas} falha(s)` : '\n✓ ds-bundle/ válido');
process.exit(falhas ? 1 : 0);
