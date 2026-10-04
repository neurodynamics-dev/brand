# Brand — brand.neurodynamics.dev

Brand guidelines e central de assets da NeuroDynamics, em arquivo único
(`index.html`), no mesmo padrão dos demais apps do ecossistema e com a
linguagem visual do site institucional.

## O que a página contém

- **Marca** — imagotipo nas versões branca e preta, regras de respiro,
  tamanho mínimo e usos proibidos.
- **Cores** — quatro conjuntos de famílias, cada uma em quatro tons
  (light, medium, primary, dark), com nomes do sistema nervoso: o
  **primário** Cortex (Axon `#00594F`, Cortex `#00352F` e o acento
  Synapse `#CEDC00`), o **neutro** (Sulco, Pia, Medula), o **secundário**
  (Ion, Neuron, Glia, Retina, Nexo, Dendrito, Lúmen, Ritmo, Impulso,
  Plexo, Íris) e o **funcional**, só para estados de interface (Nominal,
  Caution, Critical, Signal, Idle). Clique copia o hex; há download em
  JSON e tokens CSS.
- **Tipografia** — dois modos. Operacional: Archivo nos títulos e
  rótulos, Instrument Sans no texto, IBM Plex Mono só em códigos e dados.
  Executivo (peças formais): Instrument Serif nos títulos, nomes e
  citações, Archivo Light no texto.
- **Elementos visuais** — grade técnica, blobs orgânicos, vidro, banda em
  gradiente, placeholder técnico (FIG.), eyebrow e pills — com exemplos
  vivos e regras de uso.
- **Estúdio (geradores de mídia)** — tudo renderizado em canvas, no
  navegador, com download em PNG na resolução final e 4 visuais
  selecionáveis (Void, Cortex, Synapse, Aura):
  - banner/header de redes sociais (LinkedIn pessoal e empresa, X, YouTube);
  - post de entrada na equipe (feed, quadrado e story, com foto);
  - post de aviso ou frase (feed, quadrado e story);
  - foto de perfil com anel Synapse (com upload de foto);
  - thumbnail de vídeo (YouTube) e crachá de evento;
  - wallpaper (desktop, ultrawide e celular);
  - fundo de reunião (1920×1080, centro limpo);
  - capa de apresentação/documento (16:9 e A4).
- **Assinaturas de e-mail** — a pessoa entra com a própria conta
  (mesmo login das ferramentas internas), os dados de cargo e contato
  vêm do cadastro da equipe no banco, e dá para ajustar o **nome de
  exibição** e incluir **pronomes**. O HTML gerado é o mesmo da
  ferramenta original do repositório `signature`.
- **Downloads e templates** — logos e símbolo oficiais via Brandfetch
  (fonte única da marca), paleta, o template de documentos NRO-PUB-002
  (`assets/`), os templates Overleaf de artigo e pôster (em
  desenvolvimento), um `template.html` de página no padrão da marca e
  os links de fontes e do ecossistema.

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
