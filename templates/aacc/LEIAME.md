# Relatório de AACC — o template LaTeX

O relatório com que um membro (ou egresso) da NeuroDynamics pede ao seu
colegiado o aproveitamento de horas de **Atividades Acadêmicas Curriculares
Complementares**, no modelo de documentos da equipe (NRO-PUB-002). O
aproveitamento na Escola de Engenharia segue a Resolução da Congregação
nº 02/2019, de 31 de maio de 2019.

A equipe não é um órgão registrado da UFMG, e quem decide é o Colegiado. Por
isso o template é exigente de propósito: ele pede, de cada atividade, o que foi
feito, como, com que resultado e com que evidência — a placa com o esquemático
e o layout, a peça com o modelo e o cálculo, a simulação com o modelo e a
validação. Quem trabalhou de verdade tem o que escrever; quem não trabalhou
fica com as pendências na capa. O que chega ao Colegiado já passou pela direção
da equipe e pelo professor responsável, com nota.

**Veja o exemplo antes de começar:** `exemplo-relatorio-aacc.pdf` (no ZIP e em
brand.neurodynamics.dev, *Downloads*). É uma pessoa fictícia, com sete
atividades, sem nenhuma pendência — o nível que a equipe espera.

## O caminho

1. **O membro cria o registro no SOMA.** Em *Arquivos*, na série
   `NRO-PES-020` (*Relatório de atividades para aproveitamento de AACC*),
   *Novo PN*. O PN que o SOMA der vai em `\documento{pn = …}`.
2. **Emite a declaração de vínculo** (SOMA › Serviços › Declaração de vínculo)
   e salva o PDF em `anexos/declaracao-vinculo.pdf`. O código verificador dela
   vai em `\membro{verificador = …}`.
3. **Escreve o relatório** — abaixo, *Como escrever*.
4. **Passa para `final`** (`\documentclass[final]{nro-aacc}`). A capa diz
   *SEM PENDÊNCIAS* ou *NÃO ENCAMINHE*, e a lista do que falta está logo
   depois dos quadros do pedido.
5. **Sobe o PDF no SOMA** como revisão do seu PN. O grupo revisor da série (a
   direção da equipe) confere com os registros, ouve os supervisores e
   preenche o *Parecer da direção da equipe* (Parte V).
6. **O professor responsável** avalia pelo barema, dá a nota (0 a 100, com o
   conceito da UFMG) e assina o *Parecer e nota*.
7. **O membro entrega ao Colegiado**, pelo meio que o colegiado usar (e-mail,
   SEI, formulário próprio). Se o colegiado tem formulário próprio, o
   relatório vai como anexo dele. A *Deliberação do Colegiado* (Parte V) tem o
   espaço para ele aprovar as horas em outra modalidade, no todo ou em parte.

Os campos dos pareceres se preenchem no próprio PDF (Acrobat, Edge, Preview) ou
à mão. A assinatura pode ser digital, pelo gov.br. Para imprimir sem os campos
do formulário, use a opção `impresso`.

## Como escrever

Abra no Overleaf (*Abrir no Overleaf*, em brand.neurodynamics.dev) ou compile
localmente com `latexmk -pdf relatorio-aacc.tex` (TeX Live 2022 ou mais novo,
com `biber`). O arquivo que você edita é o `relatorio-aacc.tex`.

- **Os seus dados** (`\estudante`, `\membro`, `\documento`) vão no começo do
  arquivo. Datas como `AAAA-MM`; horas como número.
- **As modalidades**: para cada uma em que você pede horas, o código da
  atividade no quadro de AACC do seu curso e o dispositivo da norma do seu
  colegiado: `\modalidade{EXT}{codigo = …, dispositivo = {Res. 02/2019, art. …}}`.
  A lista das modalidades está na Parte I do próprio relatório.
- **Uma atividade por arquivo**, em `atividades/`. Copie o modelo do tipo
  certo de `modelos/` — ele já traz a ficha técnica e as perguntas do tipo — e
  inclua o arquivo no `relatorio-aacc.tex` com `\input{atividades/…}`. Uma
  atividade é uma entrega, com começo, meio e fim: "participei do projeto por
  dois anos" são várias atividades.
- **Cada atividade tem**: a ficha (tipo, modalidade pedida e alternativa,
  horas, período, projeto, papel, quem confirma, registros no SOMA,
  competências, disciplinas); as seções *Contexto e problema*, *Minha
  contribuição*, *Desenvolvimento técnico*, *Resultados*, *Evidências* e
  *Aprendizados*; a ficha técnica do tipo; e as figuras que o tipo pede.
- **Evidência** é o que alguém de fora consegue conferir:
  `\evidencia{tipo}{identificador}{o que mostra}{onde conferir}` — o código
  de um arquivo controlado, de um cartão, um commit, uma declaração com código
  verificador. Atividade sem evidência não conta.
- **Figuras**: exporte do KiCad, do CAD, do simulador (PDF, de preferência) para
  `figuras/` e use `\includegraphics`. A `\figuraprovisoria` dos modelos é
  pendência até ser trocada.
- **Nada confidencial**: nem dados de pacientes ou de participantes (LGPD), nem
  informação de projeto que a equipe não divulga. Na dúvida, pergunte ao
  supervisor antes de pôr a figura.

### O que o template confere sozinho

