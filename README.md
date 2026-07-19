# Brand — brand.neurodynamics.dev

Brand guidelines e central de assets da NeuroDynamics, em arquivo único
(`index.html`), no mesmo padrão dos demais apps do ecossistema e com a
linguagem visual do site institucional.

## O que a página contém

- **Marca** — imagotipo nas versões branca e preta, regras de respiro,
  tamanho mínimo e usos proibidos.
- **Cores** — paleta oficial nomeada (sistema neural): primárias
  **Cortex `#00352F` · Axon `#00594F` · Synapse `#CEDC00`**, profundos e
  neutros (Void, Painel, Blackout, Ink, Aura, Névoa, Grafite) e a paleta
  **auxiliar** para dados e status (Soma, Íon, Vital, Mielina, Pulso,
  Plasma, Dendrito). Clique copia o hex; há download em JSON e tokens CSS.
- **Tipografia** — Archivo (500–700) para display/UI, IBM Plex Mono
  (400–500) para dados e rótulos técnicos, pilha do sistema no corpo.
- **Elementos visuais** — grade técnica, blobs orgânicos, vidro, banda em
  gradiente, placeholder técnico (FIG.), eyebrow e pills — com exemplos
  vivos e regras de uso.
- **Estúdio (geradores de mídia)** — tudo renderizado em canvas, no
  navegador, com download em PNG na resolução final e 4 visuais
  selecionáveis (Void, Cortex, Synapse, Aura):
  - banner/header de redes sociais (LinkedIn, X, YouTube);
  - post de entrada na equipe (feed, quadrado e story, com foto);
  - wallpaper (desktop, ultrawide e celular);
  - fundo de reunião (1920×1080, centro limpo);
  - capa de apresentação/documento (16:9 e A4).
- **Assinaturas de e-mail** — a Central de Assinaturas incorporada: lê o
  quadro oficial `quadro-assinaturas.xlsx` direto do repositório
  [`signature`](https://github.com/neurodynamics-dev/signature) (via
  raw.githubusercontent.com) e gera as duas assinaturas do Gmail com o
  mesmo HTML da ferramenta original.
- **Downloads** — logo preto/branco, símbolo SVG, paleta e links de
  fontes e do ecossistema.

## Como editar

- **Cores e nomes:** bloco `PALETA` no `<script>` de `index.html`.
- **Geradores:** blocos `GERADORES` (formatos/campos) e `VARIANTES`
  (visuais); o desenho fica nas funções `desenhaBase`/`renderPeca`.
- **Assinaturas:** os dados vêm do repositório `signature` — edite o
  `quadro-assinaturas.xlsx` lá (colunas: nome, cargo, email, telefone).
  O bloco `SIG_ORG` daqui espelha a configuração da ferramenta original.
- **Versão:** atualize o marcador `#versao` no hero quando houver mudança
  relevante nas guidelines.

## Como publicar

1. Ative o GitHub Pages neste repositório (branch `main`, raiz).
2. No Cloudflare, aponte `brand.neurodynamics.dev` → `CNAME` para
   `neurodynamics-dev.github.io`.

## Observações

- A página é pública (como o site institucional); os geradores rodam
  inteiramente no navegador — nada é enviado a servidor.
- A seção de assinaturas expõe os mesmos dados já públicos no repositório
  `signature` (nome, cargo, e-mail institucional, telefone). Se o quadro
  precisar deixar de ser público, mova o xlsx e ajuste `SIG_DADOS_URL`.
