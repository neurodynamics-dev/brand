// Gera o manual: node scripts/montar.mjs
import { mkdirSync, writeFileSync, rmSync, existsSync } from 'node:fs';
import path from 'node:path';
import { raiz } from './manual/layout.mjs';

const MODULOS = ['home', 'fundamentos', 'aplicacoes', 'interface', 'imprensa', 'downloads', 'erro'];
const paginas = [];
for (const m of MODULOS) {
  const r = (await import(`./manual/paginas/${m}.mjs`)).default();
  paginas.push(...(Array.isArray(r) ? r : [r]));
}
const gravar = (rel, html) => { const f = path.join(raiz, rel); mkdirSync(path.dirname(f), { recursive: true }); writeFileSync(f, html); };
for (const p of paginas) gravar(p.arquivo || (p.rota === '/' ? 'index.html' : `${p.rota.slice(1)}/index.html`), p.html);

// endereços antigos continuam funcionando
const REDIR = { marca: '/fundamentos/marca', cores: '/fundamentos/cor', tipografia: '/fundamentos/tipografia', escrita: '/fundamentos/redacao', elementos: '/fundamentos/elementos', galeria: '/aplicacoes' };
for (const [de, para] of Object.entries(REDIR)) {
  gravar(`${de}.html`, `<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Redirecionando</title><link rel="canonical" href="${para}"><meta http-equiv="refresh" content="0;url=${para}"><p><a href="${para}">Abrir ${para}</a></p></html>`);
}
for (const velho of ['aplicacoes.html']) if (existsSync(path.join(raiz, velho))) rmSync(path.join(raiz, velho));
console.log(`${paginas.length} páginas geradas.`);
