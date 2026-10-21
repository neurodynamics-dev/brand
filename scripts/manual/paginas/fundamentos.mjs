import { pagina, sec, sub, assimEvite, pendente, lista, grade, cartao, tabela, figura, esc, FAMILIAS, rgb, contraste, PAPEL, FUNDO_ESCURO } from '../layout.mjs';

const CAPITULOS = [
  ['marca', 'A marca', 'Quem somos, como falamos e de onde vêm os nomes.'],
  ['assinaturas', 'Assinaturas', 'Imagotipo, ícone, símbolo, onda e selo: cada marca tem um lugar.'],
  ['cor', 'Cor', 'Quatro conjuntos, uma família por superfície, contraste medido.'],
  ['tipografia', 'Tipografia', 'Operacional por padrão, executiva só em documentos formais.'],
  ['elementos', 'Elementos gráficos', 'Fundo, superfícies, formas, padrões e movimento.'],
  ['redacao', 'Redação', 'Português primeiro, frase curta, números e códigos no formato certo.'],
];
const prox = i => CAPITULOS[i + 1] ? [`/fundamentos/${CAPITULOS[i + 1][0]}`, CAPITULOS[i + 1][1]] : undefined;
const pg = (i, o) => ({ rota: `/fundamentos/${CAPITULOS[i][0]}`, titulo: CAPITULOS[i][1], descricao: CAPITULOS[i][2], proximo: prox(i), ...o });

/* ---------- a marca ---------- */
function marca() {
  const corpo =
    sec('quem', 'Quem somos', `<p>A NeuroDynamics desenvolve ferramentas de tecnologia para a saúde: neurotecnologia, análise de sinais clínicos e plataformas internas de pesquisa. Funciona como uma startup, a partir do LABBIO, na Escola de Engenharia da UFMG, em Belo Horizonte.</p>`)
    + sec('tom', 'Como falamos', `<p>Calmo, profissional e cuidadoso. Direto, sem enfeite: o texto orienta uma ação ou registra um fato.</p>`
      + assimEvite('Documento emitido.', 'Pronto! Seu documento saiu na hora, no padrão da NRO.'))
    + sec('nomes', 'De onde vêm os nomes', `<p>As cores têm nomes do sistema nervoso. O verde da marca é <b>Cortex</b>; seu tom principal é <b>Axon</b>; a centelha é <b>Synapse</b>, usada com parcimônia. Os neutros são <b>Sulco</b>, <b>Pia</b> e <b>Medula</b>. As famílias secundárias seguem a ideia: Ion, Neuron, Glia, Retina, Nexo, Dendrito, Lúmen, Ritmo, Impulso, Plexo e Íris.</p>`)
    + sec('dominios', 'Dois domínios', `<p>O manual cobre duas coisas, cada uma com as suas regras.</p>` + grade([
      cartao('Documentos', 'Peças que se leem, imprimem ou apresentam: relatórios, certificados, convites, apresentações, redes sociais. Usam o conjunto primário, ou o formal em ocasiões solenes.'),
      cartao('Interface', 'Telas de produto: site, Portal do Membro, ERP e ferramentas internas. Sempre escuras, no conjunto primário, com o conjunto funcional para estados.')], 'duas'));
  return pagina(pg(0, { corpo, toc: [['quem', 'Quem somos'], ['tom', 'Como falamos'], ['nomes', 'Os nomes'], ['dominios', 'Dois domínios']] }));
}

