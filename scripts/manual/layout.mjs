/* Layout e blocos do manual. O HTML sai daqui, e as cores, os contrastes e os
   downloads saem dos arquivos do repositório: nada de hex escrito à mão. */
import { readFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

export const raiz = path.resolve(fileURLToPath(new URL('../..', import.meta.url)));
const NDCasca = createRequire(import.meta.url)(path.join(raiz, 'design-system/casca.js'));
export const SOMA = 'https://membro.neurodynamics.dev';
export const EMAIL = 'hello@neurodynamics.dev';
export const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

/* ---------- a navegação do manual ---------- */
export const SECOES = [
  { href: '/fundamentos', rotulo: 'Fundamentos' },
  { href: '/aplicacoes', rotulo: 'Aplicações' },
  { href: '/interface', rotulo: 'Interface' },
  { href: '/imprensa', rotulo: 'Imprensa' },
  { href: '/downloads', rotulo: 'Downloads' },
  { href: SOMA, rotulo: 'Área da equipe' },
];
const secaoDe = rota => '/' + (rota.split('/')[1] || '');

/* ---------- tokens ---------- */
const tokens = readFileSync(path.join(raiz, 'design-system/tokens.css'), 'utf8');
export const PAPEL = tokens.match(/--paper:\s*(#[0-9A-Fa-f]{6})/)[1].toUpperCase();
export const FUNDO_ESCURO = tokens.match(/--sulco-dark:\s*(#[0-9A-Fa-f]{6})/)[1].toUpperCase();
export const FAMILIAS = {};
for (const m of tokens.matchAll(/--((?:fn-)?[a-z]+)-(light|medium|primary|dark|accent):\s*(#[0-9A-Fa-f]{6})/g)) {
  (FAMILIAS[m[1]] ||= {})[m[2]] = m[3].toUpperCase();
}
export const rgb = hex => [1, 3, 5].map(i => parseInt(hex.slice(i, i + 2), 16));
const lum = hex => { const [r, g, b] = rgb(hex).map(v => { v /= 255; return v <= .03928 ? v / 12.92 : ((v + .055) / 1.055) ** 2.4; }); return .2126 * r + .7152 * g + .0722 * b; };
export const contraste = (a, b) => { const [x, y] = [lum(a), lum(b)].sort((p, q) => q - p); return (x + .05) / (y + .05); };

/* ---------- blocos ---------- */
export const sec = (id, titulo, html, lead) => `<section class="m-sec" id="${id}"><h2>${esc(titulo)}</h2>${lead ? `<p class="m-lead">${lead}</p>` : ''}${html}</section>`;
export const sub = (titulo, html) => `<h3 class="m-h3">${esc(titulo)}</h3>${html}`;
export const assimEvite = (assim, evite) => `<div class="m-ae"><div class="m-ae-a"><b><span aria-hidden="true">✓</span> Assim</b><p>${assim}</p></div><div class="m-ae-e"><b><span aria-hidden="true">×</span> Evite</b><p>${evite}</p></div></div>`;
export const pendente = html => `<aside class="m-pend"><b>Pendente</b><p>${html}</p></aside>`;
export const copiar = (texto, rotulo = 'Copiar') => `<button type="button" class="btn ghost mini m-copiar" data-copiar="${esc(texto)}">${esc(rotulo)}</button>`;
export const bloco = (codigo, rotulo = 'Copiar') => `<div class="m-code"><pre><code>${esc(codigo)}</code></pre>${copiar(codigo, rotulo)}</div>`;
export const baixar = (href, nome) => `<a class="btn ghost mini" href="${esc(href)}" download>${esc(nome || 'Baixar')}</a>`;
export const lista = itens => `<ul class="m-lista">${itens.map(i => `<li>${i}</li>`).join('')}</ul>`;
export const grade = (itens, cls = '') => `<div class="m-grade ${cls}">${itens.join('')}</div>`;
export const cartao = (titulo, texto, extra = '') => `<article class="card m-cartao"><h3>${esc(titulo)}</h3><p>${texto}</p>${extra}</article>`;
export const tabela = (cab, linhas, cls = '') => `<div class="wrap"><table class="tabela trabalho ${cls}"><thead><tr>${cab.map(c => `<th>${c}</th>`).join('')}</tr></thead><tbody>${linhas.map(l => `<tr>${l.map(c => `<td>${c}</td>`).join('')}</tr>`).join('')}</tbody></table></div>`;
export const figura = (src, legenda, larga) => `<figure class="m-fig ${larga ? 'larga' : ''}"><img src="${esc(src)}" alt="${esc(legenda)}" loading="lazy"><figcaption>${esc(legenda)}</figcaption></figure>`;

/* ---------- a página ---------- */
export function pagina({ rota, titulo, descricao, corpo, toc = [], proximo, eyebrow = 'Manual da marca', hero }) {
  const links = SECOES.map(l => ({ ...l, atual: !l.href.startsWith('http') && l.href === secaoDe(rota) }));
  const base = { site: 'brand', lang: 'pt', tag: 'Brand', inicio: '/', logo: '/design-system/marca/imagotipo-branco.webp', ano: new Date().getFullYear(), links };
  const nav = toc.length ? `<nav class="m-toc" aria-label="Nesta página"><p class="rot">Nesta página</p><ol>${toc.map(([id, t]) => `<li><a href="#${id}">${esc(t)}</a></li>`).join('')}</ol></nav>` : '';
  const prox = proximo ? `<a class="m-prox" href="${proximo[0]}"><span class="rot">Próximo</span><b>${esc(proximo[1])}</b><span aria-hidden="true">→</span></a>` : '';
  const h = hero || `<header class="m-hero m-hero-curto"><div class="m-wrap"><span class="eyebrow">${esc(eyebrow)}</span><h1>${esc(titulo)}</h1>${descricao ? `<p class="m-lead">${esc(descricao)}</p>` : ''}</div></header>`;
  const html = `<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${esc(titulo)} | Manual da marca NeuroDynamics</title><meta name="description" content="${esc(descricao || 'Manual da marca NeuroDynamics.')}">
<meta property="og:title" content="${esc(titulo)} | NeuroDynamics"><meta property="og:image" content="https://brand.neurodynamics.dev/assets/logo-imagotipo-white.png">
<link rel="icon" href="/favicon.png">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Archivo:wght@300;400;500;600;700&family=Instrument+Sans:ital,wght@0,400;0,500;0,600;1,400&family=IBM+Plex+Mono:wght@400;500&display=swap">
<link rel="stylesheet" href="/design-system/tokens.css"><link rel="stylesheet" href="/design-system/neuro.css"><link rel="stylesheet" href="/design-system/casca.css"><link rel="stylesheet" href="/site/manual.css">
<script defer src="/design-system/casca.js"></script><script defer src="/site/manual.js"></script></head>
<body><div class="nd-fundo" aria-hidden="true"><div class="blob b1"></div><div class="blob b2"></div></div>
<!-- cabecalho -->\n${NDCasca.cabecalho(base)}\n<!-- /cabecalho -->
<main>${h}<div class="m-wrap m-cap${toc.length ? ' com-toc' : ''}">${nav}<div class="m-corpo">${corpo}${prox}</div></div></main>
<!-- rodape -->\n${NDCasca.rodape(base)}\n<!-- /rodape --></body></html>`;
  return { rota, html };
}
