Toast, carregamento, estado vazio e diálogo.

**Classes e tokens:** `.nd-toast` `.toast`

```html
<div class="nd-toast"><div class="toast">#CEDC00 copiado.</div></div>
```

Toast confirma e some em ~4s — **não carrega decisão**. Se a pessoa precisa
escolher, o lugar é o diálogo, que só sai com uma resposta.

Estado vazio sempre com um botão que resolve o vazio: tela vazia sem próximo
passo é um beco.

Esqueleto quando você sabe a forma do conteúdo, indicador de giro quando não sabe.
Os dois respeitam `prefers-reduced-motion`.

---
Card completo com todos os estados: `components/Componentes/Feedback/Feedback.html`