/* ---------- assinaturas ---------- */
const marcaTile = (img, nome, desc, fundo) => `<div class="m-marca"><div class="pano ${fundo}"><img src="/assets/${img}" alt="${esc(nome)}" loading="lazy"></div><div class="info"><b>${esc(nome)}</b><span>${desc}</span></div></div>`;
function assinaturas() {
  const corpo =
    sec('imagotipo', 'Imagotipo', `<p>A assinatura principal: preto, branco, ou nos tons de uma única família. Nunca em Synapse, nunca esticado. O arquivo branco é um desenho próprio, de traço vazado: não inverta o preto.</p>`
      + `<div class="m-marcas">${marcaTile('logo-imagotipo-white.png', 'Branco', 'Sobre fundos escuros.', 'escuro')}${marcaTile('logo-imagotipo-black.png', 'Preto', 'Sobre fundos claros.', 'claro')}${marcaTile('logo-imagotipo-cortex-light.png', 'Em tons de uma família', 'Cortex light sobre Cortex, por exemplo.', 'cortex')}</div>`
      + assimEvite('Arquivo branco original sobre Cortex.', 'Inverter o arquivo preto, esticar, aplicar Synapse ou usar duas famílias.'))
    + sec('icone', 'Ícone quadrado', `<p>Substitui o imagotipo quando ele não cabe: menu recolhido, favicon, avatar pequeno. Fica pequeno e na cor do título. Nunca grande, centralizado, em cor contrastante, nem repetido ao lado do imagotipo.</p>`
      + `<div class="m-marcas">${marcaTile('icon-square-solid-white.png', 'Ícone branco', 'Fundos escuros.', 'escuro')}${marcaTile('icon-square-solid-black.png', 'Ícone preto', 'Fundos claros.', 'claro')}</div>`)
    + sec('simbolo', 'Símbolo', `<p>Mantém o verde original. Só em molduras redondas, como a foto de perfil. Nunca recolorido nem reenquadrado, e não entra em apresentações.</p>`
      + `<div class="m-marcas">${marcaTile('icon-colored-transparent.png', 'Símbolo', 'Molduras redondas.', 'escuro')}</div>`)
    + sec('onda', 'Onda branca', `<p>Só em sistemas internos, como o ícone do ERP e ferramentas da equipe. Nunca em material público.</p>`
      + `<div class="m-marcas">${marcaTile('icon-monochromatic.png', 'Onda branca', 'Uso interno.', 'escuro')}</div>`)
    + sec('selo', 'Selo solene', `<p>A onda dentro de uma coroa de louros, para certificados, diplomas e atos oficiais. Axon sobre papel claro, ou branco sobre Cortex.</p>`
      + `<div class="m-marcas">${marcaTile('seal-axon.png', 'Selo Axon', 'Sobre papel claro.', 'claro')}${marcaTile('seal-white.png', 'Selo branco', 'Sobre Cortex.', 'cortex')}</div>`)
    + sec('colocacao', 'Onde a marca aparece', `<p>O logo não vai em toda página. Em apresentações, aparece só na capa e na contracapa; as páginas de conteúdo levam o rodapé (nome da apresentação, número da página e “Proprietário e confidencial”), sem logo. Uma marca por lugar.</p>`
      + assimEvite('Logo legível, sem texto ou fotografia por baixo.', 'Logo sobre imagem carregada, ou repetido em todas as páginas.')
      + pendente('Tamanho mínimo (em mm e em px) e a unidade da área de proteção ainda não foram definidos pelo responsável pela marca. Sugestão em estudo: usar a altura do ícone quadrado como unidade. Enquanto isso, preserve espaço livre ao redor e confira a leitura no tamanho final.'));
  return pagina(pg(1, { corpo, toc: [['imagotipo', 'Imagotipo'], ['icone', 'Ícone quadrado'], ['simbolo', 'Símbolo'], ['onda', 'Onda branca'], ['selo', 'Selo solene'], ['colocacao', 'Onde aparece']] }));
}

/* ---------- cor ---------- */
const NOMES = { cortex: 'Cortex', sulco: 'Sulco', pia: 'Pia', medula: 'Medula', ion: 'Ion', neuron: 'Neuron', glia: 'Glia', retina: 'Retina', nexo: 'Nexo', dendrito: 'Dendrito', lumen: 'Lúmen', ritmo: 'Ritmo', impulso: 'Impulso', plexo: 'Plexo', iris: 'Íris',
  'fn-nominal': 'Nominal (sucesso)', 'fn-caution': 'Caution (alerta)', 'fn-critical': 'Critical (erro, destrutivo)', 'fn-signal': 'Signal (informação, ao vivo)', 'fn-idle': 'Idle (offline, desativado)' };
