Tabela, métricas e lista de especificação — número sempre em mono e à direita.

**Classes e tokens:** `.tabela` `.num` `.escala`

```html
<table class="tabela">
  <thead><tr><th>Peça</th><th class="num">Downloads</th></tr></thead>
  <tbody><tr><td>Banner</td><td class="num">318</td></tr></tbody>
</table>
```

Número em `--fm` e alinhado à direita, para as casas se empilharem — nunca
centralize coluna numérica. Ponto para milhar, vírgula para decimal: `1.284`, `1,8s`.

Borda a 8% entre linhas, cabeçalho a 16%, sem zebra; hover a 2% na linha inteira.
Tabela larga vai dentro de um contêiner com `overflow-x:auto`.

`.escala` é a lista chave/valor para especificação.

---
Card completo com todos os estados: `components/Componentes/Dados/Dados.html`
