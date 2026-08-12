Campos, seleção e estados — o foco acende a borda em Synapse.

**Classes e tokens:** `.fld` `.fld.erro` `.chip` `.chip.on` `.panel`

```html
<div class="fld">
  <label for="email">E-mail institucional</label>
  <input id="email" type="email" placeholder="ana@neurodynamics.dev">
  <p class="mini">Use a conta da equipe.</p>
</div>
```

`.fld` envolve rótulo, campo e ajuda. O rótulo é **sempre visível** (caixa alta,
10,5px, peso 700) — placeholder é exemplo de conteúdo, nunca substituto do rótulo.

`.fld.erro` pinta a borda e a mensagem em Pulso; a mensagem diz **o que fazer**,
não só que deu errado. Campo sem borda não delimita — a borda de 16% é obrigatória.

Formulários longos ficam melhor dentro de `.panel`.

---
Card completo com todos os estados: `components/Componentes/Formularios/Formularios.html`
