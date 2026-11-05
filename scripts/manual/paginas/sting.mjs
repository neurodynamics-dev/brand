import { existsSync, statSync } from 'node:fs';
import path from 'node:path';
import { pagina, sec, sub, tabela as tabelaBase, lista, assimEvite, esc, baixar, raiz, FAMILIAS } from '../layout.mjs';

/* O sting, a assinatura em vídeo. Os vídeos ficam em assets/sting, com o nome
   NeuroDynamics-sting-<fundo>-<formato>-<resolução>.mp4, e o pacote com todos eles e o README
   em NeuroDynamics-sting.zip. As regras vêm de assets/sting/README; mudou lá, muda aqui. */
const PASTA = 'assets/sting';
export const FUNDOS = [['claro', 'Fundo branco'], ['escuro', 'Fundo verde']];
export const FORMATOS = [['16x9', 'Horizontal', 'YouTube, sites, projeção, apresentações'], ['9x16', 'Vertical inteira', 'Reels, Stories, Shorts, TikTok'],
  ['4x5', 'Vertical de feed', 'Feed do Instagram e do LinkedIn'], ['1x1', 'Quadrada', 'Feeds que aceitam vídeo quadrado']];
export const RESOLUCOES = ['4K', '8K'];
const existe = rel => { if (!existsSync(path.join(raiz, rel))) throw new Error(`sting: falta ${rel}`); return '/' + rel; };
export const video = (fundo, formato, res) => existe(`${PASTA}/NeuroDynamics-sting-${fundo}-${formato}-${res}.mp4`);
export const PACOTE = existe(`${PASTA}/NeuroDynamics-sting.zip`);
export const MB = href => (statSync(path.join(raiz, href)).size / 1e6).toLocaleString('pt-BR', { maximumFractionDigits: 1 }) + ' MB';
export const previa = fundo => `/assets/manual/sting-${fundo}.jpg`;
const c = s => `<code>${esc(s)}</code>`;
const VERDE = FAMILIAS.cortex.dark;
/* tabelas de texto: as células quebram linha */
const tabela = (cab, linhas) => tabelaBase(cab, linhas, 'texto');

