import { pagina, sec, sub, assimEvite, lista, grade, cartao, tabela, bloco, baixar, esc, copiar } from '../layout.mjs';

const SUBS = [
  ['comecar', 'Começar', 'Instale os arquivos e abra uma página base.'],
  ['regras', 'Regras', 'O contrato das interfaces, em português.'],
  ['componentes', 'Componentes', 'O que existe, com o HTML para copiar.'],
  ['padroes', 'Padrões de página', 'Os templates de tela do SOMA e de site.'],
  ['prompts', 'Prompts', 'Instruções prontas para modelos de linguagem.'],
];
const nx = i => SUBS[i + 1] ? [`/interface/${SUBS[i + 1][0]}`, SUBS[i + 1][1]] : undefined;
const pg = (i, o) => ({ rota: `/interface/${SUBS[i][0]}`, titulo: SUBS[i][1], descricao: SUBS[i][2], eyebrow: 'Interface', proximo: nx(i), ...o });
const prev = (html, cls = '') => `<div class="m-prev ${cls}">${html}</div>`;
const par = (titulo, previa, codigo) => sub(titulo, prev(previa) + bloco(codigo, 'Copiar HTML'));

/* ---------- começar ---------- */
const BASE = `<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Minha tela | NeuroDynamics</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Archivo:wght@300;400;500;600;700&family=IBM+Plex+Mono:wght@400;500&family=Instrument+Sans:wght@400;500;600&display=swap">
<link rel="stylesheet" href="ds/tokens.css">
<link rel="stylesheet" href="ds/neuro.css">
<link rel="stylesheet" href="ds/casca.css"><!-- só se usar o cabeçalho e o rodapé dos sites -->
</head>
<body>
  <main class="container">
    <header class="cab">
      <span class="eyebrow">Meu espaço</span>
      <div class="cab-linha"><h1>Título da tela</h1>
        <div class="cab-acoes"><button class="btn solid">Ação principal</button></div></div>
    </header>
    <section class="card">Conteúdo.</section>
  </main>
</body>
</html>`;
function comecar() {
  const corpo =
    sec('arquivos', 'Os arquivos', `<p>O design system é CSS puro: não precisa de build nem de framework. Baixe os arquivos e coloque numa pasta <span style="font-family:var(--fm)">ds/</span> do projeto. Não edite as cópias; peça a mudança ao responsável pelo manual.</p>`
      + tabela(['Arquivo', 'Para quê', ''], [
        ['<span style="font-family:var(--fm)">tokens.css</span>', 'Cores, tipografia, espaço, forma, movimento e o tema claro', baixar('/design-system/tokens.css')],
        ['<span style="font-family:var(--fm)">neuro.css</span>', 'Componentes: botões, campos, navegação, dados, feedback, templates de tela', baixar('/design-system/neuro.css')],
        ['<span style="font-family:var(--fm)">casca.css, casca.js</span>', 'Cabeçalho, menu do celular e rodapé dos sites', baixar('/design-system/casca.css', 'CSS') + ' ' + baixar('/design-system/casca.js', 'JS')],
        ['<span style="font-family:var(--fm)">select.css, select.js</span>', 'O select próprio, no lugar da lista nativa', baixar('/design-system/select.css', 'CSS') + ' ' + baixar('/design-system/select.js', 'JS')],
        ['<span style="font-family:var(--fm)">formal.css</span>', 'Só para documentos no modo executivo', baixar('/design-system/formal.css')]]))
    + sec('base', 'Uma página base', `<p>Interfaces são sempre escuras: Void na página, painéis elevados, com o cabeçalho único no alto. Comece por aqui e troque o conteúdo.</p>` + bloco(BASE, 'Copiar página'))
    + sec('tema', 'Tema claro', `<p>Opcional, por escolha de quem usa. Marque o <span style="font-family:var(--fm)">&lt;html data-tema="claro"&gt;</span>: os papéis de cor trocam e os componentes não mudam. O Synapse deixa de ser texto e linha e vira Axon.</p>`)
    + sec('fontes', 'Fontes', `<p>Archivo, Instrument Sans e IBM Plex Mono vêm do Google Fonts (licença SIL Open Font License). Use o link da página base.</p>`);
  return pagina(pg(0, { corpo, toc: [['arquivos', 'Os arquivos'], ['base', 'Página base'], ['tema', 'Tema claro'], ['fontes', 'Fontes']] }));
}

