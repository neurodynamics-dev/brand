import { pagina, sec, assimEvite, lista, esc, figura, baixar } from '../layout.mjs';

/* As peças do manual. Imagens em assets/manual; modelos em templates/. As regras vêm do readme do design system. */
export const PECAS = [
  { k: 'relatorio', n: 'Relatório formal', grupo: 'Documentos', modo: 'Executivo', img: ['relatorio-capa', 'relatorio-texto'], modelo: 'templates/formal-report/FormalReport.html',
    d: 'Capa e página de texto em A4 sobre branco, com cabeçalho de documento controlado.',
    quando: 'Relatórios técnicos e documentos formais que serão lidos, impressos ou assinados.',
    regras: ['A4, margens de 22mm.', 'Cabeçalho de documento controlado: no alto à direita, o tipo do documento e o código logo abaixo, na mesma fonte e tamanho.', 'Rótulos formais: kickers (filete, fólio, tinta) ou rótulo em Instrument Serif itálico; nunca mono em caixa alta.', 'Fotos só se fornecidas, retangulares e sem filtros.', 'Paleta: conjunto primário com neutros; Synapse só como acento minúsculo.'],
    assim: 'Código “NRO-REL-2026-014” abaixo do tipo do documento.', evite: 'Código em outra fonte, ou foto com filtro duotone.' },
  { k: 'carta-memorando', n: 'Carta e memorando', grupo: 'Documentos', modo: 'Ambos', img: ['timbre-executivo', 'timbre-operacional'], modelo: 'templates/letterhead/Letterhead.html',
    d: 'Papel timbrado em A4, nas versões executiva e operacional.', quando: 'Cartas oficiais (executivo) e comunicações internas do dia a dia (operacional).',
    regras: ['A versão executiva usa Instrument Serif nos títulos e Archivo Light no corpo.', 'A operacional usa Archivo e Instrument Sans.', 'Documento com código leva o cabeçalho de documento controlado.'],
    assim: 'Memorando interno na versão operacional.', evite: 'Misturar serifa executiva e texto operacional na mesma página.' },
  { k: 'documentos-registros', n: 'Documentos e registros', grupo: 'Documentos', modo: 'Operacional', img: ['relatorio-texto'], modelo: null, arquivos: [['/assets/NRO-PUB-002-template-documentos-e-registros.docx', 'NRO-PUB-002 em Word', 'DOCX']],
    d: 'O modelo Word da série de documentos e registros (NRO-PUB-002).', quando: 'Procedimentos, registros e documentos controlados da equipe.',
    regras: ['O código segue o padrão NRO-XXX-000 e nunca quebra entre linhas.', 'Documentos controlados circulam pelo Arquivos, no SOMA, que decide a versão em vigor e quem baixa.'],
    assim: 'Baixar o modelo pelo SOMA, na versão em vigor.', evite: 'Reaproveitar uma cópia antiga do arquivo.' },
  { k: 'certificado', n: 'Certificado clássico', grupo: 'Documentos', modo: 'Executivo', img: ['certificado'], modelo: 'templates/certificate/Certificate.html',
    d: 'A4 paisagem, composição clássica centralizada com o selo Axon.', quando: 'Certificados de participação e atos solenes.',
    regras: ['O cabeçalho traz o tipo do documento, “Certificado de participação”; o corpo não repete o título.', 'Cidade e data vêm logo após o parágrafo de participação, na mesma fonte e tamanho.', 'Selo Axon sobre papel claro; branco sobre Cortex.'],
    assim: 'Cidade e data depois do parágrafo, na mesma fonte.', evite: 'Repetir “Certificado” como título no corpo.' },
  { k: 'certificado-marca', n: 'Certificado da marca', grupo: 'Documentos', modo: 'Operacional', img: ['certificado-marca-ion'], modelo: 'templates/certificate-brand/CertificateBrand.html',
    d: 'A4 paisagem para aplicações mais simples: fundo claro de uma família e faixa lateral.', quando: 'Certificados de eventos e cursos fora do registro solene.',
    regras: ['Fundo claro da família, com faixa chapada à esquerda (um quinto da largura, Cortex com brilho).', 'Famílias: Cortex, Ion, Retina, Lúmen e Dendrito.', 'A opção de parceiro acrescenta o espaço do logo do parceiro e uma segunda assinatura.'],
    assim: 'Uma família por certificado.', evite: 'Duas famílias na mesma peça.' },
  { k: 'convite', n: 'Convite', grupo: 'Documentos', modo: 'Executivo', img: ['convite-cortex', 'convite-retina'], modelo: 'templates/invitation/Invitation.html',
    d: 'Quatro faces de cor (Cortex, Neuron, Retina, Dendrito) mais o verso com os detalhes.', quando: 'Eventos, aberturas e ocasiões institucionais.',
    regras: ['Uma face de cor por convite.', 'Os detalhes (data, local, programação) ficam no verso.'], assim: 'Título curto na frente, detalhes no verso.', evite: 'Detalhes na frente, competindo com o título.' },
  { k: 'cartao', n: 'Cartão de visita', grupo: 'Documentos', modo: 'Executivo', img: ['cartao-frente', 'cartao-verso'], modelo: 'templates/business-card/BusinessCard.html',
    d: '85 × 55 mm: frente em Cortex dark chapado, verso branco com o nome em serifa.', quando: 'Contato pessoal, eventos e visitas.',
    regras: ['Cartões de visita são sempre modo executivo.', 'Frente Cortex dark chapada.', 'Verso branco com o nome em Instrument Serif.'], assim: 'Frente chapada, sem brilho.', evite: 'Gradiente ou foto na frente.' },
  { k: 'apresentacao-formal', n: 'Apresentação formal', grupo: 'Apresentações', modo: 'Executivo', img: ['deck-formal-capa', 'deck-formal-numeros'], modelo: 'templates/formal-deck/FormalDeck.html', arquivos: [['/downloads/apresentacoes/formal-deck.pptx', 'Apresentação formal', 'PPTX']],
    d: '16:9, com 7 capas e 17 leiautes. Só cores do conjunto primário e neutro.', quando: 'Reuniões institucionais e apresentações a conselhos e parceiros.',
    regras: ['Páginas de conteúdo levam o rodapé (nome da apresentação, número da página e “Proprietário e confidencial”), sem logo.', 'O logo aparece só na capa e na contracapa.', 'Páginas de cor cheia apenas nos conjuntos primário e neutro.'], assim: 'Logo só na capa e na contracapa.', evite: 'Logo em todas as páginas.' },
  { k: 'apresentacao-marca', n: 'Apresentação da marca', grupo: 'Apresentações', modo: 'Operacional', img: ['deck-marca-capa', 'deck-marca-grafico', 'deck-marca-paineis'], modelo: 'templates/brand-deck/BrandDeck.html', arquivos: [['/downloads/apresentacoes/brand-deck.pptx', 'Apresentação da marca', 'PPTX']],
    d: '16:9, com 7 capas e 17 leiautes e a paleta expandida.', quando: 'Apresentações expressivas de projetos e da equipe.',
    regras: ['Páginas de cor cheia só nos conjuntos primário e neutro; outras famílias entram como painéis sobre branco, em vários tons.', 'Rodapé nas páginas de conteúdo, sem logo.'], assim: 'Família secundária em painel sobre branco.', evite: 'Página inteira numa família secundária.' },
  { k: 'social', n: 'Redes sociais', grupo: 'Digital', modo: 'Operacional', img: ['social-feed-cortex', 'social-feed-retina', 'social-story', 'social-linkedin'], modelo: 'templates/social/Social.html', arquivos: [['/downloads/linkedin/capa.jpg', 'Capa do LinkedIn', 'JPG 1584 × 396']],
    d: 'Feed 1080 × 1350 (Cortex expressivo e família com foto), story 1080 × 1920 e capa do LinkedIn 1584 × 396.', quando: 'Publicações da equipe e da instituição.',
    regras: ['Modo operacional (Archivo e Instrument Sans).', 'Uma família por peça.', 'Foto só se fornecida, sem filtro.'], assim: 'Feed em Cortex com título curto.', evite: 'Emoji e ponto médio nas legendas das artes.' },
  { k: 'email', n: 'Boletim e comunicado', grupo: 'Digital', modo: 'Operacional', img: ['email-boletim', 'email-comunicado-retina'], modelo: 'templates/email/Boletim.html', arquivos: [['/templates/email/Boletim.html', 'Boletim (Cortex)', 'HTML'], ['/templates/email/Comunicado.html', 'Comunicado (Cortex)', 'HTML'], ['/templates/email/Cabecalhos.html', 'Sete cabeçalhos', 'HTML']],
    d: 'E-mails prontos para envio: 600px, em tabelas e estilos embutidos.', quando: 'Boletim da equipe e comunicados internos.',
    regras: ['Há sete blocos de cabeçalho, o Boletim e o Comunicado em Cortex, e versões em cada família secundária (pasta variantes), com o logo recolorido por família.', 'A data fica no cabeçalho; títulos nunca em negrito.', 'As células de imagem trazem comentários SWAP para trocar pelos endereços hospedados.'], assim: 'Uma família por e-mail, com o logo na mesma família.', evite: 'Trocar a família só no botão.' },
  { k: 'cracha', n: 'Crachá', grupo: 'Ambientes', modo: 'Operacional', img: ['cracha-sinal', 'cracha-retrato', 'cracha-ficha'], modelo: 'templates/badges/Badges.html',
    d: 'CR80 em três propostas (A Sinal, B Retrato, C Ficha), com frente, verso e a versão de visitante.', quando: 'Identificação de membros e visitantes no laboratório.',
    regras: ['A Sinal: campo de onda e faixa de função em Synapse. B Retrato: foto de página inteira com painel em degraus. C Ficha: ficha técnica com marcas de registro.', 'Foto só se fornecida.'], assim: 'Uma proposta só por lote de crachás.', evite: 'Foto com filtro.' },
  { k: 'wallpapers', n: 'Wallpapers', grupo: 'Ambientes', modo: 'Operacional', img: ['wall-mesh', 'wall-waves', 'wall-circuit', 'wall-pulse'], modelo: 'templates/wallpapers/Wallpapers.html', arquivos: [['/downloads', 'Os 16 arquivos prontos', 'Downloads']],
    d: 'Quatro estilos (rede, ondas, circuito, pulso) em desktop, celular, tablet e videochamada.', quando: 'Fundo de tela e de videochamada da equipe.',
    regras: ['Campo cheio em conjunto primário.', 'Desktop 2560 × 1440, celular 1179 × 2556, tablet 2048 × 2732, videochamada 1920 × 1080.'], assim: 'Videochamada com o fundo da equipe.', evite: 'Recortar um wallpaper de desktop para o celular.' },
  { k: 'posters', n: 'Cartazes', grupo: 'Ambientes', modo: 'Operacional', img: ['poster-sinal', 'poster-simplicidade', 'poster-pcb', 'poster-blocos'], modelo: 'templates/posters/Posters.html',
    d: 'Quatro cartazes de frases e quatro desenhos técnicos do sistema NeuroAmp-32, em retrato e paisagem.', quando: 'Ambientes do laboratório e eventos.',
    regras: ['Os desenhos técnicos têm blocos de título e de revisão no estilo de projeto.', 'Uma família por cartaz.'], assim: 'Uma família por cartaz.', evite: 'Duas famílias no mesmo cartaz.' },
];
const GRUPOS = ['Documentos', 'Apresentações', 'Digital', 'Ambientes'], MODOS = ['Operacional', 'Executivo'];
const img = k => `/assets/manual/${k}.jpg`;

