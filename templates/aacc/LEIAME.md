# Relatório de AACC: o template LaTeX

O relatório com que um membro (ou egresso) da NeuroDynamics pede ao seu colegiado
o aproveitamento de **Atividades Acadêmicas Curriculares Complementares**, no
modelo de documentos da equipe (NRO-PUB-002) e no registro formal do design
system. O aproveitamento na Escola de Engenharia segue a **Resolução nº 02/2019,
de 31 de maio de 2019, da Congregação**, e o relatório é escrito em cima dela.

Quem decide é o Colegiado. Para a equipe de competição estudantil, a resolução
pede o relatório das atividades aprovado pelo responsável pela equipe e pelo
professor responsável, e a declaração do período de participação (art. 11). A
participação no Cybathlon está registrada no SIEX/UFMG como a ação de extensão
*Competição Cybathlon 2024* (nº 205234), o que sustenta tanto o enquadramento
como equipe de competição quanto o de extensão. O template pede, de cada
atividade, o que foi feito, como, com que resultado e com que evidência; o que
falta vira pendência, e o SOMA não aceita relatório com pendência.

A resolução é da Escola de Engenharia. Estudantes de outras unidades (EEFFTO,
Faculdade de Medicina, Escola de Enfermagem, ICEx, FACE) pedem pelo
enquadramento **OUT**, com a norma do próprio Colegiado.

**Veja o exemplo antes de começar:** `exemplo-relatorio-aacc.pdf` (no ZIP e em
brand.neurodynamics.dev, *Downloads*). É uma pessoa fictícia, com oito
atividades e nenhuma pendência: o nível que a equipe espera.

## O caminho

O pedido começa e termina no SOMA, em **Serviços, Aproveitamento de AACC**
(`membro.neurodynamics.dev/aproveitamento`).

1. **Os seus dados.** A página confere o que falta na sua ficha (os dados do
   recadastro, inclusive os pronomes, com que o relatório concorda) e os dados
   acadêmicos: o curso (de uma lista; o curso escolhe as competências da Parte
   IV), a matrícula, o semestre de ingresso, a entrada e a saída da equipe.
2. **O enquadramento.** O painel mostra o que a resolução permite e quantos
   créditos cada opção rende com os seus semestres. Você escolhe o principal e,
   se quiser, alternativas para o Colegiado.
3. **O ZIP.** O SOMA gera o template com o `soma.tex`: os seus dados, o número
   do pedido e o enquadramento escolhido.
4. **A escrita.** No Overleaf: *Novo projeto, Carregar projeto*, e o ZIP. O
   arquivo que você edita é o `relatorio-aacc.tex`; as atividades vão em
   `atividades/`.
5. **O envio.** Em `final`, sem pendência, baixe o PDF e envie na mesma página
   do SOMA. Ele confere que o PDF é deste template, do seu pedido e sem
   pendência.
6. **As aprovações.** O pedido passa por três instâncias da equipe, nesta ordem:
   o PMO, o Departamento de Pessoal e a Diretoria. Aprova uma pessoa de cada
   grupo, nunca quem pediu, e cada uma pode devolver o pedido com o motivo. Na
   última etapa, a Diretoria indica o professor orientador (nome, título,
   e-mail, departamento e unidade acadêmica), que recebe o pedido por e-mail, lê
   o relatório, atribui a nota pelo barema e aprova no próprio SOMA. Você é
   avisado por e-mail a cada passo.
7. **A folha de aprovação.** Aprovado, o SOMA troca a segunda folha do PDF (a
   *folha reservada*) pela folha de aprovação: as aprovações, a nota, a
   declaração do período e o código verificador, conferível em
   `auth.neurodynamics.dev`. Na capa, o *Pendente* da avaliação da equipe vira a
   data da aprovação. Baixe o PDF final e entregue ao seu Colegiado, pelo
   meio que ele usar (o Centro de Graduação, o SEI, o formulário do curso; art.
   6º).
8. **Se o Colegiado apontar algo.** Reabra o pedido no SOMA: a folha de
   aprovação é revogada (a validação passa a dizer isso), você corrige, envia o
   PDF de novo e o pedido passa pelas aprovações outra vez.

## O enquadramento

A resolução classifica as atividades em projeto, programa, evento e estágio (art.
1º) e dá a regra de crédito de cada uma. O pedido tem duas partes.

**A participação na equipe**, por inteiro, num enquadramento principal e, se
quiser, em alternativas:

