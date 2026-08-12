#!/usr/bin/env node
/* ============================================================
   build.mjs · NeuroDynamics Design System

   Os previews são HTML autocontidos: cada card do Claude Design
   renderiza isolado, então nada de <link> para CSS local nem de
   <img src> apontando para arquivo do repositório. Isso obriga a
   repetir tokens e artes dentro de cada arquivo — este script
   mantém essas cópias iguais às fontes.

   O que faz:
     1. lê o :root{...} de tokens.css, compacta e reescreve o
        trecho entre @tokens:start / @tokens:end de cada preview;
     2. lê os arquivos de marca/ e embute como data URI no trecho
        entre @arte:start / @arte:end (hoje só 05-marca.html);
     3. regrava _ds_manifest.json a partir dos marcadores @dsCard.

   Uso:  node build.mjs          (grava)
         node build.mjs --check  (só confere; sai 1 se divergir)
   ============================================================ */
import { readFileSync, writeFileSync, readdirSync, existsSync, statSync } from 'node:fs';
import { join, dirname, extname } from 'node:path';
import { fileURLToPath } from 'node:url';

const raiz = dirname(fileURLToPath(import.meta.url));
const soConfere = process.argv.includes('--check');
let divergentes = 0;

const nota = (m) => console.log(`  ${m}`);
const erro = (m) => { console.error(`✗ ${m}`); process.exit(1); };

/* ============================================================
   1. tokens
   ============================================================ */
const fonteTokens = readFileSync(join(raiz, 'tokens.css'), 'utf8');
const blocoRaiz = fonteTokens.match(/:root\s*\{[\s\S]*?\n\}/);
if (!blocoRaiz) erro('tokens.css: bloco :root{...} não encontrado.');

const tokensCompactos = blocoRaiz[0]
  .replace(/\/\*[\s\S]*?\*\//g, '')   // comentários
  .replace(/\s*\n\s*/g, '')           // quebras e indentação
  .replace(/;\s*\}/, '}')             // ponto e vírgula final
  .replace(/;\s*(?=--)/g, ';\n  ')    // uma declaração por linha
  .replace(/:root\{/, ':root{\n  ')
  .replace(/\}$/, '\n}');

/* ============================================================
   2. artes da marca
   ------------------------------------------------------------
   Coloque os arquivos oficiais em design-system/marca/ com estes
   nomes. Formatos aceitos: .svg (preferido), .png ou .webp.

     imagotipo        marca horizontal completa, versão preta
     simbolo          traço sozinho, gradiente verde, sem fundo
     icone-escuro     traço claro sobre quadrado escuro
     icone-verde      traço branco sobre quadrado verde

   O SVG é preferido: escala sem perda e pesa muito menos que o
   PNG dentro do data URI.
   ============================================================ */
const ARTES = ['imagotipo', 'simbolo', 'icone-escuro', 'icone-verde'];
const MIMES = { '.svg': 'image/svg+xml', '.png': 'image/png', '.webp': 'image/webp' };
const dirMarca = join(raiz, 'marca');

function achaArte(nome) {
  for (const ext of Object.keys(MIMES)) {
    const p = join(dirMarca, nome + ext);
    if (existsSync(p)) return p;
  }
  return null;
}

const artes = {};
let artesFaltando = [];
for (const nome of ARTES) {
  const caminho = achaArte(nome);
  if (!caminho) { artesFaltando.push(nome); artes[nome] = 'none'; continue; }
  const bytes = readFileSync(caminho);
  const mime = MIMES[extname(caminho)];
  artes[nome] = `url("data:${mime};base64,${bytes.toString('base64')}")`;
  nota(`arte ${nome.padEnd(13)} ${(statSync(caminho).size / 1024).toFixed(0)}KB  ${caminho.replace(raiz + '/', '')}`);
}
if (artesFaltando.length) {
  nota(`arte pendente: ${artesFaltando.join(', ')} — veja design-system/marca/LEIAME.md`);
}

const blocoArte =
  ':root{\n' +
  ARTES.map(n => `  --${n}:${artes[n]};`).join('\n') +
  '\n}';

