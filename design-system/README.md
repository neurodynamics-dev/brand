# Design System — NeuroDynamics

Biblioteca de componentes da marca: a linguagem visual de
`brand.neurodynamics.dev` extraída do `index.html` e organizada em cards.

Não substitui a página de brand — ela continua sendo a referência pública e a
central de assets. Isto aqui é a versão em pedaços, para ser consultada por
ferramenta e por gente que está construindo alguma coisa.

## O que tem dentro

```
design-system/
├── tokens.css          fonte única dos tokens (cor, tipo, espaço, forma)
├── neuro.css           folha consumível: base + componentes
├── conventions.md      cabeçalho de convenções (vai no prompt do agente)
├── build.mjs           sincroniza tokens e artes nos previews; gera o índice
├── bundle.mjs          monta a ds-bundle/ para o Claude Design
├── validate.mjs        confere o contrato da ds-bundle/
├── cards.json          índice dos cards (gerado)
├── marca/              artes de preview, derivadas de assets/
└── previews/           14 cards, um HTML autocontido cada
```

E, na raiz do repositório, a `ds-bundle/` gerada — é ela que sobe.

| Grupo | Cards |
| --- | --- |
| **Fundamentos** | Cores · Tipografia · Espaço e forma · Superfícies |
| **Marca** | Imagotipo · Fundo e textura · Banda e hero |
| **Componentes** | Botões · Cartões · Formulários · Status e etiquetas · Navegação · Dados · Feedback |

Cada preview mostra os estados reais do componente (repouso, hover, foco,
erro, desativado) e fecha com as regras de uso, inclusive as proibições.

## Como isso chega no Claude Design

> **Leia esta seção antes de tentar sincronizar.** Uma versão anterior deste
> README dizia que bastava rodar `/design-sync` e ele leria esta pasta. Isso
> está errado, e a diferença é grande.

### O que o Claude Design faz

Em claude.ai/design você conversa com um agente e ele constrói interface de
verdade — telas, fluxos, protótipos — renderizada ao vivo a partir de código
React. Sem design system sincronizado, ele usa componentes genéricos. Com um
sincronizado, ele constrói **com os seus componentes**, e o que sai já é da
marca e mapeia no código que a equipe manda para produção.

### O que o `/design-sync` espera encontrar

A skill trabalha em cima de **bibliotecas React**. Ela detecta uma de duas
formas no repositório:

- **Storybook** — acha um `.storybook/main.*` e usa as stories como previews.
- **Pacote** — acha um `package.json`, roda o build, e lê os componentes a
  partir dos `.d.ts` exportados pelo `dist/`.

A partir daí um conversor gera uma pasta `ds-bundle/` e é **ela** que sobe:

```
ds-bundle/
├── _ds_bundle.js                        componentes compilados em window.<Global>.*
├── styles.css                           a raiz do CSS (ver nota abaixo)
├── components/<grupo>/<Nome>/
│   ├── <Nome>.html                      o card de preview (primeira linha: @dsCard)
│   ├── <Nome>.jsx                       stub de re-export
│   ├── <Nome>.d.ts                      o contrato de API que o agente lê
│   └── <Nome>.prompt.md                 como compor o componente
├── _vendor/  _preview/  fonts/  tokens/  guidelines/
├── README.md                            com o cabeçalho de convenções
└── _ds_sync.json                        hashes de conteúdo, para o próximo sync
```

Uma regra fácil de perder: **o que o agente recebe ao renderizar um design é
só o fecho de `@import` do `styles.css`** (mais o bundle JS). CSS que não é
alcançável a partir dele não existe para o design final.

### Onde a NeuroDynamics não encaixa

Este repositório **não tem `package.json`, não tem `dist/` e não tem um único
arquivo React**. É um site estático de arquivo único, e o design system que
está aqui é CSS + HTML. Nenhuma das duas formas que a skill detecta se aplica,
então o conversor não tem por onde começar — não há componente compilado para
colocar em `_ds_bundle.js`.

Isso não é um beco. A própria skill prevê dois caminhos para esse caso:
produzir o layout "por qualquer meio que o repositório permita", e um modo
documentado de **design system só de tokens**, que sobe `styles.css` com um
bundle de corpo vazio.

### As duas saídas

**A. Sincronizar como sistema de tokens e CSS** — montar a `ds-bundle/` à mão:
`styles.css` importando `tokens.css` + `neuro.css`, os 14 cards em
`components/<grupo>/<Nome>/<Nome>.html`, e um `README.md` com o cabeçalho de
convenções ensinando o vocabulário (`.btn.solid`, `.card`, `.band`,
`var(--synapse)`…). O agente então escreve o HTML/JSX dele **estilizado com a
nossa marca**, mas não importa componente nosso — porque não existe componente
nosso para importar. É o caminho curto, e entrega a maior parte do valor: cor,
tipografia, espaçamento e as regras chegam.

**B. Construir uma biblioteca React de verdade** — transformar o `neuro.css` e
os componentes em um pacote npm com componentes React, aí o caminho oficial
funciona inteiro e o agente passa a montar telas com `<Botao>`, `<Card>`,
`<Banda>`. É bem mais trabalho e cria um projeto novo para manter, mas é o
único jeito de o agente compor com peças nossas em vez de imitá-las.

**O caminho A já está pronto neste repositório** — ver a próxima seção. O B
continua em aberto, e um não fecha a porta do outro.

### O que já está montado (caminho A)

