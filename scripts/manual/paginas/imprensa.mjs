import { pagina, sec, sub, lista, grade, pendente, copiar, baixar, esc, EMAIL, assimEvite } from '../layout.mjs';

const TEXTOS = [
  ['Português', 'pt', 'A NeuroDynamics é uma iniciativa sem fins lucrativos de pesquisa e desenvolvimento em tecnologia para a saúde, na Escola de Engenharia da Universidade Federal de Minas Gerais (UFMG). Software, firmware, sistemas embarcados e IA a serviço da saúde humana.'],
  ['English', 'en', 'NeuroDynamics is a nonprofit health-tech research and development initiative at the School of Engineering of the Federal University of Minas Gerais (UFMG). Software, firmware, embedded systems and AI in service of human health.'],
  ['Français', 'fr', "NeuroDynamics est une initiative à but non lucratif de recherche et développement en technologies de la santé, à l'École d'Ingénierie de l'Université Fédérale du Minas Gerais (UFMG). Logiciel, firmware, systèmes embarqués et IA au service de la santé humaine."],
];
const LOGOS = [
  ['Imagotipo branco', '/assets/logo-imagotipo-white.png', 'Para fundos escuros'],
  ['Imagotipo preto', '/assets/logo-imagotipo-black.png', 'Para fundos claros'],
  ['Ícone colorido', '/assets/icon-colored-transparent.png', 'Fundo transparente'],
  ['Ícone monocromático', '/assets/icon-monochromatic.png', 'Uma cor, para carimbos e impressão simples'],
];

export default function () {
  const corpo =
    sec('texto', 'Sobre a NeuroDynamics', `<p>Use o texto como está. Ele já existe nos três idiomas do site.</p>`
      + `<div class="m-textos">${TEXTOS.map(([n, l, t]) => `<article class="card m-cartao"><h3>${n}</h3><p lang="${l}">${esc(t)}</p>${copiar(t)}</article>`).join('')}</div>`)
    + sec('nome', 'Como escrever o nome', `<p>Escreva <b>NeuroDynamics</b>, junto, com N e D maiúsculos. Na primeira menção, acrescente o vínculo: “NeuroDynamics, iniciativa da Escola de Engenharia da UFMG”.</p>`
      + assimEvite('NeuroDynamics', 'Neurodynamics, Neuro Dynamics, NEURODYNAMICS, ND')
      + assimEvite('o LABBIO, Escola de Engenharia, UFMG', 'laboratório da NeuroDynamics na UFMG, sem citar o LABBIO'))
    + sec('logos', 'Logos para publicação', `<p>Escolha pelo fundo da peça. Não recolora, não distorça, não aplique sombra. As demais assinaturas estão em <a href="/fundamentos/assinaturas">Fundamentos, Assinaturas</a>.</p>`
      + grade(LOGOS.map(([n, src, d]) => `<article class="card m-cartao"><div class="m-logo-prev"><img src="${src}" alt="${esc(n)}" loading="lazy"></div><h3>${esc(n)}</h3><p>${esc(d)}</p>${baixar(src, 'Baixar PNG')}</article>`)))
    + sec('uso', 'Antes de publicar', lista([
      'Logo inteiro, em fundo com contraste. Ao redor, deixe espaço livre.',
      'Citações e números vêm de fonte da equipe. Em dúvida, pergunte.',
      'Fotos de pessoas só com autorização. Sem emoji nem pontos médios nos textos.',
      'Peças prontas ficam em <a href="/aplicacoes">Aplicações</a>.']))
    + sec('cobranding', 'Co-branding e parcerias', pendente('As regras de uso conjunto com logos de parceiros (proporção, espaço, ordem) dependem do responsável pela marca. Não monte lockups por conta própria: envie a peça para revisão.'))
    + sec('contato', 'Contato de imprensa', `<p>Pedidos de entrevista, material e aprovação de peças: <a href="mailto:${EMAIL}">${EMAIL}</a> ${copiar(EMAIL)}</p><p>LABBIO, Escola de Engenharia, UFMG. Belo Horizonte, MG, Brasil.</p>`);
  return pagina({ rota: '/imprensa', titulo: 'Imprensa', descricao: 'Textos prontos, logos e orientações para citar ou divulgar a NeuroDynamics.', eyebrow: 'Para quem divulga',
    corpo, toc: [['texto', 'Sobre'], ['nome', 'O nome'], ['logos', 'Logos'], ['uso', 'Antes de publicar'], ['cobranding', 'Co-branding'], ['contato', 'Contato']] });
}
