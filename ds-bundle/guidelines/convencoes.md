## NeuroDynamics — como construir com este design system

Sistema de **CSS e tokens**, não uma biblioteca React. Não há nada para importar
de `window.*`: escreva o seu HTML/JSX e estilize com as classes e tokens abaixo.
Não invente nomes de classe — o que existe está todo aqui, e um nome inventado
sai sem estilo nenhum.

### Montagem

Carregue `styles.css` e as fontes Archivo (500/600/700) e IBM Plex Mono (400/500)
do Google Fonts. O sistema é **escuro por padrão** e não usa wrapper: `body` já
recebe fundo Void e texto Ink.

Para a textura da marca, ponha isto como primeiro filho do `<body>` — é
`position:fixed` e fica atrás de tudo:

```html
<div class="nd-bg"><div class="blob b1"></div><div class="blob b2"></div></div>
```

### Vocabulário de classes

- **Layout** — `.container` (max 1240px) · `.grid-2` `.grid-3` `.grid-4` · `.stack` · `.row`
- **Superfície** — `.card` (padrão) · `.panel` (opaca, para blocos de controle) · `.glass` (só sobre conteúdo em movimento) · `.claro` (fundo Aura, para documento e assinatura)
- **Botões** — `.btn` mais uma variante: `.solid` (Synapse, a ação principal) · `.claro` (Ink) · `.ghost` (borda) · e `.mini` para reduzir
- **Tipografia** — `.eyebrow` (rótulo de seção, com o quadradinho Synapse) · `.display` · `.lead` · `.mono` · `.nota` · `.sec-head` (cabeçalho de seção em duas colunas)
- **Formulário** — `.fld` envolve rótulo + campo; `.fld.erro` marca o estado de erro
- **Etiquetas** — `.chip` / `.chip.on` (escolha do usuário) · `.pill` (status) · `.tag` (contexto, em Synapse)
- **Status** — `.pill` mais `.st-vital` (sucesso) · `.st-mielina` (atenção) · `.st-pulso` (erro) · `.st-plasma` (info) · `.st-ion` · `.st-dendrito`
- **Estrutura** — `.nd-header` (+ `.rolou` depois de rolar) com `.hd-in` `.hd-logo` `.logotype` `.hd-nav` · `.nd-footer` com `.ft-in`
- **Marca** — `.nd-bg` + `.blob.b1/.b2/.b3` · `.band` (bloco verde da chamada principal) · `.fig` (placeholder técnico)
- **Dados** — `.tabela` (número em `.num`, alinhado à direita) · `.escala` (lista de especificação)
- **Feedback** — `.nd-toast` envolve os `.toast`

### Tokens, para o seu próprio layout

Cor: `--cortex --axon --synapse` · `--void --painel --blackout --ink --aura --nevoa --grafite` ·
status `--vital --mielina --pulso --plasma --ion --dendrito --soma`.
Papéis: `--bg --muted --dim --line --line2 --card --glass`.
Tipo: `--fd` (Archivo, títulos e botões) · `--fm` (IBM Plex Mono, rótulos e números) ·
`--f` (sistema, texto corrido) · `--fs-display` a `--fs-micro`.
Forma: `--r` (18px, base) · `--r-sm --r-md --r-lg --r-xl --r-pill`.
Espaço: `--s1` (4px) a `--s10` (80px) · `--gap` · `--sec` (ritmo entre seções).
Medida: `--max` (container) · `--measure` (640px, limite de texto corrido).

Use sempre o token, nunca o hex literal.

### Quatro regras que o sistema cobra

1. **Um `.btn.solid` por tela.** Ele é o Synapse disparando; dois competindo e nenhum é a ação principal. O segundo vira `.ghost`.
2. **Synapse em dose pequena** — acima de ~5% da tela deixa de ser acento.
3. **`--grafite` não é cor de texto corrido** (3,69:1 sobre o Void, reprova em AA). Serve para rótulo caixa alta, legenda e borda. Texto secundário é `--muted`.
4. **Status nunca só por cor** — todo `.pill` de status carrega texto junto.

### Onde está a verdade

`styles.css` e o que ele importa (`tokens/tokens.css`, `_ds_bundle.css`) são a
fonte real — leia antes de estilizar. Cada card em `components/` documenta um
pedaço do sistema, com estados e proibições.

### Exemplo idiomático

```html
<div class="nd-bg"><div class="blob b1"></div><div class="blob b2"></div></div>

<main class="container">
  <section>
    <span class="eyebrow">01 / Assinaturas</span>
    <h1 class="display">Uma marca para tecnologia que <em>cuida</em>.</h1>
    <p class="lead">Um parágrafo curto de apresentação, dentro da medida.</p>
  </section>

  <section class="grid-3">
    <div class="card">
      <h3 style="font-size:var(--fs-h3)">Cartão</h3>
      <p style="font-size:var(--fs-sm);color:var(--muted)">Texto de apoio.</p>
      <span class="pill st-vital"><span class="dt"></span>Ativo</span>
    </div>
  </section>

  <section class="band">
    <h2>A banda verde é para o que importa.</h2>
    <p>Reserve este bloco para a ação principal da página.</p>
    <button class="btn solid">Ação principal</button>
  </section>
</main>
```

O `<em>` dentro de `.display` sai em Synapse — é o único destaque de cor no
título, e só uma palavra.
