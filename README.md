# Manual da marca NeuroDynamics

Site estático em `brand.neurodynamics.dev`, com páginas independentes: `/marca`, `/cores`, `/tipografia`, `/escrita`, `/elementos`, `/aplicacoes` e `/galeria`. A página inicial redireciona os hashes anteriores. Assinaturas, materiais controlados e ferramentas de criação ficam em **SOMA › Marca**.

## Desenvolvimento

```sh
npm ci --prefix scripts
node scripts/servir.mjs
```

O servidor usa `127.0.0.1:8766` e resolve os mesmos endereços sem `.html` do GitHub Pages. Não precisa de credenciais.

- Conteúdo: arquivos HTML na raiz; estilos e comportamento em `site/`.
- Design system: `design-system/tokens.css`, `neuro.css`, `casca.css`, `casca.js`, `formal.css`, `select.*`; regras em `design-system/v3/` (ver `design-system/DIRETRIZES.md`).
- Cabeçalho e rodapé: saem de `design-system/casca.js`, os mesmos dos outros sites. Depois de mudar a casca ou os capítulos, rode `node scripts/montar.mjs`, que gera todas as páginas do manual.
- Consumidores: `node scripts/distribuir.mjs` copia o design system para `ds/` em membro, website e selecao; `node scripts/auditar.mjs <pasta>` roda o checklist de interface.
- Templates de peças: `templates/`. Dados pessoais dos exemplos são fictícios.

## Gerar imagens e conferir

Com o servidor iniciado e Chromium instalado (`CHROMIUM_PATH` permite indicar outro executável):

```sh
node scripts/gerar-miniaturas.mjs
node scripts/gerar-downloads.mjs
node scripts/conferir.mjs
node design-system/build.mjs --check
```

As fontes dos renderizadores vêm das dependências locais `@fontsource`; não é necessário liberar TLS nem carregar fontes remotas para gerar imagens. `assets/manual/index.json` registra a origem de cada miniatura. `downloads/index.json` lista as dimensões dos 16 wallpapers e da capa de LinkedIn. Os scripts sobrescrevem somente as imagens geradas correspondentes.

Não há backend nem login no manual público. Documentos controlados continuam sujeitos à permissão de Arquivos no SOMA. A versão publicada deve acompanhar a atualização do portal para que os downloads novos estejam disponíveis.

## Relatório de AACC (LaTeX)

A pasta [`templates/aacc/`](templates/aacc/) é o template com que um membro ou egresso pede ao Colegiado do curso o aproveitamento de Atividades Acadêmicas Curriculares Complementares, pela Resolução nº 02/2019 da Congregação da Escola de Engenharia (ou pela norma de outro Colegiado), no desenho do relatório formal: a classe `nro-aacc.cls`, o relatório que a pessoa edita, um modelo por tipo de atividade, as regras da equipe em `nro/` e um exemplo fictício completo. O pedido começa no SOMA (Serviços, Aproveitamento de AACC), que gera o ZIP com os dados da pessoa, conduz as aprovações e devolve o PDF com a folha de aprovação autenticável. O passo a passo está no [`LEIAME.md`](templates/aacc/LEIAME.md); a peça está em `/aplicacoes/relatorio-aacc`.

O site serve `assets/template-relatorio-aacc.zip` (o SOMA o baixa) e `assets/exemplo-relatorio-aacc.pdf`. Mudou o template? Rode `templates/aacc/empacotar.sh`, que compila tudo e gera os dois de novo; as prévias da peça (`assets/manual/aacc-capa.jpg` e `aacc-atividade.jpg`) são as páginas 1 e 13 do exemplo, com `pdftoppm -jpeg -scale-to-x 800`.

## Decisões de marca pendentes

As regras de redução mínima da marca, unidade de área de proteção e equivalências oficiais CMYK/Pantone dependem da validação dos responsáveis pela marca. Não foram inventadas medidas ou equivalências nesta implementação.