const TONS = ['light', 'medium', 'primary', 'dark', 'accent'];
const ROT = { light: 'light', medium: 'medium', primary: 'primary', dark: 'dark', accent: 'accent' };
const fam = (id, extra = '') => {
  const f = FAMILIAS[id]; if (!f) return '';
  const tons = TONS.filter(t => f[t]).map(t => {
    const claro = contraste(f[t], FUNDO_ESCURO) > contraste(f[t], PAPEL);
    const nome = id === 'cortex' ? { primary: 'Axon', dark: 'Cortex', accent: 'Synapse' }[t] : '';
    return `<button type="button" class="m-ton ${claro ? 'k-claro' : 'k-escuro'}" style="background:var(--${id}-${t})" data-copiar="${f[t]}" title="Copiar ${f[t]}"><span class="t">${ROT[t]}${nome ? ', ' + nome : ''}</span><span class="h">${f[t]}</span><span class="r">${rgb(f[t]).join(', ')}</span></button>`;
  }).join('');
  return `<div class="m-fam"><h3>${NOMES[id]}${extra}</h3><div class="m-tons">${tons}</div></div>`;
};
const C = id => FAMILIAS[id];
function cor() {
  const ink = C('pia').light, nevoa = C('pia').primary, grafite = C('sulco').light, void_ = C('sulco').dark, painel = C('sulco').primary;
  const pares = [
    ['Tinta (Pia light) sobre Void', ink, void_, 'Texto principal em interfaces escuras'],
    ['Névoa (Pia primary) sobre Void', nevoa, void_, 'Texto secundário'],
    ['Grafite (Sulco light) sobre Void', grafite, void_, 'Só rótulos e legendas, nunca texto corrido'],
    ['Synapse sobre Void', C('cortex').accent, void_, 'Foco, CTA e marcas pequenas'],
    ['Axon sobre Void', C('cortex').primary, void_, 'Linhas e indicadores, nunca texto'],
    ['Cortex sobre Synapse', C('cortex').dark, C('cortex').accent, 'Texto do botão sólido'],
    ['Branco sobre Axon', PAPEL, C('cortex').primary, 'Pareamento do primary Cortex'],
    ['Cortex sobre Cortex light', C('cortex').dark, C('cortex').light, 'Fundo claro, dark da família'],
    ['Axon sobre branco', C('cortex').primary, PAPEL, 'Acento em papel (no lugar do Synapse)'],
    ['Tinta sobre Painel', ink, painel, 'Texto em painéis elevados'],
  ];
  const linhas = pares.map(([n, a, b, uso]) => { const r = contraste(a, b); return [esc(n), `<span class="mono" style="font-family:var(--fm)">${r.toFixed(2).replace('.', ',')}:1</span>`, r >= 7 ? 'AAA' : r >= 4.5 ? 'AA' : r >= 3 ? 'AA grande' : 'Reprova', esc(uso)]; });
  const corpo =
    sec('conjuntos', 'Quatro conjuntos', `<p>Cada conjunto tem um papel. As famílias têm quatro tons (light, medium, primary, dark). Clique num tom para copiar o hex.</p>`
      + sub('Primário: Cortex', `<p>A assinatura. Axon é o tom principal e Synapse a centelha, só para destaques. É o único conjunto permitido em brilho, desfoque, gradiente, vidro e transparência.</p>` + fam('cortex'))
      + sub('Neutro', `<p>Sulco (fundos e tinta: legendas, tinta, painéis, void), Pia (cinzas frios) e Medula (papel quente).</p>` + fam('sulco') + fam('pia') + fam('medula'))
      + sub('Secundário, verdes e frios', `<p>Ion, Neuron e Glia lideram; Retina, Nexo e Dendrito são o contraponto azul-violeta.</p>` + ['ion', 'neuron', 'glia', 'retina', 'nexo', 'dendrito'].map(f => fam(f)).join(''))
      + sub('Secundário, quentes', `<p>Registro de primavera: claro e luminoso, nunca terroso.</p>` + ['lumen', 'ritmo', 'impulso', 'plexo', 'iris'].map(f => fam(f)).join(''))
      + sub('Funcional (só interface)', `<p>Estados de interface, com nomes fora do vocabulário da marca. São tons elétricos que nunca leem como identidade. Jamais em documentos, em peças da marca ou como capa. Em UI escura: o dark como fundo, o primary só em linhas e indicadores (nunca texto), o medium em rótulos e o light em valores.</p>` + ['fn-nominal', 'fn-caution', 'fn-critical', 'fn-signal', 'fn-idle'].map(f => fam(f)).join('')))
    + sec('regras', 'Regras de uso', lista([
      '<b>Uma família por superfície.</b> Uma peça usa uma família mais branco ou um neutro. Nunca duas famílias de matiz juntas. Nexo e Dendrito aparecem sempre em mais de um tom.',
      '<b>Uso chapado.</b> Famílias de marca, neutras e funcionais só em preenchimento, texto e linha. Brilho, gradiente, vidro e transparência são só do conjunto primário.',
      '<b>Pareamento.</b> Fundo claro com o dark da família. Fundo escuro com branco. Fundo primary com o dark da família, exceto Cortex, Retina e Nexo, que levam branco.',
      '<b>Secundárias em interface</b> são complemento: uma família pode tingir uma banda de destaque onde o conjunto primário não está em uso, nunca ao lado do Synapse ou de um CTA Cortex.',
      '<b>Composição.</b> Primário mais neutro é a composição principal; o Synapse é uma fatia minúscula. Fundos formais: branco, Medula light, Cortex light ou Cortex dark chapado. Synapse nunca como campo.'])
      + assimEvite('Um fundo Ion, texto Ion dark e botão Ion.', 'Ion e Ritmo na mesma peça, ou Synapse como fundo grande.'))
    + sec('contraste', 'Contraste', `<p>Razões de contraste calculadas dos tokens atuais (WCAG 2.1). O texto corrido precisa de 4,5:1 ou mais.</p>` + tabela(['Par', 'Razão', 'Nível', 'Uso'], linhas))
    + sec('impressao', 'Impressão', pendente('CMYK e Pantone ainda precisam ser definidos com um fornecedor gráfico. Os valores acima são digitais (hex e RGB).'));
  return pagina(pg(2, { corpo, toc: [['conjuntos', 'Quatro conjuntos'], ['regras', 'Regras de uso'], ['contraste', 'Contraste'], ['impressao', 'Impressão']] }));
}