/* ---------- regras ---------- */
function regras() {
  const corpo =
    sec('naonegociavel', 'O que não se negocia', lista([
      'Void na página, Painel nos cartões; cartões com borda de 1px e raio de 18px. Sem sombra para elevar.',
      'Synapse é raro: foco, o único CTA sólido e marcas pequenas (barra da aba, contador de pendência). Nunca preenchimento de seleção, estado, área grande ou banda de família.',
      'Brilho, desfoque, gradiente, vidro e transparência: só no conjunto primário. As outras famílias são chapadas.',
      'Cores funcionais (Nominal, Caution, Critical, Signal, Idle) só para estados. Nunca identidade ou decoração.',
      'Archivo em títulos e rótulos, Instrument Sans no texto, Plex Mono só em códigos e dados.',
      'Sem formato pílula, sem emoji, sem ponto médio, sem travessão como separador.',
      'Ações utilitárias só com ícone; rótulo sempre visível nos campos.',
      'Alvos de toque de 44px ou mais no celular. Respeite a preferência por movimento reduzido.']))
    + sec('navegacao', 'Navegação', `<p>A hierarquia vem sempre nesta ordem, nunca invertida:</p>` + lista([
      '<b>SectionNav</b> é o primeiro seletor de uma tela.', '<b>Abas</b> ficam dentro de uma seção.', '<b>Segmentado</b> serve a um filtro exclusivo.', '<b>FilterBar</b> serve quando várias opções ficam ativas (OU dentro de um grupo, E entre grupos), com os valores ativos como tags removíveis.'])
      + `<p>Sites usam o cabeçalho flutuante de vidro; apps usam o menu lateral (252px aberto, 68px recolhido). Em apps, o cabeçalho de tela é único: eyebrow com o nome do espaço, título num tamanho só, voltar nas telas de objeto, e no máximo um botão sólido.</p>`)
    + sec('formularios', 'Formulários', lista(['Rótulo sempre visível acima do campo (Archivo 600, caixa alta). O placeholder é um exemplo, nunca o rótulo.', 'Borda sempre presente (16%). Foco: borda Synapse e véu de 4%. Erro: borda Critical e uma dica que diz como corrigir.', 'Select nunca nativo: lista própria sobre Painel, com opções de 34px.', 'Botões com verbo (“Baixar PNG”), nunca um “OK” solto. Um sólido Synapse por tela; ghost para o resto; perigo (Critical) para destrutivo.']))
    + sec('dados', 'Dados', lista(['Números em Plex Mono, à direita; texto à esquerda. Linhas a 8%, cabeçalho a 16%, sem zebra.', 'Um gráfico, uma família. Comparações curtas em traços discretos.', 'Use Métrica para um número com variação, Tabela de dados para listas e Lista de pares para chave e valor. A tabela de documento é só de papel.']))
    + sec('feedback', 'Feedback', lista(['Toast para confirmação passageira (4,2 s), nunca para uma decisão. Diálogo para decisões. Alerta dentro da página.', 'Estado vazio sempre com uma ação. Esqueleto quando se sabe a forma; giro quando não se sabe.', 'Cor sozinha nunca carrega significado: junte texto ou ícone.']))
    + sec('checklist', 'Checklist de entrega', tabela(['Violação', 'Correção'], [
      ['Synapse em seleção, status, área grande ou banda', 'Seleção quieta (9% e tinta); cor funcional para estado; cor da família na banda'],
      ['Plex Mono em rótulo, eyebrow, navegação ou título', 'Archivo 600 caixa alta para rótulos; Instrument Sans para texto'],
      ['Ponto médio, travessão ou barra como separador', 'Vírgula, quebra de linha, vão ou elementos separados'],
      ['Chip, tag ou botão em formato pílula', 'Chip de 6px, tag de 5px, botão de 11px'],
      ['Brilho ou gradiente em cor secundária ou funcional', 'Só o conjunto primário; o resto é chapado'],
      ['Duas famílias de matiz numa superfície', 'Uma família mais neutros'],
      ['Hex, raio ou fonte escritos à mão', 'Token (var(--axon), var(--r), var(--fd))'],
      ['Campo sem rótulo visível ou sem borda', 'Rótulo em caixa alta e borda de 16%'],
      ['Select nativo', 'Lista própria'],
      ['Dois botões sólidos Synapse na tela', 'Um; o resto vira ghost'],
      ['Hierarquia invertida (abas acima do SectionNav)', 'SectionNav, abas, depois segmentado ou FilterBar'],
      ['Alvo de toque abaixo de 44px no celular', 'Aumente a área de toque'],
      ['Sombra para elevação', 'Borda e tom de superfície'],
      ['Idioma visível no cabeçalho fechado do celular', 'Só com o menu aberto'],
      ['Emoji ou unicode decorativo', 'Remova; use ✓ ! × i e setas'],
      ['Movimento sem alternativa de movimento reduzido', 'Envolva em prefers-reduced-motion']]))
    + sec('completa', 'Referência completa', `<p>O contrato completo, com a lista de componentes e os cartões visuais, está em inglês no repositório do design system.</p><div class="acts">${baixar('/design-system/v3/interface-rules.md', 'interface-rules.md')}</div>`);
  return pagina(pg(1, { corpo, toc: [['naonegociavel', 'Não se negocia'], ['navegacao', 'Navegação'], ['formularios', 'Formulários'], ['dados', 'Dados'], ['feedback', 'Feedback'], ['checklist', 'Checklist'], ['completa', 'Referência']] }));
}

