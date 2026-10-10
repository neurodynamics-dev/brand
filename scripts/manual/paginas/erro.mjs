import { pagina } from '../layout.mjs';
export default function () {
  const p = pagina({ rota: '/404', titulo: 'Página não encontrada', eyebrow: '404', descricao: 'Este caminho não existe no manual.',
    corpo: `<p><a class="btn" href="/">Voltar ao início</a> <a class="btn ghost" href="/fundamentos">Fundamentos</a></p>` });
  return { ...p, arquivo: '404.html' };
}
