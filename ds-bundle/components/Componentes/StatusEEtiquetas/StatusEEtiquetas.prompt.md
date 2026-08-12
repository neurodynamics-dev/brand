Pills de status com significado fixo, tags de contexto e chips de escolha.

**Classes e tokens:** `.pill` + `.st-vital` `.st-mielina` `.st-pulso` `.st-plasma` `.st-ion` `.st-dendrito` · `.tag` · `.chip` `.chip.on`

```html
<span class="pill st-vital"><span class="dt"></span>Concluído</span>
<span class="pill st-mielina"><span class="dt"></span>Em análise</span>
<span class="pill st-pulso"><span class="dt"></span>Falhou</span>
```

Significado é fixo: Vital = sucesso, Mielina = atenção, Pulso = erro,
Plasma = informação neutra, Íon = destaque/evento, Dendrito = processo e pesquisa.
Não troque por gosto.

**Cor nunca sozinha** — todo status carrega texto junto.
**Synapse não é status**: é acento e ação. Sucesso é Vital.

`.tag` é rótulo de contexto (em Synapse), `.chip` é escolha do usuário —
o selecionado vira `.chip.on`.

---
Card completo com todos os estados: `components/Componentes/StatusEEtiquetas/StatusEEtiquetas.html`
