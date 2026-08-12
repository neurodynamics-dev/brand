# Artes da marca

Esta pasta guarda os arquivos que o preview `previews/05-marca.html` embute
como data URI. Ela existe porque cada card do Claude Design renderiza isolado:
um `<img src="../assets/logo.png">` não resolveria, então a arte precisa estar
dentro do HTML.

## O que colocar aqui

Quatro arquivos, com estes nomes exatos:

| Nome            | O que é                                              |
| --------------- | ---------------------------------------------------- |
| `imagotipo`     | marca horizontal completa (símbolo + logotipo), versão preta |
| `simbolo`       | o traço sozinho, em gradiente verde, sem fundo       |
| `icone-escuro`  | traço claro sobre quadrado escuro — ícone de app padrão |
| `icone-verde`   | traço branco sobre quadrado verde                    |

Extensões aceitas, nesta ordem de preferência: **`.svg`**, `.png`, `.webp`.

O SVG é preferido por dois motivos: escala sem perda em qualquer tamanho do
preview e pesa muito menos dentro do data URI (um PNG de 512px vira ~75KB de
base64 em cada arquivo que o usa).

A versão branca do imagotipo não é um arquivo separado — ela é gerada a partir
da preta com `filter:brightness(0) invert(1)`, como já acontece em `index.html`.

## Depois de colocar os arquivos

```bash
node ../build.mjs
```

O script embute as artes em `05-marca.html`, remove o aviso de "arte pendente"
e atualiza o manifesto. Enquanto faltar algum arquivo, o preview mostra
placeholders tracejados no lugar das artes — ele continua válido e sincronizável,
só sem as imagens.

## Fonte da verdade

O repositório não é a fonte canônica da marca: o **Brandfetch** é
(<https://brandfetch.com/neurodynamics.dev>). Os arquivos aqui são uma cópia de
trabalho para a documentação renderizar sozinha. Se a marca mudar no Brandfetch,
troque os arquivos aqui e rode o build de novo.