/* ---------- tipografia ---------- */
function tipografia() {
  const corpo =
    sec('operacional', 'Modo operacional', `<p>O padrão: interfaces, canais digitais e toda a marca. Tudo em <b>Archivo</b> nos títulos e rótulos, <b>Instrument Sans</b> no texto corrido e <b>IBM Plex Mono</b> só em códigos e dados.</p>`
      + `<div class="m-esp"><small>Archivo, 500 a 700, títulos</small><span class="a">O próximo movimento.</span></div>`
      + `<div class="m-esp"><small>Instrument Sans, 400 e 500, texto</small><span class="b">Pesquisa e desenvolvimento de ferramentas para a saúde. Clareza, cuidado e precisão em cada decisão.</span></div>`
      + `<div class="m-esp"><small>IBM Plex Mono, códigos e dados</small><span class="c">NRO-PUB-002, 1.284, 0,94, ${C('cortex').primary}</span></div>`
      + tabela(['Papel', 'Fonte', 'Especificação'], [
        ['Display e títulos', 'Archivo 600', 'tracking −.025em no display, −.015em nos títulos; display com entrelinha 1,02'],
        ['Rótulos e eyebrows', 'Archivo 600, caixa alta', '9,5 a 11,5px, tracking .12 a .18em (.14em por padrão)'],
        ['Texto corrido', 'Instrument Sans 400 e 500', '15px, entrelinha 1,65; secundário no mesmo peso, um tom mais claro'],
        ['Dados e códigos', 'IBM Plex Mono', 'números em tabelas, leituras, hex, códigos de documento'],
        ['Números grandes', 'Archivo 300', 'widgets e quiosques']])
      + `<p>Escala: display <span class="mono" style="font-family:var(--fm)">clamp(40px, 6,8vw, 88px)</span>, h1 <span style="font-family:var(--fm)">clamp(36px, 6vw, 72px)</span>, h2 <span style="font-family:var(--fm)">clamp(26px, 3,8vw, 42px)</span>, texto 15px, pequeno 13,5px, rótulo 11px.</p>`)
    + sec('hierarquia', 'Hierarquia sem ruído', `<p>Texto secundário e subtítulos mantêm o peso do corpo e usam um tom mais claro da mesma família: nunca negrito, nunca itálico para dar ênfase. Maiúsculas só em rótulos.</p>`
      + assimEvite('Agenda da equipe, e embaixo “Compromissos desta semana.” em Névoa.', 'Título em mono ou subtítulo em negrito.'))
    + sec('mono', 'O papel do mono', `<p>IBM Plex Mono só para códigos e dados: códigos, leituras, números em tabelas e painéis, valores hex. Nunca em rótulos, títulos, datas, eyebrows ou itens de navegação. Uma hora ou uma contagem usada como dado pode ser mono; um título como “Hoje” nunca. Códigos não quebram entre linhas.</p>`)
    + sec('executivo', 'Modo executivo', `<p>Para ocasiões formais específicas: certificados, relatórios formais, convites, apresentações formais e cartões de visita. <b>Instrument Serif</b>, regular ou itálico e nunca em negrito, para títulos, nomes, numerais e citações; <b>Archivo Light 300</b> no corpo (10,5pt na impressão); Archivo 400 e 500 em rótulos e códigos.</p>`
      + `<div class="m-esp serif"><small>Instrument Serif</small><span class="a">Conhecimento que ganha alcance.</span><span class="b">Uma linguagem editorial para documentos de caráter formal.</span></div>`
      + assimEvite('Certificado, relatório formal, convite, cartão de visita.', 'Interface de produto, redes sociais, canais digitais ou este manual como voz principal.'))
    + sec('licenca', 'Uso e licença', `<p>Archivo, Instrument Sans, Instrument Serif e IBM Plex Mono vêm do Google Fonts, sob a licença SIL Open Font License. O texto é sempre alinhado à esquerda, nunca justificado (centralizado só em peças específicas, como o certificado clássico).</p>`);
  return pagina(pg(3, { corpo, toc: [['operacional', 'Operacional'], ['hierarquia', 'Hierarquia'], ['mono', 'O papel do mono'], ['executivo', 'Executivo'], ['licenca', 'Licença']] }));
}

