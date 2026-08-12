Três variantes de botão e dois tamanhos; só um botão sólido por tela.

**Classes e tokens:** `.btn` + `.solid` `.claro` `.ghost` `.mini`

```html
<button class="btn solid">Ação principal</button>
<button class="btn ghost">Cancelar</button>
<button class="btn ghost mini">Ação em cartão</button>
```

- `.solid` é o Synapse disparando: **um por tela**. O segundo vira `.ghost`.
- `.claro` (Ink) para fundo escuro neutro — **não use sobre a banda verde**,
  perde o contorno; ali vale `.solid` ou `.ghost` com borda clara.
- `.mini` (34px) dentro de cartão, tabela e barra de ferramenta; o padrão (44px)
  em formulário e chamada.

Rótulo com verbo: "Gerar asset", "Baixar PNG". Nada de "OK" solto.

---
Card completo com todos os estados: `components/Componentes/Botoes/Botoes.html`
