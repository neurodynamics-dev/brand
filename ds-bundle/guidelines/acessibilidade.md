# Acessibilidade

Contrastes calculados em WCAG 2.1 sobre a paleta oficial.

| Combinação | Razão | Nível |
| --- | --- | --- |
| Ink sobre Void | 18,47:1 | AAA |
| Névoa sobre Void | 7,92:1 | AAA |
| **Grafite sobre Void** | **3,69:1** | **só texto ≥18,5px** |
| Synapse sobre Void | 13,27:1 | AAA |
| Synapse sobre Cortex | 8,94:1 | AAA |
| Synapse sobre Axon | 5,45:1 | AA |
| Blackout sobre Aura | 15,82:1 | AAA |
| Grafite sobre Aura | 5,12:1 | AA |

Três regras que saem daí:

1. **`--grafite` não é cor de texto corrido.** Reprova em AA. Use em rótulo caixa
   alta, legenda e borda. Texto secundário é `--muted` (Névoa).
2. **Status nunca só por cor.** Todo `.pill` de status carrega texto; todo alerta
   carrega também um ícone.
3. **Foco sempre visível.** `:focus-visible` recebe contorno em Synapse com 2px de
   afastamento; não remova.

Animações (esqueleto, giro, blobs) respeitam `prefers-reduced-motion`.
