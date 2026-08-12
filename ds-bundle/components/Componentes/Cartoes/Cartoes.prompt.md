Cartão de conteúdo, cartão de regra, superfície clara e cabeçalho de seção.

**Classes e tokens:** `.card` `.claro` `.sec-head` `.grid-2` `.grid-3` `.grid-4`

```html
<div class="grid-3">
  <div class="card">
    <h3 style="font-size:var(--fs-h3)">Título</h3>
    <p style="font-size:var(--fs-sm);color:var(--muted)">Texto de apoio.</p>
  </div>
</div>
```

Um cartão, uma ideia: se precisa de subtítulo, lista e dois botões, virou seção.
Título em `--fd` e Ink; corpo em `--f` e `--muted`.

`.sec-head` é o cabeçalho de seção em duas colunas — eyebrow numerado à esquerda,
título e subtítulo à direita; colapsa em uma coluna abaixo de 820px.

---
Card completo com todos os estados: `components/Componentes/Cartoes/Cartoes.html`