function catalogo() {
  const chips = (g, vals) => vals.map(v => `<button type="button" class="chip" data-grupo="${g}" data-valor="${v}" aria-pressed="false">${v}</button>`).join('');
  const cards = PECAS.map(p => `<a class="m-peca" href="/aplicacoes/${p.k}" data-q="${esc((p.n + ' ' + p.d + ' ' + p.grupo).toLowerCase())}" data-tipo="${p.grupo}" data-modo="${p.modo}"><img src="${img(p.img[0])}" alt="" loading="lazy"><div class="info"><b>${esc(p.n)}</b><span>${esc(p.grupo)}, modo ${p.modo.toLowerCase()}</span></div></a>`).join('');
  const corpo = `<div class="m-filtros"><div class="fld busca"><label for="m-busca">Buscar</label><input id="m-busca" type="search" placeholder="Relatório, crachá, e-mail" autocomplete="off"></div>
    <div role="group" aria-label="Tipo" style="display:flex;gap:6px;flex-wrap:wrap">${chips('tipo', GRUPOS)}</div><div role="group" aria-label="Modo" style="display:flex;gap:6px;flex-wrap:wrap">${chips('modo', MODOS)}</div>
    <span class="total" aria-live="polite"></span></div>
    <div class="m-cat" data-catalogo>${cards}</div>
    <div class="m-vazio vazio"><p>Nenhuma peça com esse filtro.</p><button class="btn ghost mini" id="m-limpar" type="button">Limpar filtros</button></div>`;
  return pagina({ rota: '/aplicacoes', titulo: 'Aplicações', descricao: 'O modelo certo para cada peça: documentos, apresentações, canais digitais e ambientes.', corpo });
}

