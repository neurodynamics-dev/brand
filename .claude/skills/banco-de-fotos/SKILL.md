---
name: banco-de-fotos
description: Use ao criar artes, publicações, wallpapers, banners do LinkedIn, capas, apresentações ou qualquer asset da NeuroDynamics que leve foto. Busca as fotos que a equipe pôs no banco de fotos da marca (SOMA), com tema, tags, autor e licença, e baixa as imagens no tamanho certo.
---

# O banco de fotos da marca

As fotos da NeuroDynamics moram no **banco de fotos do SOMA**. A gestão do
Studio escolhe o que entra (Studio › Curadoria de fotos) e a equipe vê tudo em
Marca › Galeria de fotos. Para peças da marca, use **só fotos do banco**. Não
busque fotos fora dele sem a pessoa pedir.

## Como ler o banco

Da raiz deste repositório:

```bash
node scripts/fotos.mjs                          # o banco todo, em tabela
node scripts/fotos.mjs --tag UTI --tag monitor  # com alguma dessas tags
node scripts/fotos.mjs --tema hospital          # de um tema (laboratorio, hospital, equipe...)
node scripts/fotos.mjs --busca microscópio      # texto na descrição, nas tags ou no autor
node scripts/fotos.mjs --json                   # o JSON, para escolher com calma
node scripts/fotos.mjs --baixar saida/ --largura 2560 --tema laboratorio
```

`--baixar` grava as imagens e um `creditos.json` com a descrição, o autor, o
banco, a licença e a página de cada foto. Sem o repositório, a mesma leitura
sai direto da função pública do SOMA:

```bash
curl -s -X POST "https://rxzmkyjttzzpwtodqkve.supabase.co/rest/v1/rpc/fotos_banco_publico" \
  -H "apikey: $SOMA_CHAVE" -H "Authorization: Bearer $SOMA_CHAVE" -H "Content-Type: application/json" \
  -d '{"p_tags":["UTI"],"p_tema":null}'
```

A chave é a publicável do SOMA, a mesma do site, e está em `scripts/fotos.mjs`.
A função devolve só as fotos aprovadas e só os campos públicos: `banco`,
`banco_id`, `pagina`, `imagem` (o endereço no CDN do banco), `descricao`,
`tema`, `tema_nome`, `familia` (a família de cor do tema), `tags`, `autor`,
`licenca`, `enquadramento` e `paleta`.

- O banco muda. Consulte na hora de criar e não guarde a lista como verdade.
- Se a função não responder (antes da migração 2.25.0 do SOMA no Supabase),
  peça à pessoa a lista de *Copiar a lista*, em Marca › Galeria de fotos.
- Foto sem `imagem` ainda não tem o endereço do CDN e fica de fora. Quem tem a
  chave do banco resolve isso abrindo a foto na curadoria do SOMA.

## Como usar as fotos

- **Chapado, sem degradê.** A equipe prefere peças chapadas: cor sólida, sem
  degradê, brilho, desfoque nem halo. Texto sobre foto ganha um véu uniforme
  ou uma faixa sólida, nunca um degradê. Vale também para os modelos
  expressivos de `templates/`, que ainda têm brilho.
- **A foto como está.** Retangular ou com raio de 18px, sem filtro, sem
  duotone, sem recolorir. Recorte com `object-fit: cover`, nunca estique.
- **Uma família por superfície.** A `familia` da foto sugere a família da
  peça. Regras de cor, tipografia e marca em `design-system/v3/readme.md` (a
  skill `neurodynamics-design`).
- **Crédito.** Unsplash e Pexels não exigem, mas a marca credita: "Foto: Nome /
  Unsplash" no rodapé da peça, quando cabe, e a lista no fim de documentos.
  Guarde o `creditos.json` junto da peça.
- **Resolução.** Peça ao CDN a largura que a peça usa: `--largura`, ou o
  parâmetro `w` no endereço do Unsplash (`&w=2560&fm=jpg&q=85&fit=max`).

## Tamanhos de sempre

| Peça | Tamanho (px) | Onde está o modelo |
| --- | --- | --- |
| Feed (Instagram, LinkedIn) | 1080 × 1350 | `templates/social/` |
| Story | 1080 × 1920 | `templates/social/` |
| Banner do perfil no LinkedIn | 1584 × 396 | `templates/social/` |
| Capa da página da empresa no LinkedIn | 1128 × 191 | (sem modelo; use o banner como base) |
| Wallpaper de computador | 2560 × 1440 | `templates/wallpapers/` |
| Wallpaper de celular | 1179 × 2556 | `templates/wallpapers/` |
| Wallpaper de tablet | 2048 × 2732 | `templates/wallpapers/` |
| Fundo de videochamada | 1920 × 1080 | `templates/wallpapers/` |

No banner do LinkedIn, o canto inferior esquerdo fica coberto pela foto do
perfil: deixe a marca e o texto do meio para a direita. No wallpaper de
celular, o relógio ocupa o terço de cima: a parte forte da foto vai para o
meio ou para baixo.
