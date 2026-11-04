import { pagina, sec, grade, baixar, esc, cartao } from '../layout.mjs';
import { readdirSync, readFileSync } from 'node:fs';
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
const galeria = (itens, classe = '') => `<div class="m-galeria ${classe}">${itens.join('')}</div>`;

/* As capas de LinkedIn (downloads/linkedin/index.json): fotos do banco de imagens do SOMA.
   "perfil" é o banner de cada pessoa, com a logo; "empresa" é a capa da página da NeuroDynamics.
   O SOMA (Marca, Capas do LinkedIn) lê o mesmo manifesto. */
const LINKEDIN = JSON.parse(readFileSync(path.join(raiz, 'downloads/linkedin/index.json'), 'utf8')).capas;
const GRUPOS_LI = [['en', 'foto', 'Em inglês, a foto inteira', 'Uma frase só, no espaço calmo da foto.'],
  ['en', 'faixa', 'Em inglês, foto e faixa', 'A foto e o painel chapado de uma família.'],
  ['pt', 'faixa', 'Em português', 'A foto, o painel chapado e o tema.']];
const capaLi = c => item({ src: '/' + c.previa, titulo: c.frase, fundo: 'faixa',
  texto: `Foto: ${esc(c.foto.autor)} / ${esc(c.foto.banco)}`,
  acoes: baixar('/' + c.perfil.arquivo, 'Perfil') + baixar('/' + c.empresa.arquivo, 'Página da empresa') });
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
    + sec('fundos', 'Papéis de parede', galeria(
      WALL.map(([k, n, m]) => item({ src: mini(m), titulo: n, texto: 'Desktop, celular, tablet e videochamada.',
        acoes: FORMATOS.filter(([f]) => formatos.includes(`${k}-${f}.jpg`)).map(([f, r]) => baixar(`/downloads/wallpapers/${k}-${f}.jpg`, r)).join('') }))))
    + sec('linkedin', 'Capas do LinkedIn', GRUPOS_LI.map(([idioma, estilo, titulo, texto]) => {
        const lista = LINKEDIN.filter(c => c.idioma === idioma && c.estilo === estilo);
        return lista.length ? `<h3 class="m-sub">${esc(titulo)}</h3><p class="m-sub-lead">${esc(texto)}</p>${galeria(lista.map(capaLi), 'larga')}` : '';
      }).join('')
      + `<h3 class="m-sub">Do modelo social</h3>${galeria([item({ src: '/downloads/linkedin/capa.jpg', titulo: 'Tools for health.', fundo: 'faixa',
        texto: 'O banner do modelo de redes sociais.', acoes: baixar('/downloads/linkedin/capa.jpg', 'Perfil') })], 'larga')}`,
      'Para o perfil de cada pessoa, com a logo (1584 × 396), e para a página da NeuroDynamics (1128 × 191). Os arquivos vêm no dobro do tamanho, para ficarem nítidos em telas de alta densidade. No perfil, o canto de baixo à esquerda fica sob a sua foto: ali vai só foto. As fotos são do <a href="https://membro.neurodynamics.dev/#/marca/fotos">banco de imagens do SOMA</a>, com o crédito em <a href="/downloads/linkedin/index.json">index.json</a>.')
    + sec('tokens', 'Para interfaces', grade([
      cartao('Design system', 'Os mesmos arquivos que os sites e o SOMA usam.', `<div class="m-baixas">${[['/design-system/tokens.css', 'tokens.css'], ['/design-system/neuro.css', 'neuro.css'], ['/design-system/casca.css', 'casca.css'], ['/design-system/casca.js', 'casca.js']].map(([h, n]) => baixar(h, n)).join('')}</div>`)]));
  return pagina({ rota: '/downloads', titulo: 'Downloads', descricao: 'Marcas, apresentações, modelos, papéis de parede e capas do LinkedIn, com a prévia de cada um.', eyebrow: 'Arquivos', corpo,
    toc: [['marcas', 'Marcas'], ['apresentacoes', 'Apresentações'], ['modelos', 'Modelos'], ['fundos', 'Papéis de parede'], ['linkedin', 'LinkedIn'], ['tokens', 'Interfaces']] });
}
