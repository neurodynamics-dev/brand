# Brand — brand.neurodynamics.dev

Manual da marca e central de assets da NeuroDynamics (`index.html`). A
página carrega as mesmas folhas que os apps importam
(`design-system/tokens.css` e `design-system/neuro.css`), então o que
aparece nela é o próprio design system.

## O que a página contém

O conteúdo é dividido em seis abas (SectionNav), com subabas onde ajuda.
O endereço guarda as duas, por exemplo `#cores/secundario`.

1. **Cores** — primário e neutro, secundário, funcional e "em uso"
   (pareamento com exemplos, regras, download da paleta em JSON e CSS).
   Clique em qualquer tom para copiar o hex.
2. **Tipografia** — o modo operacional (Archivo, Instrument Sans,
   IBM Plex Mono), a escala e as regras. O modo executivo aparece no fim,
   como extra, numa peça no próprio registro (papel, Cortex, fio fino).
3. **Elementos** — marcas (imagotipo, recolorido por família, ícone
   quadrado, símbolo, onda branca, selo), superfícies e fundo, bandas e
   forma e espaço (raios, escala, movimento).
4. **Interfaces** — componentes vivos de `neuro.css`: ações, formulários,
   navegação, dados, feedback e widgets.
5. **Creative gallery** — wallpapers, pôsteres e peças sociais, e o
   **Estúdio**, com os geradores de mídia em canvas (PNG na resolução
   final, renderizado no navegador): banners, posts de entrada e de aviso,
   foto de perfil, thumbnail, crachá de evento, wallpaper, fundo de
   reunião e capa.
6. **Aplicações** — documentos, apresentações, e-mails e crachás, cada
   um com miniaturas e o link para o template; as **assinaturas de
   e-mail** (login com a conta da equipe, dados do cadastro, nome de
   exibição e pronomes); e os **downloads**.

As miniaturas das peças ficam em `assets/manual/` e foram geradas a
partir de `templates/`. Se um template mudar, gere a miniatura de novo.

## Design system (Claude Design)

A pasta [`design-system/`](design-system/) traz a mesma linguagem visual
organizada como biblioteca de componentes para o **Claude Design**: 18 cards
em três grupos (Fundamentos, Marca, Componentes), tokens em arquivo único e
um `build.mjs` que mantém tudo em sincronia. Com ela sincronizada, as
interfaces que o Claude gera para a equipe já saem na marca.

O passo a passo do setup está em [`design-system/README.md`](design-system/README.md).

## Templates

A pasta [`templates/`](templates/) traz as peças prontas da marca em HTML
estático: relatório formal, certificados, convite, papel timbrado, cartão
de visita, apresentações formal e de marca, crachás, redes sociais,
e-mails, wallpapers e pôsteres. O índice e as regras de cada uma estão em
[`templates/README.md`](templates/README.md). As regras completas da marca
ficam em [`design-system/DIRETRIZES.md`](design-system/DIRETRIZES.md).

## Como editar

- **Cores e nomes:** bloco `PALETA` no `<script>` de `index.html`.
- **Geradores:** blocos `GERADORES` (formatos/campos) e `VARIANTES`
  (visuais); o desenho fica nas funções `desenhaBase`/`renderPeca`.
- **Assinaturas:** os dados vêm do banco (tabelas `perfis` e
  `membros`), com a conta da própria pessoa. O bloco `SIG_ORG` espelha
  a configuração institucional da ferramenta original.
- **Versão:** atualize o marcador `#versao` no hero quando houver mudança
  relevante nas guidelines.

## Como publicar

1. Ative o GitHub Pages neste repositório (branch `main`, raiz).
2. No Cloudflare, aponte `brand.neurodynamics.dev` → `CNAME` para
   `neurodynamics-dev.github.io`.

## Observações

- A página é pública (como o site institucional); os geradores rodam
  inteiramente no navegador — nada é enviado a servidor.
- A seção de assinaturas exige login: cada pessoa vê apenas os
  próprios dados, lidos com a permissão da própria conta.
