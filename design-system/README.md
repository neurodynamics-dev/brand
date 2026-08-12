# Design System — NeuroDynamics

Biblioteca de componentes da marca, pronta para sincronizar com o
**Claude Design** (claude.ai/design). É a mesma linguagem visual de
`brand.neurodynamics.dev`, extraída do `index.html` e organizada em cards
que o Claude consulta quando gera qualquer interface para a equipe.

Não substitui a página de brand: ela continua sendo a referência pública e a
central de assets. Isto aqui é a versão que a ferramenta lê.

## O que tem dentro

```
design-system/
├── tokens.css          fonte única dos tokens (cor, tipo, espaço, forma)
├── neuro.css           folha consumível: base + componentes
├── build.mjs           sincroniza tokens e artes nos previews; gera o manifesto
├── _ds_manifest.json   índice dos cards (gerado)
├── marca/              artes de preview, derivadas de assets/
└── previews/           14 cards, um HTML autocontido cada
```

Os 14 cards, em três grupos:

| Grupo | Cards |
| --- | --- |
| **Fundamentos** | Cores · Tipografia · Espaço e forma · Superfícies |
| **Marca** | Imagotipo · Fundo e textura · Banda e hero |
| **Componentes** | Botões · Cartões · Formulários · Status e etiquetas · Navegação · Dados · Feedback |

Cada preview mostra os estados reais do componente (repouso, hover, foco,
erro, desativado) e fecha com as regras de uso — inclusive as proibições, que
é o que o modelo mais precisa para não inventar variações.

## Setup: sincronizar com o Claude Design

O envio precisa de um **terminal interativo**: a autorização do Claude Design
(`/design-login`) não roda em sessão da web nem em CI. Então o push é feito da
sua máquina, uma vez só — depois é `/design-sync` sempre que mudar algo.

**1. Traga o branch para a sua máquina**

```bash
git clone https://github.com/neurodynamics-dev/brand.git
cd brand
git checkout claude/design-system-setup-6c5ysl
```

**2. Confira que está tudo em sincronia**

```bash
cd design-system
node build.mjs --check
```

As artes da marca já estão embutidas — versões de preview derivadas dos PNGs
de `assets/`, descritas em [`marca/LEIAME.md`](marca/LEIAME.md). Só é preciso
mexer nelas quando a marca mudar.

**3. Autorize e envie**

```bash
claude                 # na raiz do repositório
```

Dentro da sessão:

```
/design-login          # autoriza o acesso aos projetos de design
/design-sync           # lê design-system/ e envia para o projeto
```

O `/design-sync` mostra o plano — quais caminhos serão escritos e de qual pasta
— e espera sua aprovação antes de gravar. Se você ainda não tem um projeto de
design, ele oferece criar um; o tipo *design system* é definido na criação e
não pode ser mudado depois, então crie por ali mesmo.

> Se o comando `/design-sync` não existir na sua versão do Claude Code, peça na
> própria sessão: *"sincronize a pasta design-system/ com o meu projeto de
> design system no Claude Design"*. A ferramenta por trás é a mesma.

**4. Confira**

Abra claude.ai/design, entre no projeto e veja os 14 cards distribuídos em
Fundamentos, Marca e Componentes. A partir daí, toda interface que o Claude
gerar para a NeuroDynamics sai já na marca.

## Como editar

**Mudou um token?** Edite `tokens.css` e rode `node build.mjs`. O bloco de
tokens é reescrito nos 14 previews de uma vez.

**Mudou um componente?** Edite o preview correspondente em `previews/` e, se o
componente também vive em `neuro.css`, atualize os dois. O preview é a
documentação; o `neuro.css` é o que os apps importam.

**Novo card?** Crie o HTML em `previews/` com o marcador `@dsCard` na primeira
linha e os marcadores de token no `<style>`:

```html
<!-- @dsCard group="Componentes" name="Nome" subtitle="Variantes" width="1180" height="900" -->
...
<style>
/* @tokens:start */
/* @tokens:end */
```

Rode `node build.mjs` e o card entra no manifesto sozinho. O `--check` serve
para CI ou pre-commit: sai com código 1 se algum preview estiver fora de sincronia.

```bash
node build.mjs --check
```

## Por que os previews são autocontidos

Cada card renderiza isolado no Claude Design — sem acesso aos outros arquivos
do projeto. Por isso o bloco de tokens aparece repetido em todo preview e as
artes da marca entram como data URI, em vez de `<link>` e `<img src>`. É
duplicação deliberada, e o `build.mjs` existe justamente para que essa
duplicação nunca saia do lugar.

As fontes (Archivo e IBM Plex Mono) vêm do Google Fonts por `<link>`. Se o
ambiente de renderização bloquear a requisição, a pilha de fallback assume e o
layout continua íntegro — só a fonte muda.

## Acessibilidade

Os contrastes da paleta foram calculados (WCAG 2.1) e estão na tabela do card
de Cores. O resultado que muda o dia a dia: **Grafite (`#616C68`) rende 3,69:1
sobre o Void e reprova em AA para texto corrido** — serve para rótulo caixa
alta, legenda e borda, e nada além disso. Para texto secundário, use Névoa
(7,92:1).
