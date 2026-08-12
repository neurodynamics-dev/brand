#!/usr/bin/env node
/* ============================================================
   bundle.mjs · NeuroDynamics Design System

   Monta a pasta ds-bundle/ no layout que o Claude Design consome.

   Por que existe: a skill /design-sync roda um conversor sobre
   bibliotecas React (Storybook ou package.json + dist/). Este
   repositório é CSS e HTML — não há componente compilado para pôr
   em _ds_bundle.js. A própria skill prevê a saída: produzir o
   layout por outro meio, no modo "design system só de tokens",
   que sobe styles.css com um bundle de corpo vazio.

   O que o agente ganha: os tokens, o vocabulário de classes e as
   regras da marca. O que ele não ganha: componentes importáveis —
   ele escreve o HTML dele e estiliza com o nosso CSS.

   Ordem:  node build.mjs && node bundle.mjs

   Uso:  node bundle.mjs          (grava)
         node bundle.mjs --check  (só confere; sai 1 se divergir)
   ============================================================ */
import { readFileSync, writeFileSync, readdirSync, mkdirSync, rmSync, existsSync, cpSync, statSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const raiz = dirname(fileURLToPath(import.meta.url));
const saida = join(raiz, '..', 'ds-bundle');
const soConfere = process.argv.includes('--check');

const escritos = new Map();   // caminho relativo → conteúdo (string ou Buffer)
const põe = (rel, conteudo) => escritos.set(rel, conteudo);

/* ------------------------------------------------------------
   nome de diretório a partir do rótulo do card:
   "Espaço e forma" → "EspacoEForma"
   ------------------------------------------------------------ */
const pascal = (s) => s
  .normalize('NFD').replace(/[̀-ͯ]/g, '')
  .split(/[\s/-]+/).filter(Boolean)
  .map(p => p[0].toUpperCase() + p.slice(1))
  .join('');

/* ============================================================
   1. CSS — styles.css é a raiz; só o que ele importa chega aos
   designs que o agente renderiza.
   ============================================================ */
const tokensCss = readFileSync(join(raiz, 'tokens.css'), 'utf8');
const neuroCss = readFileSync(join(raiz, 'neuro.css'), 'utf8');

põe('tokens/tokens.css', tokensCss);
põe('_ds_bundle.css', neuroCss);
põe('styles.css',
`/* NeuroDynamics · raiz do CSS
   Os designs renderizados recebem SÓ o fecho de @import deste
   arquivo — qualquer CSS que precise chegar neles entra aqui. */
@import "./tokens/tokens.css";
@import "./_ds_bundle.css";
`);

/* ============================================================
   2. bundle JS — corpo vazio: não há componente React neste
   design system. O cabeçalho da primeira linha é lido pelo
   self-check do app.
   ============================================================ */
const cabecalho = {
  globalName: 'NeuroDynamics',
  kind: 'tokens-only',
  components: 0,
  note: 'CSS/token design system — style with classes from styles.css, nothing to import',
};
põe('_ds_bundle.js',
`/* @ds-bundle: ${JSON.stringify(cabecalho)} */
(function () {
  /* Design system só de tokens: o estilo vem de styles.css.
     O global existe para o runtime encontrar algo definido. */
  window.NeuroDynamics = window.NeuroDynamics || {};
})();
`);

/* ============================================================
   3. cards — um por preview, em components/<Grupo>/<Nome>/
   ============================================================ */

/* resumo (primeira linha do .prompt.md, que o agente lê como
   índice) e como compor. Escrito à mão: é o que ensina o agente. */
const USO = {
  Cores: {
    resumo: 'Paleta nomeada da marca: 3 primárias, 7 neutros e 7 auxiliares de dados e status.',
    classes: '`--cortex` `--axon` `--synapse` · `--void` `--painel` `--ink` `--aura` `--nevoa` `--grafite` · `--vital` `--mielina` `--pulso` `--plasma` `--ion` `--dendrito` `--soma`',
    corpo: `Use sempre o token, nunca o hex. \`--bg\` é o fundo, \`--muted\` o texto secundário,
\`--dim\` o rótulo técnico.

**Grafite (\`--grafite\`) reprova em AA para texto corrido** (3,69:1 sobre o Void):
serve para rótulo caixa alta, legenda e borda. Texto secundário é \`--muted\` (7,92:1).

O Synapse é acento — acima de ~5% da tela deixa de funcionar como tal.`,
  },
  Tipografia: {
    resumo: 'Archivo para display e interface, IBM Plex Mono para dados e rótulos, fonte de sistema no corpo.',
    classes: '`--fd` `--fm` `--f` · `--fs-display` `--fs-h1` `--fs-h2` `--fs-h3` `--fs-body` `--fs-sm` `--fs-xs` `--fs-label` `--fs-micro` · `.display` `.lead` `.mono` `.nota` `.eyebrow`',
    corpo: `\`--fd\` (Archivo) em título, botão e nome. \`--fm\` (IBM Plex Mono) em eyebrow,
rótulo caixa alta, código e número de tabela — sempre com tracking positivo quando
em caixa alta. \`--f\` (sistema) no texto corrido.

Texto corrido não passa de \`--measure\` (640px).

\`\`\`html
<span class="eyebrow">01 / Seção</span>
<h1 class="display">Título com <em>uma</em> palavra em Synapse.</h1>
<p class="lead">Parágrafo de abertura.</p>
\`\`\``,
  },
  EspacoEForma: {
    resumo: 'Escala de espaçamento base 4px, seis raios e as medidas de container e de linha.',
    classes: '`--s1` a `--s10` · `--gap` · `--sec` · `--r` `--r-sm` `--r-md` `--r-lg` `--r-xl` `--r-pill` · `--max` `--measure`',
    corpo: `Espaço em múltiplos de 4: \`--s1\` (4px) a \`--s10\` (80px). \`--gap\` (16px) é o gap
padrão de grade e \`--sec\` o ritmo entre seções — é ele que dá o ar da marca, não reduza.

Raio pelo tamanho do objeto: \`--r-sm\` (11px) em botão e campo, \`--r-md\` (14px) em
cartão menor, \`--r\` (18px) base, \`--r-lg\` (20px) em painel, \`--r-xl\` (24px) na banda.`,
  },
  Superficies: {
    resumo: 'Quatro níveis de superfície: Void, cartão, painel e vidro — sem sombra separando.',
    classes: '`.card` `.panel` `.glass` `.claro`',
    corpo: `A hierarquia vem de fundo, borda e desfoque, não de sombra. Sombra só no que
flutua de verdade: cabeçalho, toast e diálogo.

- \`.card\` — a superfície padrão do conteúdo (branco a 3%, borda a 8%)
- \`.panel\` — opaca, borda mais visível; para blocos de controle e formulário
- \`.glass\` — só sobre conteúdo em movimento; pesa no celular, use pouco
- \`.claro\` — fundo Aura com texto Blackout; documento, assinatura, impresso

Não empilhe \`.card\` dentro de \`.card\`: dois fundos translúcidos somam opacidade
e viram uma mancha sem hierarquia.`,
  },
  Imagotipo: {
    resumo: 'A marca: versões, respiro de 1x, tamanho mínimo e usos proibidos.',
    classes: '(artes, não classes)',
    corpo: `Símbolo e logotipo formam uma unidade e nunca são recompostos. A fonte oficial
dos arquivos é o Brandfetch — não recrie a marca a partir de captura de tela nem
redigite o nome em Archivo.

- Sobre fundo escuro vai o **imagotipo branco**; sobre Ink e Aura, o **preto**.
  São arquivos diferentes — não gere um do outro com filtro.
- Respiro livre ao redor = a altura do símbolo, em todos os lados.
- Mínimo: 17px de altura em tela, 12mm de largura em impresso. Abaixo disso,
  troque pelo ícone.
- Não distorça, não gire, não recolora, não use sobre fundo com ruído.`,
  },
  FundoETextura: {
    resumo: 'O fundo da marca: brilho radial, grade técnica mascarada e blobs desfocados.',
    classes: '`.nd-bg` `.blob` `.b1` `.b2` `.b3` `.fig`',
    corpo: `Receita fixa, sempre nesta ordem: brilho radial no fundo, blobs por cima, grade
mascarada por último, conteúdo acima de tudo. Trocar a ordem embaça o texto.

\`\`\`html
<div class="nd-bg">
  <div class="blob b1"></div><div class="blob b2"></div><div class="blob b3"></div>
</div>
\`\`\`

Os blobs sempre sangram para fora da tela — blob inteiro e centralizado vira forma,
e forma tem que ter significado. **Nunca foto atrás do texto**: a textura da marca é
geométrica. Foto entra em cartão, com borda e raio.

\`.fig\` é o placeholder de imagem que ainda não existe.`,
  },
  BandaEHero: {
    resumo: 'Abertura de página e chamada principal — uma de cada por página.',
    classes: '`.band` `.display` `.eyebrow` `.lead` `.sec-head`',
    corpo: `O hero abre com a textura da marca; a \`.band\` fecha com a ação principal.
As duas juntas competem — uma de cada por página.

\`\`\`html
<section class="band">
  <span class="eyebrow">Chamada</span>
  <h2>A banda verde é para o que importa.</h2>
  <p>Uma linha de apoio.</p>
  <button class="btn solid">Ação principal</button>
</section>
\`\`\`

Não encha a banda: eyebrow, título, uma linha e um botão. Lista, imagem ou
formulário dentro dela quebram o gesto.`,
  },
  Botoes: {
    resumo: 'Três variantes de botão e dois tamanhos; só um botão sólido por tela.',
    classes: '`.btn` + `.solid` `.claro` `.ghost` `.mini`',
    corpo: `\`\`\`html
<button class="btn solid">Ação principal</button>
<button class="btn ghost">Cancelar</button>
<button class="btn ghost mini">Ação em cartão</button>
\`\`\`

- \`.solid\` é o Synapse disparando: **um por tela**. O segundo vira \`.ghost\`.
- \`.claro\` (Ink) para fundo escuro neutro — **não use sobre a banda verde**,
  perde o contorno; ali vale \`.solid\` ou \`.ghost\` com borda clara.
- \`.mini\` (34px) dentro de cartão, tabela e barra de ferramenta; o padrão (44px)
  em formulário e chamada.

Rótulo com verbo: "Gerar asset", "Baixar PNG". Nada de "OK" solto.`,
  },
  Cartoes: {
    resumo: 'Cartão de conteúdo, cartão de regra, superfície clara e cabeçalho de seção.',
    classes: '`.card` `.claro` `.sec-head` `.grid-2` `.grid-3` `.grid-4`',
    corpo: `\`\`\`html
<div class="grid-3">
  <div class="card">
    <h3 style="font-size:var(--fs-h3)">Título</h3>
    <p style="font-size:var(--fs-sm);color:var(--muted)">Texto de apoio.</p>
  </div>
</div>
\`\`\`

Um cartão, uma ideia: se precisa de subtítulo, lista e dois botões, virou seção.
Título em \`--fd\` e Ink; corpo em \`--f\` e \`--muted\`.

\`.sec-head\` é o cabeçalho de seção em duas colunas — eyebrow numerado à esquerda,
título e subtítulo à direita; colapsa em uma coluna abaixo de 820px.`,
  },
  Formularios: {
    resumo: 'Campos, seleção e estados — o foco acende a borda em Synapse.',
    classes: '`.fld` `.fld.erro` `.chip` `.chip.on` `.panel`',
    corpo: `\`\`\`html
<div class="fld">
  <label for="email">E-mail institucional</label>
  <input id="email" type="email" placeholder="ana@neurodynamics.dev">
  <p class="mini">Use a conta da equipe.</p>
</div>
\`\`\`

\`.fld\` envolve rótulo, campo e ajuda. O rótulo é **sempre visível** (caixa alta,
10,5px, peso 700) — placeholder é exemplo de conteúdo, nunca substituto do rótulo.

\`.fld.erro\` pinta a borda e a mensagem em Pulso; a mensagem diz **o que fazer**,
não só que deu errado. Campo sem borda não delimita — a borda de 16% é obrigatória.

Formulários longos ficam melhor dentro de \`.panel\`.`,
  },
  StatusEEtiquetas: {
    resumo: 'Pills de status com significado fixo, tags de contexto e chips de escolha.',
    classes: '`.pill` + `.st-vital` `.st-mielina` `.st-pulso` `.st-plasma` `.st-ion` `.st-dendrito` · `.tag` · `.chip` `.chip.on`',
    corpo: `\`\`\`html
<span class="pill st-vital"><span class="dt"></span>Concluído</span>
<span class="pill st-mielina"><span class="dt"></span>Em análise</span>
<span class="pill st-pulso"><span class="dt"></span>Falhou</span>
\`\`\`

Significado é fixo: Vital = sucesso, Mielina = atenção, Pulso = erro,
Plasma = informação neutra, Íon = destaque/evento, Dendrito = processo e pesquisa.
Não troque por gosto.

**Cor nunca sozinha** — todo status carrega texto junto.
**Synapse não é status**: é acento e ação. Sucesso é Vital.

\`.tag\` é rótulo de contexto (em Synapse), \`.chip\` é escolha do usuário —
o selecionado vira \`.chip.on\`.`,
  },
  Navegacao: {
    resumo: 'Cabeçalho flutuante de vidro, âncoras e rodapé.',
    classes: '`.nd-header` `.nd-header.rolou` `.hd-in` `.hd-logo` `.logotype` `.hd-nav` · `.nd-footer` `.ft-in`',
    corpo: `\`\`\`html
<header class="nd-header">
  <div class="hd-in">
    <span class="hd-logo"><span class="logotype">NeuroDynamics</span></span>
    <nav class="hd-nav"><a href="#">Marca</a><a href="#">Cores</a></nav>
    <button class="btn solid mini">Entrar</button>
  </div>
</header>
\`\`\`

O cabeçalho flutua: 14px do topo, cantos de 16px, vidro por trás. A grade do fundo
atravessa ele — é isso que dá a sensação de vidro. Depois de ~20px de rolagem,
adicione \`.rolou\` (fundo mais opaco, borda mais forte, sombra funda).

A \`.hd-nav\` some abaixo de 1080px — preveja o menu alternativo.`,
  },
  Dados: {
    resumo: 'Tabela, métricas e lista de especificação — número sempre em mono e à direita.',
    classes: '`.tabela` `.num` `.escala`',
    corpo: `\`\`\`html
<table class="tabela">
  <thead><tr><th>Peça</th><th class="num">Downloads</th></tr></thead>
  <tbody><tr><td>Banner</td><td class="num">318</td></tr></tbody>
</table>
\`\`\`

Número em \`--fm\` e alinhado à direita, para as casas se empilharem — nunca
centralize coluna numérica. Ponto para milhar, vírgula para decimal: \`1.284\`, \`1,8s\`.

Borda a 8% entre linhas, cabeçalho a 16%, sem zebra; hover a 2% na linha inteira.
Tabela larga vai dentro de um contêiner com \`overflow-x:auto\`.

\`.escala\` é a lista chave/valor para especificação.`,
  },
  Feedback: {
    resumo: 'Toast, carregamento, estado vazio e diálogo.',
    classes: '`.nd-toast` `.toast`',
    corpo: `\`\`\`html
<div class="nd-toast"><div class="toast">#CEDC00 copiado.</div></div>
\`\`\`

Toast confirma e some em ~4s — **não carrega decisão**. Se a pessoa precisa
escolher, o lugar é o diálogo, que só sai com uma resposta.

Estado vazio sempre com um botão que resolve o vazio: tela vazia sem próximo
passo é um beco.

Esqueleto quando você sabe a forma do conteúdo, indicador de giro quando não sabe.
Os dois respeitam \`prefers-reduced-motion\`.`,
  },
};

const dirPreviews = join(raiz, 'previews');
const arquivos = readdirSync(dirPreviews).filter(f => f.endsWith('.html')).sort();
const cards = [];

for (const nome of arquivos) {
  const html = readFileSync(join(dirPreviews, nome), 'utf8');
  const marca = html.match(/<!--\s*@dsCard\s+([\s\S]*?)-->/);
  if (!marca) { console.error(`✗ ${nome}: @dsCard ausente.`); process.exit(1); }
  const a = {};
  for (const [, k, v] of marca[1].matchAll(/(\w+)="([^"]*)"/g)) a[k] = v;

  const grupo = pascal(a.group);
  const Nome = pascal(a.name);
  const base = `components/${grupo}/${Nome}`;

  /* o card linka styles.css (o contrato) e mantém os tokens embutidos
     (robustez: renderiza mesmo se o link não resolver) */
  const comLink = html.replace(
    /(<link href="https:\/\/fonts\.googleapis\.com[^>]*>)/,
    `$1\n<link rel="stylesheet" href="../../../styles.css">`
  );
  põe(`${base}/${Nome}.html`, comLink);

  const uso = USO[Nome];
  if (!uso) { console.error(`✗ ${Nome}: sem entrada em USO. Adicione em bundle.mjs.`); process.exit(1); }
  põe(`${base}/${Nome}.prompt.md`,
`${uso.resumo}

**Classes e tokens:** ${uso.classes}

${uso.corpo}

---
Card completo com todos os estados: \`${base}/${Nome}.html\`
`);

  cards.push({ grupo: a.group, nome: a.name, dir: base });
}

/* ============================================================
   4. guidelines
   ============================================================ */
const conventions = readFileSync(join(raiz, 'conventions.md'), 'utf8');
põe('guidelines/convencoes.md', conventions);
põe('guidelines/acessibilidade.md',
`# Acessibilidade

Contrastes calculados em WCAG 2.1 sobre a paleta oficial.

| Combinação | Razão | Nível |
| --- | --- | --- |
| Ink sobre Void | 18,47:1 | AAA |
| Névoa sobre Void | 7,92:1 | AAA |
| **Grafite sobre Void** | **3,69:1** | **só texto ≥18,5px** |
| Synapse sobre Void | 13,27:1 | AAA |
| Synapse sobre Cortex | 8,94:1 | AAA |
| Synapse sobre Axon | 5,45:1 | AA |
| Blackout sobre Aura | 15,82:1 | AAA |
| Grafite sobre Aura | 5,12:1 | AA |

Três regras que saem daí:

1. **\`--grafite\` não é cor de texto corrido.** Reprova em AA. Use em rótulo caixa
   alta, legenda e borda. Texto secundário é \`--muted\` (Névoa).
2. **Status nunca só por cor.** Todo \`.pill\` de status carrega texto; todo alerta
   carrega também um ícone.
3. **Foco sempre visível.** \`:focus-visible\` recebe contorno em Synapse com 2px de
   afastamento; não remova.

Animações (esqueleto, giro, blobs) respeitam \`prefers-reduced-motion\`.
`);

/* ============================================================
   5. README — cabeçalho de convenções + índice
   ============================================================ */
const porGrupo = cards.reduce((acc, c) => {
  (acc[c.grupo] ||= []).push(c); return acc;
}, {});
põe('README.md',
`${conventions}

---

# Índice dos cards

${Object.entries(porGrupo).map(([g, cs]) =>
  `## ${g}\n\n${cs.map(c => `- **${c.nome}** — \`${c.dir}/\``).join('\n')}`
).join('\n\n')}

Cada card tem um \`.prompt.md\` (como compor, com exemplo) e um \`.html\` (todos os
estados, renderizado).

# Sobre este bundle

Design system de **CSS e tokens**. O \`_ds_bundle.js\` tem corpo vazio de propósito:
não existe componente React aqui, e não há nada para importar. O estilo chega pelo
\`styles.css\` e o vocabulário está no cabeçalho acima.

Gerado por \`design-system/bundle.mjs\` no repositório
[neurodynamics-dev/brand](https://github.com/neurodynamics-dev/brand).
`);