| Chave | Enquadramento | Dispositivo | Créditos |
|---|---|---|---|
| EQC | Participação em equipe de competição estudantil | art. 1º, II, c; art. 11 | 3 por semestre letivo |
| EXT | Projeto de extensão com vínculo formal | art. 1º, I, c; arts. 3º e 8º | 3 por semestre com registro no SIEX |
| VPC | Vivência profissional complementar | art. 1º, IV, a; art. 17 | 1 a cada 300 horas |
| OUT | Outro enquadramento, pela norma do Colegiado | a norma do Colegiado | a definir pelo Colegiado |

No OUT, descreva o enquadramento em `outro` (no `\pedido`) e troque a norma com
`\equipe{norma = …, normacurta = …}`; o Quadro 1 mostra as horas e deixa os
créditos a definir.

**As atividades que contam à parte** (art. 7º: uma atividade conta numa AACC
só), cada uma com a sua regra:

| Chave | Atividade | Dispositivo | Créditos |
|---|---|---|---|
| PUB | Publicação | art. 1º, I, d; art. 9º | 1 (evento nacional), 2 (internacional), 3 (revista indexada, periódico, livro, patente) |
| EVO | Organização de evento técnico-científico | art. 1º, III, b; art. 14 | 1 a cada 7,5 h de duração do evento |
| EVP | Participação em evento técnico-científico | art. 1º, III, a; art. 14 | 1 a cada 15 h de duração do evento |
| CUR | Curso presencial ou a distância | art. 1º, III; art. 15 | 1 a cada 15 h de curso |
| VOL | Voluntariado | art. 1º, II, g; art. 12 | 1 a cada 15 h |

**Os semestres.** O 1º semestre vai de fevereiro a julho, e o 2º, de agosto a
janeiro. Conta o semestre com ao menos quatro meses de participação, descontados
os afastamentos, e posterior ao ingresso no curso (art. 5º). O SOMA e a classe
contam do mesmo jeito; o Quadro 3 do relatório mostra a conta.

Cada colegiado define quantos créditos o curso aceita (art. 2º). Se o quadro de
AACC do seu curso tem o código da atividade ou um limite, informe com
`\modalidade{EQC}{codigo = …, limite = …}`; o Quadro 1 avisa se o pedido passar
do limite.

## Como escrever

Abra no Overleaf ou compile localmente com `latexmk -pdf relatorio-aacc.tex`
(TeX Live 2022 ou mais novo, com `biber`).

- **Os seus dados** chegam no `soma.tex`. Um campo vazio no `relatorio-aacc.tex`
  não apaga o que veio do SOMA; preencha só o que faltar (o colegiado, o
  supervisor, a dedicação semanal). Não edite o `soma.tex`: corrija no SOMA e
  baixe de novo.
- **Uma atividade por arquivo**, em `atividades/`. Copie o modelo do tipo certo
  de `modelos/` (ele já traz a ficha técnica e as perguntas do tipo) e inclua o
  arquivo no `relatorio-aacc.tex` com `\input{atividades/…}`. Uma atividade é
  uma entrega, com começo, meio e fim: "participei do projeto por dois anos" são
  várias atividades.
- **Cada atividade tem**: a ficha (tipo, aproveitamento, horas, período,
  projeto, papel, quem confirma, registros no SOMA, competências, disciplinas);
  as seções *Contexto e problema*, *Minha contribuição*, *Desenvolvimento
  técnico*, *Resultados*, *Evidências* e *Aprendizados*; a ficha técnica do
  tipo; e as figuras que o tipo pede.
- **O aproveitamento da atividade** é `participacao` (o comum: ela compõe o
  enquadramento do pedido) ou a chave de uma atividade à parte. A publicação
  pede `publicacao = nacional` (ou `internacional`, `revista`, `periodico`,
  `livro`, `patente`); o evento e o curso pedem `duracao`, em horas.
- **Evidência** é o que alguém de fora consegue conferir:
  `\evidencia{tipo}{identificador}{o que mostra}{onde conferir}`. O código de um
  arquivo controlado, de um cartão, um commit, uma declaração com código
  verificador. Atividade sem evidência não conta.
- **Sem registro no SOMA** (atividade anterior a ele, ou registro a que você não
  tem acesso): use o arquivo do projeto, o repositório, fotos datadas, e-mails
  ou a confirmação do supervisor, e anexe o que puder em `anexos/`. Os
  comentários da Parte III do `relatorio-aacc.tex` e de cada modelo trazem
  exemplos.