Tudo o que falta vira uma **pendência**: aparece no PDF (caixa amarela no
rascunho, vermelha no final), entra na lista do começo e na conta da capa.

| Confere | Como |
|---|---|
| Os seus dados e os da equipe | cada campo obrigatório vazio |
| A ficha de cada atividade | tipo, modalidade, horas, período, projeto, papel, quem confirma, registros, competências |
| As seções da atividade | as seis têm de existir |
| As evidências | ao menos uma por atividade |
| As figuras | o mínimo do tipo (2 para placa, peça e simulação; 1 para software, ensaio e comunicação) |
| A ficha técnica | os campos obrigatórios do tipo |
| O pedido | o código e o dispositivo de cada modalidade usada |
| A Parte II | a trajetória e os afastamentos declarados |
| A autoavaliação | as seis notas |
| Os anexos | o PDF da declaração de vínculo |

E calcula: as horas e os créditos por modalidade (15 h por crédito), o
requerimento ao Colegiado, a lista das atividades com a página de cada uma, a
média semanal das horas pedidas (e avisa acima de 20 h), a matriz das
competências das DCN de Engenharia, o quadro das disciplinas e o índice de todas
as evidências (Anexo A).

### Antes de encaminhar

- [ ] Em `final`, a capa diz **SEM PENDÊNCIAS**.
- [ ] A declaração de vínculo é recente e está em `anexos/`.
- [ ] Toda atividade tem evidência que outra pessoa consegue conferir.
- [ ] As figuras são as de verdade, e o supervisor liberou as de projeto.
- [ ] As horas batem com a memória de cálculo e não aparecem em outra atividade acadêmica.
- [ ] Os supervisores de *Quem confirma* sabem que serão consultados.
- [ ] Nenhum dado pessoal de terceiros, nenhuma informação confidencial.

## Para a Diretoria

**Antes de publicar o template**, preencha `nro/equipe.tex`: o professor
responsável (com o título e o departamento), o dirigente que assina o parecer
da equipe e os dados da ação de extensão no SIEX (título, número, coordenador,
vigência). Enquanto estiverem vazios, todo relatório nasce com essas
pendências — de propósito.

**A série no SOMA.** O código `NRO-PES-020` é uma proposta. Em *Arquivos ›
Adicionar › Série nova*, crie a série do Pessoal com a estrutura *Template →
registros*, o grupo revisor (a direção da equipe) e a classe *controlado*. Se o
número não for 020, troque-o em `nro/equipe.tex`.

**As regras moram em `nro/`**, fora da classe, para a equipe ajustar sem mexer
em código:

| Arquivo | O que tem |
|---|---|
| `nro/equipe.tex` | a série, o professor, o dirigente, o SIEX, a norma, horas por crédito, média semanal máxima |
| `nro/institucional.tex` | a Parte I — a equipe apresentada ao Colegiado (o vínculo com a UFMG, a governança, o SOMA, o padrão exigido) |
| `nro/modalidades.tex` | o catálogo das modalidades de aproveitamento |
| `nro/tipos.tex` | os tipos de atividade: a ficha técnica, as figuras mínimas e o roteiro de cada um |
| `nro/avaliacao.tex` | o barema do professor (os pesos somam 100) e as competências das DCN |

A lista de repercussão da Parte I espelha a imprensa do site institucional
(SOMA › Studio › Configurações › Imprensa do site); quando entrar matéria nova
lá, atualize aqui.

**Os dispositivos da Resolução nº 02/2019 não vêm preenchidos.** Cada membro
informa o artigo e o inciso do seu curso. Quando a equipe conferir o texto
oficial e o quadro de AACC dos cursos mais comuns, vale pôr um exemplo por
modalidade no comentário do `relatorio-aacc.tex`.

**Os modelos de `modelos/`** seguem os campos de `nro/tipos.tex`. Mudou um tipo,
confira o modelo dele.

**Publicar uma versão nova** (o ZIP e o PDF do exemplo em `assets/`, que o site
serve): rode `./empacotar.sh` nesta pasta, com TeX Live, `latexmk`, `biber` e
`zip`. Ele compila o template e o exemplo numa cópia limpa e só gera os arquivos
se os dois compilarem.

## Para o professor responsável

O *Parecer e nota* (Parte V) tem o barema de seis critérios — aderência à
formação (15), profundidade técnica (25), contribuição individual (20),
evidências e rastreabilidade (15), resultados e impacto (15) e comunicação (10).
Cada critério recebe de 0 a 10; os pontos são a nota vezes o peso, dividida por
10; a nota final é a soma (0 a 100), com o conceito da UFMG. O mesmo barema está
na autoavaliação do estudante, na Parte IV.

## Os arquivos

```
relatorio-aacc.tex          o relatório — o arquivo que o membro edita
nro-aacc.cls                a classe (o modelo NRO-PUB-002 e toda a lógica)
referencias.bib             as referências, em ABNT
nro/                        o que é da equipe (a Diretoria mantém)
atividades/                 as atividades do membro, uma por arquivo
modelos/                    um modelo por tipo de atividade, para copiar
figuras/                    as figuras do membro
anexos/                     os PDFs anexos (a declaração de vínculo…)
exemplo-relatorio-aacc.tex  o exemplo fictício (fora do ZIP; o PDF vai junto)
exemplo/                    as atividades e as figuras do exemplo
empacotar.sh                gera o ZIP e o PDF do exemplo em ../../assets
```
