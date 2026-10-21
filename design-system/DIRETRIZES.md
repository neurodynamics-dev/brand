# NeuroDynamics Design System

As regras moram em **`v3/readme.md`** (marca, documentos e interface) e
**`v3/interface-rules.md`** (o contrato das telas). Este arquivo não repete
as regras: diz como este repositório as implementa.

| Peça do pacote | Aqui |
| --- | --- |
| `tokens/*.css` | `tokens.css` (um arquivo; os papéis de tema e o tema claro estão nele) |
| `components/core` e `components/interface` | classes de `neuro.css` |
| SiteHeader, MobileSiteMenu e o rodapé | `casca.css` e `casca.js` |
| `components/formal` | `formal.css` |
| `templates/`, `assets/` | na raiz do repositório |
| os cards, como referência visual | `v3/components/*/*.card.html` e `v3/guidelines/` |

Onde o pacote e `tokens.css` divergem, vale `tokens.css`: `--tr-label` é
.14em (o pacote diz .22em, contra a própria regra de rótulo), `--r-pill` é
7px, e há `--r-chip`, `--r-tag` e `--r-badge`.

Fluxo de trabalho:

1. Mudou um componente: edite `neuro.css` (ou `casca.*`), rode
   `node scripts/auditar.mjs design-system` e `node build.mjs`.
2. Leve aos consumidores: `node scripts/distribuir.mjs` (escreve `ds/` em
   membro, website e selecao). Cada um confere com
   `node scripts/distribuir.mjs --check`.
3. Uma tela nova ou corrigida passa no auditor nos arquivos que tocou:
   `node scripts/auditar.mjs --falhar <arquivos>`.

## SOMA: tema claro e navegação

O portal admite tema claro e escuro. O bloco `:root[data-tema="claro"]` de `tokens.css` troca só os papéis (`--bg`, `--ink`, `--muted`, `--syn-tx`...); os componentes de `neuro.css` não mudam. A classe `.ilha-escura` mantém uma faixa escura no tema claro. Claro: superfície Pia light, tinta Sulco, linhas Pia medium. Escuro: Void e Sulco. Estados funcionais usam marca ou ícone; o texto continua na cor de leitura. A área de destaque (`.sl-destaque`) preserva os aliases escuros nos dois temas.

O menu usa imagotipo branco no escuro e preto no claro, sem filtros. Recolhido, usa o ícone quadrado correspondente. Seleção permanece discreta (fundo neutro e peso 600); Synapse identifica a ação principal, não a opção selecionada. Marca fica entre Studio e Equipe. Selects usam realce progressivo: o elemento nativo permanece sincronizado com o controle acessível e continua disponível para automação.
