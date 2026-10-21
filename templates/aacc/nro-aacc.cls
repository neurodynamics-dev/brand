%% ============================================================
%% nro-aacc.cls: o relatório de atividades para aproveitamento de
%% AACC, no modelo de documento da NeuroDynamics (NRO-PUB-002) e no
%% registro formal do design system da marca
%%
%% O membro (ou o egresso) escreve em relatorio-aacc.tex; esta classe
%% cuida do resto:
%%   - a folha: o cabeçalho do NRO-PUB-002, o mesmo dos PDFs do SOMA
%%     (doc-nro.js), em toda folha menos a capa; a capa no desenho do
%%     relatório formal do design system;
%%   - o PEDIDO, nos termos da Resolução nº 02/2019 da Congregação da
%%     Escola de Engenharia: o enquadramento da participação (por
%%     semestre letivo, art. 8º e 11; ou por horas, art. 17), as
%%     alternativas para o Colegiado e as atividades à parte (art. 7º);
%%   - a ATIVIDADE: a ficha, a ficha técnica do tipo, as seções que toda
%%     atividade tem, as figuras e as evidências, e o que falta nela;
%%   - os quadros que se montam sozinhos (o pedido, as atividades, os
%%     semestres, as horas, as competências, as disciplinas, o índice
%%     das evidências);
%%   - as PENDÊNCIAS: tudo o que não foi preenchido aparece no PDF, na
%%     capa e na lista do começo. O SOMA não aceita relatório com
%%     pendência;
%%   - a FOLHA DE APROVAÇÃO: a segunda folha fica reservada; o SOMA a
%%     troca pela folha com as aprovações e a autenticação.
%%
%% Os dados e as regras da equipe ficam fora daqui, em nro/: os dados
%% da equipe, o catálogo do aproveitamento, os tipos de atividade, o
%% barema e as competências. A Diretoria mantém esses arquivos; o
%% membro não mexe neles. O que o SOMA sabe do membro chega em
%% soma.tex, que o portal gera junto com o ZIP.
%%
%% Opções:
%%   rascunho  (padrão) mostra os roteiros e as instruções;
%%   final     esconde as instruções; o que falta sai em vermelho, e a
%%             capa diz se o relatório pode seguir;
%%   exemplo   a marca d'água do exemplo fictício.
%%
%% As fontes. O design system pede Instrument Serif nos títulos e
%% Archivo Light no texto. No pdfLaTeX (o padrão do Overleaf, e o que
%% funciona em qualquer instalação) elas não existem; a classe usa as
%% mais próximas que o TeX Live tem e cai para as do sistema se faltar
%% alguma: TeX Gyre Termes nos títulos (a reserva que o próprio design
%% system indica), Roboto Light no texto, Archivo nos rótulos e nos
%% códigos. Nada disso muda o arquivo do membro.
%%
%% Os quadros do começo (o pedido, a lista das atividades, as
%% pendências) dependem de o documento inteiro já ter sido lido: vêm do
%% .aux da compilação anterior. O Overleaf compila quantas vezes for
%% preciso; na linha de comando, use o latexmk.
%%
%% Duas regras de quem mexe aqui: (1) nada com efeito colateral (uma
%% pendência, um contador) dentro do corpo de uma tabularx/xltabular:
%% o corpo roda várias vezes; as linhas se montam antes, numa tl, e a
%% tabela só as escreve. (2) Texto com acento não passa por expansão
%% x/e crua: as descrições das pendências passam por \protected@edef.
%% ============================================================
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesExplClass{nro-aacc}{2026-10-20}{2.0}
  {Relatorio de atividades para aproveitamento de AACC - NeuroDynamics}

%% ------------------------------------------------------------
%% 0. AS OPÇÕES
%% ------------------------------------------------------------
\bool_new:N \g__nro_final_bool
\bool_new:N \g__nro_exemplo_bool
\DeclareOption { rascunho } { \bool_gset_false:N \g__nro_final_bool }
\DeclareOption { final }    { \bool_gset_true:N  \g__nro_final_bool }
\DeclareOption { exemplo }  { \bool_gset_true:N  \g__nro_exemplo_bool }
%% a versão 1 tinha campos de formulário no PDF; a opção fica, sem efeito
\DeclareOption { impresso } { }
\DeclareOption* { \PassOptionsToClass { \CurrentOption } { article } }
\ProcessOptions \scan_stop:
\LoadClass [ a4paper , 10pt ] { article }

%% ------------------------------------------------------------
%% 1. OS PACOTES (todos do TeX Live básico do Overleaf)
%% ------------------------------------------------------------
\RequirePackage [ T1 ] { fontenc }
\RequirePackage [ brazil ] { babel }
\RequirePackage { lmodern }         % a matemática e as listagens de código
\RequirePackage { textcomp }
\RequirePackage { amsmath }
\RequirePackage [ final ] { microtype }
\RequirePackage
  [ a4paper , top = 32.5mm , bottom = 25mm , left = 15mm , right = 12.5mm ]
  { geometry }
\RequirePackage [ table ] { xcolor }
\RequirePackage { graphicx }
\RequirePackage { array , tabularx , xltabular , multirow , booktabs }
\RequirePackage { enumitem }
\RequirePackage { titlesec , titletoc }
\RequirePackage [ most ] { tcolorbox }
\RequirePackage { tikz }
\RequirePackage { lastpage }
\RequirePackage { needspace }
\RequirePackage { caption , subcaption }
\RequirePackage { siunitx }
\RequirePackage [ autostyle ] { csquotes }
\RequirePackage { listings }
\RequirePackage { pdfpages }
\RequirePackage { ragged2e }
\RequirePackage [ backend = biber , style = abnt-numeric ] { biblatex }
\RequirePackage { hyperref }
\RequirePackage { bookmark }

%% as variantes de que a lógica precisa (as que já existem ficam como estão)
\cs_generate_variant:Nn \prop_item:Nn { Ne }
\prg_generate_conditional_variant:Nnn \prop_get:NnN { Ne } { T , F , TF }
\prg_generate_conditional_variant:Nnn \tl_if_blank:n { e } { p , T , F , TF }
\prg_generate_conditional_variant:Nnn \str_if_eq:nn { Vn } { T , F , TF }
\prg_generate_conditional_variant:Nnn \clist_if_in:Nn { NV } { T , F , TF }
\prg_generate_conditional_variant:Nnn \seq_if_in:Nn { NV } { T , F , TF }
\prg_generate_conditional_variant:Nnn \regex_match:nn { nV } { T , F , TF }
\prg_generate_conditional_variant:Nnn \regex_extract_once:nnN { nV } { T , F , TF }
\prg_generate_conditional_variant:Nnn \file_if_exist:n { V } { T , F , TF }
\cs_generate_variant:Nn \tl_to_str:n { e }
\cs_generate_variant:Nn \tl_trim_spaces:n { e }
\cs_generate_variant:Nn \prop_gput:Nnn { Nxn , Nxx , NVx }
\cs_generate_variant:Nn \prop_put:Nnn { NVx }
\prg_generate_conditional_variant:Nnn \prop_get:NnN { NV , Nx } { T , F , TF }
\cs_generate_variant:Nn \seq_set_split:Nnn { Nnx }
\cs_generate_variant:Nn \msg_warning:nnnn { nnVV }
\cs_generate_variant:Nn \msg_warning:nnn { nnV }
\cs_generate_variant:Nn \str_case:nnT { Vn }
\cs_generate_variant:Nn \clist_set:Nn { NV }

%% ------------------------------------------------------------
%% 2. OS DADOS: tudo o que o relatório sabe fica num lugar só,
%%    \g__nro_dados_prop, com a chave "grupo/campo" (estudante/nome,
%%    equipe/professor, apr/EQC/nome, tipo/pcb/nome…). A chave é
%%    expandida antes da consulta: "tipo/\l__nro_atv_tipo_tl/nome" vale.
%%    \campo{grupo/campo} escreve o valor, ou a marca do que falta.
%% ------------------------------------------------------------
\prop_new:N \g__nro_dados_prop
\tl_new:N \l__nro_tmp_tl
\tl_new:N \l__nro_tmpb_tl
\tl_new:N \l__nro_tmpc_tl
\tl_new:N \l__nro_chave_tl
\tl_new:N \l__nro_prefixo_tl
\tl_new:N \l__nro_grupo_tl
\int_new:N \l__nro_tmp_int
\int_new:N \l__nro_tmpb_int
\fp_new:N \l__nro_tmp_fp
\seq_new:N \l__nro_tmp_seq
\bool_new:N \l__nro_achou_bool
\bool_new:N \l__nro_gravar_bool

