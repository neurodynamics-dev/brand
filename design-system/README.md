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
├── build.mjs           sincroniza tokens e artes nos previews; gera o índice
├── cards.json          índice dos cards (gerado)
├── marca/              artes de preview, derivadas de assets/
└── previews/           14 cards, um HTML autocontido cada
```

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

Nada disso foi executado ainda — o A está descrito, não testado.

### A autorização

O envio precisa de autorização que **esta sessão web não consegue fazer**. A
mensagem da ferramenta aponta dois caminhos:

- **Terminal interativo** — rode `claude` na sua máquina, dentro do repositório,
  e use `/design-login` antes do `/design-sync`.
- **A partir do claude.ai/code** — use o botão **"Send to Claude Code Web"** do
  Claude Design, que semeia o projeto direto no workspace.

Vale saber antes de começar: numa importação de verdade a skill avisa que o
processo pode levar **horas** e consumir bastante token, porque ela verifica o
render de cada componente. No nosso caso (caminho A, sem componentes React)
isso é muito menor.

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
