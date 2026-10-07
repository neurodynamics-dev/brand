# Manual da marca NeuroDynamics

Site estático em `brand.neurodynamics.dev`, com páginas independentes: `/marca`, `/cores`, `/tipografia`, `/escrita`, `/elementos`, `/aplicacoes` e `/galeria`. A página inicial redireciona os hashes anteriores. Assinaturas, materiais controlados e ferramentas de criação ficam em **SOMA › Marca**.

## Desenvolvimento

```sh
npm ci --prefix scripts
node scripts/servir.mjs
```

O servidor usa `127.0.0.1:8766` e resolve os mesmos endereços sem `.html` do GitHub Pages. Não precisa de credenciais.

- Conteúdo: arquivos HTML na raiz; estilos e comportamento em `site/`.
- Cabeçalho e rodapé: `site/partes/`. Depois de editar, rode `node scripts/carimbar.mjs`.
- Fontes da marca: `design-system/tokens.css`, `neuro.css`, `formal.css` e `DIRETRIZES.md`.
- Integração SOMA: `design-system/portal.css`, `select.css` e `select.js`.
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

## Decisões de marca pendentes

As regras de redução mínima da marca, unidade de área de proteção e equivalências oficiais CMYK/Pantone dependem da validação dos responsáveis pela marca. Não foram inventadas medidas ou equivalências nesta implementação.
