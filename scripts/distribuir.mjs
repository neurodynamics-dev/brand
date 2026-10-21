#!/usr/bin/env node
/* ============================================================
   distribuir.mjs · leva o design system aos consumidores

   Os sites e o SOMA não têm build e não podem depender do brand
   no ar: cada um recebe uma cópia em ds/, com a versão e o commit
   do brand no cabeçalho de cada arquivo de texto.

   Uso (repositórios lado a lado, como ../membro):
     node scripts/distribuir.mjs              copia para os três
     node scripts/distribuir.mjs ../website   copia para um
     node scripts/distribuir.mjs --check      só confere; sai 1 se
                                              alguma cópia divergir
   ============================================================ */
import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { execSync } from 'node:child_process';

const raiz = join(dirname(fileURLToPath(import.meta.url)), '..');
const ds = join(raiz, 'design-system');
export const VERSAO = '3.0.0';

/* o que cada consumidor recebe: [origem em design-system/, destino em ds/] */
const ARQUIVOS = [
  ['tokens.css', 'tokens.css'],
  ['neuro.css', 'neuro.css'],
  ['casca.css', 'casca.css'],
  ['casca.js', 'casca.js'],
  ['select.css', 'select.css'],
  ['select.js', 'select.js'],
  ['marca/imagotipo-branco.webp', 'marca/imagotipo-branco.webp'],
];
const CONSUMIDORES = ['../membro', '../website', '../selecao'];

const args = process.argv.slice(2);
const soConfere = args.includes('--check');
const alvos = args.filter(a => !a.startsWith('--'));
let sha = 'local';
try { sha = execSync('git rev-parse --short HEAD', { cwd: raiz }).toString().trim(); } catch {}

const cabecalho = nome => nome.endsWith('.css') || nome.endsWith('.js')
  ? `/* NRO DS ${VERSAO}, gerado de brand/design-system/${nome}. Não edite aqui: edite no brand e rode scripts/distribuir.mjs. */\n`
  : null;
/* o sha muda a cada commit; a conferência compara só o conteúdo */
const conteudo = (orig) => {
  const buf = readFileSync(join(ds, orig));
  const c = cabecalho(orig);
  return c ? Buffer.concat([Buffer.from(c), buf]) : buf;
};

let divergentes = 0;
for (const alvo of (alvos.length ? alvos : CONSUMIDORES)) {
  const pasta = join(raiz, alvo);
  if (!existsSync(pasta)) { console.log(`  ${alvo}: não encontrado, pulado`); continue; }
  for (const [orig, dest] of ARQUIVOS) {
    const caminho = join(pasta, 'ds', dest), novo = conteudo(orig);
    const atual = existsSync(caminho) ? readFileSync(caminho) : null;
    if (atual && atual.equals(novo)) continue;
    if (soConfere) { console.error(`✗ ${alvo}/ds/${dest}: diverge do brand`); divergentes++; continue; }
    mkdirSync(dirname(caminho), { recursive: true });
    writeFileSync(caminho, novo);
    console.log(`  ${alvo}/ds/${dest}`);
  }
  if (!soConfere) writeFileSync(join(pasta, 'ds', 'VERSAO'), `${VERSAO} brand@${sha}\n`);
}
if (soConfere) {
  if (divergentes) { console.error(`\n${divergentes} arquivo(s) fora de sincronia. Rode: node scripts/distribuir.mjs`); process.exit(1); }
  console.log('✓ ds/ em sincronia nos consumidores');
} else console.log(`✓ NRO DS ${VERSAO} (brand@${sha}) distribuído`);
