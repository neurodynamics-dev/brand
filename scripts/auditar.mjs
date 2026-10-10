#!/usr/bin/env node
/* ============================================================
   auditar.mjs · o checklist da seção 13 de interface-rules.md,
   como regras de texto

   Não substitui o olho: pega o que é mecânico (cor literal, raio
   de pílula, Plex Mono em rótulo, ponto médio, seleção em Synapse,
   sombra de elevação, emoji, fonte escrita à mão).

   Uso:
     node scripts/auditar.mjs <arquivo ou pasta>...   relatório
     node scripts/auditar.mjs --resumo <pasta>        só a contagem
     node scripts/auditar.mjs --falhar <arquivos>     sai 1 se houver
                                                      violação (para
                                                      rodar nos arquivos
                                                      de um diff)
   Exceções: tokens.css (é onde as cores moram), ds/ (cópia), peças e
   documentos (templates/, cartazes, e-mails, mod-criador e mod-mailer, que montam peças e e-mails), que seguem as regras de
   documento. Marque uma linha legítima com o comentário
   "auditar: ok, <motivo>".
   ============================================================ */
import { readFileSync, statSync, readdirSync } from 'node:fs';
import { join, relative, basename } from 'node:path';

const REGRAS = [
  { id: 'cor-literal', secao: '13', msg: 'cor escrita à mão; use um token (--axon, --muted, rgba(var(--tom),.05))',
    re: /#[0-9a-fA-F]{6}\b|#[0-9a-fA-F]{3}\b(?![0-9a-fA-F-])/g, css: true },
  { id: 'pilula', secao: '5', msg: 'raio de pílula; chip 6px (--r-chip), tag 5px (--r-tag), botão 11px (--r-sm)',
    /* círculo (50%) é permitido em ponto, avatar, spinner e blob; a escala vai até 24px */
    re: /border-radius:\s*(9{2,4}|100)px|border-radius:\s*(2[5-9]|[3-9]\d)px|border-radius:\s*(1[5-9]|2[0-4])px(?![^;}]*\/\*\s*escala)(?=[^}]*\b(height:\s*(2\d|3[0-6])px))/g, css: true },
  { id: 'mono-rotulo', secao: '3', msg: 'Plex Mono em rótulo (caixa alta); rótulo é Archivo 600',
    re: /var\(--fm\)[^}]{0,120}text-transform:\s*uppercase|text-transform:\s*uppercase[^}]{0,120}var\(--fm\)/g, css: true },
  { id: 'selecao-synapse', secao: '4', msg: 'seleção em Synapse; seleção é quieta: rgba(var(--tom),.09) e tinta',
    re: /\.(on|ativo|sel|selecionad[oa])\b[^{}]{0,60}\{[^}]*background:\s*var\(--(syn|synapse)\)/g, css: true },
  /* aviso, não erro: popover, listbox e diálogo podem ter sombra suave */
  { id: 'sombra', secao: '2', aviso: true, msg: 'sombra de elevação? em cartão, elevação é borda e superfície',
    re: /box-shadow:\s*0\s+\d+px\s+\d{2,}px\s+rgba\((?!var\(--syn)/g, css: true },
  { id: 'fonte-literal', secao: '13', msg: 'fonte escrita à mão; use --fd, --f ou --fm',
    re: /font-family:\s*['"]?(Archivo|Instrument|IBM Plex|Inter|Helvetica)/g, css: true },
  { id: 'ponto-medio', secao: '3', msg: 'ponto médio como separador; use vírgula, quebra de linha ou layout',
    re: /·/g, texto: true },
  { id: 'travessao', secao: '3', msg: 'travessão como separador em texto de interface; use vírgula ou dois-pontos',
    re: /(?:>|['"`])[^<'"`\n]{0,80}\s—\s[^<'"`\n]{0,80}(?:<|['"`])/g, texto: true },
  { id: 'emoji', secao: '11', msg: 'emoji; os únicos glifos são → ↓ ✓ ! × i',
    re: /[\u{1F300}-\u{1FAFF}\u{2600}-\u{26FF}\u{2B50}\u{2B55}]/gu, texto: true },
];

const IGNORAR_PASTA = /(^|\/)(node_modules|\.git|ds|v3|previews|templates|downloads|assets|fontes|mailer|db|supabase|testes|scripts|marca)(\/|$)/;
const IGNORAR_ARQ = /(^|\/)(tokens\.css|formal\.css|cartazes\.html|redes\.html|doc-nro\.js|mod-criador\.js|mod-mailer\.js|fontes-pdf\.js|sw\.js)$/;
const EXT = /\.(html|css|js|mjs)$/;

const args = process.argv.slice(2);
const resumo = args.includes('--resumo'), falhar = args.includes('--falhar');
const alvos = args.filter(a => !a.startsWith('--'));
if (!alvos.length) { console.error('uso: node scripts/auditar.mjs [--resumo|--falhar] <arquivo ou pasta>...'); process.exit(2); }

function arquivos(c) {
  const st = statSync(c);
  if (st.isFile()) return EXT.test(c) ? [c] : [];
  return readdirSync(c).flatMap(n => {
    const p = join(c, n);
    if (IGNORAR_PASTA.test(relative(c, p)) || IGNORAR_PASTA.test(n)) return [];
    if (IGNORAR_ARQ.test(p)) return [];
    return arquivos(p);
  });
}

/* comentários de código não contam: tira /* *\/ e // antes de procurar */
function semComentarios(s) {
  return s.replace(/\/\*[\s\S]*?\*\//g, m => m.replace(/[^\n]/g, ' '))
          .replace(/(^|[^:'"`\\])\/\/[^\n]*/g, (m, p) => p + ' '.repeat(m.length - p.length))
          .replace(/<!--[\s\S]*?-->/g, m => m.replace(/[^\n]/g, ' '));
}

let total = 0, avisos = 0; const porRegra = {}; const porArquivo = {};
for (const a of alvos) for (const f of arquivos(a)) {
  const bruto = readFileSync(f, 'utf8');
  const s = semComentarios(bruto);
  const linhas = bruto.split('\n');
  for (const r of REGRAS) {
    for (const m of s.matchAll(r.re)) {
      const n = s.slice(0, m.index).split('\n').length;
      if (/auditar:\s*ok/.test(linhas[n - 1] || '')) continue;
      if (r.aviso) avisos++; else total++;
      porRegra[r.id] = (porRegra[r.id] || 0) + 1; if (!r.aviso) porArquivo[f] = (porArquivo[f] || 0) + 1;
      if (!resumo) console.log(`${f}:${n}  [${r.aviso ? 'aviso ' : ''}${r.id}, §${r.secao}] ${r.msg}\n    ${(linhas[n - 1] || '').trim().slice(0, 140)}`);
    }
  }
}
console.log(`\n${total} violação(ões)${avisos ? `, ${avisos} aviso(s)` : ''}`);
for (const [k, v] of Object.entries(porRegra).sort((a, b) => b[1] - a[1])) console.log(`  ${k.padEnd(16)} ${v}`);
if (resumo) for (const [k, v] of Object.entries(porArquivo).sort((a, b) => b[1] - a[1]).slice(0, 25)) console.log(`  ${String(v).padStart(5)}  ${k}`);
if (falhar && total) process.exit(1);