`node bundle.mjs` gera a pasta `ds-bundle/` na raiz do repositório, no layout que
o Claude Design consome — ela está versionada, então dá para enviar sem rodar nada:

```
ds-bundle/                     41 arquivos · 294KB
├── styles.css                 a raiz: @import tokens + _ds_bundle.css
├── tokens/tokens.css          os 58 tokens
├── _ds_bundle.css             o neuro.css
├── _ds_bundle.js              corpo vazio, com o cabeçalho @ds-bundle
├── components/<Grupo>/<Nome>/
│   ├── <Nome>.html            o card, com @dsCard na primeira linha
│   └── <Nome>.prompt.md       como compor, com exemplo — é o que o agente lê
├── guidelines/                convenções e acessibilidade
├── marca/                     as artes
├── README.md                  cabeçalho de convenções + índice
└── _ds_needs_recompile        sentinela que dispara o self-check do app
```

O `README.md` do bundle começa com o **cabeçalho de convenções**
(`conventions.md` aqui na pasta), que é o artefato de maior alavancagem: ele vai
inline no prompt do agente e enumera o vocabulário — as classes, os tokens e as
quatro regras que o sistema cobra. Todo nome citado nele foi conferido contra o
`neuro.css` e o `tokens.css`.

Para conferir antes de subir:

```bash
node build.mjs && node bundle.mjs   # gera
node validate.mjs                    # confere o contrato
```

O `validate.mjs` checa que o fecho de `@import` do `styles.css` resolve, que o
`_ds_bundle.js` tem o cabeçalho na primeira linha, e que todo card tem `@dsCard`,
link resolvendo e resumo no `.prompt.md`. Com `playwright-core` instalado ele
ainda faz a prova que importa: abre uma página que **só** linka o `styles.css` —
exatamente o que um design do agente recebe — e confirma que tokens, botão,
cartão, status, banda e acento chegam.

Uma nota para quando o envio acontecer: o `_ds_needs_recompile` leva
`{"by":"neurodynamics-brand-bundle"}`. Esse campo é só um carimbo de procedência.
Se o self-check do app se recusar a rodar por não reconhecer o valor, troque para
`{"by":"design-sync-cli"}` e reenvie só esse arquivo.

### A autorização

O envio precisa de autorização que **esta sessão web não consegue fazer**. A
mensagem da ferramenta aponta dois caminhos:

- **Terminal interativo** — rode `claude` na sua máquina, dentro do repositório,
  e use `/design-login`.
- **A partir do claude.ai/code** — use o botão **"Send to Claude Code Web"** do
  Claude Design, que semeia o projeto direto no workspace.

**Não rode `/design-sync` depois de entrar.** Ele iria procurar Storybook ou
`package.json`, não achar nenhum dos dois, e tentar construir uma biblioteca que
não existe. A `ds-bundle/` já está pronta — o que você quer é só enviá-la. Peça
na sessão, com estas palavras:

> Crie um projeto de design system no Claude Design chamado `NeuroDynamics` e
> envie a pasta `ds-bundle/` deste repositório para a raiz dele. Ela já está
> montada e validada; não rode o conversor.

O envio em si são três passos que o Claude faz por você: pedir sua aprovação do
plano, gravar os 41 arquivos, e regravar o `_ds_needs_recompile` no fim — é essa
sentinela que dispara o self-check do app e faz os cards aparecerem.

## Como editar

**Mudou um token?** Edite `tokens.css` e rode `node build.mjs`. O bloco de
tokens é reescrito nos 14 previews de uma vez.

**Mudou um componente?** Edite o preview em `previews/` e, se o componente
também vive em `neuro.css`, atualize os dois. O preview é a documentação; o
`neuro.css` é o que os apps importam.

**Novo card?** Crie o HTML em `previews/` com o marcador `@dsCard` na primeira
linha e os marcadores de token no `<style>`:

```html
<!-- @dsCard group="Componentes" name="Nome" subtitle="Variantes" width="1180" height="900" -->
...
<style>
/* @tokens:start */
/* @tokens:end */
```

Rode `node build.mjs` e o card entra no índice sozinho. O `--check` sai com
código 1 se algum preview estiver fora de sincronia — serve para CI ou
pre-commit:

```bash
node build.mjs --check
```

Do marcador `@dsCard`, o atributo que o Claude Design lê com certeza é o
`group`. Os outros (`name`, `subtitle`, `width`, `height`) alimentam o nosso
`cards.json` e são um palpite razoável sobre o resto do formato — se o envio
reclamar, são eles os suspeitos.

## Por que os previews são autocontidos

Cada card renderiza isolado — sem acesso aos outros arquivos do projeto. Por
isso o bloco de tokens aparece repetido em todo preview e as artes da marca
entram como data URI, em vez de `<link>` e `<img src>`. É duplicação
deliberada, e o `build.mjs` existe justamente para que ela nunca saia do lugar.

As fontes (Archivo e IBM Plex Mono) vêm do Google Fonts por `<link>`. Se o
ambiente de renderização bloquear a requisição, a pilha de fallback assume e o
layout continua íntegro — só a fonte muda.

## Acessibilidade

Os contrastes da paleta foram calculados (WCAG 2.1) e estão na tabela do card
de Cores. O resultado que muda o dia a dia: **Grafite (`#616C68`) rende 3,69:1
sobre o Void e reprova em AA para texto corrido** — serve para rótulo caixa
alta, legenda e borda, e nada além disso. Para texto secundário, use Névoa
(7,92:1).