function ficha(p) {
  const arqs = [...(p.modelo ? [[`/${p.modelo}`, 'Abrir o modelo', 'HTML']] : []), ...(p.arquivos || [])];
  const dl = arqs.length ? `<div class="card m-dl">${arqs.map(([h, n, t]) => `<div class="item"><span>${esc(n)}<small>${esc(t)}</small></span><a class="btn ghost mini" href="${esc(h)}"${/\.(pptx|docx|jpg)$/.test(h) ? ' download' : ''}>${/\.(pptx|docx|jpg)$/.test(h) ? 'Baixar' : 'Abrir'}</a></div>`).join('')}</div>` : '';
  const corpo = `<div class="m-ficha"><div>
    ${sec('uso', 'Quando usar', `<p>${esc(p.quando)}</p>` + p.img.map(k => figura(img(k), `${p.n}: exemplo`)).join(''))}
    ${sec('regras', 'Regras desta peça', lista(p.regras.map(esc)))}
    ${sec('assim', 'Assim e evite', assimEvite(esc(p.assim), esc(p.evite)))}</div>
    <aside class="lateral"><div class="card m-dl"><div class="item"><span>Tipo<small>${esc(p.grupo)}</small></span></div><div class="item"><span>Modo<small>${esc(p.modo)}</small></span></div></div>${dl ? '<div style="height:16px"></div>' + dl : ''}</aside></div>`;
  return pagina({ rota: `/aplicacoes/${p.k}`, titulo: p.n, descricao: p.d, eyebrow: 'Aplicações', corpo,
    proximo: (() => { const i = PECAS.indexOf(p); const q = PECAS[i + 1]; return q ? [`/aplicacoes/${q.k}`, q.n] : ['/aplicacoes', 'Todas as aplicações']; })() });
}
export default () => [catalogo(), ...PECAS.map(ficha)];