/* ---------- componentes ---------- */
function componentes() {
  const corpo =
    `<p class="m-lead">Cada exemplo é o componente real, com o CSS do design system. Copie o HTML e não reestilize: componha.</p>`
    + sec('botoes', 'Botões', par('Variantes', `<button class="btn solid">Ação principal</button><button class="btn ghost">Secundária</button><button class="btn danger">Excluir</button><button class="btn ghost mini">Pequeno</button><button class="btn ghost" disabled>Desativado</button>`, `<button class="btn solid">Ação principal</button>\n<button class="btn ghost">Secundária</button>\n<button class="btn danger">Excluir</button>\n<button class="btn ghost mini">Pequeno</button>`)
      + `<p>Um sólido Synapse por tela. Ghost para o resto. Perigo para destrutivo.</p>`)
    + sec('campos', 'Campos', par('Campo com rótulo', `<div class="fld" style="min-width:260px"><label for="ex1">E-mail</label><input id="ex1" placeholder="voce@neurodynamics.dev"></div><div class="fld" style="min-width:260px"><label for="ex2">Nome</label><input id="ex2" value="Ana"></div>`, `<div class="fld">\n  <label for="email">E-mail</label>\n  <input id="email" placeholder="voce@neurodynamics.dev">\n</div>`))
    + sec('navegacao', 'Navegação', par('SectionNav', `<nav class="nav1"><a class="on" href="#">Para você</a><a href="#">Todos</a><a href="#">Meus certificados</a></nav>`, `<nav class="nav1" aria-label="Seções">\n  <a class="on" aria-current="page" href="#/para-voce">Para você</a>\n  <a href="#/todos">Todos</a>\n</nav>`)
      + par('Abas', `<nav class="abas"><a class="on" href="#">Geral</a><a href="#">Predefinidos</a><a href="#">Google Agenda</a></nav>`, `<nav class="abas" aria-label="Recortes">\n  <a class="on" href="#/geral">Geral</a>\n  <a href="#/predefinidos">Predefinidos</a>\n</nav>`)
      + par('Segmentado', `<div class="seg" role="group" aria-label="Situação"><button class="on" aria-pressed="true">Todos</button><button aria-pressed="false">Publicados</button><button aria-pressed="false">Arquivados</button></div>`, `<div class="seg" role="group" aria-label="Situação">\n  <button class="on" aria-pressed="true">Todos</button>\n  <button aria-pressed="false">Publicados</button>\n</div>`))
    + sec('status', 'Chips, pills e alertas', par('Chip e pills', `<span class="chip on">Escolhido</span><span class="chip">Opção</span><span class="pill p-ok"><span class="dt dt-ok"></span>Ativo</span><span class="pill p-warn"><span class="dt dt-warn"></span>Pendente</span>`, `<span class="chip on">Escolhido</span>\n<span class="pill p-ok"><span class="dt dt-ok"></span>Ativo</span>`)
      + par('Alerta', `<div class="alerta a-vital"><span class="ic" aria-hidden="true">✓</span><div><b>Reporte enviado</b><p>As publicações entram no feed da equipe.</p></div></div>`, `<div class="alerta a-vital">\n  <span class="ic" aria-hidden="true">✓</span>\n  <div><b>Reporte enviado</b><p>As publicações entram no feed.</p></div>\n</div>`))
    + sec('superficies', 'Cartão, métrica e banda', par('Cartão', `<div class="card" style="min-width:260px"><h3>Atividade</h3><p class="muted">Borda de 1px, raio de 18px.</p></div>`, `<div class="card">\n  <h3>Atividade</h3>\n  <p>Borda de 1px, raio de 18px.</p>\n</div>`)
      + par('Métrica', `<div class="metricas"><div class="metrica"><span class="rot">Membros ativos</span><span class="val">42</span></div><div class="metrica"><span class="rot">Presença média</span><span class="val">0,94</span></div></div>`, `<div class="metrica">\n  <span class="rot">Membros ativos</span>\n  <span class="val">42</span>\n</div>`))
    + sec('feedback', 'Vazio e esqueleto', par('Estado vazio, com ação', `<div class="vazio" style="flex:1;min-width:260px"><p>Nenhuma atividade com esse filtro.</p><button class="btn ghost mini">Limpar filtros</button></div>`, `<div class="vazio">\n  <p>Nenhuma atividade com esse filtro.</p>\n  <button class="btn ghost mini">Limpar filtros</button>\n</div>`))
    + sec('mais', 'E o resto', `<p>Também existem Diálogo, Toast, Progresso, Tabela de dados, Barras, Widget, Menu lateral e o cabeçalho único de tela. Eles estão no CSS (<span style="font-family:var(--fm)">neuro.css</span>) e nos cartões de referência do design system.</p>`);
  return pagina(pg(2, { corpo, toc: [['botoes', 'Botões'], ['campos', 'Campos'], ['navegacao', 'Navegação'], ['status', 'Chips e alertas'], ['superficies', 'Cartão e métrica'], ['feedback', 'Vazio'], ['mais', 'E o resto']] }));
}

