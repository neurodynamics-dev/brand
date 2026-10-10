# Design system v3: a referência

Cópia do pacote `nro_design_system` (outubro de 2026), a fonte das regras e
do visual. **Não é código de produção**: é o que se consulta para construir
ou corrigir uma tela.

| Arquivo | Para quê |
| --- | --- |
| `interface-rules.md` | O contrato das interfaces. Leia antes de qualquer tela |
| `readme.md` | Todas as regras da marca (documentos e interface) |
| `components/*/*.card.html` | Os cards: o visual de referência de cada componente, com estados |
| `components/*/*.d.ts`, `*.prompt.md` | O contrato de cada componente e os exemplos de uso |
| `guidelines/*.html` | Os cards de fundamento (cores, tipo, raios, marca) |
| `tokens/`, `styles.css` | Os tokens como o pacote os entregou |
| `handoff/` | Os briefs (implementação, manual da marca, treinamento) |

O código de produção é outro, em `design-system/`:

- `tokens.css`: os tokens. Onde o pacote e este arquivo divergem, vale o
  `tokens.css` (`--tr-label` .14em, `--r-pill` 7px, papéis de tema).
- `neuro.css`: os componentes, em CSS puro.
- `casca.css` e `casca.js`: o cabeçalho, o menu do celular e o rodapé dos
  sites, e o rodapé do SOMA.
- `select.css` e `select.js`: o listbox no lugar do select nativo.

Para ver um card: sirva a raiz do repositório (`node scripts/servir.mjs`) e
abra `/design-system/v3/components/interface/widgets.card.html`. Os cards
usam os assets de `/assets/`.

Os consumidores (membro, website, selecao) recebem a pasta `ds/` por
`node scripts/distribuir.mjs`. O checklist da seção 13 roda com
`node scripts/auditar.mjs <pasta ou arquivos>`.