- **A trajetória** é uma lista editável: um `\marco{AAAA-MM}{texto}` por linha,
  em ordem.
- **Códigos** (`NRO-PRO-003-7`, `CERT-…`) vão com `\cod{…}`: saem na fonte dos
  rótulos e nunca quebram.
- **Figuras**: exporte do KiCad, do CAD, do simulador (PDF, de preferência) para
  `figuras/` e use `\includegraphics`. A `\figuraprovisoria` dos modelos é
  pendência até ser trocada.
- **Tabelas**: no estilo do relatório, com `\reguatopo`, `\cab{…}`,
  `\reguameio`, `\reguafina` e `\reguabase` (veja as do exemplo).
- **Nada confidencial**: nem dados de pacientes ou de participantes (LGPD), nem
  informação de projeto que a equipe não divulga. Na dúvida, pergunte ao
  supervisor antes de pôr a figura.

### O que o template confere sozinho

Tudo o que falta vira uma **pendência**: aparece no PDF (caixa amarela no
rascunho, vermelha no final), entra na lista do começo e na conta da capa.

| Confere | Como |
|---|---|
| Os seus dados | cada campo obrigatório vazio (inclusive os pronomes); o ingresso como AAAA/1 ou AAAA/2 |
| O pedido | o enquadramento principal; os semestres do SIEX, se pede EXT; os dados da ação no SIEX |
| A ficha de cada atividade | tipo, horas, período, projeto, papel, quem confirma, registros, competências (só as do curso) |
| O art. 5º | a atividade que começou antes do ingresso no curso |
| As atividades à parte | a espécie da publicação, a duração do evento ou do curso, e se chegam a um crédito |
| As seções da atividade | as seis têm de existir |
| As evidências | ao menos uma por atividade |
| As figuras | o mínimo do tipo (2 para placa, peça e simulação; 1 para software, ensaio e comunicação) |
| A ficha técnica | os campos obrigatórios do tipo |
| A Parte II | a trajetória e os afastamentos declarados |
| A autoavaliação | as seis notas |

E calcula: os semestres que contam, os créditos do principal, das alternativas e
de cada atividade à parte, o requerimento ao Colegiado, a lista das atividades
com a página de cada uma, a média semanal das horas (e avisa acima de 20 h), a
matriz das competências das DCN do curso, o quadro das disciplinas e o índice de
todas as evidências (Anexo A).

**Os pronomes** (`pronomes = ela`, `ele` ou `elu`) escolhem a forma do texto que
a classe escreve (egressa, egresso, egresse). **O nome da equipe** sai por
extenso na primeira menção, com o significado de PD&I, e curto nas demais;
`\NRO` faz isso sozinho, e nunca quebra no fim da linha.

### Antes de enviar

- [ ] Em `final`, a capa diz **Sem pendências**.
- [ ] Toda atividade tem evidência que outra pessoa consegue conferir.
- [ ] As figuras são as de verdade, e o supervisor liberou as de projeto.
- [ ] As horas batem com a memória de cálculo e nenhuma atividade aparece em
      outra AACC ou atividade acadêmica (art. 7º).
- [ ] Os supervisores de *Quem confirma* sabem que serão consultados.
- [ ] Nenhum dado pessoal de terceiros, nenhuma informação confidencial.

## O desenho

O relatório segue o **relatório formal** do design system: a capa com a régua
Cortex, o título serifado e a grade dos dados; o kicker (régua fina, rótulo e
numeral em itálico) em cada parte e atividade; tabelas com régua em cima e
embaixo e linhas finas, sem colunas riscadas; texto alinhado à esquerda. O
cabeçalho das folhas (menos a capa) continua o do NRO-PUB-002, igual aos PDFs
do SOMA.

As fontes do design system (Instrument Serif e Archivo Light) não existem no
pdfLaTeX. A classe usa as mais próximas que o TeX Live tem: TeX Gyre Termes nos
títulos, Roboto Light no texto e Archivo nos rótulos e nos códigos; se alguma
faltar, cai para Times e Helvetica. Sem fonte de código em rótulos, sem ponto
médio, sem travessão como separador. O PDF não tem campo de formulário: abre
igual em qualquer leitor, e a mesma compilação dá o mesmo resultado no
Overleaf, no Windows, no Mac e no Linux.

## Para a Diretoria

**Antes de publicar**, confira em `nro/equipe.tex` os dados da ação de extensão
no SIEX (título e número; o coordenador e a vigência são opcionais): eles só
viram pendência para quem pede o enquadramento EXT. O professor responsável é
opcional ali; o professor orientador de cada pedido é indicado no SOMA.