/* ---------- elementos ---------- */
function elementos() {
  const corpo =
    sec('fundo', 'Fundo expressivo', `<p>Void na página, Painel nos cartões. A grade técnica de fundo e o blob de Cortex e Axon dão profundidade a superfícies do conjunto primário: cabeçalho, quiosque, capa. Brilho, desfoque e gradiente só em Cortex.</p>`)
    + sec('superficie', 'Superfície', `<p>Borda de 1px, raio de 18px e preenchimento de 3% de branco. Sem sombra decorativa para elevar cartões: a elevação é borda e superfície.</p>`
      + assimEvite('Cartão com borda de 1px sobre o Void.', 'Sombra pesada para “levantar” o cartão.'))
    + sec('banda', 'Banda de família', `<p>Uma família por banda, botão na mesma família, ícone grande e discreto na borda direita, por trás do texto. Nunca em Synapse. Só onde o conjunto primário não está em uso.</p>`)
    + sec('formas', 'Formas', tabela(['Elemento', 'Raio'], [['Botões e campos', '11px'], ['Cartões (base)', '18px'], ['Bandas e painéis grandes', '24px'], ['Chips', '6px, cerca de 26px de altura'], ['Pills de status e tags', '5px'], ['Contadores', '4px'], ['Registro formal', '2px']]) + `<p>Não existe formato pílula: nada interativo é uma pílula. Avatares e blobs podem ser círculos.</p>`
      + assimEvite('Seleção neutra, texto legível, foco em Synapse.', 'Todos os controles preenchidos em Synapse.'))
    + sec('padroes', 'Padrões', `<p>Rede, ondas, circuito e pulso transformam a linguagem neural em fundos. Cada um existe em desktop, celular, tablet e videochamada (veja em <a href="/downloads">Downloads</a>).</p>`
      + grade(['mesh:Rede', 'waves:Ondas', 'circuit:Circuito', 'pulse:Pulso'].map(x => { const [k, n] = x.split(':'); return `<figure class="m-fig"><img src="/assets/manual/wall-${k}.jpg" alt="Padrão ${n}" loading="lazy"><figcaption>${n}</figcaption></figure>`; })))
    + sec('dados', 'Dados e imagens', lista([
      'Texto à esquerda, números à direita, em mono. Linhas a 8%, cabeçalho a 16%, sem zebra.',
      'Um gráfico usa uma família. Barras de proporção usam os quatro tons dela.',
      'Comparações curtas em traços discretos (1,5px de traço e 4,5px de vão, pontas retas), nunca preenchimentos arredondados que viram elipses.',
      'Fotografia retangular, ou com raio de 18px, sem filtros. Em peças formais, só fotos fornecidas; sem duotone nem recorte ornamental.'])
      + `<p>Movimento: de 0,15 a 0,25 segundo, sem quique. A preferência por movimento reduzido sempre prevalece.</p>`);
  return pagina(pg(4, { corpo, toc: [['fundo', 'Fundo'], ['superficie', 'Superfície'], ['banda', 'Banda'], ['formas', 'Formas'], ['padroes', 'Padrões'], ['dados', 'Dados e imagens']] }));
}

