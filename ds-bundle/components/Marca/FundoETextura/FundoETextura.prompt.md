O fundo da marca: brilho radial, grade técnica mascarada e blobs desfocados.

**Classes e tokens:** `.nd-bg` `.blob` `.b1` `.b2` `.b3` `.fig`

Receita fixa, sempre nesta ordem: brilho radial no fundo, blobs por cima, grade
mascarada por último, conteúdo acima de tudo. Trocar a ordem embaça o texto.

```html
<div class="nd-bg">
  <div class="blob b1"></div><div class="blob b2"></div><div class="blob b3"></div>
</div>
```

Os blobs sempre sangram para fora da tela — blob inteiro e centralizado vira forma,
e forma tem que ter significado. **Nunca foto atrás do texto**: a textura da marca é
geométrica. Foto entra em cartão, com borda e raio.

`.fig` é o placeholder de imagem que ainda não existe.

---
Card completo com todos os estados: `components/Marca/FundoETextura/FundoETextura.html`