/* ---------- padrões ---------- */
const tpl = (sigla, nome, anat, onde) => cartao(`${sigla}, ${nome}`, anat, `<p style="margin-top:8px"><b>Onde:</b> ${onde}</p>`);
function padroes() {
  const corpo =
    sec('cabecalho', 'O cabeçalho único', `<p>Toda tela de app abre com o mesmo cabeçalho: voltar (ou trilha) quando é uma tela de objeto, o eyebrow com o nome do espaço, o título e as ações na mesma linha, a linha de meta (código em Plex Mono, situação) e, só se for preciso, uma linha de apoio. O SectionNav vem logo abaixo, sempre no mesmo lugar.</p>`
      + lista(['O eyebrow é sempre o espaço do menu: nunca um slogan, uma trilha ou um código.', 'O título é o nome da tela ou do objeto, num tamanho só, sem repetir o eyebrow.', 'Voltar só em objeto e subtela; seção irmã não tem voltar, tem o SectionNav.', 'No máximo um botão sólido.']))
    + sec('apps', 'Templates de app', `<p>Toda tela de um sistema é um destes, com a mesma largura, o mesmo topo e os mesmos estados (carregando com esqueleto, vazio com ação, erro que diz o que fazer).</p>` + grade([
      tpl('L', 'Lista', 'Cabeçalho, SectionNav, barra de ferramentas (busca, filtros, total) e tabela ou grade de tiles.', 'quadros de pessoal, arquivos, projetos'),
      tpl('O', 'Objeto', 'Voltar ou trilha, cabeçalho com código e situação, duas colunas: o principal e a lateral com os pares de chave e valor.', 'ficha, projeto, arquivo'),
      tpl('F', 'Fluxo', 'Voltar, cabeçalho, etapas (progresso, nunca SectionNav), coluna única e uma barra de ações fixa: salvamento à esquerda, ação principal à direita.', 'reporte, novo projeto, pedido'),
      tpl('P', 'Painel', 'Cabeçalho, grade de widgets e métricas, no máximo uma banda de destaque.', 'início, presença, painéis'),
      tpl('E', 'Leitura', 'Cabeçalho e uma coluna de leitura de 720px, com itens separados por linha.', 'feed, notas de versão'),
      tpl('A', 'Ajustes', 'Cabeçalho, SectionNav e linhas de ajuste: rótulo e dica à esquerda, controle à direita.', 'configurações'),
      tpl('T', 'Área de trabalho', 'Cabeçalho de uma linha, e o conteúdo na largura toda.', 'quadro de atividades, agenda')]))
    + sec('sites', 'Templates de site', grade([
      cartao('S1, Capa', 'Cabeçalho de vidro, uma capa curta (no máximo 56% da altura) com eyebrow em Archivo, título e apoio, depois as seções.'),
      cartao('S2, Capítulo', 'Coluna de leitura, índice “Nesta página” à esquerda a partir de 1100px e o próximo capítulo no fim.'),
      cartao('S3, Catálogo', 'Cabeçalho, filtros, total e a grade de tiles; o vazio traz “Limpar filtros”.'),
      cartao('S4, Ficha', 'Prévia grande e lateral com os dados e os downloads.'),
      cartao('S5, Formulário', 'Etapas, coluna única e um CTA.')]));
  return pagina(pg(3, { corpo, toc: [['cabecalho', 'Cabeçalho único'], ['apps', 'Templates de app'], ['sites', 'Templates de site']] }));
}