/* ---------- redação ---------- */
function redacao() {
  const corpo =
    sec('principios', 'Dizer o necessário', `<p>Português do Brasil primeiro. Calmo, profissional e direto. O que precisa de explicação vai para um ícone de informação, não para um parágrafo no alto da tela.</p>`
      + assimEvite('Informe o motivo.', 'Conte para a gente por que você quer fazer isso.')
      + assimEvite('Não foi possível salvar: informe o título.', 'Algo deu errado!')
      + assimEvite('Salvar alterações', 'Clique no botão abaixo para salvar suas alterações.')
      + assimEvite('Nenhuma atividade aberta.', 'Você ainda não possui nenhuma atividade aberta neste momento.'))
    + sec('forma', 'A forma também informa', lista([
      'Caixa de frase nos títulos. Caixa alta só em rótulos (Archivo 600, espaçamento aberto).',
      'Sem emoji. Os únicos glifos são setas (→ ↓) e ✓ ! × i.',
      'Sem ponto médio nem travessão como separador: use vírgula, quebra de linha ou layout. O travessão só atribui uma citação.',
      'Texto alinhado à esquerda, nunca justificado.']))
    + sec('numeros', 'Números e datas', `<p>Separadores brasileiros: <span style="font-family:var(--fm)">1.284</span> participantes, <span style="font-family:var(--fm)">0,94</span> de precisão, 15 de outubro de 2026.</p>`)
    + sec('codigos', 'Códigos', `<p>Códigos de documento seguem o padrão <span style="font-family:var(--fm)">NRO-PUB-002</span>, <span style="font-family:var(--fm)">NRO-REL-2026-014</span>, e nunca quebram entre linhas. Em documento controlado, no alto à direita e alinhado à direita, vão o tipo do documento em caixa de frase e o código logo abaixo, na mesma fonte e tamanho: “Relatório técnico” e “NRO-PRO-010-5”.</p>`)
    + sec('registros', 'Dois registros, a mesma clareza', `<p>A interface orienta; o documento registra. Ambos dispensam explicações óbvias e usam estados vazios de uma linha.</p>`);
  return pagina(pg(5, { corpo, toc: [['principios', 'Dizer o necessário'], ['forma', 'A forma informa'], ['numeros', 'Números'], ['codigos', 'Códigos'], ['registros', 'Dois registros']] }));
}

export default function () {
  const indice = pagina({ rota: '/fundamentos', titulo: 'Fundamentos', descricao: 'As regras da marca, uma a uma: assinaturas, cor, tipografia, elementos gráficos e escrita.',
    corpo: grade(CAPITULOS.map(([k, t, d], i) => `<a class="card m-cartao" href="/fundamentos/${k}"><span class="mono" style="font-family:var(--fm);font-size:12px;color:var(--dim)">0${i + 1}</span><h3>${esc(t)}</h3><p>${esc(d)}</p></a>`)) });
  return [indice, marca(), assinaturas(), cor(), tipografia(), elementos(), redacao()];
}
