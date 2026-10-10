import { pagina, sec, grade, baixar, esc, lista } from '../layout.mjs';
import { readdirSync } from 'node:fs';
import path from 'node:path';
import { raiz } from '../layout.mjs';

const ls = (d, re) => readdirSync(path.join(raiz, d)).filter(f => re.test(f)).sort();
const NOMES = { rede: 'Rede', ondas: 'Ondas', circuito: 'Circuito', pulso: 'Pulso', desktop: 'Desktop', celular: 'Celular', tablet: 'Tablet', videochamada: 'Videochamada' };
const rot = f => f.replace(/\.[a-z]+$/, '').split('-').map(p => NOMES[p] || p).join(', ');

const cartaoLinks = (titulo, texto, itens) => `<article class="card m-cartao"><h3>${esc(titulo)}</h3><p>${texto}</p><div class="m-baixas">${itens.map(([h, n]) => baixar(h, n)).join('')}</div></article>`;

export default function () {
  const logos = ls('assets', /^(logo-imagotipo-(white|black)|icon-[a-z-]+)\.png$/).map(f => [`/assets/${f}`, f.replace(/\.png$/, '').replace(/-/g, ' ')]);
  const paleta = ls('assets', /^logo-imagotipo-[a-z]+-(dark|light)\.png$/).map(f => [`/assets/${f}`, f.replace(/^logo-imagotipo-|\.png$/g, '').replace('-', ' ')]);
  const wall = ls('downloads/wallpapers', /\.jpg$/).map(f => [`/downloads/wallpapers/${f}`, rot(f)]);
  const corpo =
    sec('logos', 'Logos e ícones', '', '') + grade([
      cartaoLinks('Marcas principais', 'Imagotipo e ícones em PNG. Escolha pelo fundo.', logos),
      cartaoLinks('Marcas por família', 'Uma versão clara e uma escura de cada família de cor.', paleta)])
    + sec('tokens', 'Para interfaces', '', '') + grade([
      cartaoLinks('Design system', 'Os mesmos arquivos que os sites e o SOMA usam.', [['/design-system/tokens.css', 'tokens.css'], ['/design-system/neuro.css', 'neuro.css'], ['/design-system/casca.css', 'casca.css'], ['/design-system/casca.js', 'casca.js']])])
    + sec('apresentacoes', 'Apresentações', '', '') + grade([
      cartaoLinks('Modelos PowerPoint', 'Apresentação da marca (operacional) e apresentação formal (executiva).', [['/downloads/apresentacoes/brand-deck.pptx', 'Apresentação da marca'], ['/downloads/apresentacoes/formal-deck.pptx', 'Apresentação formal']])])
    + sec('documentos', 'Documentos', '', '') + grade([
      cartaoLinks('Modelo de documento', 'Documentos e registros (NRO-PUB-002), em Word.', [['/assets/NRO-PUB-002-template-documentos-e-registros.docx', 'Baixar .docx']]),
      cartaoLinks('Modelos em HTML', 'Papel timbrado, relatório, certificado, convite, cartão, crachás e e-mails. Abra e imprima.', [['/aplicacoes', 'Ver Aplicações']])])
    + sec('fundos', 'Papéis de parede e capa', '', '') + grade([
      cartaoLinks('Papéis de parede', 'Quatro padrões em quatro formatos, para tela, celular, tablet e videochamada.', wall),
      cartaoLinks('LinkedIn', 'Capa 1584 × 396.', [['/downloads/linkedin/capa.jpg', 'Capa']])]);
  return pagina({ rota: '/downloads', titulo: 'Downloads', descricao: 'Todos os arquivos do manual em um só lugar.', eyebrow: 'Arquivos', corpo,
    toc: [['logos', 'Logos'], ['tokens', 'Interfaces'], ['apresentacoes', 'Apresentações'], ['documentos', 'Documentos'], ['fundos', 'Fundos']] });
}
