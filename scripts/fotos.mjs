#!/usr/bin/env node
/* ============================================================
   O banco de imagens da marca, para quem cria peças (gente e o Claude).

   O banco mora no SOMA (Studio › Banco de imagens, Marca › Galeria de
   fotos): o admin põe fotos novas e a gestão do Studio aprova uma de
   cada vez (SOMA 2.26.0). Este script lê o banco pela função pública
   fotos_banco_publico, só com as fotos aprovadas e os campos públicos,
   e baixa as imagens.

   Uso, da raiz do repositório:
     node scripts/fotos.mjs                          o banco todo, em tabela
     node scripts/fotos.mjs --tag UTI --tag monitor  as fotos com alguma dessas tags
     node scripts/fotos.mjs --tema hospital          as de um tema (a chave: hospital, laboratorio...)
     node scripts/fotos.mjs --busca microscópio      texto na descrição, nas tags ou no autor
     node scripts/fotos.mjs --json                   o JSON da função, para ler ou guardar
     node scripts/fotos.mjs --baixar saida/ --largura 2560 [filtros]
         baixa as imagens filtradas em saida/ e escreve saida/creditos.json
         (descrição, autor, banco, licença e a página de cada foto)

   Sem dependências. Usa fetch e, se a rede do fetch falhar (um proxy,
   por exemplo), tenta de novo com o curl.
   SOMA_URL e SOMA_CHAVE trocam o projeto e a chave (o padrão é o
   projeto do SOMA e a chave publicável, a mesma do site).
   ============================================================ */
import { mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const URL_SOMA = process.env.SOMA_URL || 'https://rxzmkyjttzzpwtodqkve.supabase.co';
const CHAVE = process.env.SOMA_CHAVE || 'sb_publishable_MJFR-aaQqTS1BthxYJG2kg_5XGhs9wg';
const BANCOS = { unsplash:'Unsplash', pexels:'Pexels', link:'link' };

function args(argv){
  const a = { tags:[], tema:null, busca:null, json:false, baixar:null, largura:2400 };
  for (let i = 0; i < argv.length; i++){
    const k = argv[i], v = argv[i + 1];
    if (k === '--tag'){ a.tags.push(v); i++; }
    else if (k === '--tema'){ a.tema = v; i++; }
    else if (k === '--busca'){ a.busca = v; i++; }
    else if (k === '--json') a.json = true;
    else if (k === '--baixar'){ a.baixar = v; i++; }
    else if (k === '--largura'){ a.largura = Math.max(320, Math.min(6000, Number(v) || 2400)); i++; }
    else if (k === '-h' || k === '--help'){ console.log(readmeCurto()); process.exit(0); }
    else { console.error(`Opção desconhecida: ${k}\n\n${readmeCurto()}`); process.exit(2); }
  }
  return a;
}
const readmeCurto = () => `node scripts/fotos.mjs [--tag T]... [--tema CHAVE] [--busca TEXTO] [--json] [--baixar PASTA] [--largura PX]`;

/* fetch; se a rede falhar, curl (que respeita HTTPS_PROXY e o CA do sistema) */
async function pedir(url, { metodo = 'GET', corpo = null, cabecalhos = {}, binario = false } = {}){
  try {
    const r = await fetch(url, { method:metodo, headers:cabecalhos, body:corpo });
    if (!r.ok) throw Object.assign(new Error(`${r.status} ${await r.text().catch(() => '')}`.slice(0, 300)), { http:true });
    return binario ? Buffer.from(await r.arrayBuffer()) : await r.text();
  } catch(e){
    if (e.http) throw e;
    const c = ['-sS', '-L', '--fail-with-body', '-X', metodo, url];
    for (const [k, v] of Object.entries(cabecalhos)) c.push('-H', `${k}: ${v}`);
    if (corpo) c.push('--data-binary', corpo);
    const p = spawnSync('curl', c, { encoding: binario ? 'buffer' : 'utf8', maxBuffer: 200 * 1024 * 1024 });
    if (p.error) throw new Error(`a rede falhou (${e.message}) e o curl não está disponível`);
    if (p.status !== 0) throw new Error(String(p.stdout || p.stderr || `curl saiu com ${p.status}`).slice(0, 300));
    return p.stdout;
  }
}

async function banco({ tags, tema }){
  const corpo = JSON.stringify({ p_tags: tags.length ? tags : null, p_tema: tema || null });
  let txt;
  try {
    txt = await pedir(`${URL_SOMA}/rest/v1/rpc/fotos_banco_publico`, { metodo:'POST', corpo,
      cabecalhos:{ apikey:CHAVE, Authorization:`Bearer ${CHAVE}`, 'Content-Type':'application/json' } });
  } catch(e){
    if (/fotos_banco_publico|PGRST202|404/.test(e.message))
      throw new Error('A função fotos_banco_publico não respondeu. Falta aplicar a migração db/2.25.0_fotos_sem_votacao.sql do SOMA no Supabase? '
        + 'Enquanto isso, use Copiar a lista em Marca › Galeria de fotos, no SOMA.');
    throw e;
  }
  const r = JSON.parse(txt);
  if (r?.status !== 'ok') throw new Error('O banco de imagens respondeu: ' + txt.slice(0, 200));
  return r.fotos || [];
}

const norm = s => String(s || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();
/* o endereço da imagem na largura pedida, no CDN do banco */
function comLargura(url, w){
  try {
    const u = new URL(url);
    if (u.hostname === 'images.unsplash.com'){ ['auto', 'fit', 'q', 'w', 'fm'].forEach(k => u.searchParams.delete(k));
      u.searchParams.set('fm', 'jpg'); u.searchParams.set('fit', 'max'); u.searchParams.set('q', '85'); u.searchParams.set('w', String(w)); }
    else if (u.hostname === 'images.pexels.com'){ u.searchParams.set('auto', 'compress'); u.searchParams.set('cs', 'tinysrgb'); u.searchParams.set('w', String(w)); }
    return u.toString();
  } catch(e){ return url; }
}
const credito = f => f.autor ? `${f.autor} / ${BANCOS[f.banco] || f.banco}` : (BANCOS[f.banco] || 'Foto do banco');
const arquivo = (f, i) => `${String(i + 1).padStart(2, '0')}-${norm(f.descricao).replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '').slice(0, 48) || f.banco_id}.jpg`;

const a = args(process.argv.slice(2));
let fotos;
try { fotos = await banco(a); }
catch(e){ console.error(e.message); process.exit(1); }
if (a.busca){
  const termos = norm(a.busca).split(/\s+/).filter(Boolean);
  fotos = fotos.filter(f => termos.every(t => norm([f.descricao, f.autor, f.tema_nome, ...(f.tags || [])].join(' ')).includes(t)));
}

if (a.json){ console.log(JSON.stringify({ fonte:'Banco de imagens da NeuroDynamics (SOMA)', lido_em:new Date().toISOString(), fotos }, null, 2)); process.exit(0); }

if (!a.baixar){
  if (!fotos.length){ console.log('Nenhuma foto com esse filtro.'); process.exit(0); }
  for (const f of fotos){
    console.log(`${(f.tema_nome || '—').padEnd(26)} ${f.descricao}`);
    console.log(`${''.padEnd(26)} tags: ${(f.tags || []).join(', ') || '—'}; crédito: ${credito(f)}${f.imagem ? '' : '; sem endereço de imagem ainda'}`);
    console.log(`${''.padEnd(26)} ${f.imagem ? comLargura(f.imagem, 2400) : f.pagina || ''}`);
  }
  console.log(`\n${fotos.length} ${fotos.length === 1 ? 'foto' : 'fotos'}.`);
  process.exit(0);
}

mkdirSync(a.baixar, { recursive:true });
const creditos = [];
let ok = 0;
for (const [i, f] of fotos.entries()){
  if (!f.imagem){ console.log(`pulei (sem endereço de imagem): ${f.descricao}`); continue; }
  const nome = arquivo(f, i);
  try {
    const bin = await pedir(comLargura(f.imagem, a.largura), { binario:true });
    writeFileSync(join(a.baixar, nome), bin);
    creditos.push({ arquivo:nome, descricao:f.descricao, tema:f.tema_nome || null, familia:f.familia || null, tags:f.tags || [],
      autor:f.autor || null, banco:BANCOS[f.banco] || f.banco, licenca:f.licenca || null, pagina:f.pagina || null, credito:credito(f) });
    ok++; console.log(`baixei ${nome} (${Math.round(bin.length / 1024)} KB), ${credito(f)}`);
  } catch(e){ console.log(`não baixei ${f.descricao}: ${e.message}`); }
}
writeFileSync(join(a.baixar, 'creditos.json'), JSON.stringify({ fonte:'Banco de imagens da NeuroDynamics (SOMA)', baixado_em:new Date().toISOString(), fotos:creditos }, null, 2));
console.log(`\n${ok} de ${fotos.length} em ${a.baixar}, com creditos.json.`);