**As regras moram em `nro/`**, fora da classe, para a equipe ajustar sem mexer
em código:

| Arquivo | O que tem |
|---|---|
| `nro/equipe.tex` | a série, o SIEX, a norma, horas por crédito, média semanal máxima, meses por semestre |
| `nro/institucional.tex` | a Parte I: a equipe, a competição, o vínculo com a UFMG, a organização e as normas |
| `nro/aproveitamento.tex` | o catálogo do aproveitamento: os enquadramentos e as atividades à parte |
| `nro/tipos.tex` | os tipos de atividade: a ficha técnica, as figuras mínimas e o roteiro de cada um |
| `nro/avaliacao.tex` | o barema do professor (os pesos somam 100) |
| `nro/competencias.tex` | as competências do egresso, uma lista por conjunto de cursos, e os cursos de cada lista |

**O que anda junto com o SOMA.** O catálogo (`nro/aproveitamento.tex`), a regra
dos semestres, o barema (`nro/avaliacao.tex`) e a lista de cursos
(`nro/competencias.tex`, que espelha `AAC_CURSOS` no portal) têm uma cópia no
SOMA (`mod-aproveitamento.js`, `doc-nro.js` e a configuração do aproveitamento
no banco). Mudou aqui, mude lá no mesmo dia, e publique o ZIP de novo.

**As competências.** Cada curso aponta para uma lista
(`\cursos{eng-eletrica}{Engenharia Elétrica; …}`), que traz as competências
gerais das DCN da área e as específicas do curso. Curso fora das listas cai na
lista `geral`. A competência que não é do curso vira pendência na ficha.

O SOMA lê do PDF enviado as palavras-chave que a classe grava: `nro-aacc`, e
`documento`, `modo`, `pendencias`, `folha` (a página da folha reservada),
`principal`, `creditos`, `principalcreditos`, `avaliacao` (a posição, em mm a
partir do canto inferior esquerdo, do *Pendente* da capa), `itens`, `semestres`
e `exemplo`. Ele recusa o PDF que não é do template, que é de outro pedido, em
rascunho, com pendência ou sem a folha reservada. Mexer na classe sem manter
essas chaves quebra o envio.

A lista de repercussão e a competição da Parte I espelham a imprensa do site
institucional (SOMA, Studio, Configurações, Imprensa do site); quando entrar
matéria nova lá, atualize aqui.

**Os modelos de `modelos/`** seguem os campos de `nro/tipos.tex`. Mudou um tipo,
confira o modelo dele.

**Publicar uma versão nova** (o ZIP e o PDF do exemplo em `assets/`, que o site
serve e que o SOMA baixa): rode `./empacotar.sh` nesta pasta, com TeX Live,
`latexmk`, `biber` e `zip`. Ele compila o template e o exemplo numa cópia limpa
e só gera os arquivos se os dois compilarem.

## Para o professor orientador

O professor recebe o pedido por e-mail, com um link pessoal para o SOMA, e
avalia ali, sem cadastro no portal, pelo barema de seis critérios: aderência à
formação (15), profundidade técnica (25), contribuição individual (20),
evidências e rastreabilidade (15), resultados e impacto (15) e comunicação (10).
Cada critério recebe de 0 a 10, de meio em meio ponto; os pontos são a nota
vezes o peso, dividida por 10; a nota final é a soma (0 a 100), com o conceito
da UFMG. A folha de aprovação imprime a nota e os pontos de cada critério. A
nota mínima para o aproveitamento é 60 (art. 3º, II). O mesmo barema está na
autoavaliação, na Parte IV, e na Parte V do relatório.

## Os arquivos

```
relatorio-aacc.tex          o relatório: o arquivo que o membro edita
soma.tex                    os dados do SOMA (vem no ZIP gerado pelo portal)
nro-aacc.cls                a classe (o modelo e toda a lógica)
referencias.bib             as referências, em ABNT
nro/                        o que é da equipe (a Diretoria mantém)
atividades/                 as atividades do membro, uma por arquivo
modelos/                    um modelo por tipo de atividade, para copiar
figuras/                    as figuras do membro
anexos/                     os PDFs anexos
exemplo-relatorio-aacc.tex  o exemplo fictício (fora do ZIP; o PDF vai junto)
exemplo/                    as atividades e as figuras do exemplo
empacotar.sh                gera o ZIP e o PDF do exemplo em ../../assets
```