\msg_new:nnn { nro-aacc } { campo-desconhecido }
  { O~campo~'#2'~nao~existe~em~\iow_char:N\\#1.~Confira~a~grafia~(o~valor~foi~guardado~mesmo~assim). }
\msg_new:nnn { nro-aacc } { chave-atividade }
  { Uma~atividade~usa~o~campo~'#2',~que~nao~existe.~Os~campos~sao:~tipo,~aproveitamento,~horas,~duracao,~publicacao,~inicio,~fim,~projeto,~papel,~supervisor,~registros,~competencias,~disciplinas. }
\msg_new:nnn { nro-aacc } { tipo-desconhecido }
  { Uma~atividade~usa~o~tipo~'#1',~que~nao~esta~em~nro/tipos.tex. }
\msg_new:nnn { nro-aacc } { sem-arquivo }
  { Nao~encontrei~#1.~Ele~vem~no~template:~baixe~o~ZIP~de~novo. }
\msg_new:nnn { nro-aacc } { atividade-dentro }
  { Uma~atividade~abriu~dentro~de~outra.~Feche~a~anterior~com~\iow_char:N\\end{atividade}. }
\msg_new:nnn { nro-aacc } { fora-da-atividade }
  { '#1'~so~existe~dentro~de~\iow_char:N\\begin{atividade}. }
\msg_new:nnn { nro-aacc } { fora-das-evidencias }
  { \iow_char:N\\evidencia~so~existe~dentro~de~\iow_char:N\\begin{evidencias}. }

%% os campos que cada grupo aceita (um nome errado vira aviso no log)
\prop_new:N \g__nro_campos_prop
\prop_gput:Nnn \g__nro_campos_prop { estudante }
  { nome , matricula , curso , colegiado , email , ingresso , periodo , unidade }
\prop_gput:Nnn \g__nro_campos_prop { membro }
  { registro , situacao , inicio , fim , cargo , departamento , projetos ,
    supervisor , dedicacao , siex , vinculo , verificador }
\prop_gput:Nnn \g__nro_campos_prop { documento }
  { pn , data , cidade , soma }
\prop_gput:Nnn \g__nro_campos_prop { serie }
  { codigo , titulo , emissor , revisao }
\prop_gput:Nnn \g__nro_campos_prop { equipe }
  { nome , sigla , laboratorios , unidade , site , validacao , professor ,
    artigoprofessor , departamentoprofessor , emailprofessor , dirigente ,
    cargodirigente , siextitulo , siexnumero , siexcoordenador ,
    artigocoordenador , siexvigencia , norma , normacurta , horasporcredito ,
    mediamaxima , mesespersemestre }
\prop_gput:Nnn \g__nro_campos_prop { pedido }
  { principal , alternativas , siex , ic }

%% a chave limpa: sem os \par das linhas em branco, sem os espaços das pontas
\cs_new_protected:Npn \__nro_chave:Nn #1 #2
  {
    \tl_set:Nn #1 {#2}
    \tl_remove_all:Nn #1 { \par }
    \tl_trim_spaces:N #1
  }
%% "chave = valor" numa prop, com as chaves limpas
\cs_new_protected:Npn \__nro_kv_prop:Nn #1 #2
  {
    \cs_set_protected:Npn \__nro_kv_prop_par:nn ##1 ##2
      { \__nro_chave:Nn \l__nro_chave_tl {##1} \prop_gput:NVn #1 \l__nro_chave_tl {##2} }
    \cs_set_protected:Npn \__nro_kv_prop_chave:n ##1 { \__nro_kv_prop_par:nn {##1} { } }
    \keyval_parse:NNn \__nro_kv_prop_chave:n \__nro_kv_prop_par:nn {#2}
  }
\cs_new_protected:Npn \__nro_kv_prop_par:nn #1 #2 { }
\cs_new_protected:Npn \__nro_kv_prop_chave:n #1 { }
%% guarda "chave = valor" sob o prefixo; o grupo é o que confere os nomes.
%% Valor em branco NÃO apaga um valor que já existe: é assim que os dados
%% do SOMA (soma.tex, lido antes) sobrevivem aos campos vazios do
%% relatorio-aacc.tex. Para trocar um dado do SOMA, escreva o valor novo.
\cs_new_protected:Npn \__nro_guardar:nnn #1 #2 #3
  {
    \tl_set:Nx \l__nro_prefixo_tl {#1}
    \tl_set:Nn \l__nro_grupo_tl {#2}
    \keyval_parse:NNn \__nro_guardar_chave:n \__nro_guardar_par:nn {#3}
  }
\cs_new_protected:Npn \__nro_guardar_chave:n #1
  { \__nro_guardar_par:nn {#1} { } }
\cs_new_protected:Npn \__nro_guardar_par:nn #1 #2
  {
    \__nro_chave:Nn \l__nro_tmpb_tl {#1}
    \tl_set:Nx \l__nro_chave_tl { \l__nro_prefixo_tl / \l__nro_tmpb_tl }
    \bool_set_true:N \l__nro_gravar_bool
    \tl_if_blank:nT {#2}
      {
        \prop_get:NVNT \g__nro_dados_prop \l__nro_chave_tl \l__nro_tmp_tl
          { \tl_if_blank:VF \l__nro_tmp_tl { \bool_set_false:N \l__nro_gravar_bool } }
      }
    \bool_if:NT \l__nro_gravar_bool
      { \prop_gput:NVn \g__nro_dados_prop \l__nro_chave_tl {#2} }
    \tl_if_empty:NF \l__nro_grupo_tl
      {
        \prop_get:NVNT \g__nro_campos_prop \l__nro_grupo_tl \l__nro_tmp_tl
          {
            \clist_set:NV \l_tmpa_clist \l__nro_tmp_tl
            \clist_if_in:NVF \l_tmpa_clist \l__nro_tmpb_tl
              { \msg_warning:nnVV { nro-aacc } { campo-desconhecido } \l__nro_grupo_tl \l__nro_tmpb_tl }
          }
      }
  }

%% o valor, cru (expansível; vazio se não há)
\cs_new:Npn \__nro_dado:n #1 { \prop_item:Ne \g__nro_dados_prop {#1} }
%% existe e não está em branco? (a versão expansível e a protegida)
\prg_new_conditional:Npnn \__nro_se_dado_exp:n #1 { TF }
  { \tl_if_blank:eTF { \__nro_dado:n {#1} } { \prg_return_false: } { \prg_return_true: } }
\prg_new_protected_conditional:Npnn \__nro_se_dado:n #1 { T , F , TF }
  {
    \prop_get:NeNTF \g__nro_dados_prop {#1} \l__nro_tmp_tl
      { \tl_if_blank:VTF \l__nro_tmp_tl { \prg_return_false: } { \prg_return_true: } }
      { \prg_return_false: }
  }

%% Os comandos de quem preenche. \equipe e \serie vêm de nro/equipe.tex;
%% \estudante, \membro, \documento e \pedido vêm do soma.tex e do
%% relatorio-aacc.tex.
\NewDocumentCommand \estudante { +m } { \__nro_guardar:nnn { estudante } { estudante } {#1} }
\NewDocumentCommand \membro    { +m } { \__nro_guardar:nnn { membro } { membro } {#1} }
\NewDocumentCommand \documento { +m } { \__nro_guardar:nnn { documento } { documento } {#1} }
\NewDocumentCommand \serie     { +m } { \__nro_guardar:nnn { serie } { serie } {#1} }
\NewDocumentCommand \equipe    { +m } { \__nro_guardar:nnn { equipe } { equipe } {#1} }
\NewDocumentCommand \pedido    { +m } { \__nro_guardar:nnn { pedido } { pedido } {#1} }

%% os nomes dos campos, como a lista de pendências os escreve
\prop_new:N \g__nro_rotulos_prop
\prop_gset_from_keyval:Nn \g__nro_rotulos_prop
  {
    estudante/nome = { o~seu~nome~completo } ,
    estudante/matricula = { o~número~de~matrícula } ,
    estudante/curso = { o~curso } ,
    estudante/colegiado = { o~colegiado~do~curso } ,
    estudante/email = { o~e-mail } ,
    estudante/ingresso = { o~semestre~de~ingresso~no~curso~(AAAA/S) } ,
    estudante/pronomes = { os~pronomes~(ela,~ele~ou~elu) } ,
    membro/registro = { o~registro~no~SOMA } ,
    membro/situacao = { a~situação~(ativo~ou~egresso) } ,
    membro/inicio = { o~mês~de~entrada~na~equipe } ,
    membro/fim = { o~mês~de~saída~da~equipe } ,
    membro/cargo = { o~cargo~na~equipe } ,
    membro/departamento = { o~departamento } ,
    membro/supervisor = { o~supervisor~imediato } ,
    membro/dedicacao = { a~dedicação~semanal~média } ,
    documento/pn = { o~número~do~pedido~no~SOMA~(baixe~o~template~em~Serviços,~Aproveitamento~de~AACC) } ,
    pedido/principal = { o~enquadramento~principal~(\textbackslash pedido) } ,
    equipe/siextitulo = { o~título~da~ação~de~extensão~(nro/equipe.tex) } ,
    equipe/siexnumero = { o~registro~da~ação~no~SIEX~(nro/equipe.tex) } ,
    equipe/siexcoordenador = { o~coordenador~da~ação~no~SIEX~(nro/equipe.tex) } ,
    equipe/siexvigencia = { a~vigência~da~ação~no~SIEX~(nro/equipe.tex) } ,
  }

%% os campos sem os quais o relatório não se encaminha
\clist_const:Nn \c__nro_obrigatorios_clist
  {
    estudante/nome , estudante/pronomes , estudante/matricula , estudante/curso , estudante/colegiado ,
    estudante/email , estudante/ingresso , membro/registro , membro/situacao ,
    membro/inicio , membro/cargo , membro/departamento , membro/supervisor ,
    membro/dedicacao , documento/pn , pedido/principal
  }

%% \campo{grupo/campo}: o valor, ou a marca do que falta
\NewDocumentCommand \campo { m } { \__nro_campo:n {#1} }
\cs_new_protected:Npn \__nro_campo:n #1
  {
    \__nro_se_dado:nTF {#1}
      { \__nro_dado:n {#1} }
      {
        \prop_get:NnNF \g__nro_rotulos_prop {#1} \l__nro_tmp_tl
          { \tl_set:Nn \l__nro_tmp_tl {#1} }
        \nro@marca { \l__nro_tmp_tl }
      }
  }
%% \secampo{grupo/campo}{se tem}{se não tem}
\NewDocumentCommand \secampo { m +m +m } { \__nro_se_dado:nTF {#1} {#2} {#3} }

%% o valor é um destes? (sem diferença de maiúsculas; só ASCII na lista)
\prg_new_protected_conditional:Npnn \__nro_se_valor:nn #1 #2 { T , F , TF }
  {
    \tl_set:Nx \l__nro_tmp_tl { \str_lowercase:f { \tl_to_str:e { \__nro_dado:n {#1} } } }
    \tl_trim_spaces:N \l__nro_tmp_tl
    \bool_set_false:N \l__nro_achou_bool
    \clist_map_inline:nn {#2}
      { \str_if_eq:VnT \l__nro_tmp_tl {##1} { \bool_set_true:N \l__nro_achou_bool \clist_map_break: } }
    \bool_if:NTF \l__nro_achou_bool { \prg_return_true: } { \prg_return_false: }
  }
\cs_new_protected:Npn \__nro_se_egresso:TF #1 #2
  { \__nro_se_valor:nnTF { membro/situacao } { egresso , egressa , egresse , ex-membro } {#1} {#2} }
%% consta da ação no SIEX: a lista de semestres do pedido, ou "sim" na ficha
\cs_new_protected:Npn \__nro_se_siex:TF #1 #2
  {
    \__nro_se_dado:nTF { pedido/siex } {#1}
      { \__nro_se_valor:nnTF { membro/siex } { sim , s , yes , registrado , registrada } {#1} {#2} }
  }
\NewDocumentCommand \seegresso { +m +m } { \__nro_se_egresso:TF {#1} {#2} }
%% "do Prof." ou "da Prof.ª": o artigo vem de equipe/artigoprofessor (o ou a)
\NewDocumentCommand \doprofessor { } { \__nro_se_valor:nnTF { equipe/artigoprofessor } { a } { da } { do } }
\NewDocumentCommand \peloprofessor { } { \__nro_se_valor:nnTF { equipe/artigoprofessor } { a } { pela } { pelo } }
\NewDocumentCommand \pelocoordenador { } { \__nro_se_valor:nnTF { equipe/artigocoordenador } { a } { pela } { pelo } }
\NewDocumentCommand \sesiex { +m +m } { \__nro_se_siex:TF {#1} {#2} }
%% Os pronomes da pessoa (estudante/pronomes: ela, ele ou elu) escolhem a
%% forma: \pron{masculina}{feminina}{neutra}. Em branco, a masculina, até
%% a pendência ser resolvida. Os atalhos cobrem os casos do texto.
\cs_new:Npn \__nro_pron:nnn #1 #2 #3
  {
    \str_case_e:nnF { \str_lowercase:f { \__nro_dado:n { estudante/pronomes } } }
      { { ela } {#2} { ela/dela } {#2} { elu } {#3} { elu/delu } {#3} }
      {#1}
  }
\NewExpandableDocumentCommand \pron { m m m } { \__nro_pron:nnn {#1} {#2} {#3} }
\NewExpandableDocumentCommand \oa { } { \__nro_pron:nnn { o } { a } { e } }
\NewExpandableDocumentCommand \doa { } { \__nro_pron:nnn { do } { da } { de } }
\NewExpandableDocumentCommand \ele { } { \__nro_pron:nnn { ele } { ela } { elu } }
\NewExpandableDocumentCommand \dele { } { \__nro_pron:nnn { dele } { dela } { delu } }
\NewExpandableDocumentCommand \egresso { } { \__nro_pron:nnn { egresso } { egressa } { egresse } }
%% "Egresso" ou "Membro ativo"; a marca, se a situação está em branco
\cs_new_protected:Npn \nro@textosituacao #1 #2
  { \__nro_se_dado:nTF { membro/situacao } { \__nro_se_egresso:TF {#1} {#2} } { \nro@marca { a~situação } } }

%% ------------------------------------------------------------
%% 3. AS DATAS E OS NÚMEROS: as datas entram como AAAA-MM ou
%%    AAAA-MM-DD e saem por extenso; os números entram com ponto ou
%%    vírgula e saem com vírgula.
%% ------------------------------------------------------------
\seq_new:N \l__nro_data_seq
\int_new:N \l__nro_ano_int
\int_new:N \l__nro_mes_int
\int_new:N \l__nro_dia_int
\cs_new:Npn \__nro_mes_nome:n #1
  {
    \int_case:nn {#1}
      { {1}{janeiro} {2}{fevereiro} {3}{março} {4}{abril} {5}{maio} {6}{junho}
        {7}{julho} {8}{agosto} {9}{setembro} {10}{outubro} {11}{novembro} {12}{dezembro} }
  }
\cs_new:Npn \__nro_mes_abrev:n #1
  {
    \int_case:nn {#1}
      { {1}{jan.} {2}{fev.} {3}{mar.} {4}{abr.} {5}{maio} {6}{jun.}
        {7}{jul.} {8}{ago.} {9}{set.} {10}{out.} {11}{nov.} {12}{dez.} }
  }
%% lê a data em \l__nro_ano_int, \l__nro_mes_int e \l__nro_dia_int (0 se não há dia)
\prg_new_protected_conditional:Npnn \__nro_ler_data:n #1 { T , F , TF }
  {
    \regex_extract_once:nnNTF
      { \A \s* (\d{4}) - (\d{1,2}) (?: - (\d{1,2}) )? \s* \Z } {#1} \l__nro_data_seq
      {
        \int_set:Nn \l__nro_ano_int { \seq_item:Nn \l__nro_data_seq { 2 } }
        \int_set:Nn \l__nro_mes_int { \seq_item:Nn \l__nro_data_seq { 3 } }
        \tl_set:Nx \l__nro_tmp_tl { \seq_item:Nn \l__nro_data_seq { 4 } }
        \tl_if_blank:VTF \l__nro_tmp_tl
          { \int_set:Nn \l__nro_dia_int { 0 } }
          { \int_set:Nn \l__nro_dia_int { \l__nro_tmp_tl } }
        \bool_lazy_and:nnTF
          { \int_compare_p:nNn { \l__nro_mes_int } > { 0 } }
          { \int_compare_p:nNn { \l__nro_mes_int } < { 13 } }
          { \prg_return_true: } { \prg_return_false: }
      }
      { \prg_return_false: }
  }
\prg_generate_conditional_variant:Nnn \__nro_ler_data:n { x } { T , F , TF }
%% "2024-03" → "março de 2024"; "2026-10-15" → "15 de outubro de 2026"
\cs_new_protected:Npn \__nro_data_extenso:n #1
  {
    \__nro_ler_data:xTF {#1}
      {
        \int_compare:nNnT { \l__nro_dia_int } > { 0 }
          {
            \int_compare:nNnTF { \l__nro_dia_int } = { 1 }
              { 1\textordmasculine } { \int_use:N \l__nro_dia_int }
            \c_space_tl de ~
          }
        \__nro_mes_nome:n { \l__nro_mes_int } ~ de ~ \int_use:N \l__nro_ano_int
      }
      {#1}
  }
%% "2024-03" → "mar./2024"
\cs_new_protected:Npn \__nro_data_curta:n #1
  {
    \__nro_ler_data:xTF {#1}
      {
        \int_compare:nNnT { \l__nro_dia_int } > { 0 } { \int_use:N \l__nro_dia_int \, }
        \__nro_mes_abrev:n { \l__nro_mes_int } / \int_use:N \l__nro_ano_int
      }
      {#1}
  }
\NewDocumentCommand \dataextenso { m } { \__nro_data_extenso:n {#1} }
\NewDocumentCommand \datacurta { m } { \__nro_data_curta:n {#1} }

%% a data de hoje, AAAA-MM-DD, e a do documento (a de \documento, ou hoje)
\tl_const:Nx \c__nro_hoje_tl
  {
    \int_use:N \year - \int_compare:nNnT { \month } < { 10 } { 0 } \int_use:N \month
    - \int_compare:nNnT { \day } < { 10 } { 0 } \int_use:N \day
  }
\cs_new:Npn \__nro_data_doc:
  { \__nro_se_dado_exp:nTF { documento/data } { \__nro_dado:n { documento/data } } { \c__nro_hoje_tl } }

%% o mês como número corrido (ano × 12 + mês), para contar os meses
\int_new:N \l__nro_ini_int
\int_new:N \l__nro_fim_int
\cs_new_protected:Npn \__nro_mes_corrido:nN #1 #2
  {
    \__nro_ler_data:xTF {#1}
      { \int_set:Nn #2 { \l__nro_ano_int * 12 + \l__nro_mes_int } }
      { \int_set:Nn #2 { 0 } }
  }
%% os meses de #1 a #2, contando os dois (0 se uma data não se lê)
\cs_new_protected:Npn \__nro_meses:nnN #1 #2 #3
  {
    \__nro_mes_corrido:nN {#1} \l__nro_ini_int
    \__nro_mes_corrido:nN {#2} \l__nro_fim_int
    \bool_lazy_or:nnTF
      { \int_compare_p:nNn { \l__nro_ini_int } = { 0 } }
      { \int_compare_p:nNn { \l__nro_fim_int } = { 0 } }
      { \int_set:Nn #3 { 0 } }
      { \int_set:Nn #3 { \int_max:nn { 0 } { \l__nro_fim_int - \l__nro_ini_int + 1 } } }
  }

%% um número: "12,5" ou "12.5" → "12.5" em \l__nro_num_tl (vazio se não é número)
\tl_new:N \l__nro_num_tl
\cs_new_protected:Npn \__nro_numero:n #1
  {
    \tl_set:Nx \l__nro_num_tl { \tl_trim_spaces:e {#1} }
    \tl_replace_all:Nnn \l__nro_num_tl { , } { . }
    \regex_match:nVF { \A \d+ (?: \. \d+ )? \Z } \l__nro_num_tl
      { \tl_clear:N \l__nro_num_tl }
  }
%% escreve um número com vírgula e uma casa, sem ",0"; milhar com ponto
\cs_new_protected:Npn \__nro_escreve_num:n #1
  {
    \tl_set:Nx \l__nro_tmp_tl { \fp_eval:n { round ( #1 , 1 ) } }
    \tl_replace_all:Nnn \l__nro_tmp_tl { . } { , }
    \regex_replace_once:nnN { \A (\d) (\d{3}) (\Z|,) } { \1 . \2 \3 } \l__nro_tmp_tl
    \tl_use:N \l__nro_tmp_tl
  }
\NewDocumentCommand \numero { m } { \__nro_escreve_num:n {#1} }

%% horas por crédito (15 na UFMG) e a média semanal que pede justificativa
\cs_new:Npn \__nro_hpc:
  { \__nro_se_dado_exp:nTF { equipe/horasporcredito } { \__nro_dado:n { equipe/horasporcredito } } { 15 } }
\cs_new:Npn \__nro_media_max:
  { \__nro_se_dado_exp:nTF { equipe/mediamaxima } { \__nro_dado:n { equipe/mediamaxima } } { 20 } }
%% "150 h"; "12 créditos"; "1 crédito"
\cs_new_protected:Npn \__nro_horas:n #1 { \__nro_escreve_num:n {#1} \,h }
\cs_new_protected:Npn \__nro_cred:n #1
  {
    \int_set:Nn \l__nro_tmpb_int {#1}
    \int_use:N \l__nro_tmpb_int \c_space_tl
    \int_compare:nNnTF { \l__nro_tmpb_int } = { 1 } { crédito } { créditos }
  }
%% os créditos em horas, como o quadro de AACC do curso os lança (15 h cada)
\cs_new_protected:Npn \__nro_cred_horas:n #1
  { \__nro_horas:n { (#1) * \__nro_hpc: } }

%% ------------------------------------------------------------
%% 4. AS PENDÊNCIAS
%%    Cada coisa que falta vira uma pendência: tem número, diz o que é
%%    e sabe a página. A lista inteira sai no começo do relatório e a
%%    conta sai na capa (as duas da compilação anterior, pelo .aux).
%% ------------------------------------------------------------
\int_new:N \g__nro_pend_int            % as desta compilação
\int_new:N \g__nro_pend_ant_int        % as da compilação anterior (do .aux)
\seq_new:N \g__nro_pend_seq            % {n}{descrição}, da anterior
\bool_new:N \g__nro_aux_lido_bool      % o .aux trouxe o fim de uma compilação?
\bool_new:N \g__nro_aux_encerrado_bool % depois do \begin{document}, o .aux não se relê
\tl_new:N \g__nro_contexto_tl          % onde estamos: "A3, Minha contribuição"
\tl_gset:Nn \g__nro_contexto_tl { Relatório }
\tl_new:N \l__nro_pend_tl

\cs_new_protected:Npn \nro@pend #1 #2
  { \bool_if:NF \g__nro_aux_encerrado_bool { \seq_gput_right:Nn \g__nro_pend_seq { {#1} {#2} } } }
\cs_new_protected:Npn \nro@npend #1
  {
    \bool_if:NF \g__nro_aux_encerrado_bool
      { \int_gset:Nn \g__nro_pend_ant_int {#1} \bool_gset_true:N \g__nro_aux_lido_bool }
  }

%% registra a pendência #1 (a descrição, que se expande com as regras do
%% LaTeX: acentos e comandos robustos passam intactos) aqui
\cs_new_protected:Npn \__nro_pend:n #1
  {
    \protected@edef \l__nro_pend_tl {#1}
    \int_gincr:N \g__nro_pend_int
    \iow_now:Nx \@auxout
      { \token_to_str:N \nro@pend { \int_use:N \g__nro_pend_int } { \exp_not:V \l__nro_pend_tl } }
    \mode_if_vertical:F { \phantomsection }
    \exp_args:Nx \label { nro:pend:\int_use:N \g__nro_pend_int }
  }
\cs_new_protected:Npn \nro@pendencia #1 { \__nro_pend:n {#1} }
\cs_new:Npn \nro@contexto { \g__nro_contexto_tl }
\cs_new_protected:Npn \nro@definircontexto #1 { \protected@xdef \g__nro_contexto_tl {#1} }
\NewExpandableDocumentCommand \sefinal { +m +m } { \bool_if:NTF \g__nro_final_bool {#1} {#2} }
\NewExpandableDocumentCommand \seexemplo { +m +m } { \bool_if:NTF \g__nro_exemplo_bool {#1} {#2} }

%% no fim: a conta vai para o .aux, e um aviso de "rode de novo" se ela mudou
\AddToHook { enddocument / afterlastpage }
  {
    \iow_now:Nx \@auxout { \token_to_str:N \nro@npend { \int_use:N \g__nro_pend_int } }
    \iow_now:Nx \@auxout { \token_to_str:N \nro@nevid { \int_use:N \g__nro_evid_int } }
    \bool_lazy_or:nnT
      { ! \g__nro_aux_lido_bool }
      { \int_compare_p:n { \g__nro_pend_int != \g__nro_pend_ant_int } }
      { \ClassWarningNoLine { nro-aacc } { Os~quadros~e~as~pendencias~mudaram.~Rerun~to~get~cross-references~right } }
    \int_compare:nNnT { \g__nro_pend_int } > { 0 }
      { \ClassWarningNoLine { nro-aacc } { O~relatorio~tem~\int_use:N \g__nro_pend_int \c_space_tl pendencia(s).~A~lista~esta~no~comeco~do~PDF } }
  }

%% os campos obrigatórios que faltam (uma pendência por campo)
\cs_new_protected:Npn \__nro_conferir_campos:
  {
    \clist_map_inline:Nn \c__nro_obrigatorios_clist
      {
        \__nro_se_dado:nF {##1}
          {
            \prop_get:NnNF \g__nro_rotulos_prop {##1} \l__nro_tmp_tl { \tl_set:Nn \l__nro_tmp_tl {##1} }
            \__nro_pend:n { Identificação:~falta~\l__nro_tmp_tl }
          }
      }
    \__nro_se_egresso:TF
      {
        \__nro_se_dado:nF { membro/fim }
          { \__nro_pend:n { Identificação:~falta~o~mês~de~saída~da~equipe~(egresso) } }
      }
      { }
    \__nro_se_dado:nT { membro/inicio }
      {
        \__nro_ler_data:xF { \__nro_dado:n { membro/inicio } }
          { \__nro_pend:n { Identificação:~a~entrada~na~equipe~deve~estar~como~AAAA-MM } }
      }
    \__nro_se_dado:nT { estudante/ingresso }
      {
        \int_compare:nNnT { \__nro_sem_ingresso: } < { 0 }
          { \__nro_pend:n { Identificação:~o~ingresso~no~curso~deve~estar~como~AAAA/1~ou~AAAA/2 } }
      }
    \__nro_se_dado:nT { membro/dedicacao }
      {
        \__nro_numero:n { \__nro_dado:n { membro/dedicacao } }
        \tl_if_empty:NT \l__nro_num_tl
          { \__nro_pend:n { Identificação:~a~dedicação~semanal~deve~ser~um~número~de~horas } }
      }
  }

%% ------------------------------------------------------------
%% 5. O APROVEITAMENTO (nro/aproveitamento.tex)
%%    O catálogo diz o que a Resolução nº 02/2019 permite e como cada
%%    coisa se conta. Duas classes:
%%      participacao  o enquadramento da participação na equipe como um
%%                    todo (EQC, EXT, IC, VPC). O pedido tem um principal
%%                    e, se quiser, alternativas para o Colegiado;
%%      atividade     uma atividade que conta à parte (PUB, EVO, EVP,
%%                    CUR, VOL): art. 7º, cada atividade numa AACC só.
%%    As bases: semestre (créditos por semestre letivo), horas (créditos
%%    a cada N horas da atividade), duracao (a cada N horas de duração do
%%    evento ou do curso) e publicacao (pela espécie da publicação).
%% ------------------------------------------------------------
\seq_new:N \g__nro_apr_seq
\NewDocumentCommand \definiraproveitamento { m +m }
  {
    \tl_set:Nx \l__nro_tmpb_tl { \tl_to_str:e { \tl_trim_spaces:n {#1} } }
    \seq_if_in:NVF \g__nro_apr_seq \l__nro_tmpb_tl
      { \seq_gput_right:NV \g__nro_apr_seq \l__nro_tmpb_tl }
    \__nro_guardar:nnn { apr/ \l__nro_tmpb_tl } { } {#2}
  }
%% o membro: o código da atividade no quadro de AACC do curso e o limite
%% (em créditos) que a norma do curso aceita; os dois são opcionais
\NewDocumentCommand \modalidade { m +m }
  { \__nro_guardar:nnn { apr/ \tl_to_str:e { \tl_trim_spaces:n {#1} } } { } {#2} }
\cs_new:Npn \__nro_apr_nome:n #1
  { \__nro_se_dado_exp:nTF { apr/#1/nome } { \__nro_dado:n { apr/#1/nome } } { #1 } }
\cs_new:Npn \__nro_apr_disp:n #1 { \__nro_dado:n { apr/#1/dispositivo } }
%% o nome no meio da frase ("como participação em equipe…")
\cs_new:Npn \__nro_apr_frase:n #1
  { \__nro_se_dado_exp:nTF { apr/#1/frase } { \__nro_dado:n { apr/#1/frase } } { \__nro_apr_nome:n {#1} } }
\NewExpandableDocumentCommand \nomeaproveitamento { m } { \__nro_apr_nome:n {#1} }
%% a chave, normalizada: maiúsculas, sem espaços, como string
\cs_new:Npn \__nro_chave_apr:n #1
  { \str_uppercase:f { \tl_to_str:e { \tl_trim_spaces:e {#1} } } }
\prg_new_conditional:Npnn \__nro_se_classe:nn #1 #2 { p , T , F , TF }
  { \str_if_eq:eeTF { \__nro_dado:n { apr/#1/classe } } {#2} { \prg_return_true: } { \prg_return_false: } }

%% as linhas do quadro do catálogo (a Parte I o mostra ao Colegiado)
\cs_new_protected:Npn \nro@montarcatalogo #1
  {
    %% #1: participacao ou atividade
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_apr_seq
      {
        \__nro_se_classe:nnT {##1} {#1}
          {
            \tl_gput_right:Nx \g__nro_linhas_tl
              {
                \exp_not:N \nro@linhacatalogo { \exp_not:n {##1} }
                  { \__nro_dado:n { apr/##1/nome } } { \__nro_dado:n { apr/##1/dispositivo } }
                  { \__nro_dado:n { apr/##1/regra } } { \__nro_dado:n { apr/##1/comprova } }
                  { \__nro_dado:n { apr/##1/quando } }
              }
          }
      }
  }

%% ------------------------------------------------------------
%% 6. OS SEMESTRES LETIVOS
%%    O enquadramento por semestre (art. 8º, III, e art. 11, III) conta
%%    os semestres de participação. A regra da equipe, que o SOMA aplica
%%    do mesmo jeito (mod-aproveitamento.js, semestresDe):
%%      - o 1º semestre vai de fevereiro a julho; o 2º, de agosto a
%%        janeiro;
%%      - o semestre conta se a participação cobre ao menos
%%        equipe/mesespersemestre meses dele (4, por padrão), sem os
%%        meses de afastamento;
%%      - o semestre anterior ao ingresso no curso não conta (art. 5º).
%%    Os afastamentos vêm do .aux (a Parte II os declara).
%% ------------------------------------------------------------
\seq_new:N \g__nro_afast_seq        % {mês corrido inicial}{final}, do .aux
\seq_new:N \g__nro_sem_seq          % {rótulo}{meses}{situação}
\int_new:N \g__nro_sem_conta_int
\int_new:N \l__nro_mi_int
\int_new:N \l__nro_mf_int
\int_new:N \l__nro_s_int
\int_new:N \l__nro_sfim_int
\int_new:N \l__nro_ms_int
\int_new:N \l__nro_m_int
\int_new:N \l__nro_cont_int
\int_new:N \l__nro_si_int
\cs_new_protected:Npn \nro@afast #1 #2
  {
    \bool_if:NF \g__nro_aux_encerrado_bool
      {
        \__nro_mes_corrido:nN {#1} \l__nro_ini_int
        \__nro_mes_corrido:nN {#2} \l__nro_fim_int
        \seq_gput_right:Nx \g__nro_afast_seq
          { { \int_use:N \l__nro_ini_int } { \int_use:N \l__nro_fim_int } }
      }
  }
%% o semestre de um mês corrido: ano × 2 + 0 (1º) ou + 1 (2º)
\cs_new:Npn \__nro_sem_de_mes:n #1
  {
    \int_eval:n
      {
        \int_compare:nNnTF { \int_mod:nn { (#1) - 1 } { 12 } + 1 } > { 7 }
          { \int_div_truncate:nn { (#1) - 1 } { 12 } * 2 + 1 }
          {
            \int_compare:nNnTF { \int_mod:nn { (#1) - 1 } { 12 } + 1 } > { 1 }
              { \int_div_truncate:nn { (#1) - 1 } { 12 } * 2 }
              { \int_div_truncate:nn { (#1) - 1 } { 12 } * 2 - 1 }
          }
      }
  }
%% o primeiro mês corrido do semestre
\cs_new:Npn \__nro_sem_inicio:n #1
  {
    \int_eval:n
      {
        \int_div_truncate:nn {#1} { 2 } * 12
        + \int_compare:nNnTF { \int_mod:nn {#1} { 2 } } = { 0 } { 2 } { 8 }
      }
  }
\cs_new:Npn \__nro_sem_rotulo:n #1
  { \int_eval:n { \int_div_truncate:nn {#1} { 2 } } / \int_eval:n { \int_mod:nn {#1} { 2 } + 1 } }
%% o ingresso no curso, como semestre (−1 se não se lê)
\cs_new:Npn \__nro_sem_ingresso:
  { \__nro_sem_ingresso_aux:e { \__nro_dado:n { estudante/ingresso } } }
\cs_new:Npn \__nro_sem_ingresso_aux:n #1
  { \__nro_sem_ingresso_ler:w #1 / / \q_stop }
\cs_generate_variant:Nn \__nro_sem_ingresso_aux:n { e }
\cs_new:Npn \__nro_sem_ingresso_ler:w #1 / #2 / #3 \q_stop
  {
    \bool_lazy_and:nnTF
      { \__nro_se_ano_p:n {#1} }
      { \bool_lazy_or_p:nn { \str_if_eq_p:ee { \tl_trim_spaces:n {#2} } { 1 } } { \str_if_eq_p:ee { \tl_trim_spaces:n {#2} } { 2 } } }
      { \int_eval:n { \tl_trim_spaces:n {#1} * 2 + \tl_trim_spaces:n {#2} - 1 } }
      { -1 }
  }
%% quatro algarismos (expansível)
\prg_new_conditional:Npnn \__nro_se_ano:n #1 { p }
  {
    \bool_lazy_and:nnTF
      { \int_compare_p:nNn { \str_count:e { \tl_trim_spaces:n {#1} } } = { 4 } }
      { \__nro_so_digitos_p:e { \tl_trim_spaces:n {#1} } }
      { \prg_return_true: } { \prg_return_false: }
  }
\prg_new_conditional:Npnn \__nro_so_digitos:n #1 { p }
  {
    \str_if_eq:eeTF { \tl_map_function:nN {#1} \__nro_digito:n } { }
      { \prg_return_true: } { \prg_return_false: }
  }
\prg_generate_conditional_variant:Nnn \__nro_so_digitos:n { e } { p }
\cs_new:Npn \__nro_digito:n #1
  { \str_case:nnF {#1} { {0}{} {1}{} {2}{} {3}{} {4}{} {5}{} {6}{} {7}{} {8}{} {9}{} } { x } }
\cs_generate_variant:Nn \str_count:n { e }

%% o mês corrido #1 está num afastamento?
\prg_new_protected_conditional:Npnn \__nro_afastado:n #1 { T , F , TF }
  {
    \bool_set_false:N \l__nro_achou_bool
    \seq_map_inline:Nn \g__nro_afast_seq { \__nro_afastado_aux:nnn {#1} ##1 }
    \bool_if:NTF \l__nro_achou_bool { \prg_return_true: } { \prg_return_false: }
  }
\cs_new_protected:Npn \__nro_afastado_aux:nnn #1 #2 #3
  {
    \bool_lazy_and:nnT
      { \int_compare_p:nNn {#1} > { #2 - 1 } }
      { \int_compare_p:nNn {#1} < { #3 + 1 } }
      { \bool_set_true:N \l__nro_achou_bool }
  }

\cs_new:Npn \__nro_meses_min:
  { \__nro_se_dado_exp:nTF { equipe/mesespersemestre } { \__nro_dado:n { equipe/mesespersemestre } } { 4 } }

%% monta \g__nro_sem_seq (uma vez, no \begin{document})
\cs_new_protected:Npn \__nro_semestres:
  {
    \seq_gclear:N \g__nro_sem_seq
    \int_gzero:N \g__nro_sem_conta_int
    \__nro_mes_corrido:nN { \__nro_dado:n { membro/inicio } } \l__nro_mi_int
    \__nro_se_egresso:TF
      {
        \__nro_se_dado:nTF { membro/fim }
          { \tl_set:Nx \l__nro_tmpb_tl { \__nro_dado:n { membro/fim } } }
          { \tl_set:Nx \l__nro_tmpb_tl { \__nro_data_doc: } }
      }
      { \tl_set:Nx \l__nro_tmpb_tl { \__nro_data_doc: } }
    \__nro_mes_corrido:nN { \l__nro_tmpb_tl } \l__nro_mf_int
    \int_set:Nn \l__nro_si_int { \__nro_sem_ingresso: }
    \bool_lazy_and:nnT
      { \int_compare_p:nNn { \l__nro_mi_int } > { 0 } }
      { \int_compare_p:nNn { \l__nro_mf_int } > { \l__nro_mi_int - 1 } }
      {
        \int_set:Nn \l__nro_s_int { \__nro_sem_de_mes:n { \l__nro_mi_int } }
        \int_set:Nn \l__nro_sfim_int { \__nro_sem_de_mes:n { \l__nro_mf_int } }
        \int_while_do:nNnn { \l__nro_s_int } < { \l__nro_sfim_int + 1 }
          {
            \int_set:Nn \l__nro_ms_int { \__nro_sem_inicio:n { \l__nro_s_int } }
            \int_zero:N \l__nro_cont_int
            \int_step_inline:nnn { 0 } { 5 }
              {
                \int_set:Nn \l__nro_m_int { \l__nro_ms_int + ##1 }
                \bool_lazy_and:nnT
                  { \int_compare_p:nNn { \l__nro_m_int } > { \l__nro_mi_int - 1 } }
                  { \int_compare_p:nNn { \l__nro_m_int } < { \l__nro_mf_int + 1 } }
                  { \__nro_afastado:nF { \l__nro_m_int } { \int_incr:N \l__nro_cont_int } }
              }
            \bool_lazy_and:nnTF
              { \int_compare_p:nNn { \l__nro_si_int } > { -1 } }
              { \int_compare_p:nNn { \l__nro_s_int } < { \l__nro_si_int } }
              { \tl_set:Nn \l__nro_tmp_tl { antes } }
              {
                \int_compare:nNnTF { \l__nro_cont_int } < { \__nro_meses_min: }
                  { \tl_set:Nn \l__nro_tmp_tl { parcial } }
                  {
                    \tl_set:Nn \l__nro_tmp_tl { conta }
                    \int_gincr:N \g__nro_sem_conta_int
                  }
              }
            \seq_gput_right:Nx \g__nro_sem_seq
              { { \__nro_sem_rotulo:n { \l__nro_s_int } } { \int_use:N \l__nro_cont_int } { \l__nro_tmp_tl } }
            \int_incr:N \l__nro_s_int
          }
      }
  }

%% os semestres que contam para o enquadramento #1: todos os que contam,
%% ou só os da lista do pedido (siex, ic), quando o catálogo pede uma
\cs_new_protected:Npn \__nro_sem_do:nN #1 #2
  {
    \int_zero:N #2
    \tl_set:Nx \l__nro_tmpc_tl { \__nro_dado:n { apr/#1/semestres } }
    \tl_if_blank:VTF \l__nro_tmpc_tl
      { \int_set_eq:NN #2 \g__nro_sem_conta_int }
      {
        \clist_set:Nx \l_tmpb_clist { \__nro_dado:n { pedido/ \l__nro_tmpc_tl } }
        \seq_map_inline:Nn \g__nro_sem_seq
          { \__nro_sem_do_aux:nnnN ##1 #2 }
      }
  }
\cs_new_protected:Npn \__nro_sem_do_aux:nnnN #1 #2 #3 #4
  {
    \str_if_eq:nnT {#3} { conta }
      {
        \tl_set:Nx \l__nro_tmp_tl { \tl_to_str:n {#1} }
        \clist_if_in:NVT \l_tmpb_clist \l__nro_tmp_tl { \int_incr:N #4 }
      }
  }

%% ------------------------------------------------------------
%% 7. OS TIPOS DE ATIVIDADE
%%    Cada tipo (nro/tipos.tex) tem um nome, o mínimo de figuras, a
%%    ficha técnica (os campos, e quais são obrigatórios: os marcados
%%    com *) e o roteiro: o que quem avalia procura.
%% ------------------------------------------------------------
\seq_new:N \g__nro_tipos_seq
\seq_new:N \g__nro_campos_ficha_seq
\tl_new:N \l__nro_tipo_tl
\NewDocumentCommand \definirtipo { m +m }
  {
    \tl_set:Nx \l__nro_tipo_tl { \tl_trim_spaces:n {#1} }
    \seq_if_in:NVF \g__nro_tipos_seq \l__nro_tipo_tl
      { \seq_gput_right:NV \g__nro_tipos_seq \l__nro_tipo_tl }
    \prop_gput:Nxn \g__nro_dados_prop { tipo/\l__nro_tipo_tl/campos } { }
    \__nro_guardar:nnn { tipo/ \l__nro_tipo_tl } { } {#2}
    \prop_get:NxNT \g__nro_dados_prop { tipo/\l__nro_tipo_tl/ficha } \l__nro_tmpb_tl
      {
        \seq_gclear:N \g__nro_campos_ficha_seq
        \exp_args:NNNV \keyval_parse:NNn \__nro_ficha_def:n \__nro_ficha_def:nn \l__nro_tmpb_tl
        \prop_gput:Nxx \g__nro_dados_prop { tipo/\l__nro_tipo_tl/campos }
          { \seq_use:Nn \g__nro_campos_ficha_seq { , } }
      }
  }
\cs_new_protected:Npn \__nro_ficha_def:n #1 { \__nro_ficha_def:nn {#1} {#1} }
\cs_new_protected:Npn \__nro_ficha_def:nn #1 #2
  {
    \__nro_chave:Nn \l__nro_chave_tl {#1}
    \tl_if_in:NnTF \l__nro_chave_tl { * }
      {
        \tl_remove_all:Nn \l__nro_chave_tl { * }
        \prop_gput:Nxn \g__nro_dados_prop { tipo/\l__nro_tipo_tl/obrigatorio/\l__nro_chave_tl } { 1 }
      }
      { \prop_gput:Nxn \g__nro_dados_prop { tipo/\l__nro_tipo_tl/obrigatorio/\l__nro_chave_tl } { 0 } }
    \prop_gput:Nxn \g__nro_dados_prop { tipo/\l__nro_tipo_tl/rotulo/\l__nro_chave_tl } {#2}
    \seq_gput_right:NV \g__nro_campos_ficha_seq \l__nro_chave_tl
  }
\cs_new:Npn \__nro_tipo_nome:n #1
  { \__nro_se_dado_exp:nTF { tipo/#1/nome } { \__nro_dado:n { tipo/#1/nome } } { #1 } }
\NewExpandableDocumentCommand \nometipo { m } { \__nro_tipo_nome:n {#1} }
%% o tipo tem campo obrigatório na ficha técnica?
\prg_new_protected_conditional:Npnn \__nro_tipo_tem_obrigatorio:n #1 { T , F , TF }
  {
    \bool_set_false:N \l__nro_achou_bool
    \clist_set:Nx \l_tmpb_clist { \__nro_dado:n { tipo/#1/campos } }
    \clist_map_inline:Nn \l_tmpb_clist
      {
        \str_if_eq:eeT { \__nro_dado:n { tipo/#1/obrigatorio/##1 } } { 1 }
          { \bool_set_true:N \l__nro_achou_bool \clist_map_break: }
      }
    \bool_if:NTF \l__nro_achou_bool { \prg_return_true: } { \prg_return_false: }
  }
\prg_generate_conditional_variant:Nnn \__nro_tipo_tem_obrigatorio:n { V } { T , F , TF }

%% ------------------------------------------------------------
%% 8. AS COMPETÊNCIAS, PELA DCN DO CURSO (nro/competencias.tex), E O
%%    BAREMA (nro/avaliacao.tex)
%%    Cada lista é aberta por \conjuntocompetencias{chave}{referência} e
%%    preenchida com \competencia{I}{texto}; \cursos{chave}{A; B} diz que
%%    cursos a usam. O curso de estudante/curso escolhe a lista; curso que
%%    não está em nenhuma usa a "geral".
%% ------------------------------------------------------------
\seq_new:N \g__nro_comp_seq      % as da lista do curso: I, II, …
\tl_new:N \g__nro_conjunto_tl
\tl_new:N \g__nro_conjunto_ativo_tl
\prop_new:N \g__nro_cursos_prop  % o curso, em minúsculas → a lista
\NewDocumentCommand \conjuntocompetencias { m +m }
  {
    \tl_gset:Nx \g__nro_conjunto_tl { \tl_trim_spaces:n {#1} }
    \prop_gput:Nxn \g__nro_dados_prop { compref/\g__nro_conjunto_tl } {#2}
    \seq_gclear_new:c { g__nro_comp_ \g__nro_conjunto_tl _seq }
  }
\NewDocumentCommand \competencia { m +m }
  {
    \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:n {#1} }
    \seq_gput_right:cV { g__nro_comp_ \g__nro_conjunto_tl _seq } \l__nro_tmpb_tl
    \prop_gput:Nxn \g__nro_dados_prop { comp/\g__nro_conjunto_tl/\l__nro_tmpb_tl } {#2}
  }
\cs_new:Npn \__nro_curso_chave:n #1 { \str_lowercase:f { \tl_to_str:e { \tl_trim_spaces:e {#1} } } }
\NewDocumentCommand \cursos { m +m }
  {
    \seq_set_split:Nnn \l__nro_tmp_seq { ; } {#2}
    \seq_map_inline:Nn \l__nro_tmp_seq
      {
        \tl_if_blank:nF {##1}
          { \prop_gput:Nxx \g__nro_cursos_prop { \__nro_curso_chave:n {##1} } { \tl_trim_spaces:n {#1} } }
      }
  }
%% a lista do curso: as competências dela passam a ser as do relatório
\cs_new_protected:Npn \__nro_escolher_competencias:
  {
    \tl_set:Nx \l__nro_tmp_tl { \__nro_curso_chave:n { \__nro_dado:n { estudante/curso } } }
    \prop_get:NVNF \g__nro_cursos_prop \l__nro_tmp_tl \l__nro_tmpb_tl { \tl_set:Nn \l__nro_tmpb_tl { geral } }
    \seq_if_exist:cF { g__nro_comp_ \l__nro_tmpb_tl _seq } { \tl_set:Nn \l__nro_tmpb_tl { geral } }
    \tl_gset_eq:NN \g__nro_conjunto_ativo_tl \l__nro_tmpb_tl
    \seq_gclear:N \g__nro_comp_seq
    \seq_if_exist:cT { g__nro_comp_ \l__nro_tmpb_tl _seq }
      { \seq_gset_eq:Nc \g__nro_comp_seq { g__nro_comp_ \l__nro_tmpb_tl _seq } }
    \seq_map_inline:Nn \g__nro_comp_seq
      {
        \prop_get:NxN \g__nro_dados_prop { comp/\l__nro_tmpb_tl/##1 } \l__nro_tmpc_tl
        \prop_gput:NnV \g__nro_dados_prop { comp/##1 } \l__nro_tmpc_tl
      }
    \prop_get:NxN \g__nro_dados_prop { compref/\l__nro_tmpb_tl } \l__nro_tmpc_tl
    \prop_gput:NnV \g__nro_dados_prop { compref } \l__nro_tmpc_tl
  }
\cs_generate_variant:Nn \prop_get:NnN { NxN }
\cs_generate_variant:Nn \prop_gput:Nnn { NnV }
\seq_new:N \g__nro_crit_seq      % as chaves dos critérios, na ordem
\NewDocumentCommand \criterio { m m +m +m }
  {
    %% #1 chave, #2 peso, #3 nome, #4 o que se espera para a nota máxima
    \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:n {#1} }
    \seq_gput_right:NV \g__nro_crit_seq \l__nro_tmpb_tl
    \prop_gput:Nxn \g__nro_dados_prop { crit/\l__nro_tmpb_tl/peso } {#2}
    \prop_gput:Nxn \g__nro_dados_prop { crit/\l__nro_tmpb_tl/nome } {#3}
    \prop_gput:Nxn \g__nro_dados_prop { crit/\l__nro_tmpb_tl/descritor } {#4}
  }

%% ------------------------------------------------------------
%% 9. A ATIVIDADE
%%    \begin{atividade}{Título}{tipo = …, horas = …, aproveitamento = …}
%%    Guarda a ficha, abre a atividade, confere o que falta ao fechar
%%    e escreve no .aux a linha que os quadros do começo vão ler.
%%    O aproveitamento é "participacao" (o padrão: a atividade compõe o
%%    enquadramento do pedido) ou a chave de uma atividade à parte.
%% ------------------------------------------------------------
\newcounter { atividade }
\renewcommand \theatividade { A \arabic { atividade } }
\newcounter { secaoatv } [ atividade ]
\prop_new:N \l__nro_atv_prop
\tl_new:N \l__nro_atv_titulo_tl
\tl_new:N \l__nro_atv_tipo_tl
\tl_new:N \l__nro_atv_apr_tl            % participacao, ou PUB, EVO…
\tl_new:N \l__nro_atv_cred_tl           % os créditos da atividade à parte
\tl_new:N \l__nro_atv_base_tl           % a base deles, por extenso
\prop_new:N \g__nro_atv_secoes_prop     % as seções que esta atividade abriu
\int_new:N \g__nro_atv_evid_int         % as evidências desta atividade
\int_new:N \g__nro_atv_figini_int       % a conta das figuras na abertura
\int_new:N \g__nro_atv_lstini_int       % e a das listagens
\bool_new:N \g__nro_atv_ficha_bool      % teve ficha técnica?
\bool_new:N \g__nro_dentro_atv_bool
\seq_new:N \g__nro_atvs_seq             % os números das atividades (do .aux)

\clist_const:Nn \c__nro_atv_chaves_clist
  { tipo , aproveitamento , horas , duracao , publicacao , inicio , fim , projeto ,
    papel , supervisor , registros , competencias , disciplinas }
\clist_const:Nn \c__nro_atv_obrigatorias_clist
  { tipo , horas , inicio , fim , projeto , papel , supervisor , registros , competencias }
\prop_const_from_keyval:Nn \c__nro_atv_rotulos_prop
  {
    tipo = o~tipo , horas = as~horas , inicio = o~início~(AAAA-MM) ,
    fim = o~fim~(AAAA-MM~ou~em~andamento) , projeto = o~projeto ,
    papel = o~seu~papel , supervisor = quem~confirma ,
    registros = os~registros~no~SOMA , competencias = as~competências~(DCN) ,
  }
%% as espécies de publicação (art. 9º, II) e os créditos de cada uma
\prop_const_from_keyval:Nn \c__nro_pub_cred_prop
  { nacional = 1 , internacional = 2 , revista = 3 , periodico = 3 , periódico = 3 , livro = 3 , patente = 3 }
\prop_const_from_keyval:Nn \c__nro_pub_nome_prop
  {
    nacional = artigo~em~evento~nacional , internacional = artigo~em~evento~internacional ,
    revista = artigo~em~revista~técnica~indexada , periodico = artigo~em~periódico~com~corpo~editorial ,
    periódico = artigo~em~periódico~com~corpo~editorial ,
    livro = livro~técnico~indexado , patente = depósito~de~pedido~de~patente ,
  }

\cs_new:Npn \__nro_atv:n #1 { \prop_item:Nn \l__nro_atv_prop {#1} }
\prg_new_protected_conditional:Npnn \__nro_se_atv:n #1 { T , F , TF }
  {
    \prop_get:NnNTF \l__nro_atv_prop {#1} \l__nro_tmp_tl
      { \tl_if_blank:VTF \l__nro_tmp_tl { \prg_return_false: } { \prg_return_true: } }
      { \prg_return_false: }
  }

\cs_new_protected:Npn \__nro_atv_chave:n #1 { \__nro_atv_par:nn {#1} { } }
\cs_new_protected:Npn \__nro_atv_par:nn #1 #2
  {
    \__nro_chave:Nn \l__nro_chave_tl {#1}
    %% "modalidade" e "enquadramento" (da versão 1) também valem
    \str_if_eq:VnT \l__nro_chave_tl { modalidade } { \tl_set:Nn \l__nro_chave_tl { aproveitamento } }
    \str_if_eq:VnT \l__nro_chave_tl { enquadramento } { \tl_set:Nn \l__nro_chave_tl { aproveitamento } }
    \clist_if_in:NVF \c__nro_atv_chaves_clist \l__nro_chave_tl
      { \msg_warning:nnVV { nro-aacc } { chave-atividade } \l__nro_chave_tl \l__nro_chave_tl }
    \prop_put:NVn \l__nro_atv_prop \l__nro_chave_tl {#2}
  }

\cs_new_protected:Npn \__nro_atv_inicio:nn #1 #2
  {
    \bool_if:NT \g__nro_dentro_atv_bool
      { \msg_error:nn { nro-aacc } { atividade-dentro } }
    \bool_gset_true:N \g__nro_dentro_atv_bool
    \tl_set:Nn \l__nro_atv_titulo_tl {#1}
    \prop_clear:N \l__nro_atv_prop
    \keyval_parse:NNn \__nro_atv_chave:n \__nro_atv_par:nn {#2}
    \tl_set:Nx \l__nro_atv_tipo_tl { \tl_trim_spaces:e { \__nro_atv:n { tipo } } }
    \prop_gclear:N \g__nro_atv_secoes_prop
    \int_gzero:N \g__nro_atv_evid_int
    \int_gset:Nn \g__nro_atv_figini_int { \value { figure } }
    \int_gset:Nn \g__nro_atv_lstini_int { \value { lstlisting } }
    \bool_gset_false:N \g__nro_atv_ficha_bool
    \__nro_atv_aproveitamento:
    \nro@abreatividade
    \__nro_atv_conferir_ficha:
  }
%% a entrada do sumário: o título mesmo, não o comando que o guarda
\cs_new_protected:Npn \nro@tocatividade
  {
    \exp_args:Nnnx \addcontentsline { toc } { section }
      { \exp_not:N \protect \exp_not:N \numberline { \theatividade } \exp_not:V \l__nro_atv_titulo_tl }
  }

%% o aproveitamento da atividade: participação, ou uma atividade à parte
%% com os créditos dela (sem conferir: a conferência é a da ficha)
\cs_new_protected:Npn \__nro_atv_aproveitamento:
  {
    \tl_clear:N \l__nro_atv_cred_tl
    \tl_clear:N \l__nro_atv_base_tl
    \tl_set:Nx \l__nro_tmp_tl { \__nro_chave_apr:n { \__nro_atv:n { aproveitamento } } }
    \tl_if_blank:VTF \l__nro_tmp_tl
      { \tl_set:Nn \l__nro_atv_apr_tl { participacao } }
      {
        \str_if_in:NnTF \l__nro_tmp_tl { PARTICIPA }
          { \tl_set:Nn \l__nro_atv_apr_tl { participacao } }
          {
            \__nro_se_classe:VnTF \l__nro_tmp_tl { participacao }
              { \tl_set:Nn \l__nro_atv_apr_tl { participacao } }
              { \tl_set_eq:NN \l__nro_atv_apr_tl \l__nro_tmp_tl }
          }
      }
    \__nro_se_classe:VnT \l__nro_atv_apr_tl { atividade }
      { \__nro_atv_creditos: }
  }
\prg_generate_conditional_variant:Nnn \__nro_se_classe:nn { V } { p , T , F , TF }
\cs_new_protected:Npn \__nro_atv_creditos:
  {
    \tl_set:Nx \l__nro_tmpc_tl { \__nro_dado:n { apr/ \l__nro_atv_apr_tl /base } }
    \str_case:VnT \l__nro_tmpc_tl
      {
        { publicacao }
          {
            \tl_set:Nx \l__nro_tmpb_tl { \str_lowercase:f { \tl_to_str:e { \tl_trim_spaces:e { \__nro_atv:n { publicacao } } } } }
            \prop_get:NVNT \c__nro_pub_cred_prop \l__nro_tmpb_tl \l__nro_atv_cred_tl
              { \prop_get:NVN \c__nro_pub_nome_prop \l__nro_tmpb_tl \l__nro_atv_base_tl }
          }
        { duracao }
          {
            \__nro_numero:n { \__nro_atv:n { duracao } }
            \tl_if_empty:NF \l__nro_num_tl
              {
                \tl_set:Nx \l__nro_atv_cred_tl
                  { \fp_eval:n { floor ( \l__nro_num_tl / ( \__nro_dado:n { apr/ \l__nro_atv_apr_tl /unidade } ) + 1e-9 ) * ( \__nro_dado:n { apr/ \l__nro_atv_apr_tl /creditos } ) } }
                \tl_set:Nx \l__nro_atv_base_tl { \exp_not:N \__nro_horas:n { \l__nro_num_tl } }
                \tl_put_right:Nn \l__nro_atv_base_tl { \c_space_tl de~duração }
              }
          }
        { horas }
          {
            \__nro_numero:n { \__nro_atv:n { horas } }
            \tl_if_empty:NF \l__nro_num_tl
              {
                \tl_set:Nx \l__nro_atv_cred_tl
                  { \fp_eval:n { floor ( \l__nro_num_tl / ( \__nro_dado:n { apr/ \l__nro_atv_apr_tl /unidade } ) + 1e-9 ) * ( \__nro_dado:n { apr/ \l__nro_atv_apr_tl /creditos } ) } }
                \tl_set:Nx \l__nro_atv_base_tl { \exp_not:N \__nro_horas:n { \l__nro_num_tl } }
                \tl_put_right:Nn \l__nro_atv_base_tl { \c_space_tl de~atividade }
              }
          }
      }
  }

%% o que a ficha da atividade precisa ter
\cs_new_protected:Npn \__nro_atv_conferir_ficha:
  {
    \clist_map_inline:Nn \c__nro_atv_obrigatorias_clist
      {
        \__nro_se_atv:nF {##1}
          {
            \prop_get:NnN \c__nro_atv_rotulos_prop {##1} \l__nro_tmpb_tl
            \__nro_pend:n { \theatividade ,~ficha:~falta~\l__nro_tmpb_tl }
          }
      }
    \__nro_se_atv:nT { tipo }
      {
        \seq_if_in:NVF \g__nro_tipos_seq \l__nro_atv_tipo_tl
          {
            \msg_warning:nnV { nro-aacc } { tipo-desconhecido } \l__nro_atv_tipo_tl
            \__nro_pend:n { \theatividade ,~o~tipo~'\l__nro_atv_tipo_tl'~não~existe~(veja~nro/tipos.tex) }
          }
      }
    %% o aproveitamento à parte: a chave existe? a base dele está na ficha?
    \str_if_eq:VnF \l__nro_atv_apr_tl { participacao }
      {
        \seq_if_in:NVTF \g__nro_apr_seq \l__nro_atv_apr_tl
          {
            \tl_if_empty:NT \l__nro_atv_cred_tl
              {
                \str_case:enF { \__nro_dado:n { apr/ \l__nro_atv_apr_tl /base } }
                  {
                    { publicacao } { \__nro_pend:n { \theatividade ,~publicação:~informe~publicacao~=~nacional,~internacional,~revista,~periodico,~livro~ou~patente } }
                    { duracao } { \__nro_pend:n { \theatividade ,~informe~a~duração~do~evento~ou~do~curso~em~horas~(duracao) } }
                  }
                  { }
              }
            \tl_if_empty:NF \l__nro_atv_cred_tl
              {
                \int_compare:nNnT { \l__nro_atv_cred_tl } < { 1 }
                  {
                    \__nro_pend:n { \theatividade ,~não~chega~a~um~crédito~como~\l__nro_atv_apr_tl :~conte-a~na~participação~(aproveitamento~=~participacao) }
                  }
              }
          }
          { \__nro_pend:n { \theatividade ,~o~aproveitamento~'\l__nro_atv_apr_tl'~não~existe~(veja~nro/aproveitamento.tex) } }
      }
    \__nro_se_atv:nT { horas }
      {
        \__nro_numero:n { \__nro_atv:n { horas } }
        \tl_if_empty:NTF \l__nro_num_tl
          { \__nro_pend:n { \theatividade ,~as~horas~devem~ser~um~número } }
          {
            \fp_compare:nNnT { \l__nro_num_tl } = { 0 }
              { \__nro_pend:n { \theatividade ,~atividade~sem~horas } }
          }
      }
    \__nro_se_atv:nT { inicio }
      {
        \__nro_ler_data:xTF { \__nro_atv:n { inicio } }
          {
            %% art. 5º: só depois do ingresso no curso
            \int_set:Nn \l__nro_tmp_int { \__nro_sem_ingresso: }
            \int_compare:nNnT { \l__nro_tmp_int } > { -1 }
              {
                \int_compare:nNnT
                  { \l__nro_ano_int * 12 + \l__nro_mes_int } < { \__nro_sem_inicio:n { \l__nro_tmp_int } }
                  { \__nro_pend:n { \theatividade ,~começou~antes~do~ingresso~no~curso:~não~pode~ser~aproveitada~(art.~5\textordmasculine) } }
              }
          }
          { \__nro_pend:n { \theatividade ,~o~início~deve~estar~como~AAAA-MM } }
      }
    \__nro_se_atv:nT { fim }
      {
        \__nro_se_andamento:TF { }
          {
            \__nro_ler_data:xF { \__nro_atv:n { fim } }
              { \__nro_pend:n { \theatividade ,~o~fim~deve~estar~como~AAAA-MM~(ou~em~andamento) } }
          }
      }
  }
\cs_new_protected:Npn \__nro_se_andamento:TF #1 #2
  {
    \tl_set:Nx \l__nro_tmp_tl { \str_lowercase:f { \tl_to_str:e { \__nro_atv:n { fim } } } }
    \str_if_in:NnTF \l__nro_tmp_tl { andamento } {#1} {#2}
  }
\cs_generate_variant:Nn \str_case:nnF { e }

%% o fecho: as seções, as evidências, as figuras, a ficha técnica; e o .aux
\clist_const:Nn \c__nro_secoes_clist
  { contexto , contribuicao , desenvolvimento , resultados , evidencias , aprendizados }
\prop_const_from_keyval:Nn \c__nro_secoes_nomes_prop
  {
    contexto = Contexto~e~problema , contribuicao = Minha~contribuição ,
    desenvolvimento = Desenvolvimento~técnico , resultados = Resultados ,
    evidencias = Evidências , aprendizados = Aprendizados~e~relação~com~o~curso
  }
\tl_new:N \l__nro_aux_tl
\cs_new_protected:Npn \__nro_atv_fim:
  {
    \par
    \clist_map_inline:Nn \c__nro_secoes_clist
      {
        \prop_if_in:NnF \g__nro_atv_secoes_prop {##1}
          {
            \prop_get:NnN \c__nro_secoes_nomes_prop {##1} \l__nro_tmpb_tl
            \__nro_pend:n { \theatividade ,~falta~a~seção~'\l__nro_tmpb_tl' }
            \nro@caixafalta { Falta~a~seção~\enquote { \l__nro_tmpb_tl }~nesta~atividade. }
          }
      }
    %% as figuras que o tipo pede; a listagem de código conta para software
    \int_set:Nn \l__nro_tmp_int { \value { figure } - \g__nro_atv_figini_int }
    \str_if_eq:VnT \l__nro_atv_tipo_tl { software }
      { \int_add:Nn \l__nro_tmp_int { \value { lstlisting } - \g__nro_atv_lstini_int } }
    \tl_set:Nx \l__nro_tmpb_tl { \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/figuras } }
    \tl_if_blank:VT \l__nro_tmpb_tl { \tl_set:Nn \l__nro_tmpb_tl { 0 } }
    \int_compare:nNnT { \l__nro_tmp_int } < { \l__nro_tmpb_tl }
      {
        \__nro_pend:n { \theatividade ,~faltam~figuras~(o~tipo~pede~\l__nro_tmpb_tl) }
        \nro@caixafalta
          {
            Mostre~o~que~você~fez:~uma~atividade~de~\__nro_tipo_nome:n { \l__nro_atv_tipo_tl }~pede~ao~menos~
            \l__nro_tmpb_tl \c_space_tl figura(s)~com~legenda~(o~esquemático,~o~modelo,~o~resultado,~a~bancada).
          }
      }
    %% a ficha técnica, quando o tipo tem campos obrigatórios
    \bool_if:NF \g__nro_atv_ficha_bool
      {
        \__nro_tipo_tem_obrigatorio:VT \l__nro_atv_tipo_tl
          {
            \__nro_pend:n { \theatividade ,~falta~a~ficha~técnica }
            \nro@caixafalta { Falta~a~ficha~técnica~(\cod{\textbackslash fichatecnica})~desta~atividade. }
          }
      }
    %% a linha do .aux
    \__nro_numero:n { \__nro_atv:n { horas } }
    \tl_if_empty:NT \l__nro_num_tl { \tl_set:Nn \l__nro_num_tl { 0 } }
    \tl_set:Nx \l__nro_aux_tl
      {
        titulo = { \exp_not:V \l__nro_atv_titulo_tl } ,
        horas = { \l__nro_num_tl } ,
        evidencias = { \int_use:N \g__nro_atv_evid_int } ,
        aproveitamento = { \l__nro_atv_apr_tl } ,
        creditos = { \tl_if_empty:NTF \l__nro_atv_cred_tl { 0 } { \l__nro_atv_cred_tl } } ,
        base = { \exp_not:V \l__nro_atv_base_tl } ,
      }
    \clist_map_inline:nn
      { tipo , inicio , fim , projeto , papel , competencias , disciplinas , supervisor }
      {
        \prop_get:NnNF \l__nro_atv_prop {##1} \l__nro_tmp_tl { \tl_clear:N \l__nro_tmp_tl }
        \tl_put_right:Nx \l__nro_aux_tl { ##1 = { \exp_not:V \l__nro_tmp_tl } , }
      }
    \iow_now:Nx \@auxout
      { \token_to_str:N \nro@atv { \arabic { atividade } } { \exp_not:V \l__nro_aux_tl } }
    \bool_gset_false:N \g__nro_dentro_atv_bool
    \nro@fechaatividade
  }

%% a linha do .aux, lida no \begin{document} seguinte
\cs_new_protected:Npn \nro@atv #1 #2
  {
    \bool_if:NF \g__nro_aux_encerrado_bool
      {
        \seq_gput_right:Nn \g__nro_atvs_seq {#1}
        \prop_gclear_new:c { g__nro_atv_#1_prop }
        \prop_gset_from_keyval:cn { g__nro_atv_#1_prop } {#2}
      }
  }
\cs_new:Npn \__nro_a:nn #1 #2 { \prop_item:cn { g__nro_atv_#1_prop } {#2} }

\NewDocumentEnvironment { atividade } { +m +m }
  { \__nro_atv_inicio:nn {#1} {#2} }
  { \__nro_atv_fim: }

%% as seções da atividade
\cs_new_protected:Npn \nro@secao #1 { \prop_gput:Nnn \g__nro_atv_secoes_prop {#1} { 1 } }
\cs_new_protected:Npn \nro@exigiratividade #1
  { \bool_if:NF \g__nro_dentro_atv_bool { \msg_error:nnn { nro-aacc } { fora-da-atividade } {#1} } }

%% as partes da ficha da atividade, para a apresentação
\cs_new:Npn \nro@atvdado #1 { \__nro_atv:n {#1} }
\cs_new_protected:Npn \nro@seatvdado #1 #2 #3 { \__nro_se_atv:nTF {#1} {#2} {#3} }
\cs_new:Npn \nro@atvtiponome { \__nro_tipo_nome:n { \l__nro_atv_tipo_tl } }
\cs_new_protected:Npn \nro@atvtitulo { \tl_use:N \l__nro_atv_titulo_tl }
\cs_new_protected:Npn \nro@atvperiodo
  {
    \__nro_se_atv:nTF { inicio }
      {
        \__nro_data_curta:n { \__nro_atv:n { inicio } }
        \__nro_se_atv:nT { fim }
          {
            \__nro_se_andamento:TF
              { ~ a ~ hoje~(em~andamento) }
              {
                \str_if_eq:eeF { \__nro_atv:n { inicio } } { \__nro_atv:n { fim } }
                  { ~ a ~ \__nro_data_curta:n { \__nro_atv:n { fim } } }
              }
          }
      }
      { \nro@marca { o~período } }
  }
\cs_new_protected:Npn \nro@atvhoras
  {
    \__nro_numero:n { \__nro_atv:n { horas } }
    \tl_if_empty:NTF \l__nro_num_tl { \nro@marca { as~horas } } { \__nro_horas:n { \l__nro_num_tl } }
  }
\cs_new_protected:Npn \nro@atvaproveitamento
  {
    \str_if_eq:VnTF \l__nro_atv_apr_tl { participacao }
      { Participação~na~equipe~(compõe~o~enquadramento~do~pedido,~Quadro~1) }
      {
        \__nro_apr_nome:n { \l__nro_atv_apr_tl } , ~
        \__nro_apr_disp:n { \l__nro_atv_apr_tl }
        \tl_if_empty:NF \l__nro_atv_cred_tl
          {
            \newline \textcolor { nro-cinza }
              { \tl_use:N \l__nro_atv_base_tl : ~ \__nro_cred:n { \l__nro_atv_cred_tl } ,~à~parte~(art.~7\textordmasculine) }
          }
      }
  }
\cs_new_protected:Npn \nro@atvcompetencias
  {
    \__nro_se_atv:nTF { competencias }
      {
        \clist_set:Nx \l_tmpa_clist { \__nro_atv:n { competencias } }
        \seq_clear:N \l__nro_tmp_seq
        \clist_map_inline:Nn \l_tmpa_clist
          {
            \seq_if_in:NnTF \g__nro_comp_seq {##1}
              { \seq_put_right:Nn \l__nro_tmp_seq {##1} }
              {
                \__nro_pend:n { \nro@contexto:~a~competência~##1~não~está~na~lista~do~curso~(Parte~IV) }
                \seq_put_right:Nn \l__nro_tmp_seq { \nro@marca { ##1~não~está~na~lista~do~curso } }
              }
          }
        \seq_use:Nn \l__nro_tmp_seq { ,~ }
        \c_space_tl \textcolor { nro-cinza } { (DCN~do~curso,~Parte~IV) }
      }
      { \nro@marca { as~competências } }
  }
\cs_new_protected:Npn \nro@atvdisciplinas
  {
    \__nro_se_atv:nTF { disciplinas }
      {
        \seq_set_split:Nnx \l__nro_tmp_seq { ; } { \__nro_atv:n { disciplinas } }
        \seq_remove_all:Nn \l__nro_tmp_seq { }
        \seq_use:Nn \l__nro_tmp_seq { \newline }
      }
      { \textcolor { nro-cinza } { nenhuma~indicada } }
  }
\cs_new_protected:Npn \nro@atvregistros
  {
    \__nro_se_atv:nTF { registros }
      {
        \seq_set_split:Nnx \l__nro_tmp_seq { ; } { \__nro_atv:n { registros } }
        \seq_remove_all:Nn \l__nro_tmp_seq { }
        \seq_clear:N \l_tmpb_seq
        \seq_map_inline:Nn \l__nro_tmp_seq { \seq_put_right:Nn \l_tmpb_seq { \cod {##1} } }
        \seq_use:Nn \l_tmpb_seq { ,~ }
      }
      { \nro@marca { os~registros } }
  }

%% a ficha técnica: \fichatecnica{campo = valor, …}
\prop_new:N \l__nro_ficha_prop
\seq_new:N \l__nro_ficha_extras_seq
\tl_new:N \l__nro_ficha_linhas_tl
\NewDocumentCommand \fichatecnica { +m }
  {
    \nro@exigiratividade { \iow_char:N \\fichatecnica }
    \bool_gset_true:N \g__nro_atv_ficha_bool
    \prop_clear:N \l__nro_ficha_prop
    \seq_clear:N \l__nro_ficha_extras_seq
    \keyval_parse:NNn \__nro_ficha_chave:n \__nro_ficha_par:nn {#1}
    \tl_clear:N \l__nro_ficha_linhas_tl
    \clist_set:Nx \l_tmpa_clist { \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/campos } }
    \clist_map_inline:Nn \l_tmpa_clist
      {
        \tl_set:Nx \l__nro_tmpb_tl { \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/rotulo/##1 } }
        \prop_get:NnNTF \l__nro_ficha_prop {##1} \l__nro_tmp_tl
          {
            \tl_if_blank:VTF \l__nro_tmp_tl
              { \__nro_ficha_vazio:n {##1} }
              { \__nro_ficha_linha:VV \l__nro_tmpb_tl \l__nro_tmp_tl }
          }
          { \__nro_ficha_vazio:n {##1} }
      }
    \seq_map_inline:Nn \l__nro_ficha_extras_seq
      {
        \prop_get:NnN \l__nro_ficha_prop {##1} \l__nro_tmp_tl
        \__nro_ficha_linha:nV {##1} \l__nro_tmp_tl
      }
    \nro@tabelaficha { \l__nro_ficha_linhas_tl }
  }
\cs_new_protected:Npn \__nro_ficha_chave:n #1 { \__nro_ficha_par:nn {#1} { } }
\cs_new_protected:Npn \__nro_ficha_par:nn #1 #2
  {
    \__nro_chave:Nn \l__nro_chave_tl {#1}
    \prop_put:NVn \l__nro_ficha_prop \l__nro_chave_tl {#2}
    \clist_set:Nx \l_tmpb_clist { \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/campos } }
    \clist_if_in:NVF \l_tmpb_clist \l__nro_chave_tl
      { \seq_put_right:NV \l__nro_ficha_extras_seq \l__nro_chave_tl }
  }
\cs_new_protected:Npn \__nro_ficha_linha:nn #1 #2
  { \tl_put_right:Nn \l__nro_ficha_linhas_tl { \nro@linhaficha {#1} {#2} } }
\cs_generate_variant:Nn \__nro_ficha_linha:nn { VV , nV }
\cs_new_protected:Npn \__nro_ficha_vazio:n #1
  {
    \str_if_eq:eeT { \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/obrigatorio/#1 } } { 1 }
      {
        \__nro_pend:n { \theatividade ,~ficha~técnica:~falta~\l__nro_tmpb_tl }
        \tl_put_right:Nx \l__nro_ficha_linhas_tl
          { \exp_not:N \nro@linhaficha { \exp_not:V \l__nro_tmpb_tl } { \exp_not:N \nro@marca { preencher } } }
      }
  }

%% as evidências: \evidencia{tipo}{identificador}{o que mostra}{onde conferir}
\int_new:N \g__nro_evid_int            % E1, E2… no relatório inteiro
\seq_new:N \g__nro_evid_seq            % para o índice do Anexo A
\tl_new:N \l__nro_evid_linhas_tl
\int_new:N \l__nro_evid_local_int
\bool_new:N \l__nro_em_evidencias_bool
\cs_new_protected:Npn \nro@abreevidencias
  {
    \tl_clear:N \l__nro_evid_linhas_tl
    \int_zero:N \l__nro_evid_local_int
    \bool_set_true:N \l__nro_em_evidencias_bool
  }
\NewDocumentCommand \evidencia { +m +m +m +m }
  {
    \bool_if:NF \l__nro_em_evidencias_bool { \msg_error:nn { nro-aacc } { fora-das-evidencias } }
    \int_gincr:N \g__nro_evid_int
    \int_gincr:N \g__nro_atv_evid_int
    \int_incr:N \l__nro_evid_local_int
    \tl_put_right:Nx \l__nro_evid_linhas_tl
      {
        \exp_not:N \nro@linhaevidencia { E \int_use:N \g__nro_evid_int }
          { \exp_not:n {#1} } { \exp_not:n {#2} } { \exp_not:n {#3} } { \exp_not:n {#4} }
      }
    \seq_gput_right:Nx \g__nro_evid_seq
      {
        { E \int_use:N \g__nro_evid_int } { \theatividade }
        { \exp_not:n {#1} } { \exp_not:n {#2} } { \exp_not:n {#3} } { \exp_not:n {#4} }
      }
    \ignorespaces
  }
\cs_new_protected:Npn \nro@fechaevidencias
  {
    \int_compare:nNnTF { \l__nro_evid_local_int } > { 0 }
      { \nro@tabelaevidencias { \l__nro_evid_linhas_tl } }
      {
        \__nro_pend:n { \theatividade ,~nenhuma~evidência }
        \nro@caixafalta { Atividade~sem~evidência~não~conta:~cite~ao~menos~uma~(o~código~no~SOMA,~o~repositório,~o~arquivo~do~projeto). }
      }
  }
\cs_new_protected:Npn \nro@indiceevidencias
  {
    \seq_if_empty:NTF \g__nro_evid_seq
      { \nro@semevidencias }
      {
        \tl_clear:N \l__nro_evid_linhas_tl
        \seq_map_inline:Nn \g__nro_evid_seq
          { \tl_put_right:Nn \l__nro_evid_linhas_tl { \nro@linhaindice ##1 } }
        \nro@tabelaindice { \l__nro_evid_linhas_tl }
      }
  }
\int_new:N \g__nro_evid_ant_int
\cs_new_protected:Npn \nro@nevid #1
  { \bool_if:NF \g__nro_aux_encerrado_bool { \int_gset:Nn \g__nro_evid_ant_int {#1} } }
\cs_new:Npn \nro@totalevidencias { \int_use:N \g__nro_evid_ant_int }

%% ------------------------------------------------------------
%% 10. O PEDIDO E OS QUADROS QUE SE MONTAM SOZINHOS (do .aux)
%%     Cada quadro monta as suas linhas numa tl ANTES da tabela; a
%%     tabela só escreve a tl.
%% ------------------------------------------------------------
\fp_new:N \g__nro_total_fp             % horas de todas as atividades
\fp_new:N \g__nro_part_fp              % horas das atividades da participação
\tl_new:N \g__nro_part_atvs_tl         % A1, A2…
\prop_new:N \g__nro_item_cred_prop     % chave → créditos das atividades à parte
\prop_new:N \g__nro_item_horas_prop    % chave → horas
\prop_new:N \g__nro_item_atvs_prop     % chave → A5, A7
\seq_new:N \g__nro_itens_seq           % as chaves usadas, na ordem do catálogo
\int_new:N \g__nro_itens_cred_int      % os créditos de todas as atividades à parte
\tl_new:N \g__nro_principal_tl         % a chave do enquadramento principal
\seq_new:N \g__nro_alt_seq             % as das alternativas
\int_new:N \g__nro_principal_cred_int
\bool_new:N \g__nro_totais_bool
\tl_new:N \g__nro_linhas_tl            % as linhas do próximo quadro

\cs_new_protected:Npn \__nro_totais:
  {
    \bool_if:NF \g__nro_totais_bool
      {
        \bool_gset_true:N \g__nro_totais_bool
        \fp_gzero:N \g__nro_total_fp
        \fp_gzero:N \g__nro_part_fp
        \tl_gclear:N \g__nro_part_atvs_tl
        \prop_gclear:N \g__nro_item_cred_prop
        \prop_gclear:N \g__nro_item_horas_prop
        \prop_gclear:N \g__nro_item_atvs_prop
        \int_gzero:N \g__nro_itens_cred_int
        \seq_map_inline:Nn \g__nro_atvs_seq
          {
            \fp_gadd:Nn \g__nro_total_fp { \__nro_a:nn {##1} { horas } }
            \tl_set:Nx \l__nro_tmp_tl { \__nro_a:nn {##1} { aproveitamento } }
            \str_if_eq:VnTF \l__nro_tmp_tl { participacao }
              {
                \fp_gadd:Nn \g__nro_part_fp { \__nro_a:nn {##1} { horas } }
                \tl_if_empty:NTF \g__nro_part_atvs_tl
                  { \tl_gset:Nn \g__nro_part_atvs_tl { A##1 } }
                  { \tl_gput_right:Nn \g__nro_part_atvs_tl { ,~A##1 } }
              }
              {
                \__nro_somar_item:Vnn \l__nro_tmp_tl {##1} { creditos }
                \__nro_somar_item_horas:Vn \l__nro_tmp_tl {##1}
                \prop_get:NVNTF \g__nro_item_atvs_prop \l__nro_tmp_tl \l__nro_tmpb_tl
                  { \prop_gput:NVx \g__nro_item_atvs_prop \l__nro_tmp_tl { \exp_not:V \l__nro_tmpb_tl ,~ A##1 } }
                  { \prop_gput:NVx \g__nro_item_atvs_prop \l__nro_tmp_tl { A##1 } }
                \int_gadd:Nn \g__nro_itens_cred_int { \__nro_a:nn {##1} { creditos } }
              }
          }
        \seq_gclear:N \g__nro_itens_seq
        \seq_map_inline:Nn \g__nro_apr_seq
          {
            \prop_if_in:NnT \g__nro_item_cred_prop {##1}
              { \seq_gput_right:Nn \g__nro_itens_seq {##1} }
          }
        %% o pedido: o principal e as alternativas
        \tl_gset:Nx \g__nro_principal_tl { \__nro_chave_apr:n { \__nro_dado:n { pedido/principal } } }
        \seq_gclear:N \g__nro_alt_seq
        \clist_set:Nx \l_tmpa_clist { \__nro_dado:n { pedido/alternativas } }
        \clist_map_inline:Nn \l_tmpa_clist
          {
            \tl_set:Nx \l__nro_tmp_tl { \__nro_chave_apr:n {##1} }
            \bool_lazy_or:nnF
              { \tl_if_blank_p:V \l__nro_tmp_tl }
              { \str_if_eq_p:VV \l__nro_tmp_tl \g__nro_principal_tl }
              { \seq_gput_right:NV \g__nro_alt_seq \l__nro_tmp_tl }
          }
        \__nro_cred_participacao:VN \g__nro_principal_tl \l__nro_tmp_int
        \int_gset_eq:NN \g__nro_principal_cred_int \l__nro_tmp_int
      }
  }
\cs_new_protected:Npn \__nro_somar_item:nnn #1 #2 #3
  {
    \prop_get:NnNF \g__nro_item_cred_prop {#1} \l__nro_tmpb_tl { \tl_set:Nn \l__nro_tmpb_tl { 0 } }
    \prop_gput:Nnx \g__nro_item_cred_prop {#1} { \int_eval:n { \l__nro_tmpb_tl + ( \__nro_a:nn {#2} {#3} ) } }
  }
\cs_generate_variant:Nn \__nro_somar_item:nnn { Vnn }
\cs_new_protected:Npn \__nro_somar_item_horas:nn #1 #2
  {
    \prop_get:NnNF \g__nro_item_horas_prop {#1} \l__nro_tmpb_tl { \tl_set:Nn \l__nro_tmpb_tl { 0 } }
    \prop_gput:Nnx \g__nro_item_horas_prop {#1} { \fp_eval:n { \l__nro_tmpb_tl + ( \__nro_a:nn {#2} { horas } ) } }
  }
\cs_generate_variant:Nn \__nro_somar_item_horas:nn { Vn }
\cs_generate_variant:Nn \prop_gput:Nnn { Nnx }
\prg_generate_conditional_variant:Nnn \str_if_eq:nn { VV } { p , T , F , TF }

%% os créditos de um enquadramento da participação, em #2; a base, por
%% extenso, em \l__nro_base_tl
\tl_new:N \l__nro_base_tl
\cs_new_protected:Npn \__nro_cred_participacao:nN #1 #2
  {
    \int_zero:N #2
    \tl_clear:N \l__nro_base_tl
    \str_case:enF { \__nro_dado:n { apr/#1/base } }
      {
        { semestre }
          {
            \__nro_sem_do:nN {#1} \l__nro_tmpb_int
            \int_set:Nn #2 { \l__nro_tmpb_int * ( \__nro_dado:n { apr/#1/creditos } ) }
            \tl_set:Nx \l__nro_base_tl
              {
                \int_use:N \l__nro_tmpb_int \c_space_tl
                \int_compare:nNnTF { \l__nro_tmpb_int } = { 1 } { semestre~letivo } { semestres~letivos }
              }
          }
        { horas }
          {
            \int_set:Nn #2
              { \fp_eval:n { floor ( \g__nro_part_fp / ( \__nro_dado:n { apr/#1/unidade } ) + 1e-9 ) * ( \__nro_dado:n { apr/#1/creditos } ) } }
            \tl_set:Nx \l__nro_base_tl { \exp_not:N \__nro_horas:n { \fp_use:N \g__nro_part_fp } \c_space_tl de~atividades }
          }
        { colegiado }
          {
            \tl_set:Nx \l__nro_base_tl { \exp_not:N \__nro_horas:n { \fp_use:N \g__nro_part_fp } \c_space_tl de~atividades }
          }
      }
      { }
  }
%% os créditos e as horas de um enquadramento, para os quadros: na base
%% "colegiado", os créditos ficam a definir e as horas são as declaradas
\cs_new:Npn \__nro_col_cred:nn #1 #2
  { \str_if_eq:eeTF { \__nro_dado:n { apr/#1/base } } { colegiado } { a~definir } { \__nro_cred:n {#2} } }
\cs_new_protected:Npn \__nro_col_horas:nn #1 #2
  {
    \str_if_eq:eeTF { \__nro_dado:n { apr/#1/base } } { colegiado }
      { \__nro_horas:n { \fp_use:N \g__nro_part_fp } }
      { \__nro_cred_horas:n {#2} }
  }
\prg_new_conditional:Npnn \__nro_se_colegiado:n #1 { T , F , TF }
  { \str_if_eq:eeTF { \__nro_dado:n { apr/#1/base } } { colegiado } { \prg_return_true: } { \prg_return_false: } }
\cs_new_protected:Npn \nro@seprincipalcolegiado #1 #2
  { \__nro_totais: \exp_args:NV \__nro_se_colegiado:nTF \g__nro_principal_tl {#1} {#2} }
\cs_generate_variant:Nn \__nro_cred_participacao:nN { VN }

\cs_new_protected:Npn \nro@escrevetotalhoras { \__nro_totais: \__nro_horas:n { \g__nro_total_fp } }
\cs_new_protected:Npn \nro@totalcreditos
  { \__nro_totais: \__nro_cred:n { \g__nro_principal_cred_int + \g__nro_itens_cred_int } }
\cs_new:Npn \nro@totalcreditosnum
  { \int_eval:n { \g__nro_principal_cred_int + \g__nro_itens_cred_int } }
\cs_new:Npn \nro@natividades { \seq_count:N \g__nro_atvs_seq }
\cs_new_protected:Npn \nro@setematividades #1 #2 { \seq_if_empty:NTF \g__nro_atvs_seq {#2} {#1} }
\cs_new_protected:Npn \nro@seauxlido #1 #2 { \bool_if:NTF \g__nro_aux_lido_bool {#1} {#2} }
\cs_new:Npn \nro@pendanteriores { \int_use:N \g__nro_pend_ant_int }
\cs_new_protected:Npn \nro@setempendencias #1 #2
  { \int_compare:nNnTF { \g__nro_pend_ant_int } > { 0 } {#1} {#2} }
\cs_new:Npn \nro@linhas { \g__nro_linhas_tl }
\cs_new_protected:Npn \nro@seitens #1 #2 { \__nro_totais: \seq_if_empty:NTF \g__nro_itens_seq {#2} {#1} }
\cs_new_protected:Npn \nro@sealternativas #1 #2 { \__nro_totais: \seq_if_empty:NTF \g__nro_alt_seq {#2} {#1} }
%% o principal tem nome no catálogo?
\cs_new_protected:Npn \nro@seprincipal #1 #2
  {
    \__nro_totais:
    \__nro_se_classe:VnTF \g__nro_principal_tl { participacao } {#1} {#2}
  }
\cs_new_protected:Npn \nro@principalnome { \__nro_totais: \__nro_apr_nome:n { \g__nro_principal_tl } }
\cs_new_protected:Npn \nro@principalfrase { \__nro_totais: \__nro_apr_frase:n { \g__nro_principal_tl } }
\cs_new_protected:Npn \nro@principaldisp { \__nro_totais: \__nro_apr_disp:n { \g__nro_principal_tl } }
\cs_new_protected:Npn \nro@principalcred { \__nro_totais: \__nro_cred:n { \g__nro_principal_cred_int } }
\cs_new_protected:Npn \nro@principalchave { \__nro_totais: \tl_use:N \g__nro_principal_tl }
\cs_new_protected:Npn \nro@principalbase
  { \__nro_totais: \__nro_cred_participacao:VN \g__nro_principal_tl \l__nro_tmp_int \tl_use:N \l__nro_base_tl }
\cs_new:Npn \nro@semestresconta { \int_use:N \g__nro_sem_conta_int }
\cs_new:Npn \nro@semestrescontam
  {
    \int_use:N \g__nro_sem_conta_int \c_space_tl
    \int_compare:nNnTF { \g__nro_sem_conta_int } = { 1 } { semestre~conta } { semestres~contam }
  }

%% o limite e o código do curso, se o membro os informou (em créditos)
\cs_new_protected:Npn \__nro_limite:nn #1 #2
  {
    \__nro_se_dado:nT { apr/#1/codigo }
      { \newline \textcolor { nro-cinza } { \footnotesize no~curso:~\__nro_dado:n { apr/#1/codigo } } }
    \__nro_se_dado:nT { apr/#1/limite }
      {
        \__nro_numero:n { \__nro_dado:n { apr/#1/limite } }
        \tl_if_empty:NF \l__nro_num_tl
          {
            \fp_compare:nNnTF { #2 } > { \l__nro_num_tl }
              { \newline \textcolor { nro-impulso-escuro } { \footnotesize acima~do~limite~do~curso~(\__nro_cred:n { \l__nro_num_tl }) } }
              { \newline \textcolor { nro-cinza } { \footnotesize limite~do~curso:~\__nro_cred:n { \l__nro_num_tl } } }
          }
      }
  }

%% as pendências do pedido, uma vez
\bool_new:N \g__nro_pedido_conferido_bool
\cs_new_protected:Npn \nro@conferirpedido
  {
    \__nro_totais:
    \bool_if:NF \g__nro_pedido_conferido_bool
      {
        \bool_gset_true:N \g__nro_pedido_conferido_bool
        \tl_if_blank:VF \g__nro_principal_tl
          {
            \__nro_se_classe:VnF \g__nro_principal_tl { participacao }
              { \__nro_pend:n { Pedido:~o~enquadramento~principal~'\g__nro_principal_tl'~não~é~da~participação~(EQC,~EXT,~VPC~ou~OUT) } }
          }
        \seq_map_inline:Nn \g__nro_alt_seq
          {
            \__nro_se_classe:nnF {##1} { participacao }
              { \__nro_pend:n { Pedido:~a~alternativa~'##1'~não~é~da~participação~(EQC,~EXT,~VPC~ou~OUT) } }
          }
        %% os enquadramentos que dependem de uma lista de semestres
        \seq_set_eq:NN \l__nro_tmp_seq \g__nro_alt_seq
        \seq_put_left:NV \l__nro_tmp_seq \g__nro_principal_tl
        \seq_map_inline:Nn \l__nro_tmp_seq
          {
            \tl_set:Nx \l__nro_tmpc_tl { \__nro_dado:n { apr/##1/semestres } }
            \tl_if_blank:VF \l__nro_tmpc_tl
              {
                \__nro_se_dado:nF { pedido/ \l__nro_tmpc_tl }
                  { \__nro_pend:n { Pedido:~##1~pede~os~semestres~(\l__nro_tmpc_tl \c_space_tl =~\{2024/1,~2024/2\}~em~\textbackslash pedido) } }
              }
            \str_if_eq:nnT {##1} { EXT }
              {
                \clist_map_inline:nn { equipe/siextitulo , equipe/siexnumero }
                  {
                    \__nro_se_dado:nF {####1}
                      {
                        \prop_get:NnN \g__nro_rotulos_prop {####1} \l__nro_tmp_tl
                        \__nro_pend:n { Pedido:~falta~\l__nro_tmp_tl }
                      }
                  }
              }
          }
        \bool_lazy_and:nnT
          { \str_if_eq_p:ee { \__nro_dado:n { apr/ \g__nro_principal_tl /base } } { semestre } }
          { \int_compare_p:nNn { \g__nro_principal_cred_int } = { 0 } }
          { \__nro_pend:n { Pedido:~nenhum~semestre~conta~para~o~enquadramento~principal~(Quadro~3) } }
      }
  }

%% Quadro 1: o pedido
\cs_new_protected:Npn \nro@montarquadropedido
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    %% o principal
    \__nro_cred_participacao:VN \g__nro_principal_tl \l__nro_tmp_int
    \tl_gput_right:Nx \g__nro_linhas_tl
      {
        \exp_not:N \nro@linhapedido { Principal }
          {
            \tl_if_blank:VTF \g__nro_principal_tl
              { \exp_not:N \nro@marca { o~enquadramento~principal } }
              { \exp_not:N \__nro_apr_nome:n { \g__nro_principal_tl } }
            \exp_not:N \__nro_limite:nn { \g__nro_principal_tl } { \int_use:N \l__nro_tmp_int }
          }
          { \exp_not:N \__nro_apr_disp:n { \g__nro_principal_tl } }
          { \exp_not:V \l__nro_base_tl }
          { \exp_not:N \__nro_col_cred:nn { \g__nro_principal_tl } { \int_use:N \l__nro_tmp_int } }
          { \exp_not:N \__nro_col_horas:nn { \g__nro_principal_tl } { \int_use:N \l__nro_tmp_int } }
      }
    %% as atividades à parte
    \seq_map_inline:Nn \g__nro_itens_seq
      {
        \prop_get:NnN \g__nro_item_cred_prop {##1} \l__nro_tmp_tl
        \prop_get:NnN \g__nro_item_atvs_prop {##1} \l__nro_tmpb_tl
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhapedido { \exp_not:n { À~parte } }
              { \exp_not:N \__nro_apr_nome:n { \exp_not:n {##1} } \exp_not:N \__nro_limite:nn { \exp_not:n {##1} } { \l__nro_tmp_tl } }
              { \exp_not:N \__nro_apr_disp:n { \exp_not:n {##1} } }
              { \exp_not:V \l__nro_tmpb_tl }
              { \exp_not:N \__nro_cred:n { \l__nro_tmp_tl } }
              { \exp_not:N \__nro_cred_horas:n { \l__nro_tmp_tl } }
          }
      }
  }
%% as alternativas (fora da soma)
\cs_new_protected:Npn \nro@montaralternativas
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_alt_seq
      {
        \__nro_cred_participacao:nN {##1} \l__nro_tmp_int
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhapedido { Alternativa }
              { \exp_not:N \__nro_apr_nome:n { \exp_not:n {##1} } \exp_not:N \__nro_limite:nn { \exp_not:n {##1} } { \int_use:N \l__nro_tmp_int } }
              { \exp_not:N \__nro_apr_disp:n { \exp_not:n {##1} } }
              { \exp_not:V \l__nro_base_tl }
              { \exp_not:N \__nro_col_cred:nn { \exp_not:n {##1} } { \int_use:N \l__nro_tmp_int } }
              { \exp_not:N \__nro_col_horas:nn { \exp_not:n {##1} } { \int_use:N \l__nro_tmp_int } }
          }
      }
  }
%% o texto das atividades à parte, para o requerimento
\cs_new_protected:Npn \nro@itensrequerimento
  {
    \__nro_totais:
    \seq_map_indexed_inline:Nn \g__nro_itens_seq
      {
        \prop_get:NnN \g__nro_item_cred_prop {##2} \l__nro_tmp_tl
        \prop_get:NnN \g__nro_item_atvs_prop {##2} \l__nro_tmpb_tl
        \item \textbf { \__nro_cred:n { \l__nro_tmp_tl } } ~ como ~ \__nro_apr_frase:n {##2} ~
          ( \__nro_apr_disp:n {##2} ) , ~
          \tl_if_in:NnTF \l__nro_tmpb_tl { , } { pelas~atividades } { pela~atividade } ~
          \l__nro_tmpb_tl
          \int_compare:nNnTF {##1} = { \seq_count:N \g__nro_itens_seq } { . } { ; }
      }
  }
\cs_new_protected:Npn \nro@alternativasrequerimento
  {
    \__nro_totais:
    \seq_clear:N \l__nro_tmp_seq
    \seq_map_inline:Nn \g__nro_alt_seq
      { \seq_put_right:Nn \l__nro_tmp_seq { \__nro_apr_frase:n {##1} ~ ( \__nro_apr_disp:n {##1} ) } }
    \seq_use:Nnnn \l__nro_tmp_seq { ~ou~como~ } { ,~como~ } { ~ou~como~ }
  }

%% Quadro 2: as atividades
\cs_new_protected:Npn \nro@montarquadroatividades
  {
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_atvs_seq
      {
        \tl_set:Nx \l__nro_tmp_tl { \__nro_a:nn {##1} { aproveitamento } }
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhaatividade
              { ##1 }
              { \__nro_a:nn {##1} { titulo } }
              { \exp_not:N \__nro_tipo_nome:n { \__nro_a:nn {##1} { tipo } } }
              { \exp_not:N \__nro_periodo_aux:nn { \__nro_a:nn {##1} { inicio } } { \__nro_a:nn {##1} { fim } } }
              {
                \str_if_eq:VnTF \l__nro_tmp_tl { participacao }
                  { \exp_not:n { Participação } }
                  { \exp_not:V \l__nro_tmp_tl , ~ \exp_not:N \__nro_cred:n { \__nro_a:nn {##1} { creditos } } }
              }
              { \exp_not:N \__nro_horas:n { \__nro_a:nn {##1} { horas } } }
              { \__nro_a:nn {##1} { evidencias } }
          }
      }
  }
\cs_new_protected:Npn \__nro_periodo_aux:nn #1 #2
  {
    \__nro_data_curta:n {#1}
    \tl_if_blank:nF {#2}
      {
        \str_if_in:nnTF {#2} { andamento }
          { ~ a ~ hoje }
          { \str_if_eq:nnF {#1} {#2} { ~ a ~ \__nro_data_curta:n {#2} } }
      }
  }

%% Quadro 3: os semestres
\bool_new:N \l__nro_col_siex_bool
\bool_new:N \l__nro_col_ic_bool
\cs_new_protected:Npn \nro@montarsemestres
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    \clist_set:Nx \l_tmpa_clist { \__nro_dado:n { pedido/siex } }
    \clist_set:Nx \l_tmpb_clist { \__nro_dado:n { pedido/ic } }
    \seq_map_inline:Nn \g__nro_sem_seq { \__nro_linha_semestre:nnn ##1 }
  }
\cs_new_protected:Npn \__nro_linha_semestre:nnn #1 #2 #3
  {
    \tl_set:Nx \l__nro_tmp_tl { \tl_to_str:n {#1} }
    \clist_if_in:NVTF \l_tmpa_clist \l__nro_tmp_tl
      { \tl_set:Nn \l__nro_tmpb_tl { sim } } { \tl_clear:N \l__nro_tmpb_tl }
    \clist_if_in:NVTF \l_tmpb_clist \l__nro_tmp_tl
      { \tl_set:Nn \l__nro_tmpc_tl { sim } } { \tl_clear:N \l__nro_tmpc_tl }
    \tl_gput_right:Nx \g__nro_linhas_tl
      {
        \exp_not:N \nro@linhasemestre { #1 } { #2 }
          { \str_case:nn {#3} { {conta}{\exp_not:N \nro@semconta} {parcial}{\exp_not:N \nro@semparcial} {antes}{\exp_not:N \nro@semantes} } }
          { \exp_not:V \l__nro_tmpb_tl }
          { \exp_not:V \l__nro_tmpc_tl }
      }
  }
\cs_new_protected:Npn \nro@sesemestres #1 #2 { \seq_if_empty:NTF \g__nro_sem_seq {#2} {#1} }
\cs_new_protected:Npn \nro@secolsiex #1 #2 { \__nro_se_dado:nTF { pedido/siex } {#1} {#2} }
\cs_new_protected:Npn \nro@secolic #1 #2 { \__nro_se_dado:nTF { pedido/ic } {#1} {#2} }
\cs_new:Npn \nro@mesesmin { \__nro_meses_min: }

%% a matriz das competências: uma linha por atividade, uma coluna por competência
\cs_new:Npn \nro@ncompetencias { \seq_count:N \g__nro_comp_seq }
\tl_new:N \g__nro_cabcomp_tl
\tl_new:N \g__nro_totcomp_tl
\cs_new_protected:Npn \nro@montarmatriz
  {
    \tl_gclear:N \g__nro_cabcomp_tl
    \tl_gclear:N \g__nro_totcomp_tl
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_comp_seq
      {
        \tl_gput_right:Nn \g__nro_cabcomp_tl { & \nro@cabc {##1} }
        \int_zero:N \l__nro_tmp_int
        \seq_map_inline:Nn \g__nro_atvs_seq
          {
            \clist_set:Nx \l_tmpa_clist { \__nro_a:nn {####1} { competencias } }
            \clist_if_in:NnT \l_tmpa_clist {##1} { \int_incr:N \l__nro_tmp_int }
          }
        \tl_gput_right:Nx \g__nro_totcomp_tl { & \int_use:N \l__nro_tmp_int }
      }
    \seq_map_inline:Nn \g__nro_atvs_seq
      {
        \clist_set:Nx \l_tmpa_clist { \__nro_a:nn {##1} { competencias } }
        \tl_gput_right:Nx \g__nro_linhas_tl
          { \exp_not:N \nro@celulaatividade { A##1 } { \__nro_a:nn {##1} { titulo } } }
        \seq_map_inline:Nn \g__nro_comp_seq
          {
            \clist_if_in:NnTF \l_tmpa_clist {####1}
              { \tl_gput_right:Nn \g__nro_linhas_tl { & \nro@marcado } }
              { \tl_gput_right:Nn \g__nro_linhas_tl { & } }
          }
        \tl_gput_right:Nn \g__nro_linhas_tl { \\ \nro@fino }
      }
  }
\cs_new:Npn \nro@cabcompetencias { \g__nro_cabcomp_tl }
\cs_new:Npn \nro@totcompetencias { \g__nro_totcomp_tl }
\cs_new_protected:Npn \nro@legendacompetencias
  {
    \seq_map_inline:Nn \g__nro_comp_seq
      { \item [ ##1 ] \__nro_dado:n { comp/##1 } }
  }

%% as disciplinas: cada uma, com as atividades em que aparece
\seq_new:N \l__nro_disc_seq
\prop_new:N \l__nro_disc_prop
\cs_new_protected:Npn \nro@montardisciplinas
  {
    \seq_clear:N \l__nro_disc_seq
    \prop_clear:N \l__nro_disc_prop
    \seq_map_inline:Nn \g__nro_atvs_seq
      {
        \seq_set_split:Nnx \l__nro_tmp_seq { ; } { \__nro_a:nn {##1} { disciplinas } }
        \seq_remove_all:Nn \l__nro_tmp_seq { }
        \seq_map_inline:Nn \l__nro_tmp_seq
          {
            \tl_set:Nn \l__nro_chave_tl {####1}
            \prop_get:NVNTF \l__nro_disc_prop \l__nro_chave_tl \l__nro_tmpb_tl
              { \prop_put:NVx \l__nro_disc_prop \l__nro_chave_tl { \exp_not:V \l__nro_tmpb_tl ,~ A##1 } }
              {
                \prop_put:NVn \l__nro_disc_prop \l__nro_chave_tl { A##1 }
                \seq_put_right:NV \l__nro_disc_seq \l__nro_chave_tl
              }
          }
      }
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \l__nro_disc_seq
      {
        \prop_get:NnN \l__nro_disc_prop {##1} \l__nro_tmpb_tl
        \tl_gput_right:Nx \g__nro_linhas_tl
          { \exp_not:N \nro@linhadisciplina { \exp_not:n {##1} } { \exp_not:V \l__nro_tmpb_tl } }
      }
    \seq_if_empty:NT \l__nro_disc_seq
      { \tl_gset:Nn \g__nro_linhas_tl { \nro@semdisciplinas } }
  }

%% a deliberação do Colegiado: o principal, as alternativas, as atividades à parte
\cs_new_protected:Npn \nro@montarcolegiado
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    \__nro_cred_participacao:VN \g__nro_principal_tl \l__nro_tmp_int
    \tl_gput_right:Nx \g__nro_linhas_tl
      {
        \exp_not:N \nro@linhacolegiado
          { \exp_not:N \__nro_apr_nome:n { \g__nro_principal_tl } }
          { Principal }
          { \exp_not:N \__nro_cred:n { \int_use:N \l__nro_tmp_int } }
      }
    \seq_map_inline:Nn \g__nro_alt_seq
      {
        \__nro_cred_participacao:nN {##1} \l__nro_tmp_int
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhacolegiado { \exp_not:N \__nro_apr_nome:n { \exp_not:n {##1} } }
              { Alternativa } { \exp_not:N \__nro_cred:n { \int_use:N \l__nro_tmp_int } }
          }
      }
    \seq_map_inline:Nn \g__nro_itens_seq
      {
        \prop_get:NnN \g__nro_item_cred_prop {##1} \l__nro_tmp_tl
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhacolegiado { \exp_not:N \__nro_apr_nome:n { \exp_not:n {##1} } }
              { \exp_not:n { À~parte } } { \exp_not:N \__nro_cred:n { \l__nro_tmp_tl } }
          }
      }
  }

%% o quadro de horas da síntese: a participação e cada atividade à parte
\cs_new_protected:Npn \nro@montarquadrohoras
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    \fp_compare:nNnT { \g__nro_part_fp } > { 0 }
      {
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:n { Participação~na~equipe } & \exp_not:V \g__nro_part_atvs_tl
            & \exp_not:N \__nro_horas:n { \fp_use:N \g__nro_part_fp } \exp_not:N \\ \exp_not:N \nro@fino
          }
      }
    \seq_map_inline:Nn \g__nro_itens_seq
      {
        \prop_get:NnN \g__nro_item_horas_prop {##1} \l__nro_tmp_tl
        \prop_get:NnN \g__nro_item_atvs_prop {##1} \l__nro_tmpb_tl
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \__nro_apr_nome:n { \exp_not:n {##1} } \exp_not:n { ~ (à~parte) }
            & \exp_not:V \l__nro_tmpb_tl
            & \exp_not:N \__nro_horas:n { \l__nro_tmp_tl } \exp_not:N \\ \exp_not:N \nro@fino
          }
      }
  }

%% ------------------------------------------------------------
%% 11. OS AFASTAMENTOS, A CONSISTÊNCIA DAS HORAS, A AUTOAVALIAÇÃO
%% ------------------------------------------------------------
\int_new:N \g__nro_meses_afast_int
\bool_new:N \g__nro_afast_bool
\bool_new:N \g__nro_afast_env_bool
\cs_new_protected:Npn \nro@somaafastamento #1 #2
  {
    \bool_gset_true:N \g__nro_afast_bool
    \__nro_meses:nnN {#1} {#2} \l__nro_tmp_int
    \int_gadd:Nn \g__nro_meses_afast_int { \l__nro_tmp_int }
    \iow_now:Nx \@auxout { \token_to_str:N \nro@afast { \tl_to_str:n {#1} } { \tl_to_str:n {#2} } }
  }
\cs_new_protected:Npn \nro@semafastamento { \bool_gset_true:N \g__nro_afast_bool }
\cs_new_protected:Npn \nro@seafastamentos #1 #2 { \bool_if:NTF \g__nro_afast_bool {#1} {#2} }
\cs_new_protected:Npn \nro@abreafastamentos { \bool_gset_true:N \g__nro_afast_env_bool }
\cs_new_protected:Npn \nro@conferirpartes
  {
    \bool_if:NF \g__nro_afast_env_bool
      { \__nro_pend:n { Parte~II:~falta~a~seção~dos~afastamentos~(ambiente~afastamentos) } }
    \bool_if:NF \g__nro_auto_bool
      { \__nro_pend:n { Parte~IV:~falta~a~autoavaliação~(\textbackslash autoavaliacao) } }
  }

%% os meses de vínculo (menos os afastados) e a média semanal das horas pedidas
\int_new:N \g__nro_meses_int
\fp_new:N \g__nro_semanas_fp
\fp_new:N \g__nro_media_fp
\cs_new_protected:Npn \nro@consistencia
  {
    \__nro_totais:
    \__nro_se_egresso:TF
      {
        \__nro_se_dado:nTF { membro/fim }
          { \tl_set:Nx \l__nro_tmpb_tl { \__nro_dado:n { membro/fim } } }
          { \tl_set:Nx \l__nro_tmpb_tl { \__nro_data_doc: } }
      }
      { \tl_set:Nx \l__nro_tmpb_tl { \__nro_data_doc: } }
    \__nro_meses:nnN { \__nro_dado:n { membro/inicio } } { \l__nro_tmpb_tl } \l__nro_tmp_int
    \int_gset:Nn \g__nro_meses_int { \int_max:nn { 0 } { \l__nro_tmp_int - \g__nro_meses_afast_int } }
    \fp_gset:Nn \g__nro_semanas_fp { \g__nro_meses_int * 52.143 / 12 }
    \fp_compare:nNnTF { \g__nro_semanas_fp } > { 0 }
      { \fp_gset:Nn \g__nro_media_fp { \g__nro_total_fp / \g__nro_semanas_fp } }
      { \fp_gzero:N \g__nro_media_fp }
  }
\cs_new:Npn \nro@meses { \int_use:N \g__nro_meses_int }
\cs_new:Npn \nro@mesesafastamento { \int_use:N \g__nro_meses_afast_int }
\cs_new_protected:Npn \nro@semanas { \__nro_escreve_num:n { round ( \g__nro_semanas_fp , 0 ) } }
\cs_new_protected:Npn \nro@media { \__nro_escreve_num:n { \g__nro_media_fp } }
\cs_new:Npn \nro@mediamaxima { \__nro_media_max: }
\cs_new_protected:Npn \nro@semediaalta #1 #2
  { \fp_compare:nNnTF { \g__nro_media_fp } > { \__nro_media_max: } {#1} {#2} }
%% a capacidade declarada: dedicação × semanas
\cs_new_protected:Npn \nro@secapacidadeexcedida #1 #2
  {
    \__nro_numero:n { \__nro_dado:n { membro/dedicacao } }
    \tl_if_empty:NTF \l__nro_num_tl {#2}
      { \fp_compare:nNnTF { \g__nro_total_fp } > { \l__nro_num_tl * \g__nro_semanas_fp } {#1} {#2} }
  }
\cs_new_protected:Npn \nro@capacidade
  {
    \__nro_numero:n { \__nro_dado:n { membro/dedicacao } }
    \tl_if_empty:NTF \l__nro_num_tl { \nro@marca { dedicação } }
      { \__nro_horas:n { round ( \l__nro_num_tl * \g__nro_semanas_fp , 0 ) } }
  }

%% a autoavaliação: \autoavaliacao{criterio = nota de 0 a 10, …}
\prop_new:N \g__nro_auto_prop
\fp_new:N \g__nro_auto_fp
\bool_new:N \g__nro_auto_bool
\NewDocumentCommand \autoavaliacao { +m }
  {
    \bool_gset_true:N \g__nro_auto_bool
    \prop_gclear:N \g__nro_auto_prop
    \__nro_kv_prop:Nn \g__nro_auto_prop {#1}
    \fp_gzero:N \g__nro_auto_fp
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_crit_seq
      {
        \prop_get:NnNF \g__nro_auto_prop {##1} \l__nro_tmp_tl { \tl_clear:N \l__nro_tmp_tl }
        \__nro_numero:n { \l__nro_tmp_tl }
        \tl_if_empty:NTF \l__nro_num_tl
          {
            \__nro_pend:n { Autoavaliação:~falta~a~nota~do~critério~'##1' }
            \tl_gput_right:Nx \g__nro_linhas_tl
              {
                \exp_not:N \nro@linhaauto { \__nro_dado:n { crit/##1/nome } } { \__nro_dado:n { crit/##1/peso } }
                  { \exp_not:N \nro@marca { nota } } { \exp_not:N \nro@vazio }
              }
          }
          {
            \fp_set:Nn \l__nro_tmp_fp { \l__nro_num_tl * ( \__nro_dado:n { crit/##1/peso } ) / 10 }
            \fp_gadd:Nn \g__nro_auto_fp { \l__nro_tmp_fp }
            \tl_gput_right:Nx \g__nro_linhas_tl
              {
                \exp_not:N \nro@linhaauto { \__nro_dado:n { crit/##1/nome } } { \__nro_dado:n { crit/##1/peso } }
                  { \exp_not:N \__nro_escreve_num:n { \l__nro_num_tl } }
                  { \exp_not:N \__nro_escreve_num:n { \fp_use:N \l__nro_tmp_fp } }
              }
          }
      }
    \nro@tabelaautoavaliacao
  }
\cs_new_protected:Npn \nro@totalautoavaliacao { \__nro_escreve_num:n { \g__nro_auto_fp } }
\cs_new_protected:Npn \nro@montarbarema
  {
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_crit_seq
      {
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhabarema { ##1 } { \__nro_dado:n { crit/##1/nome } }
              { \__nro_dado:n { crit/##1/peso } } { \__nro_dado:n { crit/##1/descritor } }
          }
      }
  }
\cs_new:Npn \nro@somapesos
  { \fp_eval:n { 0 \seq_map_function:NN \g__nro_crit_seq \__nro_soma_peso:n } }
\cs_new:Npn \__nro_soma_peso:n #1 { + ( \__nro_dado:n { crit/#1/peso } ) }

%% os treinamentos e os afastamentos que o SOMA conhece (soma.tex)
\tl_new:N \g__nro_soma_trein_tl
\tl_new:N \g__nro_soma_afast_tl
\NewDocumentCommand \treinamentosdosoma { +m } { \tl_gset:Nn \g__nro_soma_trein_tl {#1} }
\NewDocumentCommand \afastamentosdosoma { +m } { \tl_gset:Nn \g__nro_soma_afast_tl {#1} }
\cs_new:Npn \nro@somatreinamentos { \g__nro_soma_trein_tl }
\cs_new:Npn \nro@somaafastamentos { \g__nro_soma_afast_tl }

%% ------------------------------------------------------------
%% 12. O QUE SE CALCULA NO COMEÇO, A MARCA D'ÁGUA E O PDF
%%     Os metadados do PDF dizem ao SOMA o que ele confere ao receber o
%%     arquivo: que é deste template, o código do pedido, se está em
%%     final e sem pendência, e a folha reservada para a aprovação.
%% ------------------------------------------------------------
\tl_new:N \g__nro_marca_tl
\bool_new:N \g__nro_marca_alerta_bool
\tl_new:N \g__nro_nome_tl          % o nome da equipe, expandido (para os marcadores do PDF)
\tl_new:N \g__nro_folha_tl         % a folha reservada à aprovação (do .aux)
\cs_new:Npn \nro@nome { \g__nro_nome_tl }
\bool_new:N \g__nro_logo_bool
\tl_const:Nn \c__nro_logo_tl { nro/imagotipo-preto.png }
\cs_new_protected:Npn \nro@folha #1
  { \bool_if:NF \g__nro_aux_encerrado_bool { \tl_gset:Nn \g__nro_folha_tl {#1} } }
\tl_new:N \g__nro_posaval_tl
\cs_new_protected:Npn \nro@posavaliacao #1 #2
  {
    \bool_if:NF \g__nro_aux_encerrado_bool
      {
        \tl_gset:Nx \g__nro_posaval_tl
          { \fp_eval:n { round ( #1 / 65536 / 72.27 * 25.4 , 1 ) } , \fp_eval:n { round ( #2 / 65536 / 72.27 * 25.4 , 1 ) } }
      }
  }
\AtBeginDocument
  {
    \bool_gset_true:N \g__nro_aux_encerrado_bool
    \tl_gset:Nx \g__nro_nome_tl { \__nro_dado:n { equipe/nome } }
    \file_if_exist:VTF \c__nro_logo_tl
      { \bool_gset_true:N \g__nro_logo_bool }
      { \msg_warning:nnV { nro-aacc } { sem-arquivo } \c__nro_logo_tl }
    %% a marca d'água: exemplo > rascunho > incompleto (final com pendência)
    \bool_if:NTF \g__nro_exemplo_bool
      { \tl_gset:Nn \g__nro_marca_tl { EXEMPLO~FICTÍCIO } }
      {
        \bool_if:NTF \g__nro_final_bool
          {
            \bool_lazy_or:nnT
              { ! \g__nro_aux_lido_bool }
              { \int_compare_p:nNn { \g__nro_pend_ant_int } > { 0 } }
              {
                \tl_gset:Nn \g__nro_marca_tl { INCOMPLETO }
                \bool_gset_true:N \g__nro_marca_alerta_bool
              }
          }
          { \tl_gset:Nn \g__nro_marca_tl { RASCUNHO } }
      }
    \__nro_escolher_competencias:
    %% o enquadramento OUT: a descrição vem do pedido e a norma, de \equipe
    \__nro_se_dado:nT { pedido/outro }
      {
        \prop_get:NnN \g__nro_dados_prop { pedido/outro } \l__nro_tmp_tl
        \prop_gput:NnV \g__nro_dados_prop { apr/OUT/nome } \l__nro_tmp_tl
        \prop_gput:NnV \g__nro_dados_prop { apr/OUT/frase } \l__nro_tmp_tl
        \prop_get:NnN \g__nro_dados_prop { equipe/normacurta } \l__nro_tmp_tl
        \prop_gput:NnV \g__nro_dados_prop { apr/OUT/dispositivo } \l__nro_tmp_tl
      }
    \__nro_semestres:
    \__nro_totais:
    %% os metadados do PDF: cópias expandidas (o \exp_not:n do \prop_item
    %% impediria o hyperref de converter os acentos)
    \tl_set:Nx \l__nro_tmp_tl { \__nro_dado:n { equipe/nome } }
    \tl_replace_all:Nnn \l__nro_tmp_tl { \& } { \c_ampersand_str }
    \tl_set:Nx \l__nro_tmpb_tl { \__nro_dado:n { serie/titulo } }
    \tl_set:Nx \l__nro_chave_tl { \__nro_dado:n { estudante/nome } }
    \hypersetup
      {
        pdftitle = { \l__nro_tmpb_tl \c_space_tl - \c_space_tl \l__nro_chave_tl } ,
        pdfauthor = { \l__nro_chave_tl } ,
        pdfsubject = { \__nro_codigo_documento_exp: \c_space_tl Rev. ~ \__nro_dado:n { serie/revisao } ,~ \l__nro_tmp_tl } ,
        pdfkeywords =
          {
            nro-aacc ; ~ documento = \__nro_codigo_documento_exp: ; ~
            modo = \bool_if:NTF \g__nro_final_bool { final } { rascunho } ; ~
            pendencias = \bool_if:NTF \g__nro_aux_lido_bool { \int_use:N \g__nro_pend_ant_int } { ? } ; ~
            folha = \tl_if_empty:NTF \g__nro_folha_tl { 0 } { \g__nro_folha_tl } ; ~
            principal = \g__nro_principal_tl ; ~
            creditos = \int_eval:n { \g__nro_principal_cred_int + \g__nro_itens_cred_int } ; ~
            principalcreditos = \int_use:N \g__nro_principal_cred_int ; ~
            avaliacao = \tl_if_empty:NTF \g__nro_posaval_tl { 0 } { \g__nro_posaval_tl } ; ~
            itens = \int_use:N \g__nro_itens_cred_int ; ~
            semestres = \int_use:N \g__nro_sem_conta_int ; ~
            exemplo = \bool_if:NTF \g__nro_exemplo_bool { sim } { nao }
          }
      }
    \__nro_conferir_campos:
  }
\cs_new_protected:Npn \nro@desenhamarca
  {
    \tl_if_empty:NF \g__nro_marca_tl
      {
        \put ( 105 , -148.5 )
          {
            \makebox ( 0 , 0 )
              {
                \rotatebox { 52 }
                  {
                    \nro@rotm \fontsize { 56 } { 56 } \selectfont
                    \bool_if:NTF \g__nro_marca_alerta_bool
                      { \color { nro-impulso-claro } } { \color { black!6 } }
                    \tl_use:N \g__nro_marca_tl
                  }
              }
          }
      }
  }

%% o código deste relatório: o da série e o PN
\cs_new:Npn \__nro_codigo_documento_exp:
  {
    \__nro_dado:n { serie/codigo }
    \__nro_se_dado_exp:nTF { documento/pn } { - \__nro_dado:n { documento/pn } } { }
  }
\cs_new:Npn \nro@codigo { \__nro_codigo_documento_exp: }
\cs_new_protected:Npn \nro@datadoc { \__nro_data_extenso:n { \__nro_data_doc: } }
\cs_new_protected:Npn \nro@selogo #1 #2 { \bool_if:NTF \g__nro_logo_bool {#1} {#2} }
\cs_new:Npn \nro@logo { \c__nro_logo_tl }
\cs_new:Npn \nro@dado #1 { \__nro_dado:n {#1} }
\cs_new_protected:Npn \nro@hpc { \__nro_hpc: }
\cs_new_protected:Npn \nro@periodomembro
  {
    \__nro_se_dado:nTF { membro/inicio }
      {
        \__nro_se_egresso:TF
          { de ~ \__nro_data_extenso:n { \__nro_dado:n { membro/inicio } } ~ a ~
            \__nro_se_dado:nTF { membro/fim }
              { \__nro_data_extenso:n { \__nro_dado:n { membro/fim } } }
              { \nro@marca { mês~de~saída } } }
          { desde ~ \__nro_data_extenso:n { \__nro_dado:n { membro/inicio } } }
      }
      { \nro@marca { o~período } }
  }
\cs_new_protected:Npn \nro@periodocurto
  {
    \__nro_se_dado:nTF { membro/inicio }
      {
        \__nro_data_curta:n { \__nro_dado:n { membro/inicio } } ~ a ~
        \__nro_se_egresso:TF
          {
            \__nro_se_dado:nTF { membro/fim }
              { \__nro_data_curta:n { \__nro_dado:n { membro/fim } } }
              { \nro@marca { saída } }
          }
          { \__nro_data_curta:n { \__nro_data_doc: } }
      }
      { \nro@marca { o~período } }
  }
%% o ingresso no curso, por extenso ("2021/1" → "1º semestre de 2021")
\cs_new_protected:Npn \nro@ingresso
  {
    \int_set:Nn \l__nro_tmp_int { \__nro_sem_ingresso: }
    \int_compare:nNnTF { \l__nro_tmp_int } < { 0 }
      { \campo { estudante/ingresso } }
      {
        \int_eval:n { \int_mod:nn { \l__nro_tmp_int } { 2 } + 1 } \textordmasculine \c_space_tl
        semestre ~ de ~ \int_eval:n { \int_div_truncate:nn { \l__nro_tmp_int } { 2 } }
      }
  }

\ExplSyntaxOff
%% ============================================================
%% DAQUI PARA BAIXO, A APRESENTAÇÃO, em LaTeX comum, que é mais fácil
%% de ler e de ajustar. A lógica fica acima, nas funções \nro@….
%% ============================================================

%% ------------------------------------------------------------
%% 13. AS CORES: as do design system (tokens/palette.css). O registro
%%     formal usa o conjunto primário (a família Cortex) com os
%%     neutros; Synapse só como acento mínimo. As pendências são do
%%     rascunho, nunca do documento que segue: Lúmen no rascunho,
%%     Impulso na versão final.
%% ------------------------------------------------------------
\definecolor{nro-tinta}{HTML}{1D1D1F}         % sulco medium: o texto
\definecolor{nro-cinza}{HTML}{616C68}         % sulco light: rótulos, legendas
\definecolor{nro-texto2}{HTML}{4A4F4D}        % o texto secundário
\definecolor{nro-regua}{HTML}{D9DEDC}         % as linhas finas das tabelas
\definecolor{nro-pia}{HTML}{C4CCC9}           % pia medium: as réguas formais
\definecolor{nro-pia-claro}{HTML}{E8EDEB}
\definecolor{nro-medula-claro}{HTML}{F7F4EE}
\definecolor{nro-cortex}{HTML}{00352F}
\definecolor{nro-axon}{HTML}{00594F}
\definecolor{nro-cortex-medio}{HTML}{A9CCC4}
\definecolor{nro-cortex-claro}{HTML}{E3EFEC}
\definecolor{nro-synapse}{HTML}{CEDC00}
\definecolor{nro-lumen-claro}{HTML}{FFF9D6}
\definecolor{nro-lumen-medio}{HTML}{FFEE8A}
\definecolor{nro-lumen-escuro}{HTML}{594A00}
\definecolor{nro-impulso-claro}{HTML}{FFE4E6}
\definecolor{nro-impulso-medio}{HTML}{FFAEB5}
\definecolor{nro-impulso-escuro}{HTML}{6E0A1A}
%% o cabeçalho e o rodapé do NRO-PUB-002 (os cinzas do doc-nro.js)
\definecolor{nro-cab-cinza}{RGB}{96,96,99}
\definecolor{nro-cab-claro}{RGB}{138,138,143}
\definecolor{nro-cab-linha}{RGB}{150,150,155}
%% os nomes da versão 1, para figuras e arquivos antigos
\colorlet{nro-claro}{nro-cinza}
\colorlet{nro-linha}{nro-pia}
\colorlet{nro-fundo}{nro-pia-claro}
\colorlet{nro-fundoclaro}{nro-pia-claro}
\colorlet{nro-mielina}{nro-lumen-medio}
\colorlet{nro-pulso}{nro-impulso-medio}
\colorlet{nro-vital}{nro-cortex-medio}

%% ------------------------------------------------------------
%% 14. AS FONTES E O TEXTO
%%     Títulos: Instrument Serif no design system; aqui, a TeX Gyre
%%     Termes (ou a Times). Texto corrido: Archivo Light no design
%%     system; aqui, a Roboto Light (ou a Helvetica). Rótulos e
%%     códigos: Archivo (ou a Helvetica), nunca fonte de código. O
%%     cabeçalho continua o do NRO-PUB-002, na métrica da Arial.
%%     Texto alinhado à esquerda, nunca justificado.
%% ------------------------------------------------------------
\newif\ifnro@corpoleve
\IfFileExists{t1qtm.fd}{\def\nro@fam@serif{qtm}}{\def\nro@fam@serif{ptm}}
\IfFileExists{T1Roboto-LF.fd}
  {\def\nro@fam@corpo{Roboto-LF}\nro@corpolevetrue}
  {\IfFileExists{t1qhv.fd}{\def\nro@fam@corpo{qhv}}{\def\nro@fam@corpo{phv}}}
\IfFileExists{T1ArchivZero-TLF.fd}
  {\def\nro@fam@rotulo{ArchivZero-TLF}\def\nro@ser@rot{m}\def\nro@ser@rotm{medium}\def\nro@ser@rotf{sb}}
  {\let\nro@fam@rotulo\nro@fam@corpo\def\nro@ser@rot{m}\def\nro@ser@rotm{m}\def\nro@ser@rotf{b}%
   \ifnro@corpoleve\IfFileExists{t1qhv.fd}{\def\nro@fam@rotulo{qhv}}{\def\nro@fam@rotulo{phv}}\fi}
\IfFileExists{t1qhv.fd}{\def\nro@fam@cab{qhv}}{\def\nro@fam@cab{phv}}
\renewcommand\sfdefault{\nro@fam@corpo}
\renewcommand\familydefault{\sfdefault}
\ifnro@corpoleve
  \DeclareFontSeriesDefault[sf]{md}{l}
  \DeclareFontSeriesDefault[sf]{bf}{medium}
  \renewcommand\seriesdefault{l}
\fi
%% as famílias, para quem desenha
\newcommand\nro@serif{\fontfamily{\nro@fam@serif}\fontseries{m}\fontshape{n}\selectfont}
\newcommand\nro@rot{\fontfamily{\nro@fam@rotulo}\fontseries{\nro@ser@rot}\fontshape{n}\selectfont}
\newcommand\nro@rotm{\fontfamily{\nro@fam@rotulo}\fontseries{\nro@ser@rotm}\fontshape{n}\selectfont}
\newcommand\nro@rotf{\fontfamily{\nro@fam@rotulo}\fontseries{\nro@ser@rotf}\fontshape{n}\selectfont}
\newcommand\nro@fcab{\fontfamily{\nro@fam@cab}\fontseries{m}\fontshape{n}\selectfont}
\newcommand\nro@fcabn{\fontfamily{\nro@fam@cab}\fontseries{b}\fontshape{n}\selectfont}
%% o tamanho, com 1,2 de entrelinha
\newcommand\nro@corpo[1]{\fontsize{#1}{\dimexpr#1pt*6/5\relax}\selectfont}
%% o corpo do texto: 10,5 pt (a escala de impressão do design system)
\renewcommand\normalsize{%
  \@setfontsize\normalsize{10.5}{15.2}%
  \abovedisplayskip 9pt plus 3pt minus 4pt
  \abovedisplayshortskip 2pt plus 3pt
  \belowdisplayshortskip 6pt plus 3pt minus 3pt
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\renewcommand\small{\@setfontsize\small{9.5}{13.2}}
\renewcommand\footnotesize{\@setfontsize\footnotesize{8.5}{11.4}}
%% um código (NRO-PES-020-7, CERT-…, E3): Archivo, e nunca quebra
\DeclareRobustCommand\cod[1]{\mbox{\nro@rot #1}}
\linespread{1}
\setlength\parindent{0pt}
\setlength\parskip{6pt plus 2pt minus 1pt}
\setlength\emergencystretch{2em}
\AtBeginDocument{\color{nro-tinta}\RaggedRight}
\setlength\RaggedRightParindent{0pt}
\setlist{itemsep=2pt, topsep=3pt, parsep=1pt, leftmargin=6mm}
\setlist[itemize]{label={\textcolor{nro-cinza}{\textbullet}}}
\setlist[enumerate]{label={\nro@rotm\arabic*.}}
\setlength\arrayrulewidth{0.35pt}
\arrayrulecolor{nro-tinta}
\setlength\tabcolsep{1.8mm}
\renewcommand\arraystretch{1.35}
\sisetup{output-decimal-marker={,}, group-separator={.}, group-minimum-digits=4, per-mode=symbol, mode=match}
\DeclareCaptionFont{nrocinza}{\color{nro-texto2}}
\DeclareCaptionFont{nrorotulo}{\nro@rotm\color{nro-tinta}}
\DeclareCaptionLabelSeparator{nrovirgula}{, }
\captionsetup{font={small,nrocinza}, labelfont=nrorotulo, labelsep=nrovirgula,
  justification=RaggedRight, singlelinecheck=false, skip=5pt}
\hypersetup{colorlinks=true, linkcolor=nro-tinta, urlcolor=nro-axon, citecolor=nro-axon,
  filecolor=nro-axon, bookmarksnumbered=true, pdfcreator={nro-aacc.cls - NeuroDynamics}}
\urlstyle{same}
\pdfstringdefDisableCommands{\def\&{\string&}\def\cod#1{#1}\def\textordmasculine{º}}
%% as listagens de código: a única fonte monoespaçada do relatório, e só
%% para código de verdade
\lstset{basicstyle=\ttfamily\small, columns=fullflexible, keepspaces=true, frame=tb,
  rulecolor=\color{nro-pia}, framerule=0.4pt, numbers=left,
  numberstyle=\tiny\color{nro-cinza}, numbersep=6pt, breaklines=true, captionpos=t,
  xleftmargin=5mm, framexleftmargin=5mm, aboveskip=8pt, belowskip=8pt,
  keywordstyle=\bfseries, commentstyle=\color{nro-cinza}\itshape,
  stringstyle=\color{nro-axon}, showstringspaces=false, extendedchars=true,
  literate=
    {á}{{\'a}}1 {à}{{\`a}}1 {ã}{{\~a}}1 {â}{{\^a}}1 {é}{{\'e}}1 {ê}{{\^e}}1
    {í}{{\'i}}1 {ó}{{\'o}}1 {ô}{{\^o}}1 {õ}{{\~o}}1 {ú}{{\'u}}1 {ç}{{\c{c}}}1
    {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1 {Ç}{{\c{C}}}1
    {Ã}{{\~A}}1 {Õ}{{\~O}}1 {º}{{\textordmasculine}}1 {ª}{{\textordfeminine}}1
    {°}{{\textdegree}}1 {µ}{{\textmu}}1 {Ω}{{$\Omega$}}1}
\renewcommand\lstlistingname{Listagem}

%% ------------------------------------------------------------
%% 15. A FOLHA: o cabeçalho e o rodapé do NRO-PUB-002, desenhados em
%%     posição fixa em toda folha (inclusive nas dos anexos). As medidas
%%     são as do doc-nro.js: a logo a 10,2 mm do topo, com 8,6 mm de
%%     altura; o emissor, o título e o código alinhados à direita, a
%%     12,6, 16,8 e 21 mm; a linha do rodapé a 10,5 mm da borda de baixo.
%%     A capa é a exceção: tem o desenho do relatório formal do design
%%     system (a logo e, à direita, o tipo do documento e o código).
%% ------------------------------------------------------------
\pagestyle{empty}
\let\ps@plain\ps@empty
\newif\ifnro@nacapa
\newif\ifnro@semnota
\newcommand\nro@notarodape{%
  Registro destinado à análise do aproveitamento de AACC pelo Colegiado do curso. Contém dados
  pessoais de \nro@dado{estudante/nome} e informações da \nro@nrocurto; não deve ser divulgado para outros fins.}
\AddToHook{shipout/background}{%
  \setlength\unitlength{1mm}%
  \normalfont\color{nro-tinta}%
  \nro@desenhamarca
  \ifnro@nacapa
    % a capa: o cabeçalho do relatório formal, a 22 mm das bordas
    \nro@selogo
      {\put(22,-27.8){\includegraphics[height=5.8mm]{\nro@logo}}}%
      {\put(22,-26.5){\nro@fcabn\nro@corpo{11}NeuroDynamics}}%
    \put(188,-23.4){\llap{\nro@rot\nro@corpo{9}\color{nro-cinza}\nro@dado{serie/titulo}}}%
    \put(188,-27.6){\llap{\nro@rot\nro@corpo{9}\color{nro-cinza}\nro@codigo\ Rev.~\nro@dado{serie/revisao}}}%
    \global\nro@nacapafalse
  \else
    % o cabeçalho do NRO-PUB-002
    \nro@selogo
      {\put(15,-18.8){\includegraphics[height=8.6mm]{\nro@logo}}}%
      {\put(15,-16.5){\nro@fcabn\nro@corpo{12.5}NeuroDynamics}}%
    \put(197.5,-12.6){\llap{\nro@fcabn\nro@corpo{9.5}\nro@dado{serie/emissor}}}%
    \put(197.5,-16.8){\llap{\nro@fcab\nro@corpo{9.5}\nro@dado{serie/titulo}}}%
    \put(197.5,-21){\llap{\nro@fcab\nro@corpo{9.5}\nro@codigo\ Rev.~\nro@dado{serie/revisao}}}%
    % o rodapé: a nota (fora da folha reservada), a linha, o código e a página
    \ifnro@semnota\global\nro@semnotafalse\else
    \put(105,-283.4){\makebox(0,0)[b]{\parbox[b]{172mm}{\centering
      \nro@fcab\nro@corpo{7.2}\itshape\color{nro-cab-cinza}\nro@notarodape}}}\fi
    \put(15,-286.6){{\color{nro-cab-linha}\rule{182.5mm}{0.2mm}}}%
    \put(15,-290){\nro@fcab\nro@corpo{7.2}\color{nro-cab-claro}\nro@codigo\ Rev.~\nro@dado{serie/revisao}%
      \secampo{estudante/nome}{, \nro@dado{estudante/nome}}{}}%
    \put(197.5,-290){\llap{\nro@fcab\nro@corpo{7.2}\color{nro-cab-claro}Página \thepage\ de \pageref*{LastPage}}}%
  \fi
}

%% ------------------------------------------------------------
%% 16. OS TÍTULOS: o kicker do registro formal (a régua fina, o rótulo
%%     e o numeral em itálico) abre cada parte e cada atividade; os
%%     títulos são serifados, nunca em negrito.
%% ------------------------------------------------------------
%% \nro@kicker{rótulo}{índice}
\newcommand\nro@kicker[2]{%
  \par\noindent{\color{nro-cortex}\rule{\linewidth}{0.5pt}}\par\nointerlineskip\vspace{2.4mm}%
  \noindent{\nro@rotm\nro@corpo{9}\color{nro-cortex}#1}\hfill
  {\nro@serif\itshape\nro@corpo{13}\color{nro-cortex}#2}\par}
\titleformat{\section}{\nro@serif\fontsize{18}{21.5}\selectfont\color{nro-tinta}\RaggedRight}
  {\nro@rotm\nro@corpo{9}\color{nro-cortex}\thesection}{3mm}{}
\titlespacing*{\section}{0pt}{18pt plus 4pt minus 2pt}{6pt plus 2pt}
\titleformat{\subsection}{\nro@serif\fontsize{13.5}{16.5}\selectfont\color{nro-tinta}\RaggedRight}
  {\nro@rotm\nro@corpo{8.5}\color{nro-cortex}\thesubsection}{2.5mm}{}
\titlespacing*{\subsection}{0pt}{12pt plus 3pt minus 1pt}{4pt plus 1pt}
\titleformat{\subsubsection}{\nro@rotm\nro@corpo{10}\color{nro-tinta}\RaggedRight}
  {\thesubsubsection}{2mm}{}
\titlespacing*{\subsubsection}{0pt}{9pt plus 2pt}{2pt}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{1}

%% o rótulo formal: Archivo, caixa de frase, cinza (nunca caixa alta em fonte de código)
\newcommand\nro@rotulo[1]{{\nro@rot\nro@corpo{8}\color{nro-cinza}#1}}
%% o nome da equipe: na primeira menção, o completo com o significado
%% ("NeuroDynamics PD&I (Pesquisa, Desenvolvimento e Inovação)"); depois,
%% o curto. \NRO* é sempre o curto (títulos, sumário). Nunca quebra.
\newif\ifnro@nrocitado
\newcommand\nro@nrocurto{\mbox{\secampo{equipe/nomecurto}{\nro@dado{equipe/nomecurto}}{\nro@nome}}}
\DeclareRobustCommand\NRO{\@ifstar{\nro@nrocurto}{\ifnro@nrocitado\nro@nrocurto\else
  \global\nro@nrocitadotrue\mbox{\nro@nome}\secampo{equipe/significado}{ (\nro@dado{equipe/significado})}{}\fi}}
%% a norma, curta (também no sumário e nos marcadores do PDF)
\newcommand\normacurta{\nro@dado{equipe/normacurta}}
\newcommand\rotulo[1]{\nro@rotulo{#1}}
\newcommand\nro@vazio{\textcolor{nro-pia}{\rule[0.6ex]{3mm}{0.4pt}}}

\newcounter{parte}
\renewcommand\thepart{\Roman{parte}}
%% \parte[apresentação]{Título}: folha nova, o kicker "Parte III" e o título
\NewDocumentCommand\parte{o m}{%
  \clearpage
  \refstepcounter{parte}%
  \phantomsection
  \addcontentsline{toc}{part}{\protect\numberline{\Roman{parte}}#2}%
  \nro@definircontexto{Parte \Roman{parte}}%
  \nro@kicker{Parte \Roman{parte}}{\romannumeral\c@parte}%
  \vspace{6mm}%
  {\nro@serif\fontsize{28}{31.5}\selectfont\color{nro-tinta}\RaggedRight\hyphenpenalty=10000 #2\par}%
  \IfValueT{#1}{\vspace{4mm}{\nro@corpo{11}\linespread{1.25}\selectfont\color{nro-texto2}#1\par}}%
  \vspace{7mm}}
\titlecontents{part}[10mm]{\addvspace{9pt}\nro@serif\nro@corpo{12.5}}
  {\contentslabel[\nro@rotm\nro@corpo{9}\color{nro-cortex}\thecontentslabel]{10mm}}{}
  {\hfill\nro@rot\nro@corpo{9}\contentspage}[\addvspace{2pt}]
\titlecontents{section}[10mm]{\nro@corpo{9.6}}
  {\contentslabel[\nro@rot\nro@corpo{8.6}\color{nro-cinza}\thecontentslabel]{10mm}}{}
  {\titlerule*[0.7pc]{\textcolor{nro-pia}{.}}\nro@rot\nro@corpo{8.6}\contentspage}
%% o sumário
\newcommand\sumario{%
  \clearpage
  \nro@kicker{Sumário}{}%
  \vspace{6mm}{\nro@serif\fontsize{28}{31.5}\selectfont O que este relatório contém\par}\vspace{6mm}%
  {\setlength\parskip{1.5pt}\@starttoc{toc}}\clearpage}

%% ------------------------------------------------------------
%% 17. AS CAIXAS
%% ------------------------------------------------------------
\tcbset{nro/base/.style={enhanced, breakable, frame hidden, boxrule=0pt, arc=1.6mm,
  left=3.2mm, right=3.2mm, top=2.4mm, bottom=2.4mm, fontupper=\nro@corpo{9.5},
  before skip=6pt, after skip=8pt}}
%% o que preencher: Lúmen no rascunho, Impulso na versão final
\newtcolorbox{nro@caixapreencher}{nro/base,
  colback=\sefinal{nro-impulso-claro}{nro-lumen-claro},
  coltext=\sefinal{nro-impulso-escuro}{nro-lumen-escuro}, fontupper=\nro@corpo{9.3}}
\newcommand\nro@tagpreencher{{\nro@rotf\nro@corpo{8.4}\sefinal{Pendente}{Preencher}}\quad}
%% \preencher[rótulo curto]{o que escrever aqui}: some quando você escreve
\NewDocumentCommand\preencher{o +m}{%
  \par
  \begin{nro@caixapreencher}%
    \nro@pendencia{\IfValueTF{#1}{#1}{\nro@contexto}}%
    \nro@tagpreencher #2%
  \end{nro@caixapreencher}}
%% a marca, no meio do texto, do dado que falta
\newcommand\nro@marca[1]{%
  \begingroup\setlength\fboxsep{0.9pt}%
  \colorbox{\sefinal{nro-impulso-claro}{nro-lumen-claro}}{%
    \nro@rot\nro@corpo{8.4}\strut\color{\sefinal{nro-impulso-escuro}{nro-lumen-escuro}}[#1]}%
  \endgroup}
%% o que falta numa atividade (uma seção, a evidência, a figura)
\newcommand\nro@caixafalta[1]{%
  \begin{nro@caixapreencher}%
    {\nro@rotf\nro@corpo{8.4}Falta}\quad #1%
  \end{nro@caixapreencher}}
%% o roteiro do tipo (só no rascunho): o rótulo serifado em itálico
\newtcolorbox{nro@caixaroteiro}[1]{nro/base, colback=nro-pia-claro, coltext=nro-tinta,
  title={#1}, coltitle=nro-cortex, colbacktitle=nro-pia-claro, titlerule=0pt,
  fonttitle=\nro@serif\itshape\nro@corpo{11.5}, toptitle=1.2mm, bottomtitle=0mm, fontupper=\nro@corpo{9}}
%% uma nota neutra, e um alerta
\newtcolorbox{nota}[1][]{nro/base, colback=nro-pia-claro, coltext=nro-tinta, fontupper=\nro@corpo{9.5}, #1}
\newtcolorbox{nro@alerta}{nro/base, colback=nro-lumen-claro, coltext=nro-lumen-escuro,
  fontupper=\nro@corpo{9.5}}
%% a instrução curta, embaixo de um título (só no rascunho)
\newcommand\nro@instrucao[1]{\sefinal{}{{\nro@corpo{8.9}\itshape\color{nro-cinza}#1\par}}}
\newcommand\instrucao[1]{\nro@instrucao{#1}}

%% a figura provisória: o placeholder técnico, que é pendência
\NewDocumentCommand\figuraprovisoria{O{55mm} m}{%
  \nro@pendencia{\nro@contexto: figura provisória}%
  \begin{tikzpicture}
    \fill[nro-pia-claro] (0,0) rectangle (0.82\linewidth,#1);
    \draw[nro-pia, line width=0.2pt, step=4mm] (0,0) grid (0.82\linewidth,#1);
    \draw[\sefinal{nro-impulso-medio}{nro-lumen-medio}, line width=0.8pt] (0,0) rectangle (0.82\linewidth,#1);
    \node[font=\nro@serif\itshape\nro@corpo{15}, text=nro-cinza] at (0.41\linewidth,0.5*#1+5mm) {Figura provisória};
    \node[text width=0.7\linewidth, align=center, font=\nro@corpo{9}, text=nro-cinza]
      at (0.41\linewidth,0.5*#1-4mm) {#2};
  \end{tikzpicture}}
%% a fonte da figura ou da tabela (ABNT)
\newcommand\fonte[1]{\par\vspace{-2pt}{\RaggedRight\nro@corpo{8.5}\color{nro-cinza}Fonte: #1\par}}

%% ------------------------------------------------------------
%% 18. AS TABELAS: o DataTable do design system. Régua de cima e de
%%     baixo na cor do texto, régua fina sob o cabeçalho, linhas finas
%%     claras entre as linhas, sem colunas riscadas e sem zebra.
%% ------------------------------------------------------------
\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcommand\nro@topo{\specialrule{0.7pt}{0pt}{0pt}}
\newcommand\nro@meio{\specialrule{0.4pt}{0pt}{0pt}}
\newcommand\nro@fino{\arrayrulecolor{nro-regua}\specialrule{0.35pt}{0pt}{0pt}\arrayrulecolor{nro-tinta}}
%% a régua de baixo, por cima da última linha fina
\newcommand\nro@base{\specialrule{0.7pt}{-0.35pt}{0pt}}
%% o cabeçalho de uma coluna; e o de uma coluna estreita, centrado
\newcommand\nro@cab[1]{\leavevmode{\nro@rotm\nro@corpo{8}\color{nro-cinza}\hyphenpenalty=10000 #1}}
\newcommand\nro@cabc[1]{\multicolumn{1}{c}{\nro@cab{#1}}}
%% os mesmos, para os arquivos da equipe e as tabelas do membro:
%%   \begin{tabularx}{\linewidth}{@{}L{40mm}Y@{}}\reguatopo
%%     \cab{Coluna} & \cab{Outra} \\ \reguameio
%%     linha & linha \\ \reguafina
%%     linha & linha \\ \reguabase
%%   \end{tabularx}
\newcommand\reguatopo{\nro@topo}
\newcommand\reguameio{\nro@meio}
\newcommand\reguafina{\nro@fino}
\newcommand\reguabase{\nro@base}
\newcommand\cab[1]{\nro@cab{#1}}
%% a célula de rótulo das fichas (começa o parágrafo antes da cor, para
%% a linha de cima da célula alinhar com a do valor)
\newcommand\nro@celrot{\leavevmode\nro@rot\nro@corpo{8}\color{nro-cinza}}
%% a ficha: rótulo | valor, um por linha
\newcommand\nro@fichatab[2][38mm]{%
  \par\begingroup\nro@corpo{9.3}\renewcommand\arraystretch{1.5}%
  \noindent\begin{tabularx}{\linewidth}{@{}>{\nro@celrot}p{#1}Y@{}}\nro@topo
    #2
  \end{tabularx}\par\endgroup}
\newcommand\nro@par[2]{#1 & #2 \\ \nro@fino}
\newcommand\nro@fimficha{\nro@base}
%% a ficha técnica (as linhas vêm prontas da lógica)
\newcommand\nro@linhaficha[2]{#1 & #2 \\ \nro@fino}
\newcommand\nro@tabelaficha[1]{%
  \par\vspace{1mm}{\nro@serif\itshape\nro@corpo{11.5}\color{nro-cortex}Ficha técnica}\par\vspace{0.6mm}%
  \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.45}%
  \noindent\begin{tabularx}{\linewidth}{@{}>{\nro@celrot}p{40mm}Y@{}}\nro@topo
    #1\nro@base
  \end{tabularx}\endgroup\par\vspace{1mm}}

%% ------------------------------------------------------------
%% 19. A ATIVIDADE, NA FOLHA
%% ------------------------------------------------------------
\newlength\nro@larga
\newlength\nro@largb
\newlength\nro@largtoda
\newcommand\nro@abreatividade{%
  \par\Needspace{0.35\textheight}%
  \refstepcounter{atividade}%
  \label{nro:atv:\arabic{atividade}}%
  \nro@tocatividade
  \nro@definircontexto{\theatividade}%
  \vspace{7mm}%
  \nro@kicker{Atividade \arabic{atividade}\nro@seatvdado{tipo}{, \nro@atvtiponome}{}}{\theatividade}%
  \vspace{3.5mm}%
  {\nro@serif\fontsize{19}{22.5}\selectfont\color{nro-tinta}\RaggedRight\nro@atvtitulo\par}\vspace{3mm}%
  % a ficha da atividade: dois pares por linha em cima, uma linha inteira embaixo
  \setlength\nro@larga{\dimexpr(\linewidth-52mm-6\tabcolsep)*54/100\relax}%
  \setlength\nro@largb{\dimexpr\linewidth-52mm-6\tabcolsep-\nro@larga\relax}%
  \setlength\nro@largtoda{\dimexpr\nro@larga+\nro@largb+26mm+4\tabcolsep\relax}%
  \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.45}%
  \noindent\begin{tabular}{@{}>{\nro@celrot}p{26mm}>{\RaggedRight\arraybackslash}p{\nro@larga}>{\nro@celrot}p{26mm}>{\RaggedRight\arraybackslash}p{\nro@largb}@{}}\nro@topo
    Projeto & \nro@seatvdado{projeto}{\nro@atvdado{projeto}}{\nro@marca{o projeto}} &
    Período & \nro@atvperiodo \\ \nro@fino
    Papel & \nro@seatvdado{papel}{\nro@atvdado{papel}}{\nro@marca{o papel}} &
    Horas dedicadas & \nro@atvhoras \\ \nro@fino
    Aproveitamento & \multicolumn{3}{>{\RaggedRight\arraybackslash}p{\nro@largtoda}@{}}{\nro@atvaproveitamento} \\ \nro@fino
    Quem confirma & \multicolumn{3}{>{\RaggedRight\arraybackslash}p{\nro@largtoda}@{}}{%
      \nro@seatvdado{supervisor}{\nro@atvdado{supervisor}}{\nro@marca{quem confirma}}} \\ \nro@fino
    Registros & \multicolumn{3}{>{\RaggedRight\arraybackslash}p{\nro@largtoda}@{}}{\nro@atvregistros} \\ \nro@fino
    Competências & \multicolumn{3}{>{\RaggedRight\arraybackslash}p{\nro@largtoda}@{}}{\nro@atvcompetencias} \\ \nro@fino
    Disciplinas & \multicolumn{3}{>{\RaggedRight\arraybackslash}p{\nro@largtoda}@{}}{\nro@atvdisciplinas} \\ \nro@base
  \end{tabular}\par\endgroup
  \vspace{1.5mm}%
  % o roteiro do tipo, no rascunho
  \sefinal{}{\nro@roteiro}}
\ExplSyntaxOn
\cs_new_protected:Npn \nro@roteiro
  {
    \__nro_se_dado:nT { tipo/\l__nro_atv_tipo_tl/roteiro }
      {
        \begin{nro@caixaroteiro} { Roteiro~do~tipo~\__nro_tipo_nome:n { \l__nro_atv_tipo_tl }:~o~que~quem~avalia~procura }
          \begin{itemize} [ leftmargin = 4.5mm , itemsep = 0.5pt , topsep = 1pt ]
            \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/roteiro }
          \end{itemize}
        \end{nro@caixaroteiro}
      }
  }
\ExplSyntaxOff
\newcommand\nro@fechaatividade{\par\vspace{2mm}}

%% as seções da atividade: "A3.2  Minha contribuição"
\newcommand\nro@titulosecao[2]{%
  \par\Needspace{5\baselineskip}\vspace{4mm}%
  \refstepcounter{secaoatv}%
  \belowpdfbookmark{\theatividade.\arabic{secaoatv} #2}{nro-\theatividade-\arabic{secaoatv}}%
  \nro@definircontexto{\theatividade, #2}%
  {\noindent{\nro@rotm\nro@corpo{8.6}\color{nro-cortex}\theatividade.\arabic{secaoatv}}\hspace{2.5mm}%
   {\nro@serif\nro@corpo{13.5}\color{nro-tinta}#2}\par}%
  \vspace{0.6mm}%
  \nro@instrucao{#1}}
\newcommand\nro@novasecao[3]{% ambiente, título, instrução
  \NewDocumentEnvironment{#1}{}{%
    \nro@exigiratividade{#1}\nro@secao{#1}\nro@titulosecao{#3}{#2}}{\par}}
\nro@novasecao{contexto}{Contexto e problema}
  {Em que projeto isto aconteceu, que problema havia para resolver e por que ele importava. Quem não conhece a equipe precisa entender.}
\nro@novasecao{contribuicao}{Minha contribuição}
  {Na primeira pessoa: o que você fez, decidiu e entregou, separado do que a equipe fez. Nomeie quem trabalhou com você.}
\nro@novasecao{desenvolvimento}{Desenvolvimento técnico}
  {Como foi feito: o método, as ferramentas, os cálculos, as decisões e os porquês, com figuras. É aqui que o nível técnico aparece.}
\nro@novasecao{resultados}{Resultados}
  {O que saiu, com números, unidades e comparação com o que se esperava. O que funcionou e o que não funcionou.}
\nro@novasecao{aprendizados}{Aprendizados e relação com o curso}
  {O que você aprendeu que a sala de aula não deu, o que ela deu e você aplicou, e o que faria diferente.}
%% as evidências: a seção e a tabela
\NewDocumentEnvironment{evidencias}{}{%
  \nro@exigiratividade{evidencias}\nro@secao{evidencias}%
  \nro@titulosecao{Uma linha por evidência: o tipo, o identificador, o que mostra e onde conferir. Sem registro no SOMA (atividade anterior a ele, ou registro sem acesso), use o arquivo do projeto, o repositório, fotos datadas, e-mails ou a confirmação do supervisor, e anexe o que puder em anexos/.}{Evidências}%
  \nro@abreevidencias\ignorespaces}{\nro@fechaevidencias\par}
\newcommand\nro@linhaevidencia[5]{%
  \cod{#1} & #2 & {\nro@rot\nro@corpo{8}#3} & #4 & #5 \\ \nro@fino}
\newcommand\nro@tabelaevidencias[1]{%
  \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.45}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{@{}L{8mm}L{24mm}L{38mm}YL{36mm}@{}}\nro@topo
    \nro@cab{ID} & \nro@cab{Tipo} & \nro@cab{Identificador} & \nro@cab{O que mostra} & \nro@cab{Onde conferir} \\ \nro@meio
    \endhead
    #1\nro@base
  \end{xltabular}\endgroup}

%% ------------------------------------------------------------
%% 20. A CAPA, A FOLHA DE APROVAÇÃO, O REQUERIMENTO, OS QUADROS DO
%%     PEDIDO E AS PENDÊNCIAS
%% ------------------------------------------------------------
%% a célula da grade da capa: o rótulo e o valor
\newcommand\nro@capacel[2]{%
  \begin{minipage}[t]{50mm}\RaggedRight
    {\nro@rot\nro@corpo{9}\color{nro-cinza}#1}\par\vspace{1.4mm}%
    {\nro@rotf\nro@corpo{9}\color{nro-tinta}#2}\par
  \end{minipage}}
\newcommand\capa{%
  \global\nro@nacapatrue
  \thispagestyle{empty}%
  \nro@definircontexto{Capa}%
  \null\vfill
  \noindent\hspace*{7mm}\begin{minipage}[b]{166mm}\RaggedRight
    {\color{nro-cortex}\rule{15mm}{0.8mm}}\par\vspace{6mm}%
    {\nro@rot\nro@corpo{10}\color{nro-cinza}Aproveitamento de atividades acadêmicas curriculares
      complementares\par}\vspace{5mm}%
    {\nro@serif\fontsize{40}{43}\selectfont\color{nro-tinta}Relatório de atividades\par}%
    \vspace{3mm}%
    {\nro@serif\fontsize{24}{28}\selectfont\color{nro-cinza}\hyphenpenalty=10000\exhyphenpenalty=10000
      \campo{estudante/nome}\par}%
    \vspace{4mm}%
    {\nro@corpo{11}\color{nro-texto2}\nro@nrocurto, \nro@periodomembro\par}%
    \vspace{22mm}%
    {\color{nro-tinta}\rule{\linewidth}{0.4pt}}\par\vspace{4mm}%
    \nro@capacel{Curso}{\campo{estudante/curso}}\hfill
    \nro@capacel{Matrícula}{\campo{estudante/matricula}}\hfill
    \nro@capacel{Data}{\nro@datadoc}\par\vspace{5mm}%
    \nro@capacel{Pedido}{\nro@seprincipal
      {\nro@seprincipalcolegiado
        {\nro@principalnome, créditos a definir}%
        {\nro@setematividades{\nro@totalcreditos\ (\nro@principalchave\nro@seitens{ e à parte}{})}%
          {\nro@seauxlido{\nro@marca{nenhuma atividade}}{na próxima compilação}}}}%
      {\nro@marca{o enquadramento}}}\hfill
    \nro@capacel{Situação}{\nro@situacaocurta}\hfill
    \nro@capacel{Avaliação da equipe}{\nro@marcaposicao Pendente}\par
    \seexemplo{\vspace{6mm}{\nro@corpo{8.6}\itshape\color{nro-cinza}Exemplo fictício: a pessoa, os
      códigos, os números e os dados são inventados e não correspondem a ninguém nem a registro
      algum do SOMA.\par}}{}%
  \end{minipage}\par
  \vspace*{4mm}%
  \clearpage
  \nro@folhaaprovacao}
%% a situação, na grade da capa
\newcommand\nro@situacaocurta{%
  \nro@seauxlido
    {\nro@setempendencias
      {\textcolor{nro-impulso-escuro}{\nro@pendanteriores\ pendência(s)\sefinal{, não encaminhe}{}}}%
      {\textcolor{nro-cortex}{\sefinal{Sem pendências}{Rascunho sem pendências}}}}%
    {\textcolor{nro-cinza}{na próxima compilação}}}
%% onde fica, na capa, o "Pendente" da avaliação da equipe: o SOMA escreve
%% por cima dele, no PDF final, a data da aprovação. A posição vai para o
%% .aux e, na compilação seguinte, para as palavras-chave do PDF.
\newcommand\nro@marcaposicao{%
  \leavevmode% na linha do "Pendente", não antes dela
  \ifdefined\pdfsavepos\pdfsavepos
    \write\@auxout{\string\nro@posavaliacao{\the\pdflastxpos}{\the\pdflastypos}}\fi}

%% a folha reservada: o SOMA a troca pela folha de aprovação
\newcommand\nro@folhaaprovacao{%
  \nro@definircontexto{Folha de aprovação}%
  \protected@write\@auxout{}{\string\nro@folha{\thepage}}%
  \label{nro:folhasoma}%
  \global\nro@semnotatrue
  \nro@kicker{Folha de aprovação}{}%
  \vspace{8mm}%
  \noindent{\setlength\fboxsep{0pt}\colorbox{nro-medula-claro}{\begin{minipage}[c][190mm][c]{\linewidth}
    \centering{\nro@serif\itshape\nro@corpo{14}\color{nro-cinza}Documento não submetido à avaliação da equipe.\par}
  \end{minipage}}}\par
  \clearpage}

%% a assinatura do registro formal: a régua, o nome serifado e o que a pessoa é
\newcommand\nro@assinatura[2]{%
  \par\noindent
  \begin{minipage}[t]{80mm}\RaggedRight
    \textcolor{nro-tinta}{\rule{58mm}{0.4pt}}\par\vspace{2.2mm}
    {\nro@serif\nro@corpo{15}#1\par}\vspace{0.6mm}
    {\nro@corpo{9}\color{nro-texto2}#2\par}
  \end{minipage}\par}

%% o requerimento ao Colegiado
\newcommand\requerimento{%
  \nro@kicker{Requerimento}{}%
  \vspace{6mm}%
  {\nro@serif\fontsize{20}{24}\selectfont Ao \campo{estudante/colegiado}\par}\vspace{1.5mm}%
  {\nro@corpo{10}\color{nro-texto2}Universidade Federal de Minas Gerais\par}\vspace{7mm}%
  Eu, \textbf{\campo{estudante/nome}}, estudante do curso de \campo{estudante/curso}, matrícula
  n\textordmasculine~\campo{estudante/matricula}, com ingresso no \nro@ingresso, integrante da
  \NRO{} \nro@periodomembro, requeiro, nos termos da \nro@dado{equipe/norma}, o
  aproveitamento de
  \nro@seprincipalcolegiado
  {atividades acadêmicas curriculares complementares, conforme o Quadro~1:
  \begin{itemize}[leftmargin=6mm, itemsep=2pt]
    \item a participação na equipe como \nro@principalfrase\ (\nro@principaldisp), por
      \nro@principalbase, com os créditos que a norma do Colegiado atribuir\nro@seitens{;}{.}
    \nro@itensrequerimento
  \end{itemize}}
  {\nro@setematividades{\textbf{\nro@totalcreditos} em atividades acadêmicas curriculares
  complementares, assim discriminados no Quadro~1:}{\nro@marca{os créditos}.}
  \nro@setematividades{%
  \begin{itemize}[leftmargin=6mm, itemsep=2pt]
    \item \nro@seprincipal
      {\textbf{\nro@principalcred} como \nro@principalfrase\ (\nro@principaldisp),
       por \nro@principalbase\ de participação na equipe (Quadro~3)\nro@seitens{;}{.}}
      {\nro@marca{o enquadramento principal};}
    \nro@itensrequerimento
  \end{itemize}}{}}

  \nro@sealternativas{Subsidiariamente, caso o Colegiado não acolha o enquadramento principal,
  requeiro que a participação seja apreciada como \nro@alternativasrequerimento, conforme o
  Quadro~1, ou noutro enquadramento que o Colegiado entenda cabível, no todo ou em parte.}%
  {Caso o Colegiado não acolha o enquadramento pedido, requeiro que a participação seja apreciada
  noutro enquadramento que entenda cabível, no todo ou em parte.}

  As atividades foram realizadas na \NRO, no \nro@dado{equipe/laboratorios}, e
  estão descritas e comprovadas neste relatório: cada uma traz o que foi feito, como, com que
  resultado e com que evidência. A folha de aprovação emitida pelo SOMA, logo depois da capa,
  traz a aprovação da direção da equipe e a do professor orientador, com a nota
  (art.~3\textordmasculine, II) e a declaração do período de participação (art.~11, I e II),
  autenticáveis em \nro@dado{equipe/validacao}.

  Nestes termos, peço deferimento.

  \vspace{3mm}%
  \campo{documento/cidade}, \nro@datadoc.
  \vspace{12mm}

  \nro@assinatura{\campo{estudante/nome}}{Matrícula \campo{estudante/matricula}. Requerimento
    firmado pelo envio do relatório no SOMA.}
  \clearpage}

%% os quadros do pedido
\newcommand\nro@titquadro[2]{%
  {\noindent\nro@rotm\nro@corpo{9}\color{nro-cortex}#1\par}\vspace{0.6mm}%
  {\nro@serif\nro@corpo{13.5}\color{nro-tinta}#2\par}\vspace{1.5mm}}
\newcommand\quadrospedido{%
  \nro@conferirpedido
  \nro@kicker{Resumo do pedido}{}%
  \vspace{6mm}{\nro@serif\fontsize{28}{31.5}\selectfont Créditos e enquadramento\par}\vspace{6mm}%
  \nro@setematividades{%
    \nro@titquadro{Quadro 1}{Créditos por enquadramento}%
    \nro@montarquadropedido
    \begingroup\nro@corpo{8.8}\renewcommand\arraystretch{1.45}%
    \setlength\LTpre{0pt}\setlength\LTpost{1.5mm}%
    \begin{xltabular}{\linewidth}{@{}L{17mm}YL{30mm}L{34mm}R{19mm}R{14mm}@{}}\nro@topo
      \nro@cab{} & \nro@cab{Enquadramento} & \nro@cab{Dispositivo} & \nro@cab{Base} &
      \nro@cab{Créditos} & \nro@cab{Horas} \\ \nro@meio\endhead
      \nro@linhas
      & \nro@rotf Total pedido & & & \nro@rotf\nro@seprincipalcolegiado{a definir}{\nro@totalcreditos} & \nro@rotf\nro@seprincipalcolegiado{\nro@escrevetotalhoras}{\nro@totalhoraslancar} \\ \nro@base
    \end{xltabular}\endgroup
    \nro@sealternativas{%
      \vspace{1mm}{\nro@corpo{9}\color{nro-texto2}Alternativas, fora da soma:\par}\vspace{0.5mm}%
      \nro@montaralternativas
      \begingroup\nro@corpo{8.8}\renewcommand\arraystretch{1.45}%
      \setlength\LTpre{0pt}\setlength\LTpost{1.5mm}%
      \begin{xltabular}{\linewidth}{@{}L{17mm}YL{30mm}L{34mm}R{19mm}R{14mm}@{}}\nro@topo
        \nro@linhas\nro@base
      \end{xltabular}\endgroup}{}%
    {\nro@corpo{8.4}\color{nro-cinza}Horas: \nro@hpc\,h por crédito. Cada atividade conta numa AACC
     só (art.~7\textordmasculine).\par}
    \vspace{5mm}%
    \nro@titquadro{Quadro 2}{Atividades}%
    \nro@montarquadroatividades
    \begingroup\nro@corpo{8.8}\renewcommand\arraystretch{1.45}%
    \setlength\LTpre{0pt}\setlength\LTpost{1.5mm}%
    \begin{xltabular}{\linewidth}{@{}L{8mm}YL{24mm}L{25mm}L{22mm}R{12mm}R{8mm}R{8mm}@{}}\nro@topo
      \nro@cab{Nº} & \nro@cab{Atividade} & \nro@cab{Tipo} & \nro@cab{Período} & \nro@cab{Aproveitamento} &
      \nro@cab{Horas} & \nro@cab{Evid.} & \nro@cab{Pág.} \\ \nro@meio\endhead
      \nro@linhas
      & \nro@rotf Total & & & & \nro@rotf\nro@escrevetotalhoras & & \\ \nro@base
    \end{xltabular}\endgroup
    \vspace{5mm}%
    \nro@titquadro{Quadro 3}{Semestres letivos}%
    \nro@quadrosemestres}
   {\nro@seauxlido{\preencher[Pedido: nenhuma atividade]{O relatório ainda não tem nenhuma atividade (Parte~III).}}
     {\begin{nota}Os quadros se montam na segunda compilação.\end{nota}}}%
  \vspace{4mm}%
  \begin{nota}
    \textbf{Verificação.} A folha de aprovação e as declarações emitidas pelo SOMA, o sistema de
    gestão da equipe, se conferem em \textbf{\nro@dado{equipe/validacao}}, pelo código verificador.
    Os demais registros são apresentados ao Colegiado quando pedidos. O Anexo~A lista as
    \nro@totalevidencias\ evidências citadas.
  \end{nota}
  \nro@listapendencias
  \clearpage}
\newcommand\nro@totalhoraslancar{\nro@credhoras{\nro@totalcreditosnum}}
\newcommand\nro@linhapedido[6]{%
  \leavevmode{\nro@rot\color{nro-cinza}#1} & #2 & #3 & #4 & #5 & #6 \\ \nro@fino}
\newcommand\nro@linhaatividade[7]{%
  \hyperref[nro:atv:#1]{\cod{A#1}} & #2 & #3 & #4 & #5 & #6 & #7 & \pageref*{nro:atv:#1} \\ \nro@fino}
\newcommand\nro@semconta{Conta}
\newcommand\nro@semparcial{\textcolor{nro-cinza}{Parcial, não conta}}
\newcommand\nro@semantes{\textcolor{nro-cinza}{Antes do ingresso (art.~5\textordmasculine)}}
\newcommand\nro@linhasemestre[5]{\cod{#1} & #2 & #3 & #4 \\ \nro@fino}
\newcommand\nro@quadrosemestres{%
  \nro@sesemestres{%
    \nro@montarsemestres
    \begingroup\nro@corpo{8.8}\renewcommand\arraystretch{1.45}%
    \setlength\LTpre{0pt}\setlength\LTpost{1.5mm}%
    \begin{xltabular}{\linewidth}{@{}L{22mm}R{28mm}YL{30mm}@{}}\nro@topo
      \nro@cab{Semestre} & \nro@cab{Meses na equipe} & \nro@cab{Situação} &
      \nro@cab{\nro@secolsiex{Registro no SIEX}{}} \\ \nro@meio\endhead
      \nro@linhas
      & & \nro@rotf\nro@semestrescontam & \\ \nro@base
    \end{xltabular}\endgroup
    {\nro@corpo{8.4}\color{nro-cinza}Conta o semestre com ao menos \nro@mesesmin\ meses de
     participação, sem os afastamentos (art.~5\textordmasculine).\par}}
   {\nro@marca{os semestres: falta o período na equipe}\par}}

%% a lista das pendências (da compilação anterior)
\ExplSyntaxOn
\cs_new_protected:Npn \nro@credhoras #1 { \__nro_cred_horas:n {#1} }
\cs_new_protected:Npn \nro@listapendencias
  {
    \bool_if:NT \g__nro_aux_lido_bool
      {
        \int_compare:nNnT { \g__nro_pend_ant_int } > { 0 }
          {
            \par \vspace { 3mm }
            \phantomsection \label { nro:pendencias }
            \begin { tcolorbox } [ nro/base , colback = \sefinal { nro-impulso-claro } { nro-lumen-claro } ,
                coltext = \sefinal { nro-impulso-escuro } { nro-lumen-escuro } , fontupper = \nro@corpo { 9 } ,
                title = { Pendências~(\int_use:N \g__nro_pend_ant_int):~o~que~ainda~falta~para~o~relatório~seguir } ,
                coltitle = \sefinal { nro-impulso-escuro } { nro-lumen-escuro } ,
                colbacktitle = \sefinal { nro-impulso-claro } { nro-lumen-claro } , titlerule = 0pt ,
                fonttitle = \nro@serif \itshape \nro@corpo { 12 } ]
              \begin { enumerate } [ leftmargin = 7mm , itemsep = 0pt , topsep = 0pt ]
                \seq_map_inline:Nn \g__nro_pend_seq { \__nro_item_pendencia:nn ##1 }
              \end { enumerate }
            \end { tcolorbox }
          }
      }
  }
\cs_new_protected:Npn \__nro_item_pendencia:nn #1 #2
  {
    \item #2 \hfill
    \hyperref [ nro:pend:#1 ] { p.~\pageref* { nro:pend:#1 } }
  }
\ExplSyntaxOff

%% ------------------------------------------------------------
%% 21. AS PARTES QUE A EQUIPE ESCREVE, E AS QUE SE MONTAM
%% ------------------------------------------------------------
%% Parte I: a equipe (nro/institucional.tex)
\newcommand\parteinstitucional{%
  \parte[O vínculo com a UFMG, a organização, o processo de desenvolvimento e a verificação dos
    registros.]{A \texorpdfstring{\NRO*}{NeuroDynamics}}%
  \IfFileExists{nro/institucional.tex}{\input{nro/institucional.tex}}
    {\preencher[Parte I: falta nro/institucional.tex]{Falta o arquivo \cod{nro/institucional.tex}: baixe o template de novo.}}}

%% o catálogo do aproveitamento, para a Parte I
\newcommand\quadroaproveitamento[1][participacao]{%
  \nro@montarcatalogo{#1}%
  \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.45}%
  \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
  \begin{xltabular}{\linewidth}{@{}L{10mm}L{38mm}L{36mm}Y@{}}\nro@topo
    \nro@cab{} & \nro@cab{Enquadramento} & \nro@cab{Créditos} & \nro@cab{O que comprova} \\ \nro@meio\endhead
    \nro@linhas\nro@base
  \end{xltabular}\endgroup}
\newcommand\nro@linhacatalogo[6]{%
  \cod{#1} & #2\newline{\nro@corpo{8}\color{nro-cinza}#3} & #4 & #5%
  \if\relax\detokenize{#6}\relax\else\newline{\nro@corpo{8}\color{nro-cinza}#6}\fi \\ \nro@fino}
\let\quadromodalidades\quadroaproveitamento

%% Parte II: a identificação
\newcommand\identificacao{%
  \section{Identificação}
  \nro@fichatab[40mm]{%
    \nro@par{Nome}{\campo{estudante/nome}}
    \nro@par{Curso}{\campo{estudante/curso}, ingresso no \nro@ingresso
      \secampo{estudante/periodo}{, \nro@dado{estudante/periodo} período}{}}
    \nro@par{Matrícula}{\campo{estudante/matricula}}
    \nro@par{Colegiado}{\campo{estudante/colegiado}}
    \nro@par{E-mail}{\campo{estudante/email}}
    \nro@fimficha}
  \vspace{3mm}
  \nro@fichatab[40mm]{%
    \nro@par{Registro no SOMA}{\campo{membro/registro}}
    \nro@par{Situação}{\nro@textosituacao{\pron{Egresso}{Egressa}{Egresse} da equipe}{Membro ativo}, \nro@periodomembro}
    \nro@par{Cargo atual ou último}{\campo{membro/cargo}}
    \nro@par{Departamento}{\campo{membro/departamento}}
    \nro@par{Projetos}{\secampo{membro/projetos}{\nro@dado{membro/projetos}}{\nro@vazio}}
    \nro@par{Supervisor imediato}{\campo{membro/supervisor}}
    \nro@par{Dedicação média}{\campo{membro/dedicacao}\,h por semana}
    \nro@par{Pedido no SOMA}{\cod{\nro@codigo}, emitido com a folha de aprovação e conferível em
      \nro@dado{equipe/validacao}}
    \nro@fimficha}
  \sesiex
    {\subsection{Extensão}
     \campo{estudante/nome} consta da equipe da ação de extensão \enquote{\campo{equipe/siextitulo}},
     registrada no \mbox{SIEX/UFMG} sob o n\textordmasculine~\campo{equipe/siexnumero}%
     \secampo{equipe/siexcoordenador}{ e coordenada \pelocoordenador\ \nro@dado{equipe/siexcoordenador}}{}%
     \secampo{pedido/siex}{, nos semestres \nro@dado{pedido/siex}}{}.}
    {}}

%% a trajetória: \begin{trajetoria} \marco{2023-03}{…} \end{trajetoria}
\ExplSyntaxOn
\tl_new:N \g__nro_marcos_tl
\int_new:N \g__nro_marcos_int
\NewDocumentEnvironment { trajetoria } { }
  { \tl_gclear:N \g__nro_marcos_tl \int_gzero:N \g__nro_marcos_int }
  {
    \int_compare:nNnTF { \g__nro_marcos_int } = { 0 }
      { \preencher [ Trajetória:~nenhum~marco ] { Conte~a~sua~trajetória~na~equipe,~do~processo~seletivo~até~hoje,~com~\cod{\textbackslash marco\{AAAA-MM\}\{o~que~aconteceu\}}. } }
      { \nro@tabelatrajetoria { \g__nro_marcos_tl } }
  }
\NewDocumentCommand \marco { m +m }
  {
    \int_gincr:N \g__nro_marcos_int
    \tl_gput_right:Nn \g__nro_marcos_tl { \nro@linhamarco {#1} {#2} }
    \ignorespaces
  }
%% os treinamentos feitos na equipe (os do SOMA vêm primeiro)
\tl_new:N \g__nro_trein_tl
\int_new:N \g__nro_trein_int
\NewDocumentEnvironment { treinamentos } { }
  {
    \tl_gclear:N \g__nro_trein_tl \int_gzero:N \g__nro_trein_int
    \nro@somatreinamentos
  }
  {
    \int_compare:nNnTF { \g__nro_trein_int } = { 0 }
      { \par \textcolor { nro-cinza } { Nenhum~treinamento~concluído~na~equipe. } \par }
      { \nro@tabelatreinamentos { \g__nro_trein_tl } }
  }
\NewDocumentCommand \treinamento { m +m m m m }
  {
    \int_gincr:N \g__nro_trein_int
    \tl_gput_right:Nn \g__nro_trein_tl { \nro@linhatreinamento {#1} {#2} {#3} {#4} {#5} }
    \ignorespaces
  }
\ExplSyntaxOff
\newcommand\nro@linhamarco[2]{\leavevmode{\nro@rot\nro@corpo{8.6}\color{nro-cinza}\datacurta{#1}} & #2 \\}
\newcommand\nro@tabelatrajetoria[1]{%
  \par\begingroup\nro@corpo{9.8}\renewcommand\arraystretch{1.5}%
  \noindent\begin{tabularx}{\linewidth}{@{}R{22mm}!{\hspace{2.5mm}\color{nro-cortex}\vrule width 0.5pt\hspace{3mm}}Y@{}}
    #1
  \end{tabularx}\endgroup\par}
\newcommand\nro@linhatreinamento[5]{\cod{#1} & #2 & #3\,h & \datacurta{#4} & \cod{#5} \\ \nro@fino}
\newcommand\nro@tabelatreinamentos[1]{%
  \par\begingroup\nro@corpo{8.8}\renewcommand\arraystretch{1.45}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{@{}L{25mm}YR{13mm}L{19mm}L{35mm}@{}}\nro@topo
    \nro@cab{Código} & \nro@cab{Treinamento} & \nro@cab{Carga} & \nro@cab{Conclusão} & \nro@cab{Certificado} \\ \nro@meio\endhead
    #1\nro@base
  \end{xltabular}\endgroup\par}
%% os afastamentos: \afastamento{início}{fim}{motivo}, ou \semafastamentos.
%% Os do SOMA (soma.tex) entram primeiro.
\newenvironment{afastamentos}{\nro@abreafastamentos\par\nro@somaafastamentos}{%
  \nro@seafastamentos{}{\preencher[Afastamentos: não declarados]{Declare os afastamentos
    (\cod{\textbackslash afastamento\{AAAA-MM\}\{AAAA-MM\}\{motivo\}}), ou escreva
    \cod{\textbackslash semafastamentos}. Os meses afastados saem da conta dos semestres e da média semanal.}}\par}
\newcommand\afastamento[3]{%
  \nro@somaafastamento{#1}{#2}%
  \par\noindent\textcolor{nro-cinza}{\textbullet}\ De \datacurta{#1} a \datacurta{#2}: #3\par}
\newcommand\semafastamentos{\nro@semafastamento
  Não houve afastamento, pausa nem interrupção da participação no período.\par}

%% Parte III: a abertura das atividades
\newcommand\parteatividades{%
  \parte[Uma seção por atividade: a ficha, o contexto, a contribuição individual, o desenvolvimento,
    os resultados, as evidências e os aprendizados. O Quadro~2 lista todas.]{Atividades desenvolvidas}}

%% Parte IV: os quadros de síntese
\newcommand\quadrohoras{%
  \nro@consistencia
  \nro@setematividades{%
    \nro@montarquadrohoras
    \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.45}%
    \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
    \begin{xltabular}{\linewidth}{@{}YL{40mm}R{22mm}@{}}\nro@topo
      \nro@cab{Aproveitamento} & \nro@cab{Atividades} & \nro@cab{Horas} \\ \nro@meio\endhead
      \nro@linhas
      \nro@rotf Total & & \nro@rotf\nro@escrevetotalhoras \\ \nro@base
    \end{xltabular}\endgroup
    \nro@fichatab[62mm]{%
      \nro@par{Meses de vínculo considerados}{\nro@meses\ meses (\nro@periodocurto, descontados
        \nro@mesesafastamento\ de afastamento), cerca de \nro@semanas\ semanas}
      \nro@par{Média das horas declaradas}{\textbf{\nro@media\,h por semana}}
      \nro@par{Capacidade declarada}{\campo{membro/dedicacao}\,h por semana \texttimes\ \nro@semanas\ semanas,
        cerca de \nro@capacidade}
      \nro@fimficha}
    \nro@semediaalta
      {\begin{nro@alerta}\textbf{A média passa de \nro@mediamaxima\,h por semana.} É possível, mas
        precisa de justificativa na memória de cálculo: quais períodos concentraram as horas e que
        registros o comprovam.\end{nro@alerta}}{}%
    \nro@secapacidadeexcedida
      {\begin{nro@alerta}\textbf{As horas declaradas passam da dedicação declarada} multiplicada pelas
        semanas de vínculo. Revise as horas ou a dedicação.\end{nro@alerta}}{}}
   {\begin{nota}O quadro de horas se monta na segunda compilação.\end{nota}}}
\newcommand\nro@marcado{\tikz[baseline=-0.6ex]\fill[nro-cortex](0,0) circle (0.55mm);}
\newcommand\nro@celulaatividade[2]{\cod{#1}\hspace{1.5mm}#2}
\newcommand\matrizcompetencias{%
  \nro@setematividades{%
    \nro@montarmatriz
    \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.45}%
    \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
    \begin{xltabular}{\linewidth}{@{}Y*{\nro@ncompetencias}{C{7mm}}@{}}\nro@topo
      \nro@cab{Atividade}\nro@cabcompetencias \\ \nro@meio\endhead
      \nro@linhas
      \nro@rotf Atividades por competência\nro@totcompetencias \\ \nro@base
    \end{xltabular}\endgroup
    {\nro@corpo{8.6}\color{nro-cinza}Competências do egresso de \campo{estudante/curso}, conforme
     \nro@dado{compref}:\par}
    \begin{description}[leftmargin=9mm, labelwidth=7mm, itemsep=0pt, parsep=0pt,
        font=\normalfont\nro@rotm\nro@corpo{8.6}\color{nro-cinza}]
      \nro@corpo{8.6}\color{nro-cinza}\nro@legendacompetencias
    \end{description}}
   {\begin{nota}A matriz se monta na segunda compilação.\end{nota}}}
\newcommand\quadrodisciplinas{%
  \nro@setematividades{%
    \nro@montardisciplinas
    \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.45}%
    \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
    \begin{xltabular}{\linewidth}{@{}YL{45mm}@{}}\nro@topo
      \nro@cab{Disciplina do curso} & \nro@cab{Atividades em que foi aplicada} \\ \nro@meio\endhead
      \nro@linhas\nro@base
    \end{xltabular}\endgroup}
   {\begin{nota}O quadro das disciplinas se monta na segunda compilação.\end{nota}}}
\newcommand\nro@linhadisciplina[2]{#1 & #2 \\ \nro@fino}
\newcommand\nro@semdisciplinas{\multicolumn{2}{@{}l@{}}{\textcolor{nro-cinza}{Nenhuma disciplina indicada
  nas atividades (o campo disciplinas).}} \\ \nro@fino}
%% a autoavaliação (a tabela; a justificativa é texto do membro)
\newcommand\nro@tabelaautoavaliacao{%
  \par\begingroup\nro@corpo{9}\renewcommand\arraystretch{1.45}%
  \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
  \begin{xltabular}{\linewidth}{@{}YR{14mm}R{28mm}R{18mm}@{}}\nro@topo
    \nro@cab{Critério} & \nro@cab{Peso} & \nro@cab{Minha nota (0 a 10)} & \nro@cab{Pontos} \\ \nro@meio\endhead
    \nro@linhas
    \nro@rotf Autoavaliação (0 a 100) & & & \nro@rotf\nro@totalautoavaliacao \\ \nro@base
  \end{xltabular}\endgroup\par}
\newcommand\nro@linhaauto[4]{#1 & #2 & #3 & #4 \\ \nro@fino}

%% ------------------------------------------------------------
%% 22. PARTE V: A DECLARAÇÃO, A AVALIAÇÃO E O ESPAÇO DO COLEGIADO
%%     As aprovações e a nota não se escrevem aqui: são dadas no SOMA,
%%     e a folha de aprovação as traz. Nada de campo de formulário no
%%     PDF: o arquivo abre igual em qualquer leitor.
%% ------------------------------------------------------------
%% a caixinha impressa, para marcar à mão
\newcommand\nro@quadrinho{\raisebox{-0.12ex}{\tikz\draw[nro-tinta, line width=0.45pt] (0,0) rectangle (2.8mm,2.8mm);}}
\newcommand\nro@opcao[1]{\mbox{\nro@quadrinho\hspace{1.8mm}{\nro@corpo{9.5}#1}}}
\newcommand\nro@linhaescrever[1]{\textcolor{nro-pia}{\rule{#1}{0.4pt}}}
\newcommand\pareceres{%
  \parte[As aprovações da equipe e a nota do professor orientador constam da folha de aprovação,
    logo depois da capa.]{Declaração, avaliação e deliberação}%
  \nro@conferirpartes
  \nro@declaracao
  \nro@avaliacao
  \nro@deliberacao}

\newcommand\nro@declaracao{%
  \section{Declaração}
  Declaro, para os devidos fins, que:
  \begin{enumerate}[label={\nro@rotm\alph*)}, leftmargin=7mm, itemsep=1.5pt]
    \item as informações deste relatório são verdadeiras e as atividades descritas foram realizadas por
      mim, nos períodos indicados, no âmbito da \NRO, depois do meu ingresso no curso
      (art.~5\textordmasculine);
    \item cada atividade é pedida numa AACC só (art.~7\textordmasculine): as horas não foram contadas duas
      vezes neste relatório e não foram nem serão aproveitadas em outra atividade acadêmica (estágio,
      iniciação científica, monitoria, outra AACC ou disciplina);
    \item as evidências citadas existem e serão apresentadas ao Colegiado, ao professor orientador ou à
      direção da equipe sempre que pedidas;
    \item não incluí informação confidencial da equipe nem dado pessoal de terceiros sem autorização, e
      as figuras de projeto foram liberadas pelo supervisor;
    \item estou ciente de que a declaração falsa leva à anulação do aproveitamento e às sanções previstas
      nas normas da UFMG e da \NRO.
  \end{enumerate}
  {\nro@corpo{9}\color{nro-texto2}Declaração firmada pelo envio do relatório no SOMA.\par}}

\newcommand\nro@avaliacao{%
  \section{Avaliação do professor orientador}
  Notas de 0 a 10 por critério, de meio em meio ponto; pontos iguais à nota vezes o peso, sobre 10;
  nota final de 0 a \nro@somapesos, com mínimo de 60 (art.~3\textordmasculine, II). A nota e os pontos
  constam da folha de aprovação.\par
  \vspace{1mm}
  \nro@montarbarema
  \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.45}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{@{}L{38mm}R{10mm}Y@{}}\nro@topo
    \nro@cab{Critério} & \nro@cab{Peso} & \nro@cab{O que se espera para a nota máxima} \\ \nro@meio\endhead
    \nro@linhas\nro@base
  \end{xltabular}\endgroup
  {\nro@corpo{8.6}\color{nro-cinza}Conceitos da UFMG: A (90 a 100), B (80 a 89), C (70 a 79), D (60 a 69),
   E (40 a 59) e F (0 a 39).\par}}
\newcommand\nro@linhabarema[4]{#2 & #3 & {\nro@corpo{8.4}#4} \\ \nro@fino}

\newcommand\nro@deliberacao{%
  \clearpage
  \section{Espaço do Colegiado}
  \nro@instrucao{Se o Colegiado tem formulário próprio, este relatório vai como anexo dele.}
  {\nro@corpo{9.8}Espaço reservado ao \campo{estudante/colegiado}. O pedido está no Quadro~1.\par}
  \vspace{1mm}
  \nro@montarcolegiado
  \begingroup\nro@corpo{8.8}\renewcommand\arraystretch{1.9}%
  \setlength\LTpre{1mm}\setlength\LTpost{3mm}%
  \begin{xltabular}{\linewidth}{@{}YL{20mm}R{20mm}L{26mm}L{40mm}@{}}\nro@topo
    \nro@cab{Enquadramento} & \nro@cab{No pedido} & \nro@cab{Créditos pedidos} & \nro@cab{Créditos aprovados} & \nro@cab{Atividade ou código atribuído} \\ \nro@meio\endhead
    \nro@linhas
    \nro@linhacolegiado{\textcolor{nro-cinza}{Outro enquadramento (se houver)}}{}{}
    \nro@linhacolegiado{\textcolor{nro-cinza}{Outro enquadramento (se houver)}}{}{}
    \nro@base
  \end{xltabular}\endgroup
  \nro@opcao{Deferido integralmente}\hspace{6mm}\nro@opcao{Deferido parcialmente}\hspace{6mm}\nro@opcao{Indeferido}\par
  \vspace{5mm}
  \nro@rotulo{Total aprovado}\hspace{2mm}\nro@linhaescrever{30mm}\hspace{8mm}%
  \nro@rotulo{Reunião ou ata}\hspace{2mm}\nro@linhaescrever{45mm}\par
  \vspace{6mm}
  \nro@rotulo{Observações}\par\vspace{7mm}
  \noindent\nro@linhaescrever{\linewidth}\par\vspace{7mm}
  \noindent\nro@linhaescrever{\linewidth}\par\vspace{7mm}
  \noindent\nro@linhaescrever{\linewidth}\par
  \vspace{14mm}
  \nro@assinatura{Coordenação do Colegiado}{\campo{estudante/colegiado}}
  \vspace{4mm}\nro@rotulo{Data}\hspace{2mm}\nro@linhaescrever{30mm}\par}
\newcommand\nro@linhacolegiado[3]{#1 & \leavevmode{\nro@rot\color{nro-cinza}#2} & #3 & \nro@linhaescrever{20mm} & \nro@linhaescrever{36mm} \\ \nro@fino}

%% ------------------------------------------------------------
%% 23. OS ANEXOS E AS REFERÊNCIAS
%% ------------------------------------------------------------
\newcounter{nroanexo}
\renewcommand\thenroanexo{\Alph{nroanexo}}
%% Anexo A: o índice das evidências (monta-se sozinho)
\newcommand\anexoevidencias{%
  \parte[O Anexo~A lista as evidências citadas nas atividades; os demais são documentos anexados ao
    relatório.]{Anexos}%
  \refstepcounter{nroanexo}%
  \section*{Anexo \thenroanexo, índice das evidências}
  \addcontentsline{toc}{section}{\protect\numberline{\thenroanexo}Índice das evidências}
  As evidências citadas, na ordem em que aparecem. Os documentos emitidos pelo SOMA se conferem em
  \textbf{\nro@dado{equipe/validacao}}.\par\vspace{1mm}
  \nro@indiceevidencias}
\newcommand\nro@linhaindice[6]{\cod{#1} & \cod{#2} & #3 & {\nro@rot\nro@corpo{7.8}#4} & #5 & #6 \\ \nro@fino}
\newcommand\nro@tabelaindice[1]{%
  \begingroup\nro@corpo{8.3}\renewcommand\arraystretch{1.45}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{@{}L{8mm}L{8mm}L{23mm}L{36mm}YL{33mm}@{}}\nro@topo
    \nro@cab{ID} & \nro@cab{Ativ.} & \nro@cab{Tipo} & \nro@cab{Identificador} & \nro@cab{O que mostra} & \nro@cab{Onde conferir} \\ \nro@meio\endhead
    #1\nro@base
  \end{xltabular}\endgroup}
\newcommand\nro@semevidencias{\preencher[Anexo A: nenhuma evidência]{Nenhuma evidência foi citada nas atividades.}}
%% \anexo{título}{arquivo.pdf}: as páginas do PDF, reduzidas para caber sob o cabeçalho
\newcommand\anexo[2]{%
  \clearpage
  \refstepcounter{nroanexo}%
  \IfFileExists{#2}
    {\includepdf[pages=-, scale=0.8, frame, pagecommand={\thispagestyle{empty}},
       addtotoc={1,section,1,\protect\numberline{\thenroanexo}#1,nro:anexo:\thenroanexo},
       picturecommand={\put(\LenToUnit{15mm},\LenToUnit{\dimexpr\paperheight-27mm\relax}){%
         {\nro@rotm\nro@corpo{9}\color{nro-cortex}Anexo \thenroanexo, #1}}}]{#2}}
    {\section*{Anexo \thenroanexo, #1}%
     \addcontentsline{toc}{section}{\protect\numberline{\thenroanexo}#1}%
     \seexemplo
       {\begin{nota}No exemplo, este anexo foi omitido. No relatório de verdade, aqui
          entram as páginas de \nolinkurl{#2}.\end{nota}}
       {\preencher[Anexo \thenroanexo: falta o PDF]{Anexe o PDF: salve-o como \nolinkurl{#2}
          (a pasta \cod{anexos/} já existe no template).}}}}
%% as referências (ABNT)
\defbibheading{nro}[Referências]{\section*{#1}\addcontentsline{toc}{section}{\protect\numberline{}#1}}
\newcommand\referencias{\printbibliography[heading=nro]}

%% ------------------------------------------------------------
%% 24. OS ARQUIVOS DA EQUIPE: o que se sabe dela e as regras
%% ------------------------------------------------------------
\InputIfFileExists{nro/equipe.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/equipe.tex}}
\InputIfFileExists{nro/aproveitamento.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/aproveitamento.tex}}
\InputIfFileExists{nro/tipos.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/tipos.tex}}
\InputIfFileExists{nro/avaliacao.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/avaliacao.tex}}
\InputIfFileExists{nro/competencias.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/competencias.tex}}

\endinput