/* sentinela que o app usa para saber que precisa recompilar */
põe('_ds_needs_recompile', JSON.stringify({ by: 'neurodynamics-brand-bundle' }) + '\n');

/* ============================================================
   6. artes da marca
   ============================================================ */
const dirMarca = join(raiz, 'marca');
for (const f of readdirSync(dirMarca).filter(f => /\.(webp|png|svg)$/.test(f))) {
  põe(`marca/${f}`, readFileSync(join(dirMarca, f)));
}

/* ============================================================
   grava ou confere
   ============================================================ */
function igual(rel, conteudo) {
  const p = join(saida, rel);
  if (!existsSync(p)) return false;
  const atual = readFileSync(p);
  return Buffer.isBuffer(conteudo)
    ? atual.equals(conteudo)
    : atual.toString('utf8') === conteudo;
}

const divergentes = [...escritos].filter(([rel, c]) => !igual(rel, c)).map(([rel]) => rel);

/* arquivos que sobraram de uma geração anterior */
function listaExistentes(dir, prefixo = '') {
  if (!existsSync(dir)) return [];
  return readdirSync(dir, { withFileTypes: true }).flatMap(e =>
    e.isDirectory()
      ? listaExistentes(join(dir, e.name), prefixo + e.name + '/')
      : [prefixo + e.name]);
}
const orfaos = listaExistentes(saida).filter(r => !escritos.has(r));

if (soConfere) {
  if (divergentes.length || orfaos.length) {
    for (const r of divergentes) console.error(`✗ desatualizado: ${r}`);
    for (const r of orfaos) console.error(`✗ sobrando: ${r}`);
    console.error(`\nRode: node bundle.mjs`);
    process.exit(1);
  }
  console.log(`✓ ds-bundle/ em sincronia · ${escritos.size} arquivos`);
} else {
  if (existsSync(saida)) rmSync(saida, { recursive: true });
  for (const [rel, conteudo] of escritos) {
    const p = join(saida, rel);
    mkdirSync(dirname(p), { recursive: true });
    writeFileSync(p, conteudo);
  }
  const total = [...escritos].reduce((n, [rel]) => n + statSync(join(saida, rel)).size, 0);
  console.log(`✓ ds-bundle/ gerado · ${escritos.size} arquivos · ${(total / 1024).toFixed(0)}KB`);
  console.log(`  ${cards.length} cards em ${Object.keys(porGrupo).length} grupos`);
}
