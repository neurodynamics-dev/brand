# Apostila: o template LaTeX para material didático

Template de apostilas, trilhas de formação e guias de estudo da NeuroDynamics, no modelo de documento controlado (NRO-PUB-002) e no modo operacional do design system: Cortex chapado nas capas, Archivo nos títulos, Instrument Sans no texto, IBM Plex Mono só em códigos. Derivado do template de AACC (`../aacc/`).

O exemplo completo é o **NRO-PRO-014-1, General onboarding: Projects practical technologies introduction** (68 páginas, 5 partes, 85 tópicos).

## Arquivos

| Arquivo | O que é |
|---|---|
| `nro-apostila.cls` | A classe: folha, capas, estrutura de estudo, sumário, ficha de progresso |
| `modelo-apostila.tex` | O modelo em branco, com todos os blocos comentados. Comece por ele |
| `NRO-PRO-014-1.tex` e `partes/` | O exemplo: introdução no arquivo principal, uma parte por arquivo |
| `NRO-PRO-014-1.pdf` | O exemplo compilado |
| `fonts/` | Archivo, Instrument Sans e IBM Plex Mono (licença OFL, textos incluídos) |
| `nro/` | Imagotipos preto (cabeçalho) e branco (capas) |
| `latexmkrc` | Faz o `latexmk` e o Overleaf usarem LuaLaTeX |

## Como compilar

A classe pede **LuaLaTeX** (as fontes da marca são carregadas por arquivo). No Overleaf: *Novo projeto, Carregar projeto*, o ZIP da pasta, e *Menu, Compilador, LuaLaTeX*. Na linha de comando, com TeX Live 2022 ou mais novo (pacotes `tcolorbox`, `tikz`, `enumitem`, `xltabular`, `csquotes`, `newunicodechar`, `ulem`, `TeX Gyre Heros`):

```sh
latexmk -lualatex modelo-apostila.tex
```

O sumário, os totais (partes, tópicos, exercícios), os níveis na capa de cada parte e a ficha de progresso são montados do `.aux`: compile duas vezes (o `latexmk` já faz).

## Como escrever

1. Na capa, `tipo` vai no canto superior direito (acima do código), `titulo` é o destaque, `emissor` aparece acima do título e `autor`, `data` e `revisao` formam a ficha logo abaixo da síntese (`subtitulo`). A primeira folha interna, "Sobre este documento", reúne objetivo, escopo, controle do documento e histórico de revisões.
2. Peça o código ao controle de documentos (NRO-PUB-001) e preencha `\documento{...}`. O código sai como `NRO-XXX-000-N` e a revisão (A, B, C) no cabeçalho, como pede o NRO-PUB-002.
3. Estrutura de estudo, tudo numerado sozinho:

| Comando | Faz |
|---|---|
| `\begin{parte}{Título}{abertura}` com `\item` | Capa da parte e "Você vai aprender a". No fim entram sozinhos os níveis (se houver `\nivel`) ou a lista dos tópicos |
| `\nivel{Básico}{descrição}` | Faixa do nível, com a faixa de tópicos e a contagem |
| `\topico{Título}` | Tópico `parte.ordem`, no sumário e na ficha |
| `noproduto`, `paraestudar` (`\leitura{url}{texto}`), `pratique` | Os blocos de um tópico. O rótulo do primeiro vem de `rotuloproduto` |
| `\pagina{Rótulo}{Título}`, `\apendice{Título}`, `\lede{}` | Páginas de introdução e apêndices |
| `nota`, `atencao`, `definicao`, `\cartao`, `estatisticas` | Quadros e números em destaque |
| `glossario` com `\termo`, `\fichaprogresso`, `\controledocumento`, `historico`, `\contracapa` | O fecho do documento |

4. Tabelas: `tabularx` com `\reguatopo`, `\reguameio`, `\reguafina`, `\reguabase` e `\cab{}` (o DataTable do design system, sem zebra). Diagramas: estilos de TikZ `nro bloco`, `nro claro`, `nro medio`, `nro forte`, `nro seta`, `nro ponte` (veja o mapa das trilhas no exemplo).
5. `\iniciarpartes{1}` faz a primeira parte ser a 1 (o padrão é a Parte 0).

## Regras da marca que o template já cumpre

Texto alinhado à esquerda; títulos em caixa de frase; rótulos em Archivo 600 caixa alta; Plex Mono só em código e dado; sem pontos médios nem travessões como separador (use vírgula ou o próprio layout); Synapse apenas como acento sobre fundo escuro; uma família de cor (Cortex) mais neutros; imagotipo só na capa, no cabeçalho de documento controlado e na contracapa; tipo do documento e código no canto superior direito da capa. O cabeçalho e o rodapé seguem o NRO-PUB-002 (departamento, título, código e revisão), alinhados à mancha de texto de 22 mm.

## Observações

- Os exercícios se numeram pelo tópico (0.1.1, 0.1.2) para poderem ser citados.
- A numeração `-N` do código (NRO-PRO-014-**1**) é a chave `numero`.
- O PDF do exemplo foi gerado sem revisor e aprovador: o quadro de controle mostra "a preencher" até a Diretoria registrar os nomes no NRO-PUB-001.