/* ---------- prompts ---------- */
const PROMPTS = [
  ['construir-tela', 'Construir uma tela', `Leia o arquivo interface-rules.md do design system da NeuroDynamics (disponível em https://brand.neurodynamics.dev/design-system/v3/interface-rules.md).

Construa a tela [NOME] para [Portal do Membro | ERP | site], usando o CSS existente (tokens.css e neuro.css) e sem criar estilos novos.

Ação principal: [VERBO]. Ela recebe o único botão sólido Synapse.
Template de página: [Lista | Objeto | Fluxo | Painel | Leitura | Ajustes | Área de trabalho].

Regras: modo operacional (Archivo, Instrument Sans, Plex Mono só em dados); interface escura; Synapse só em foco e no CTA; estados com o conjunto funcional; textos em português do Brasil, em caixa de frase; sem emoji, ponto médio ou travessão como separador.

Entregue um arquivo HTML que roda sozinho e o resultado do checklist de entrega.`],
  ['corrigir-tela', 'Corrigir uma tela', `Leia o arquivo interface-rules.md do design system da NeuroDynamics.

Audite o arquivo [ARQUIVO] contra o checklist de entrega, liste cada violação com o número da seção e corrija só o que viola uma regra. Mantenha o layout e o texto como estão. Troque cores, raios e fontes escritos à mão por tokens.`],
  ['peca-documento', 'Criar uma peça', `Você produz peças da marca NeuroDynamics. Leia o manual em https://brand.neurodynamics.dev.

Escolha primeiro o registro: expressivo (escuro, grade, brilho) para peças digitais e internas; formal (papel, serifa, filete Cortex) para documentos, relatórios, convites e certificados.

Crie [PEÇA] com uma única família de cor mais neutros, sem emoji, sem ponto médio e sem travessão como separador, números no formato 1.284 e 0,94 e códigos no padrão NRO-XXX-000. Entregue a peça e liste as regras do manual que aplicou.`],
];
function prompts() {
  const corpo = `<p class="m-lead">Cole no seu assistente e preencha o que está entre colchetes. Os três apontam para as regras publicadas aqui.</p>`
    + PROMPTS.map(([k, t, texto]) => sec(k, t, bloco(texto, 'Copiar prompt'))).join('');
  return pagina(pg(4, { corpo, toc: PROMPTS.map(([k, t]) => [k, t]), proximo: undefined }));
}
export default function () {
  const indice = pagina({ rota: '/interface', titulo: 'Interface', descricao: 'Para quem constrói sites e sistemas na identidade da NeuroDynamics: arquivos, regras, componentes e padrões de página.',
    corpo: grade(SUBS.map(([k, t, d], i) => `<a class="card m-cartao" href="/interface/${k}"><span class="mono" style="font-family:var(--fm);font-size:12px;color:var(--dim)">0${i + 1}</span><h3>${esc(t)}</h3><p>${esc(d)}</p></a>`)) });
  return [indice, comecar(), regras(), componentes(), padroes(), prompts()];
}
