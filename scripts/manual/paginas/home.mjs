import { pagina, esc, EMAIL } from '../layout.mjs';
const portas = [
  ['/imprensa', 'Vou citar ou divulgar a NeuroDynamics', 'Textos prontos, logos e como escrever o nome.'],
  ['/aplicacoes', 'Vou produzir uma peça', 'Documentos, apresentações, redes sociais e crachás, com o modelo certo para cada uso.'],
  ['/interface', 'Vou construir um site ou sistema', 'Tokens, componentes, padrões de página e prompts para modelos de linguagem.'],
  ['/fundamentos', 'Quero entender a marca', 'Marcas, cor, tipografia, elementos gráficos e escrita.'],
];
const rapidos = [
  ['/assets/logo-imagotipo-white.png', 'Imagotipo branco', 'PNG, para fundos escuros'],
  ['/assets/logo-imagotipo-black.png', 'Imagotipo preto', 'PNG, para fundos claros'],
  ['/design-system/tokens.css', 'Tokens CSS', 'Cores, tipo, espaço e forma'],
  ['/design-system/neuro.css', 'Componentes CSS', 'Para interfaces escuras'],
  ['/downloads', 'Todos os downloads', 'Logos, wallpapers, modelos'],
];
export default function () {
  const hero = `<header class="m-hero"><div class="m-wrap"><span class="eyebrow">Manual da marca</span><h1>O que você veio fazer?</h1>
    <p class="m-lead">A NeuroDynamics desenvolve ferramentas de tecnologia para a saúde, no LABBIO, Escola de Engenharia da UFMG. Escolha o caminho e encontre regras, exemplos e arquivos.</p></div></header>`;
  const corpo = `<div class="m-portas">${portas.map(([h, t, d], i) => `<a class="m-porta" href="${h}"><span class="n">0${i + 1}</span><h2>${esc(t)}</h2><p>${esc(d)}</p><span class="seta">Abrir →</span></a>`).join('')}</div>
    <section class="m-sec" id="rapidos"><h2>Downloads rápidos</h2><div class="m-rapidos">${rapidos.map(([h, t, d]) => `<a class="m-tile" href="${h}"${/\.(png|css)$/.test(h) ? ' download' : ''}><b>${esc(t)}</b><span>${esc(d)}</span></a>`).join('')}</div></section>
    <section class="m-sec" id="versao"><h2>Versão e aprovação</h2>
      <p>Manual versão 3, outubro de 2026. Fala em português; as seções de imprensa trazem também inglês e francês.</p>
      <aside class="m-pend"><b>Pendente</b><p>Quem aprova peças novas e o fluxo de aprovação ainda dependem do responsável pela marca. Enquanto isso, fale com <a href="mailto:${EMAIL}">${EMAIL}</a>.</p></aside></section>`;
  return pagina({ rota: '/', titulo: 'Manual da marca', descricao: 'Tudo para usar a marca NeuroDynamics com segurança: imprensa, peças, interfaces e fundamentos.', hero, corpo });
}