export function fichaSting(p, proximo) {
  const player = ([f, n]) => `<figure class="m-fig"><video controls playsinline preload="none" poster="${previa(f)}" aria-label="Sting, ${n.toLowerCase()}, 16x9"><source src="${video(f, '16x9', '4K')}" type="video/mp4"></video><figcaption>${esc(n)}, ${c('16x9')}</figcaption></figure>`;
  const corpo = `
    ${sec('previa', 'Prévia', `<p>A logo aparece sobre um fundo limpo, sincronizada a quatro notas de piano, em 7,27 s. Use o arquivo pronto, sem alterar imagem, som ou duração, exceto pelo corte descrito em <a href="#como">Como usar</a>.</p>`
      + `<div class="m-videos">${FUNDOS.map(player).join('')}</div>`
      + `<div class="m-baixas">${baixar(PACOTE, `Pacote completo (ZIP, 4K e 8K, ${MB(PACOTE)})`)}<a class="btn ghost mini" href="#arquivos">Escolher um arquivo</a></div>`)}
    ${sec('uso', 'Quando usar', `<p>Use o sting uma vez por vídeo, na abertura ou no encerramento. O encerramento é o padrão. A abertura é exceção, para quando o público já escolheu assistir.</p>`
      + tabela(['Posição', 'Quando usar', 'Exemplos'], [
        ['Encerramento (padrão)', 'Em todo vídeo oficial, salvo os casos de abertura', 'Demonstrações, redes sociais, anúncios, vídeos de até 1 min'],
        ['Abertura (exceção)', 'Em vídeos com mais de 1 min e público já atento', 'Exibição em evento, aula, pitch gravado, vídeo institucional']])
      + `<p>Em vídeos para redes sociais, comece pelo conteúdo, não pelo sting. Se a abertura for necessária, coloque o sting depois de um trecho curto do vídeo.</p>`
      + `<p>Não use em conteúdo que não seja da NeuroDynamics ou que ela não tenha aprovado. Em cortes de até 15 s, avalie se os 7,27 s do sting cabem no vídeo.</p>`)}
    ${sec('versao', 'Como escolher a versão', `<p>Escolha nesta ordem: o fundo pelo conteúdo, o formato pelo destino e a resolução pelo projeto de edição. Nos nomes dos arquivos, ${c('claro')} é o fundo branco e ${c('escuro')} é o fundo verde (${VERDE}). Exemplo: ${c('NeuroDynamics-sting-escuro-16x9-4K.mp4')}.</p>`
      + sub('Fundo', tabela(['Fundo', 'Nome do arquivo', 'Use quando o conteúdo for', 'Exemplos'], [
        ['Branco', c('claro'), 'Calmo e visualmente limpo, com foco em saúde e cuidado', 'Demonstrações em ambientes médicos, hospital, clínica, uso do dispositivo com pessoas'],
        ['Verde', c('escuro'), 'Técnico e cheio de movimento, com foco em engenharia', 'Bancada, prototipagem, testes, bastidores, competições, eventos, institucional']])
        + `<p>Se o vídeo tiver os dois tipos de conteúdo, escolha pelo plano que fica ao lado do sting.</p>`)
      + sub('Formato', `<p>O formato do sting deve ser igual ao do vídeo.</p>` + tabela(['Formato', 'Proporção na tela', 'Destino'], FORMATOS.map(([f, pr, d]) => [c(f), pr, d])))
      + sub('Resolução', `<p>Use 4K como padrão. Ela abre em mais programas e serve para qualquer projeto de até 4K.</p>` + tabela(['Versão', 'Quando usar', 'Limite'], [
        ['4K, H.264', 'Padrão para edição, publicação e envio', 'Não atende projetos em 8K'],
        ['8K, HEVC', 'Projetos em 8K e arquivo de maior qualidade', 'Exige programa com suporte a HEVC 10-bit e computador capaz de reproduzir 8K']])))}
    ${sec('como', 'Como usar', `<ol class="m-passos">${[
        'Crie o projeto de edição no formato final do vídeo.',
        'Coloque o arquivo correspondente na abertura ou no encerramento, ocupando a tela inteira.',
        'Faça um corte seco entre o sting e o vídeo. O sting já começa e termina no fundo limpo, sem logo.',
        'Deixe o piano como som principal. Durante o sting, retire voz e efeitos e mantenha a música em silêncio ou bem abaixo do piano.',
        'Exporte e confira o trecho final: logo nítida, tempo original e piano audível.'].map(t => `<li>${t}</li>`).join('')}</ol>`
      + sub('Referência de tempo', tabela(['Tempo', 'O que acontece'], [
        ['0 a 1,03 s', 'Fundo em silêncio. O piano entra em 1,03 s'], ['1,35 s', 'O símbolo começa a surgir'], ['2,05 s', 'O nome começa a ser revelado'],
        ['3,10 s a 5,40 s', 'Logo completa em tela'], ['5,40 s a 6,40 s', 'A logo some em fade'], ['6,40 s a 7,27 s', 'Fundo em silêncio']])
        + `<p>Se precisar encurtar, corte só o fundo em silêncio: até 1 s no início e até 0,8 s no fim. O restante fica intacto.</p>`)
      + sub('Áudio', `<p>O pico do piano fica em −12,3 dBFS. Se houver outro som durante o sting, mantenha-o pelo menos 12 dB abaixo, ou seja, com pico em até −24 dBFS. Nesse trecho, nenhum som deve competir com o piano.</p>`)
      + sub('Thumbnail', `<p>Não use a logo como thumbnail.</p>` + lista([
        '<b>Redes sociais:</b> use uma captura de um momento dinâmico do vídeo, para gerar interesse em quem vê.',
        '<b>Conteúdo institucional, como aulas e apresentações:</b> crie a thumbnail no Studio.'])))}
    ${sec('evite', 'O que não fazer', assimEvite('Sting no encerramento, no formato do vídeo, em tela cheia, com corte seco e o piano como som principal.', `Um ${c('9x16')} centralizado num vídeo ${c('16x9')}, ou música e voz por cima do piano.`)
      + sub('Imagem', lista(['Não distorça, estique, gire ou recorte o sting.', `Não use um formato dentro de outro, como um ${c('9x16')} ou ${c('1x1')} centralizado em vídeo ${c('16x9')}, com barras ou fundo preenchido.`,
        'Não reduza o sting a uma janela na tela. Ele ocupa o quadro inteiro.', 'Não amplie uma versão de resolução menor para um projeto maior.', 'Não aplique filtros, correção de cor, sombras, molduras ou texto.',
        'Não sobreponha legendas, marcas, logos de parceiros ou outros elementos.', 'Não troque as cores nem o fundo.']))
      + sub('Tempo', lista(['Não altere a velocidade de reprodução.', 'Não inverta, repita em loop nem congele quadros.', 'Não corte a animação nem o piano. Corte só o fundo em silêncio.', 'Não use transições sobre a logo. Se precisar de um fade, faça-o só no fundo.']))
      + sub('Áudio', lista(['Não deixe música, voz ou efeitos sobressaírem ao piano.', 'Não substitua o piano, separe-o da imagem nem altere sua afinação.', 'Não remova o áudio, exceto onde a plataforma ou o local de exibição não tiver som.']))
      + sub('Arquivo', lista(['Não recrie a logo ou a animação em outro programa.', 'Não reexporte um vídeo já comprimido para gerar uma nova versão. Volte ao arquivo original.'])))}
    ${sec('especificacoes', 'Especificações', tabela(['Versão', ...FORMATOS.map(([f]) => `${c(f)} (px)`), 'Quadros', 'Vídeo'], [
        ['8K', '7680 × 4320', '4320 × 7680', '4320 × 5400', '4320 × 4320', '60 fps', 'HEVC 10-bit'],
        ['4K', '3840 × 2160', '2160 × 3840', '2160 × 2700', '2160 × 2160', '60 fps', 'H.264 8-bit']])
      + `<p>Todos os arquivos têm 7,27 s, contêiner MP4 e áudio AAC.</p><p>Programas e navegadores sem suporte a HEVC 10-bit podem abrir a versão 8K sem imagem. Nesse caso, use a versão 4K.</p>`)}
    ${sec('arquivos', 'Arquivos', tabela(['Formato', 'Destino', ...FUNDOS.map(([, n]) => n)], FORMATOS.map(([f, , d]) =>
        [c(f), d, ...FUNDOS.map(([fu]) => `<div class="m-baixas">${RESOLUCOES.map(r => baixar(video(fu, f, r), r)).join('')}</div>`)]))
      + `<p>O pacote traz os 16 vídeos e o README, em pastas por resolução e fundo.</p><div class="m-baixas">${baixar(PACOTE, `Baixar o pacote (ZIP, ${MB(PACOTE)})`)}</div>`)}`;
  return pagina({ rota: `/aplicacoes/${p.k}`, titulo: p.n, descricao: p.d, eyebrow: 'Aplicações', corpo, proximo,
    toc: [['previa', 'Prévia'], ['uso', 'Quando usar'], ['versao', 'Escolher a versão'], ['como', 'Como usar'], ['evite', 'O que não fazer'], ['especificacoes', 'Especificações'], ['arquivos', 'Arquivos']] });
}