/* ============================================================
   3. propaga e coleta os cards
   ============================================================ */
const dirPreviews = join(raiz, 'previews');
const arquivos = readdirSync(dirPreviews).filter(f => f.endsWith('.html')).sort();
if (!arquivos.length) erro('previews/: nenhum .html encontrado.');

const mTokens = /(\/\* @tokens:start[^*]*\*\/)[\s\S]*?(\/\* @tokens:end \*\/)/;
const mArte = /(\/\* @arte:start[^*]*\*\/)[\s\S]*?(\/\* @arte:end \*\/)/;
const cards = [];

for (const nome of arquivos) {
  const caminho = join(dirPreviews, nome);
  const original = readFileSync(caminho, 'utf8');
  let html = original;

  if (!mTokens.test(html)) erro(`${nome}: marcadores @tokens:start/@tokens:end ausentes.`);
  html = html.replace(mTokens, `$1\n${tokensCompactos}\n$2`);

  /* o bloco de arte é opcional — só 05-marca.html usa hoje */
  if (mArte.test(html)) {
    html = html.replace(mArte, `$1\n${blocoArte}\n$2`);
    /* a classe some quando todas as artes estão presentes */
    html = artesFaltando.length
      ? html.replace(/<body(?: class="([^"]*)")?>/, (_, c) => {
          const cls = new Set((c || '').split(/\s+/).filter(Boolean));
          cls.add('arte-pendente');
          return `<body class="${[...cls].join(' ')}">`;
        })
      : html.replace(/<body class="([^"]*)">/, (m0, c) => {
          const cls = c.split(/\s+/).filter(Boolean).filter(x => x !== 'arte-pendente');
          return cls.length ? `<body class="${cls.join(' ')}">` : '<body>';
        });
  }

  if (html !== original) {
    divergentes++;
    if (soConfere) console.error(`✗ ${nome}: desatualizado.`);
    else { writeFileSync(caminho, html); nota(`${nome} atualizado`); }
  }

  const marca = original.match(/<!--\s*@dsCard\s+([\s\S]*?)-->/);
  if (!marca) erro(`${nome}: marcador @dsCard ausente na primeira linha.`);
  const attrs = {};
  for (const [, k, v] of marca[1].matchAll(/(\w+)="([^"]*)"/g)) attrs[k] = v;
  if (!attrs.group) erro(`${nome}: @dsCard sem atributo group.`);

  cards.push({
    name: attrs.name || nome.replace(/^\d+-|\.html$/g, ''),
    path: `previews/${nome}`,
    subtitle: attrs.subtitle || '',
    group: attrs.group,
    viewport: { width: Number(attrs.width) || 1180, height: Number(attrs.height) || 900 },
  });
}

/* ============================================================
   4. manifesto
   ------------------------------------------------------------
   O app do Claude Design recompila este arquivo a partir dos
   marcadores @dsCard no self-check; mantemos uma cópia versionada
   para servir de índice local e de diff legível no PR.
   ============================================================ */
const manifesto = JSON.stringify({ cards }, null, 2) + '\n';
const caminhoManifesto = join(raiz, '_ds_manifest.json');
const atual = existsSync(caminhoManifesto) ? readFileSync(caminhoManifesto, 'utf8') : '';
if (atual !== manifesto) {
  divergentes++;
  if (soConfere) console.error('✗ _ds_manifest.json desatualizado.');
  else { writeFileSync(caminhoManifesto, manifesto); nota('_ds_manifest.json atualizado'); }
}

/* ============================================================
   resultado
   ============================================================ */
if (soConfere && divergentes) {
  console.error(`\n${divergentes} arquivo(s) fora de sincronia. Rode: node build.mjs`);
  process.exit(1);
}
const grupos = [...new Set(cards.map(c => c.group))];
console.log(
  `\n✓ ${cards.length} previews em ${grupos.length} grupos (${grupos.join(', ')})` +
  (divergentes ? ` · ${divergentes} atualizado(s)` : ' · tudo em sincronia') +
  (artesFaltando.length ? `\n⚠ ${artesFaltando.length} arte(s) da marca pendente(s)` : '')
);
