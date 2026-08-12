Cabeçalho flutuante de vidro, âncoras e rodapé.

**Classes e tokens:** `.nd-header` `.nd-header.rolou` `.hd-in` `.hd-logo` `.logotype` `.hd-nav` · `.nd-footer` `.ft-in`

```html
<header class="nd-header">
  <div class="hd-in">
    <span class="hd-logo"><span class="logotype">NeuroDynamics</span></span>
    <nav class="hd-nav"><a href="#">Marca</a><a href="#">Cores</a></nav>
    <button class="btn solid mini">Entrar</button>
  </div>
</header>
```

O cabeçalho flutua: 14px do topo, cantos de 16px, vidro por trás. A grade do fundo
atravessa ele — é isso que dá a sensação de vidro. Depois de ~20px de rolagem,
adicione `.rolou` (fundo mais opaco, borda mais forte, sombra funda).

A `.hd-nav` some abaixo de 1080px — preveja o menu alternativo.

---
Card completo com todos os estados: `components/Componentes/Navegacao/Navegacao.html`
