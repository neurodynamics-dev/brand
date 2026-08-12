Archivo para display e interface, IBM Plex Mono para dados e rótulos, fonte de sistema no corpo.

**Classes e tokens:** `--fd` `--fm` `--f` · `--fs-display` `--fs-h1` `--fs-h2` `--fs-h3` `--fs-body` `--fs-sm` `--fs-xs` `--fs-label` `--fs-micro` · `.display` `.lead` `.mono` `.nota` `.eyebrow`

`--fd` (Archivo) em título, botão e nome. `--fm` (IBM Plex Mono) em eyebrow,
rótulo caixa alta, código e número de tabela — sempre com tracking positivo quando
em caixa alta. `--f` (sistema) no texto corrido.

Texto corrido não passa de `--measure` (640px).

```html
<span class="eyebrow">01 / Seção</span>
<h1 class="display">Título com <em>uma</em> palavra em Synapse.</h1>
<p class="lead">Parágrafo de abertura.</p>
```

---
Card completo com todos os estados: `components/Fundamentos/Tipografia/Tipografia.html`
