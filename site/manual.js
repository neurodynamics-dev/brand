/* Manual da marca: copiar, índice do capítulo e filtros do catálogo. Sem JS o conteúdo continua lendo. */
(function () {
  var $$ = function (s, r) { return Array.prototype.slice.call((r || document).querySelectorAll(s)); };
  /* copiar */
  document.addEventListener('click', function (e) {
    var b = e.target.closest('[data-copiar]'); if (!b) return;
    var t = b.dataset.copiar, antes = b.textContent;
    var ok = function () { b.textContent = 'Copiado'; b.classList.add('feito'); setTimeout(function () { b.textContent = antes; b.classList.remove('feito'); }, 1600); };
    if (navigator.clipboard) navigator.clipboard.writeText(t).then(ok, function () { window.prompt('Copie:', t); }); else window.prompt('Copie:', t);
  });
  /* índice: marca a seção visível */
  var links = $$('.m-toc a');
  if (links.length && 'IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (es) {
      es.forEach(function (x) { if (x.isIntersecting) links.forEach(function (a) { a.classList.toggle('on', a.getAttribute('href') === '#' + x.target.id); }); });
    }, { rootMargin: '-20% 0px -70% 0px' });
    $$('.m-sec').forEach(function (s) { io.observe(s); });
  }
  /* catálogo: busca e filtros por grupo (chips). Cada item traz data-tipo, data-modo e data-q. */
  var cat = document.querySelector('[data-catalogo]'); if (!cat) return;
  var itens = $$('[data-q]', cat), busca = document.getElementById('m-busca'), vazio = document.querySelector('.m-vazio'), total = document.querySelector('.m-filtros .total');
  var ativo = {};
  function aplicar() {
    var q = (busca && busca.value || '').toLowerCase().trim(), n = 0;
    itens.forEach(function (i) {
      var ok = (!q || i.dataset.q.indexOf(q) > -1) && Object.keys(ativo).every(function (g) { return !ativo[g] || i.dataset[g] === ativo[g]; });
      i.hidden = !ok; if (ok) n++;
    });
    if (total) total.textContent = n + (n === 1 ? ' resultado' : ' resultados');
    if (vazio) vazio.classList.toggle('on', n === 0);
  }
  $$('[data-grupo]').forEach(function (bt) {
    bt.addEventListener('click', function () {
      var g = bt.dataset.grupo, v = bt.dataset.valor;
      ativo[g] = ativo[g] === v ? '' : v;
      $$('[data-grupo="' + g + '"]').forEach(function (x) { var on = ativo[g] === x.dataset.valor; x.classList.toggle('on', on); x.setAttribute('aria-pressed', on); });
      aplicar();
    });
  });
  if (busca) busca.addEventListener('input', aplicar);
  var limpar = document.getElementById('m-limpar'); if (limpar) limpar.addEventListener('click', function () { ativo = {}; if (busca) busca.value = ''; $$('[data-grupo]').forEach(function (x) { x.classList.remove('on'); x.setAttribute('aria-pressed', 'false'); }); aplicar(); });
  aplicar();
})();
