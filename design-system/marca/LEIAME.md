# Artes da marca

Cópias de preview das artes oficiais, no tamanho e formato que os cards do
Claude Design usam. Elas existem porque cada card renderiza isolado: um
`<img src="../../assets/logo.png">` não resolveria, então a arte entra
embutida como data URI dentro do HTML.

**Fonte da verdade continua sendo `assets/` no repositório** (e o
[Brandfetch](https://brandfetch.com/neurodynamics.dev) para quem é de fora).
O que está aqui é derivado.

## O que tem

| Arquivo | Derivado de | Tamanho |
| --- | --- | --- |
| `imagotipo.webp` | `imagotipo preto.png` | 600×102 · 9KB |
| `imagotipo-branco.webp` | `imagotipo branco.png` | 600×102 · 8KB |
| `simbolo.webp` | `NRO ICON (COLORED TRANSPARENT BACKGOUND).png` | 288×256 · 15KB |
| `icone-escuro.webp` | `NRO ICON MONOCHROMATIC.png` | 288×288 · 4KB |
| `icone-verde.webp` | `NRO SQUARE ICON (COLORED TRANSPARENT BACKGOUND).png` | 288×288 · 14KB |

Os 2,3MB de PNG viram 51KB de WebP — e o card do imagotipo fecha em 84KB.

Três decisões por trás dessa tabela:

- **As variantes transparentes.** Entre `OVER DARK`, `OVER WHITE` e
  `TRANSPARENT BACKGOUND`, a transparente é a que compõe sobre qualquer
  superfície. As outras trazem o fundo embutido e apareceriam como um
  retângulo branco ou preto no meio do card. A exceção é a `MONOCHROMATIC`,
  cujo fundo escuro faz parte do ícone.
- **WebP, não PNG.** As artes têm gradiente, que o PNG comprime mal. O ícone
  escuro sai de 363KB em PNG para 4KB em WebP, com a mesma imagem. Se um dia
  existir SVG, ele passa na frente dos dois.
- **Recorte na caixa do conteúdo.** Os PNGs de 1500px têm muita margem
  transparente em volta; sem recortar, a marca apareceria pequena e
  descentralizada dentro do card.

## Quando a marca mudar

Troque os PNGs em `assets/` e regenere:

```bash
npm i playwright-core     # única dependência, não versionada
node gerar-artes.mjs
node ../build.mjs
```

O `gerar-artes.mjs` recorta, reduz e reencoda; o `build.mjs` embute o
resultado nos previews. Qualquer outra ferramenta (ImageMagick, sharp,
Squoosh) serve, desde que o resultado bata com a tabela acima.

Se algum arquivo faltar, o `build.mjs` avisa e o card do imagotipo mostra
placeholders tracejados no lugar — o resto do sistema continua sincronizável.

## Sobre a versão branca

`imagotipo branco.png` é um arquivo próprio, não um filtro. O quadrado é
branco e o traço é vazado, então sobre o Void o traço aparece escuro e sobre
a banda verde aparece verde. Não gere uma versão a partir da outra com
`brightness(0) invert(1)`: o resultado inverte também o vazado.
