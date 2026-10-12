import { pagina, sec, grade, baixar, esc, cartao } from '../layout.mjs';
import { readdirSync } from 'node:fs';
import path from 'node:path';
import { raiz } from '../layout.mjs';
import { PECAS } from './aplicacoes.mjs';

/* Downloads em galeria: cada arquivo com a prévia, o nome e os botões.
   Só as marcas principais aparecem (imagotipo branco e preto); ícones, símbolos e as versões
   por família seguem em assets/, para quem precisa, mas não entram na página. */
const ls = (d, re) => readdirSync(path.join(raiz, d)).filter(f => re.test(f)).sort();
const FORMATOS = [['desktop', 'Desktop'], ['celular', 'Celular'], ['tablet', 'Tablet'], ['videochamada', 'Videochamada']];
const WALL = [['rede', 'Rede', 'wall-mesh'], ['ondas', 'Ondas', 'wall-waves'], ['circuito', 'Circuito', 'wall-circuit'], ['pulso', 'Pulso', 'wall-pulse']];
const mini = k => `/assets/manual/${k}.jpg`;

/* um item da galeria: prévia (foto que preenche ou logo sobre um fundo), título, linha de apoio e ações */
const item = ({ src, titulo, texto = '', acoes = '', fundo = '', logo = false }) =>
  `<article class="m-dl"><div class="m-dl-prev ${logo ? 'logo' : ''} ${fundo}"><img src="${esc(src)}" alt="" loading="lazy"></div>`
  + `<div class="m-dl-info"><h3>${esc(titulo)}</h3>${texto ? `<p>${texto}</p>` : ''}${acoes ? `<div class="m-baixas">${acoes}</div>` : ''}</div></article>`;
const galeria = itens => `<div class="m-galeria">${itens.join('')}</div>`;
const ver = (href, rot = 'Ver o modelo') => `<a class="btn ghost mini" href="${esc(href)}">${esc(rot)}</a>`;
const arquivos = p => (p.arquivos || []).filter(([h]) => h !== '/downloads').map(([h, n]) => baixar(h, n)).join('');

export default function () {
  const formatos = ls('downloads/wallpapers', /\.jpg$/);
  const APRES = PECAS.filter(p => p.grupo === 'Apresentações');
  const MODELOS = PECAS.filter(p => p.grupo !== 'Apresentações' && p.k !== 'wallpapers');

  const corpo =
    sec('marcas', 'Marcas', galeria([
      item({ src: '/assets/logo-imagotipo-white.png', titulo: 'Imagotipo branco', texto: 'Para fundos escuros. PNG transparente.', logo: true, fundo: 'escuro', acoes: baixar('/assets/logo-imagotipo-white.png', 'Baixar PNG') }),
      item({ src: '/assets/logo-imagotipo-black.png', titulo: 'Imagotipo preto', texto: 'Para fundos claros. PNG transparente.', logo: true, fundo: 'claro', acoes: baixar('/assets/logo-imagotipo-black.png', 'Baixar PNG') })]),
      'O imagotipo é a assinatura de uso geral. As demais versões e quando usar cada uma estão em <a href="/fundamentos/assinaturas">Fundamentos, Assinaturas</a>.')
    + sec('apresentacoes', 'Apresentações', galeria(APRES.map(p =>
      item({ src: mini(p.img[0]), titulo: p.n, texto: esc(p.d), acoes: arquivos(p) + ver(`/aplicacoes/${p.k}`, 'Ver os leiautes') }))))
    + sec('modelos', 'Modelos e exemplos de aplicação', galeria(MODELOS.map(p =>
      item({ src: mini(p.img[0]), titulo: p.n, texto: esc(p.d), acoes: arquivos(p) + ver(`/aplicacoes/${p.k}`) }))),
      'Peças prontas para abrir, preencher e imprimir. Cada uma tem as regras de uso na página do modelo.')
    + sec('fundos', 'Papéis de parede e capa', galeria([
      ...WALL.map(([k, n, m]) => item({ src: mini(m), titulo: n, texto: 'Desktop, celular, tablet e videochamada.',
        acoes: FORMATOS.filter(([f]) => formatos.includes(`${k}-${f}.jpg`)).map(([f, r]) => baixar(`/downloads/wallpapers/${k}-${f}.jpg`, r)).join('') })),
      item({ src: '/downloads/linkedin/capa.jpg', titulo: 'Capa do LinkedIn', texto: '1584 × 396.', acoes: baixar('/downloads/linkedin/capa.jpg', 'Baixar JPG') })]))
    + sec('tokens', 'Para interfaces', grade([
      cartao('Design system', 'Os mesmos arquivos que os sites e o SOMA usam.', `<div class="m-baixas">${[['/design-system/tokens.css', 'tokens.css'], ['/design-system/neuro.css', 'neuro.css'], ['/design-system/casca.css', 'casca.css'], ['/design-system/casca.js', 'casca.js']].map(([h, n]) => baixar(h, n)).join('')}</div>`)]));
  return pagina({ rota: '/downloads', titulo: 'Downloads', descricao: 'Marcas, apresentações, modelos e papéis de parede, com a prévia de cada um.', eyebrow: 'Arquivos', corpo,
    toc: [['marcas', 'Marcas'], ['apresentacoes', 'Apresentações'], ['modelos', 'Modelos'], ['fundos', 'Papéis de parede'], ['tokens', 'Interfaces']] });
}
