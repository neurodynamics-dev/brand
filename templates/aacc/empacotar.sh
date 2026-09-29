#!/usr/bin/env bash
# ============================================================
# empacotar.sh — publica o template do relatório de AACC no site
#
# Gera, em ../../assets (o que brand.neurodynamics.dev serve):
#   template-relatorio-aacc.zip   o template, para baixar ou abrir no Overleaf
#                                 (com o PDF do exemplo dentro)
#   exemplo-relatorio-aacc.pdf    o exemplo fictício, compilado
#
# Compila o template e o exemplo numa cópia limpa: se um dos dois não
# compilar, nada é gerado. Pede TeX Live (2022 ou mais novo) com
# latexmk e biber, e o zip.
# ============================================================
set -euo pipefail
cd "$(dirname "$0")"
ASSETS="$(cd ../../assets && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cp -r . "$TMP/fonte"
cd "$TMP/fonte"
rm -f ./*.aux ./*.bbl ./*.bcf ./*.blg ./*.fdb_latexmk ./*.fls ./*.log ./*.out ./*.run.xml ./*.toc ./*.pdf

echo "compilando o template…"
latexmk -pdf -interaction=nonstopmode -halt-on-error -quiet relatorio-aacc.tex > /dev/null
echo "compilando o exemplo…"
latexmk -pdf -interaction=nonstopmode -halt-on-error -quiet exemplo-relatorio-aacc.tex > /dev/null
if grep -q "pendencia(s)" exemplo-relatorio-aacc.log; then
  echo "o exemplo tem pendências — confira antes de publicar" >&2
  exit 1
fi

# o ZIP: o que o membro usa, sem o exemplo em LaTeX (ele tem o seu próprio
# \documentclass, e o Overleaf precisa de um documento principal só)
mkdir "$TMP/zip"
cp -r LEIAME.md relatorio-aacc.tex nro-aacc.cls referencias.bib nro atividades modelos figuras anexos "$TMP/zip/"
cp exemplo-relatorio-aacc.pdf "$TMP/zip/"
rm -f "$ASSETS/template-relatorio-aacc.zip"
(cd "$TMP/zip" && zip -q -r -X "$ASSETS/template-relatorio-aacc.zip" .)
cp exemplo-relatorio-aacc.pdf "$ASSETS/exemplo-relatorio-aacc.pdf"

echo "pronto:"
ls -la "$ASSETS/template-relatorio-aacc.zip" "$ASSETS/exemplo-relatorio-aacc.pdf"
