Quatro níveis de superfície: Void, cartão, painel e vidro — sem sombra separando.

**Classes e tokens:** `.card` `.panel` `.glass` `.claro`

A hierarquia vem de fundo, borda e desfoque, não de sombra. Sombra só no que
flutua de verdade: cabeçalho, toast e diálogo.

- `.card` — a superfície padrão do conteúdo (branco a 3%, borda a 8%)
- `.panel` — opaca, borda mais visível; para blocos de controle e formulário
- `.glass` — só sobre conteúdo em movimento; pesa no celular, use pouco
- `.claro` — fundo Aura com texto Blackout; documento, assinatura, impresso

Não empilhe `.card` dentro de `.card`: dois fundos translúcidos somam opacidade
e viram uma mancha sem hierarquia.

---
Card completo com todos os estados: `components/Fundamentos/Superficies/Superficies.html`
