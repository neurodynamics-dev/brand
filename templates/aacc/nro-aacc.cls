%% ============================================================
%% nro-aacc.cls — o relatório de atividades para aproveitamento
%% de AACC, no modelo de documento da NeuroDynamics (NRO-PUB-002)
%%
%% O membro (ou o egresso) escreve em relatorio-aacc.tex; esta classe
%% cuida do resto:
%%   - o desenho do NRO-PUB-002, o mesmo dos PDFs do SOMA (doc-nro.js,
%%     no portal): a logo à esquerda e, à direita, o emissor, o título e
%%     o código com a revisão; Arial (aqui, a TeX Gyre Heros, que tem a
%%     métrica da Arial); a linha do rodapé com a página;
%%   - os campos da identificação, e a marca do que falta neles;
%%   - a ATIVIDADE: a ficha, a ficha técnica do tipo, as seções que toda
%%     atividade tem, as figuras e as evidências — e o que falta nela;
%%   - os quadros que se montam sozinhos (horas por modalidade, lista das
%%     atividades, competências, disciplinas, índice das evidências);
%%   - as PENDÊNCIAS: tudo o que não foi preenchido aparece no PDF, na
%%     capa e na lista do começo. Relatório com pendência não se
%%     encaminha — nem ao dirigente, nem ao professor, nem ao Colegiado;
%%   - os pareceres (equipe, professor, Colegiado), com os campos que se
%%     preenchem no próprio PDF.
%%
%% Os dados e as regras da equipe ficam fora daqui, em nro/: quem é o
%% professor, o registro no SIEX, as modalidades de aproveitamento, os
%% tipos de atividade, o barema e as competências. A Diretoria mantém
%% esses arquivos; o membro não mexe neles.
%%
%% Opções:
%%   rascunho  (padrão) mostra os roteiros e as instruções;
%%   final     esconde as instruções; o que falta sai em vermelho, e a
%%             capa diz se o relatório pode seguir;
%%   exemplo   a marca d'água do exemplo fictício;
%%   impresso  os campos dos pareceres saem como caixas, sem formulário.
%%
%% Os quadros do começo (o pedido, a lista das atividades, as
%% pendências) dependem de o documento inteiro já ter sido lido: vêm do
%% .aux da compilação anterior. O Overleaf compila quantas vezes for
%% preciso; na linha de comando, use o latexmk.
%%
%% Duas regras de quem mexe aqui: (1) nada com efeito colateral (uma
%% pendência, um contador) dentro do corpo de uma tabularx/xltabular —
%% o corpo roda várias vezes; as linhas se montam antes, numa tl, e a
%% tabela só as escreve. (2) Texto com acento não passa por expansão
%% x/e crua: as descrições das pendências passam por \protected@edef.
%% ============================================================
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesExplClass{nro-aacc}{2026-09-29}{1.0}
  {Relatorio de atividades para aproveitamento de AACC - NeuroDynamics}

%% ------------------------------------------------------------
%% 0. AS OPÇÕES
%% ------------------------------------------------------------
\bool_new:N \g__nro_final_bool
\bool_new:N \g__nro_exemplo_bool
\bool_new:N \g__nro_formulario_bool
\bool_gset_true:N \g__nro_formulario_bool
\DeclareOption { rascunho } { \bool_gset_false:N \g__nro_final_bool }
\DeclareOption { final }    { \bool_gset_true:N  \g__nro_final_bool }
\DeclareOption { exemplo }  { \bool_gset_true:N  \g__nro_exemplo_bool }
\DeclareOption { impresso } { \bool_gset_false:N \g__nro_formulario_bool }
\DeclareOption* { \PassOptionsToClass { \CurrentOption } { article } }
\ProcessOptions \scan_stop:
\LoadClass [ a4paper , 11pt ] { article }

%% ------------------------------------------------------------
%% 1. OS PACOTES
%% ------------------------------------------------------------
\RequirePackage [ T1 ] { fontenc }
\RequirePackage [ brazil ] { babel }
\RequirePackage { lmodern }         % a matemática, em tamanhos contínuos
\RequirePackage { tgheros }
\RequirePackage [ scale = 0.86 ] { plex-mono }
\RequirePackage { textcomp }
\RequirePackage { amsmath }
\RequirePackage [ final ] { microtype }
\RequirePackage
  [ a4paper , top = 32.5mm , bottom = 25mm , left = 15mm , right = 12.5mm ]
  { geometry }
\RequirePackage [ table ] { xcolor }
\RequirePackage { graphicx }
\RequirePackage { array , tabularx , xltabular , multirow }
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
\RequirePackage { pifont }
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
%% 2. OS DADOS — tudo o que o relatório sabe fica num lugar só,
%%    \g__nro_dados_prop, com a chave "grupo/campo" (estudante/nome,
%%    equipe/professor, mod/EXT/codigo, tipo/pcb/nome…). A chave é
%%    expandida antes da consulta: "tipo/\l__nro_atv_tipo_tl/nome" vale.
%%    \campo{grupo/campo} escreve o valor — ou a marca do que falta.
%% ------------------------------------------------------------
\prop_new:N \g__nro_dados_prop
\tl_new:N \l__nro_tmp_tl
\tl_new:N \l__nro_tmpb_tl
\tl_new:N \l__nro_chave_tl
\tl_new:N \l__nro_prefixo_tl
\tl_new:N \l__nro_grupo_tl
\int_new:N \l__nro_tmp_int
\fp_new:N \l__nro_tmp_fp
\seq_new:N \l__nro_tmp_seq
\bool_new:N \l__nro_achou_bool

\msg_new:nnn { nro-aacc } { campo-desconhecido }
  { O~campo~'#2'~nao~existe~em~\iow_char:N\\#1.~Confira~a~grafia~(o~valor~foi~guardado~mesmo~assim). }
\msg_new:nnn { nro-aacc } { chave-atividade }
  { Uma~atividade~usa~o~campo~'#2',~que~nao~existe.~Os~campos~sao:~tipo,~modalidade,~alternativa,~horas,~inicio,~fim,~projeto,~papel,~supervisor,~registros,~competencias,~disciplinas. }
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
  { pn , data , cidade }
\prop_gput:Nnn \g__nro_campos_prop { serie }
  { codigo , titulo , emissor , revisao }
\prop_gput:Nnn \g__nro_campos_prop { equipe }
  { nome , sigla , laboratorios , unidade , site , validacao , professor ,
    artigoprofessor , departamentoprofessor , emailprofessor , dirigente ,
    cargodirigente , siextitulo , siexnumero , siexcoordenador ,
    artigocoordenador , siexvigencia , norma , horasporcredito , mediamaxima }

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
%% guarda "chave = valor" sob o prefixo; o grupo é o que confere os nomes
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
    \prop_gput:NVn \g__nro_dados_prop \l__nro_chave_tl {#2}
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
%% o membro pode repeti-los no preâmbulo para trocar um valor (o
%% professor que avalia, a norma do seu colegiado).
\NewDocumentCommand \estudante { +m } { \__nro_guardar:nnn { estudante } { estudante } {#1} }
\NewDocumentCommand \membro    { +m } { \__nro_guardar:nnn { membro } { membro } {#1} }
\NewDocumentCommand \documento { +m } { \__nro_guardar:nnn { documento } { documento } {#1} }
\NewDocumentCommand \serie     { +m } { \__nro_guardar:nnn { serie } { serie } {#1} }
\NewDocumentCommand \equipe    { +m } { \__nro_guardar:nnn { equipe } { equipe } {#1} }

%% os nomes dos campos, como a lista de pendências os escreve
\prop_new:N \g__nro_rotulos_prop
\prop_gset_from_keyval:Nn \g__nro_rotulos_prop
  {
    estudante/nome = { o~seu~nome~completo } ,
    estudante/matricula = { o~número~de~matrícula } ,
    estudante/curso = { o~curso } ,
    estudante/colegiado = { o~colegiado~do~curso } ,
    estudante/email = { o~e-mail } ,
    membro/registro = { o~registro~no~SOMA } ,
    membro/situacao = { a~situação~(ativo~ou~egresso) } ,
    membro/inicio = { o~mês~de~entrada~na~equipe } ,
    membro/fim = { o~mês~de~saída~da~equipe } ,
    membro/cargo = { o~cargo~na~equipe } ,
    membro/departamento = { o~departamento } ,
    membro/supervisor = { o~supervisor~imediato } ,
    membro/dedicacao = { a~dedicação~semanal~média } ,
    membro/siex = { a~situação~no~SIEX~(sim~ou~não) } ,
    membro/vinculo = { o~código~da~declaração~de~vínculo } ,
    membro/verificador = { o~código~verificador~da~declaração } ,
    documento/pn = { o~PN~do~registro~(Arquivos,~no~SOMA) } ,
    equipe/professor = { o~professor~responsável~(nro/equipe.tex) } ,
    equipe/departamentoprofessor = { o~departamento~do~professor~(nro/equipe.tex) } ,
    equipe/dirigente = { o~dirigente~da~equipe~(nro/equipe.tex) } ,
    equipe/cargodirigente = { o~cargo~do~dirigente~(nro/equipe.tex) } ,
    equipe/siextitulo = { o~título~da~ação~de~extensão~(nro/equipe.tex) } ,
    equipe/siexnumero = { o~registro~da~ação~no~SIEX~(nro/equipe.tex) } ,
    equipe/siexcoordenador = { o~coordenador~da~ação~no~SIEX~(nro/equipe.tex) } ,
    equipe/siexvigencia = { a~vigência~da~ação~no~SIEX~(nro/equipe.tex) } ,
  }

%% os campos sem os quais o relatório não se encaminha
\clist_const:Nn \c__nro_obrigatorios_clist
  {
    estudante/nome , estudante/matricula , estudante/curso , estudante/colegiado ,
    estudante/email , membro/registro , membro/situacao , membro/inicio ,
    membro/cargo , membro/departamento , membro/supervisor , membro/dedicacao ,
    membro/siex , membro/vinculo , membro/verificador , documento/pn ,
    equipe/professor , equipe/departamentoprofessor , equipe/dirigente ,
    equipe/cargodirigente , equipe/siextitulo , equipe/siexnumero ,
    equipe/siexcoordenador , equipe/siexvigencia
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
\cs_new_protected:Npn \__nro_se_siex:TF #1 #2
  { \__nro_se_valor:nnTF { membro/siex } { sim , s , yes , registrado , registrada } {#1} {#2} }
\NewDocumentCommand \seegresso { +m +m } { \__nro_se_egresso:TF {#1} {#2} }
%% "do Prof." ou "da Profa.": o artigo vem de equipe/artigoprofessor (o ou a)
\NewDocumentCommand \doprofessor { } { \__nro_se_valor:nnTF { equipe/artigoprofessor } { a } { da } { do } }
\NewDocumentCommand \peloprofessor { } { \__nro_se_valor:nnTF { equipe/artigoprofessor } { a } { pela } { pelo } }
\NewDocumentCommand \pelocoordenador { } { \__nro_se_valor:nnTF { equipe/artigocoordenador } { a } { pela } { pelo } }
\NewDocumentCommand \sesiex { +m +m } { \__nro_se_siex:TF {#1} {#2} }
%% "Egresso" ou "Membro ativo"; a marca, se a situação está em branco
\cs_new_protected:Npn \nro@textosituacao #1 #2
  { \__nro_se_dado:nTF { membro/situacao } { \__nro_se_egresso:TF {#1} {#2} } { \nro@marca { a~situação } } }

%% ------------------------------------------------------------
%% 3. AS DATAS E OS NÚMEROS — as datas entram como AAAA-MM ou
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
%% escreve um número com vírgula e uma casa, sem ",0"
\cs_new_protected:Npn \__nro_escreve_num:n #1
  {
    \tl_set:Nx \l__nro_tmp_tl { \fp_eval:n { round ( #1 , 1 ) } }
    \tl_replace_all:Nnn \l__nro_tmp_tl { . } { , }
    \tl_use:N \l__nro_tmp_tl
  }
\NewDocumentCommand \numero { m } { \__nro_escreve_num:n {#1} }

%% horas por crédito (15 na UFMG) e a média semanal que pede justificativa
\cs_new:Npn \__nro_hpc:
  { \__nro_se_dado_exp:nTF { equipe/horasporcredito } { \__nro_dado:n { equipe/horasporcredito } } { 15 } }
\cs_new:Npn \__nro_media_max:
  { \__nro_se_dado_exp:nTF { equipe/mediamaxima } { \__nro_dado:n { equipe/mediamaxima } } { 20 } }
%% "150 h", e os créditos: "10 créditos" ou "9 créditos e 12 h"
\cs_new_protected:Npn \__nro_horas:n #1 { \__nro_escreve_num:n {#1} \,h }
\cs_new_protected:Npn \__nro_creditos:n #1
  {
    \int_set:Nn \l__nro_tmp_int { \fp_eval:n { floor ( (#1) / \__nro_hpc: ) } }
    \int_use:N \l__nro_tmp_int \c_space_tl
    \int_compare:nNnTF { \l__nro_tmp_int } = { 1 } { crédito } { créditos }
    \fp_set:Nn \l__nro_tmp_fp { (#1) - \l__nro_tmp_int * \__nro_hpc: }
    \fp_compare:nNnT { \l__nro_tmp_fp } > { 0.05 }
      { ~ e ~ \__nro_horas:n { \l__nro_tmp_fp } }
  }

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
\tl_new:N \g__nro_contexto_tl          % onde estamos: "A3 · Minha contribuição"
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
\NewExpandableDocumentCommand \seformulario { +m +m } { \bool_if:NTF \g__nro_formulario_bool {#1} {#2} }

%% no fim: a conta vai para o .aux, e um aviso de "rode de novo" se ela mudou
\AddToHook { enddocument / afterlastpage }
  {
    \iow_now:Nx \@auxout { \token_to_str:N \nro@npend { \int_use:N \g__nro_pend_int } }
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
    \__nro_se_dado:nT { membro/dedicacao }
      {
        \__nro_numero:n { \__nro_dado:n { membro/dedicacao } }
        \tl_if_empty:NT \l__nro_num_tl
          { \__nro_pend:n { Identificação:~a~dedicação~semanal~deve~ser~um~número~de~horas } }
      }
  }

%% ------------------------------------------------------------
%% 5. AS MODALIDADES DE APROVEITAMENTO
%%    O catálogo (nro/modalidades.tex) diz quais existem; o membro diz,
%%    para cada uma em que pede horas, o código da atividade no seu
%%    curso e o dispositivo da norma do seu colegiado.
%% ------------------------------------------------------------
\seq_new:N \g__nro_mod_seq
\NewDocumentCommand \definirmodalidade { m +m }
  {
    \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:n {#1} }
    \seq_if_in:NVF \g__nro_mod_seq \l__nro_tmpb_tl
      { \seq_gput_right:NV \g__nro_mod_seq \l__nro_tmpb_tl }
    \__nro_guardar:nnn { mod/ \l__nro_tmpb_tl } { } {#2}
  }
\NewDocumentCommand \modalidade { m +m }
  { \__nro_guardar:nnn { mod/ \tl_trim_spaces:n {#1} } { } {#2} }
\cs_new:Npn \__nro_mod_nome:n #1
  {
    \str_if_eq:nnTF {#1} { ? }
      { \nro@marca { sem~modalidade } }
      { \__nro_se_dado_exp:nTF { mod/#1/nome } { \__nro_dado:n { mod/#1/nome } } { #1 } }
  }
\NewExpandableDocumentCommand \nomemodalidade { m } { \__nro_mod_nome:n {#1} }
%% as linhas do quadro do catálogo (a Parte I o mostra ao Colegiado)
\cs_new_protected:Npn \nro@montarcatalogo
  {
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_mod_seq
      {
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhacatalogo { \exp_not:n {##1} }
              { \__nro_dado:n { mod/##1/nome } } { \__nro_dado:n { mod/##1/descricao } }
              { \__nro_dado:n { mod/##1/evidencias } }
          }
      }
  }

%% ------------------------------------------------------------
%% 6. OS TIPOS DE ATIVIDADE
%%    Cada tipo (nro/tipos.tex) tem um nome, o mínimo de figuras, a
%%    ficha técnica (os campos, e quais são obrigatórios: os marcados
%%    com *) e o roteiro — o que quem avalia procura.
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
%% 7. AS COMPETÊNCIAS E O BAREMA (nro/avaliacao.tex)
%% ------------------------------------------------------------
\seq_new:N \g__nro_comp_seq      % I, II, …, VIII
\NewDocumentCommand \definircompetencia { m +m }
  {
    \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:n {#1} }
    \seq_gput_right:NV \g__nro_comp_seq \l__nro_tmpb_tl
    \prop_gput:Nxn \g__nro_dados_prop { comp/\l__nro_tmpb_tl } {#2}
  }
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
%% 8. A ATIVIDADE
%%    \begin{atividade}{Título}{tipo = …, modalidade = …, horas = …}
%%    Guarda a ficha, abre a atividade, confere o que falta ao fechar
%%    e escreve no .aux a linha que os quadros do começo vão ler.
%% ------------------------------------------------------------
\newcounter { atividade }
\renewcommand \theatividade { A \arabic { atividade } }
\newcounter { secaoatv } [ atividade ]
\prop_new:N \l__nro_atv_prop
\tl_new:N \l__nro_atv_titulo_tl
\tl_new:N \l__nro_atv_tipo_tl
\prop_new:N \g__nro_atv_secoes_prop     % as seções que esta atividade abriu
\int_new:N \g__nro_atv_evid_int         % as evidências desta atividade
\int_new:N \g__nro_atv_figini_int         % a conta das figuras na abertura
\int_new:N \g__nro_atv_lstini_int         % e a das listagens
\bool_new:N \g__nro_atv_ficha_bool      % teve ficha técnica?
\bool_new:N \g__nro_dentro_atv_bool
\seq_new:N \g__nro_atvs_seq             % os números das atividades (do .aux)

\clist_const:Nn \c__nro_atv_chaves_clist
  { tipo , modalidade , alternativa , horas , inicio , fim , projeto , papel ,
    supervisor , registros , competencias , disciplinas }
\clist_const:Nn \c__nro_atv_obrigatorias_clist
  { tipo , modalidade , horas , inicio , fim , projeto , papel , supervisor ,
    registros , competencias }
\prop_const_from_keyval:Nn \c__nro_atv_rotulos_prop
  {
    tipo = o~tipo , modalidade = a~modalidade~pedida , horas = as~horas ,
    inicio = o~início~(AAAA-MM) , fim = o~fim~(AAAA-MM~ou~em~andamento) ,
    projeto = o~projeto , papel = o~seu~papel , supervisor = quem~confirma ,
    registros = os~registros~no~SOMA , competencias = as~competências~(DCN) ,
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
    %% "enquadramento" e "alternativo" também valem
    \str_if_eq:VnT \l__nro_chave_tl { enquadramento } { \tl_set:Nn \l__nro_chave_tl { modalidade } }
    \str_if_eq:VnT \l__nro_chave_tl { alternativo } { \tl_set:Nn \l__nro_chave_tl { alternativa } }
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
    \nro@abreatividade
    \__nro_atv_conferir_ficha:
  }
%% a entrada do sumário: o título mesmo, não o comando que o guarda
\cs_new_protected:Npn \nro@tocatividade
  {
    \exp_args:Nnnx \addcontentsline { toc } { section }
      { \exp_not:N \protect \exp_not:N \numberline { \theatividade } \exp_not:V \l__nro_atv_titulo_tl }
  }

%% o que a ficha da atividade precisa ter
\cs_new_protected:Npn \__nro_atv_conferir_ficha:
  {
    \clist_map_inline:Nn \c__nro_atv_obrigatorias_clist
      {
        \__nro_se_atv:nF {##1}
          {
            \prop_get:NnN \c__nro_atv_rotulos_prop {##1} \l__nro_tmpb_tl
            \__nro_pend:n { \theatividade \c_space_tl · ~ Ficha:~falta~\l__nro_tmpb_tl }
          }
      }
    \__nro_se_atv:nT { tipo }
      {
        \seq_if_in:NVF \g__nro_tipos_seq \l__nro_atv_tipo_tl
          {
            \msg_warning:nnV { nro-aacc } { tipo-desconhecido } \l__nro_atv_tipo_tl
            \__nro_pend:n { \theatividade \c_space_tl · ~ o~tipo~'\l__nro_atv_tipo_tl'~não~existe~(veja~nro/tipos.tex) }
          }
      }
    \__nro_se_atv:nT { modalidade }
      {
        \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:e { \__nro_atv:n { modalidade } } }
        \seq_if_in:NVF \g__nro_mod_seq \l__nro_tmpb_tl
          { \__nro_pend:n { \theatividade \c_space_tl · ~ a~modalidade~'\l__nro_tmpb_tl'~não~existe~(veja~nro/modalidades.tex) } }
      }
    \__nro_se_atv:nT { alternativa }
      {
        \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:e { \__nro_atv:n { alternativa } } }
        \seq_if_in:NVF \g__nro_mod_seq \l__nro_tmpb_tl
          { \__nro_pend:n { \theatividade \c_space_tl · ~ a~modalidade~alternativa~'\l__nro_tmpb_tl'~não~existe } }
      }
    \__nro_se_atv:nT { horas }
      {
        \__nro_numero:n { \__nro_atv:n { horas } }
        \tl_if_empty:NTF \l__nro_num_tl
          { \__nro_pend:n { \theatividade \c_space_tl · ~ as~horas~devem~ser~um~número } }
          {
            \fp_compare:nNnT { \l__nro_num_tl } = { 0 }
              { \__nro_pend:n { \theatividade \c_space_tl · ~ atividade~sem~horas } }
          }
      }
    \__nro_se_atv:nT { inicio }
      {
        \__nro_ler_data:xF { \__nro_atv:n { inicio } }
          { \__nro_pend:n { \theatividade \c_space_tl · ~ o~início~deve~estar~como~AAAA-MM } }
      }
    \__nro_se_atv:nT { fim }
      {
        \__nro_se_andamento:TF { }
          {
            \__nro_ler_data:xF { \__nro_atv:n { fim } }
              { \__nro_pend:n { \theatividade \c_space_tl · ~ o~fim~deve~estar~como~AAAA-MM~(ou~em~andamento) } }
          }
      }
  }
\cs_new_protected:Npn \__nro_se_andamento:TF #1 #2
  {
    \tl_set:Nx \l__nro_tmp_tl { \str_lowercase:f { \tl_to_str:e { \__nro_atv:n { fim } } } }
    \str_if_in:NnTF \l__nro_tmp_tl { andamento } {#1} {#2}
  }

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
            \__nro_pend:n { \theatividade \c_space_tl · ~ falta~a~seção~'\l__nro_tmpb_tl' }
            \nro@caixafalta { Falta~a~seção~\enquote { \l__nro_tmpb_tl }~nesta~atividade. }
          }
      }
    %% as figuras que o tipo pede — a listagem de código conta para software
    \int_set:Nn \l__nro_tmp_int { \value { figure } - \g__nro_atv_figini_int }
    \str_if_eq:VnT \l__nro_atv_tipo_tl { software }
      { \int_add:Nn \l__nro_tmp_int { \value { lstlisting } - \g__nro_atv_lstini_int } }
    \tl_set:Nx \l__nro_tmpb_tl { \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/figuras } }
    \tl_if_blank:VT \l__nro_tmpb_tl { \tl_set:Nn \l__nro_tmpb_tl { 0 } }
    \int_compare:nNnT { \l__nro_tmp_int } < { \l__nro_tmpb_tl }
      {
        \__nro_pend:n { \theatividade \c_space_tl · ~ faltam~figuras~(o~tipo~pede~\l__nro_tmpb_tl) }
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
            \__nro_pend:n { \theatividade \c_space_tl · ~ falta~a~ficha~técnica }
            \nro@caixafalta { Falta~a~ficha~técnica~(\texttt{\textbackslash fichatecnica})~desta~atividade. }
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
      }
    \clist_map_inline:nn
      { tipo , modalidade , alternativa , inicio , fim , projeto , papel ,
        competencias , disciplinas , supervisor }
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
\cs_new_protected:Npn \nro@atvmodalidade
  {
    \__nro_se_atv:nTF { modalidade }
      {
        \tl_set:Nx \l__nro_tmp_tl { \tl_trim_spaces:e { \__nro_atv:n { modalidade } } }
        \__nro_mod_nome:n { \l__nro_tmp_tl } ~ (\texttt{\l__nro_tmp_tl})
        \__nro_se_atv:nT { alternativa }
          {
            \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:e { \__nro_atv:n { alternativa } } }
            \newline \textcolor { nro-cinza }
              { alternativa:~\__nro_mod_nome:n { \l__nro_tmpb_tl } ~ (\texttt{\l__nro_tmpb_tl}) }
          }
      }
      { \nro@marca { a~modalidade } }
  }
\cs_new_protected:Npn \nro@atvcompetencias
  {
    \__nro_se_atv:nTF { competencias }
      {
        \clist_set:Nx \l_tmpa_clist { \__nro_atv:n { competencias } }
        \clist_use:Nn \l_tmpa_clist { ,~ }
        \c_space_tl \textcolor { nro-cinza } { (DCN~de~Engenharia,~art.~4\textordmasculine) }
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
      { \textcolor { nro-cinza } { — } }
  }
\cs_new_protected:Npn \nro@atvregistros
  {
    \__nro_se_atv:nTF { registros }
      {
        \seq_set_split:Nnx \l__nro_tmp_seq { ; } { \__nro_atv:n { registros } }
        \seq_remove_all:Nn \l__nro_tmp_seq { }
        \texttt { \seq_use:Nn \l__nro_tmp_seq { ~ \textperiodcentered { } ~ } }
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
        \__nro_pend:n { \theatividade \c_space_tl · ~ Ficha~técnica:~falta~\l__nro_tmpb_tl }
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
        \__nro_pend:n { \theatividade \c_space_tl · ~ nenhuma~evidência }
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
\cs_new:Npn \nro@totalevidencias { \int_use:N \g__nro_evid_int }

%% ------------------------------------------------------------
%% 9. OS QUADROS QUE SE MONTAM SOZINHOS (do .aux)
%%    Cada quadro monta as suas linhas numa tl ANTES da tabela; a
%%    tabela só escreve a tl.
%% ------------------------------------------------------------
\prop_new:N \g__nro_mod_horas_prop     % modalidade → horas pedidas
\prop_new:N \g__nro_mod_atvs_prop      % modalidade → A1, A3…
\seq_new:N \g__nro_mod_usadas_seq      % as modalidades pedidas, na ordem do catálogo
\fp_new:N \g__nro_total_fp
\bool_new:N \g__nro_totais_bool
\tl_new:N \g__nro_linhas_tl            % as linhas do próximo quadro

%% soma as horas por modalidade (uma vez só)
\cs_new_protected:Npn \__nro_totais:
  {
    \bool_if:NF \g__nro_totais_bool
      {
        \bool_gset_true:N \g__nro_totais_bool
        \fp_gzero:N \g__nro_total_fp
        \prop_gclear:N \g__nro_mod_horas_prop
        \prop_gclear:N \g__nro_mod_atvs_prop
        \seq_map_inline:Nn \g__nro_atvs_seq
          {
            \tl_set:Nx \l__nro_tmp_tl { \tl_trim_spaces:e { \__nro_a:nn {##1} { modalidade } } }
            \tl_if_blank:VT \l__nro_tmp_tl { \tl_set:Nn \l__nro_tmp_tl { ? } }
            \prop_get:NVNF \g__nro_mod_horas_prop \l__nro_tmp_tl \l__nro_tmpb_tl
              { \tl_set:Nn \l__nro_tmpb_tl { 0 } }
            \prop_gput:NVx \g__nro_mod_horas_prop \l__nro_tmp_tl
              { \fp_eval:n { \l__nro_tmpb_tl + ( \__nro_a:nn {##1} { horas } ) } }
            \prop_get:NVNTF \g__nro_mod_atvs_prop \l__nro_tmp_tl \l__nro_tmpb_tl
              { \prop_gput:NVx \g__nro_mod_atvs_prop \l__nro_tmp_tl { \exp_not:V \l__nro_tmpb_tl ,~ A##1 } }
              { \prop_gput:NVx \g__nro_mod_atvs_prop \l__nro_tmp_tl { A##1 } }
            \fp_gadd:Nn \g__nro_total_fp { \__nro_a:nn {##1} { horas } }
          }
        %% a ordem: a do catálogo; depois o que não está nele
        \seq_gclear:N \g__nro_mod_usadas_seq
        %% (como string: as chaves da prop são strings, e a seq compara também o catcode)
        \seq_map_inline:Nn \g__nro_mod_seq
          {
            \prop_if_in:NnT \g__nro_mod_horas_prop {##1}
              { \seq_gput_right:Nx \g__nro_mod_usadas_seq { \tl_to_str:n {##1} } }
          }
        \prop_map_inline:Nn \g__nro_mod_horas_prop
          { \seq_if_in:NnF \g__nro_mod_usadas_seq {##1} { \seq_gput_right:Nn \g__nro_mod_usadas_seq {##1} } }
      }
  }
\cs_new_protected:Npn \nro@escrevetotalhoras { \__nro_totais: \__nro_horas:n { \g__nro_total_fp } }
\cs_new_protected:Npn \nro@escrevetotalcreditos { \__nro_totais: \__nro_creditos:n { \g__nro_total_fp } }
\cs_new_protected:Npn \nro@nmodalidades { \__nro_totais: \seq_count:N \g__nro_mod_usadas_seq }
\cs_new:Npn \nro@natividades { \seq_count:N \g__nro_atvs_seq }
\cs_new_protected:Npn \nro@setematividades #1 #2 { \seq_if_empty:NTF \g__nro_atvs_seq {#2} {#1} }
\cs_new_protected:Npn \nro@seauxlido #1 #2 { \bool_if:NTF \g__nro_aux_lido_bool {#1} {#2} }
\cs_new:Npn \nro@pendanteriores { \int_use:N \g__nro_pend_ant_int }
\cs_new_protected:Npn \nro@setempendencias #1 #2
  { \int_compare:nNnTF { \g__nro_pend_ant_int } > { 0 } {#1} {#2} }
\cs_new:Npn \nro@linhas { \g__nro_linhas_tl }

%% o código e o dispositivo de cada modalidade são do membro: sem eles, marca
\cs_new_protected:Npn \__nro_campo_mod:nn #1 #2
  {
    \__nro_se_dado:nTF { mod/#1/#2 }
      { \__nro_dado:n { mod/#1/#2 } }
      { \nro@marca { \str_if_eq:nnTF {#2} { codigo } { código~no~curso } { dispositivo } } }
  }
%% o limite da modalidade, se o membro o informou
\cs_new_protected:Npn \__nro_limite:nn #1 #2
  {
    \__nro_se_dado:nT { mod/#1/limite }
      {
        \__nro_numero:n { \__nro_dado:n { mod/#1/limite } }
        \tl_if_empty:NF \l__nro_num_tl
          {
            \fp_compare:nNnTF { #2 } > { \l__nro_num_tl }
              { \newline \textcolor { nro-pulso-texto } { \footnotesize acima~do~limite~(\__nro_horas:n { \l__nro_num_tl }) } }
              { \newline \textcolor { nro-cinza } { \footnotesize limite:~\__nro_horas:n { \l__nro_num_tl } } }
          }
      }
  }
%% as pendências das modalidades pedidas (código e dispositivo), uma vez
\bool_new:N \g__nro_mod_conferidas_bool
\cs_new_protected:Npn \nro@conferirmodalidades
  {
    \__nro_totais:
    \bool_if:NF \g__nro_mod_conferidas_bool
      {
        \bool_gset_true:N \g__nro_mod_conferidas_bool
        \seq_map_inline:Nn \g__nro_mod_usadas_seq
          {
            %% a modalidade em branco já é pendência na ficha da atividade
            \str_if_eq:nnF {##1} { ? }
              {
                \__nro_se_dado:nF { mod/##1/codigo }
                  { \__nro_pend:n { Pedido:~o~código~da~modalidade~##1~no~seu~curso~(\textbackslash modalidade) } }
                \__nro_se_dado:nF { mod/##1/dispositivo }
                  { \__nro_pend:n { Pedido:~o~dispositivo~da~norma~para~a~modalidade~##1~(\textbackslash modalidade) } }
              }
          }
      }
  }

%% Quadro 1: as horas por modalidade
\cs_new_protected:Npn \nro@montarquadromodalidades
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_mod_usadas_seq
      {
        \prop_get:NnN \g__nro_mod_horas_prop {##1} \l__nro_tmp_tl
        \prop_get:NnN \g__nro_mod_atvs_prop {##1} \l__nro_tmpb_tl
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhamodalidade
              { \exp_not:n {##1} }
              { \exp_not:N \__nro_mod_nome:n { \exp_not:n {##1} } }
              { \exp_not:N \__nro_campo_mod:nn { \exp_not:n {##1} } { codigo } }
              { \exp_not:N \__nro_campo_mod:nn { \exp_not:n {##1} } { dispositivo } }
              { \exp_not:V \l__nro_tmpb_tl }
              { \exp_not:N \__nro_horas:n { \l__nro_tmp_tl } \exp_not:N \__nro_limite:nn { \exp_not:n {##1} } { \l__nro_tmp_tl } }
              { \exp_not:N \__nro_creditos:n { \l__nro_tmp_tl } }
          }
      }
  }

%% Quadro 2: as atividades
\cs_new_protected:Npn \nro@montarquadroatividades
  {
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_atvs_seq
      {
        \tl_set:Nx \l__nro_tmp_tl { \tl_trim_spaces:e { \__nro_a:nn {##1} { modalidade } } }
        \tl_set:Nx \l__nro_tmpb_tl { \tl_trim_spaces:e { \__nro_a:nn {##1} { alternativa } } }
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhaatividade
              { ##1 }
              { \__nro_a:nn {##1} { titulo } }
              { \exp_not:N \__nro_tipo_nome:n { \__nro_a:nn {##1} { tipo } } }
              { \exp_not:N \__nro_periodo_aux:nn { \__nro_a:nn {##1} { inicio } } { \__nro_a:nn {##1} { fim } } }
              { \exp_not:V \l__nro_tmp_tl }
              { \exp_not:V \l__nro_tmpb_tl }
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
        \tl_gput_right:Nn \g__nro_cabcomp_tl { & \nro@cab {##1} }
        \int_zero:N \l__nro_tmp_int
        \seq_map_inline:Nn \g__nro_atvs_seq
          {
            \clist_set:Nx \l_tmpa_clist { \__nro_a:nn {####1} { competencias } }
            \clist_if_in:NnT \l_tmpa_clist {##1} { \int_incr:N \l__nro_tmp_int }
          }
        \tl_gput_right:Nx \g__nro_totcomp_tl { & \exp_not:N \textbf { \int_use:N \l__nro_tmp_int } }
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
        \tl_gput_right:Nn \g__nro_linhas_tl { \\ \hline }
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

%% a deliberação do Colegiado: uma linha por modalidade pedida
\cs_new_protected:Npn \nro@montarcolegiado
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    \int_zero:N \l__nro_tmp_int
    \seq_map_inline:Nn \g__nro_mod_usadas_seq
      {
        \int_incr:N \l__nro_tmp_int
        \prop_get:NnN \g__nro_mod_horas_prop {##1} \l__nro_tmp_tl
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \nro@linhacolegiado { \int_use:N \l__nro_tmp_int }
              { \exp_not:N \__nro_mod_nome:n { \exp_not:n {##1} } ~ (\exp_not:N \texttt { \exp_not:n {##1} }) }
              { \exp_not:N \__nro_horas:n { \l__nro_tmp_tl } }
          }
      }
  }

%% o quadro de horas da síntese
\cs_new_protected:Npn \nro@montarquadrohoras
  {
    \__nro_totais:
    \tl_gclear:N \g__nro_linhas_tl
    \seq_map_inline:Nn \g__nro_mod_usadas_seq
      {
        \prop_get:NnN \g__nro_mod_horas_prop {##1} \l__nro_tmp_tl
        \prop_get:NnN \g__nro_mod_atvs_prop {##1} \l__nro_tmpb_tl
        \tl_gput_right:Nx \g__nro_linhas_tl
          {
            \exp_not:N \__nro_mod_nome:n { \exp_not:n {##1} } ~ (\exp_not:N \texttt { \exp_not:n {##1} })
            & \exp_not:V \l__nro_tmpb_tl
            & \exp_not:N \__nro_horas:n { \l__nro_tmp_tl }
            & \exp_not:N \__nro_creditos:n { \l__nro_tmp_tl } \exp_not:N \\ \exp_not:N \hline
          }
      }
  }

%% ------------------------------------------------------------
%% 10. OS AFASTAMENTOS, A CONSISTÊNCIA DAS HORAS, A AUTOAVALIAÇÃO
%% ------------------------------------------------------------
\int_new:N \g__nro_meses_afast_int
\bool_new:N \g__nro_afast_bool
\cs_new_protected:Npn \nro@somaafastamento #1 #2
  {
    \bool_gset_true:N \g__nro_afast_bool
    \__nro_meses:nnN {#1} {#2} \l__nro_tmp_int
    \int_gadd:Nn \g__nro_meses_afast_int { \l__nro_tmp_int }
  }
\cs_new_protected:Npn \nro@semafastamento { \bool_gset_true:N \g__nro_afast_bool }
\cs_new_protected:Npn \nro@seafastamentos #1 #2 { \bool_if:NTF \g__nro_afast_bool {#1} {#2} }
%% o que o relatório não pode deixar de ter, conferido ao abrir a Parte V
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
    \tl_if_empty:NTF \l__nro_num_tl { — }
      { \__nro_horas:n { round ( \l__nro_num_tl * \g__nro_semanas_fp , 0 ) } }
  }

%% a autoavaliação: \autoavaliacao{criterio = nota de 0 a 10, …}
\prop_new:N \g__nro_auto_prop
\fp_new:N \g__nro_auto_fp
\bool_new:N \g__nro_auto_bool
\bool_new:N \g__nro_afast_env_bool
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
                  { \exp_not:N \nro@marca { nota } } { — }
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

%% ------------------------------------------------------------
%% 11. O QUE SE CALCULA NO COMEÇO, E A MARCA D'ÁGUA
%% ------------------------------------------------------------
\tl_new:N \g__nro_marca_tl
\bool_new:N \g__nro_marca_alerta_bool
\tl_new:N \g__nro_nome_tl          % o nome da equipe, expandido (para os marcadores do PDF)
\cs_new:Npn \nro@nome { \g__nro_nome_tl }
\bool_new:N \g__nro_logo_bool
\tl_const:Nn \c__nro_logo_tl { nro/imagotipo-preto.png }
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
    %% os metadados do PDF: cópias expandidas (o \exp_not:n do \prop_item
    %% impediria o hyperref de converter os acentos)
    \tl_set:Nx \l__nro_tmp_tl { \__nro_dado:n { equipe/nome } }
    \tl_replace_all:Nnn \l__nro_tmp_tl { \& } { \c_ampersand_str }
    \tl_set:Nx \l__nro_tmpb_tl { \__nro_dado:n { serie/titulo } }
    \tl_set:Nx \l__nro_chave_tl { \__nro_dado:n { estudante/nome } }
    \tl_set:Nx \l__nro_pend_tl { \__nro_dado:n { estudante/curso } }
    \hypersetup
      {
        pdftitle = { \l__nro_tmpb_tl \c_space_tl - \c_space_tl \l__nro_chave_tl } ,
        pdfauthor = { \l__nro_chave_tl } ,
        pdfsubject = { \__nro_codigo_documento_exp: \c_space_tl Rev. ~ \__nro_dado:n { serie/revisao } } ,
        pdfkeywords = { AACC , ~ \l__nro_tmp_tl , ~ \l__nro_pend_tl }
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
                    \fontsize { 58 } { 58 } \selectfont \bfseries
                    \bool_if:NTF \g__nro_marca_alerta_bool
                      { \color { nro-pulso!30 } } { \color { black!7 } }
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

\ExplSyntaxOff
%% ============================================================
%% DAQUI PARA BAIXO, A APRESENTAÇÃO — em LaTeX comum, que é mais fácil
%% de ler e de ajustar. A lógica fica acima, nas funções \nro@….
%% ============================================================

%% ------------------------------------------------------------
%% 12. AS CORES — as do NRO-PUB-002 (os cinzas do doc-nro.js) e as da
%%     marca para o que é estado: Mielina é atenção (o que falta no
%%     rascunho), Pulso é erro (o que falta na versão final), Vital é
%%     sucesso (sem pendências).
%% ------------------------------------------------------------
\definecolor{nro-tinta}{RGB}{29,29,31}
\definecolor{nro-cinza}{RGB}{96,96,99}
\definecolor{nro-claro}{RGB}{138,138,143}
\definecolor{nro-linha}{RGB}{150,150,155}
\definecolor{nro-fundo}{RGB}{217,217,217}
\definecolor{nro-fundoclaro}{RGB}{242,242,242}
\definecolor{nro-h3}{HTML}{595959}
\definecolor{nro-cortex}{HTML}{00352F}
\definecolor{nro-axon}{HTML}{00594F}
\definecolor{nro-synapse}{HTML}{CEDC00}
\definecolor{nro-mielina}{HTML}{F5C36A}
\definecolor{nro-pulso}{HTML}{F1806F}
\definecolor{nro-vital}{HTML}{4ADE97}
\colorlet{nro-mielina-texto}{nro-mielina!45!black}
\colorlet{nro-pulso-texto}{nro-pulso!55!black}
\colorlet{nro-vital-texto}{nro-vital!45!black}

%% ------------------------------------------------------------
%% 13. O TEXTO — Arial no NRO-PUB-002; a Heros tem a mesma métrica.
%%     Corpo 11 pt, sem recuo, com espaço entre os parágrafos, como no
%%     Word. Os códigos (NRO-PRO-003-7, CERT-…) vão na IBM Plex Mono,
%%     a fonte técnica da marca.
%% ------------------------------------------------------------
\renewcommand\familydefault{\sfdefault}
\linespread{1.08}
\setlength\parindent{0pt}
\setlength\parskip{5pt plus 1.5pt minus 1pt}
\setlength\emergencystretch{2em}
\AtBeginDocument{\color{nro-tinta}}
\setlist{itemsep=2pt, topsep=3pt, parsep=1pt, leftmargin=6mm}
\setlist[itemize]{label={\textcolor{nro-claro}{\textbullet}}}
\setlength\arrayrulewidth{0.25mm}
\arrayrulecolor{nro-linha}
\setlength\tabcolsep{1.6mm}
\renewcommand\arraystretch{1.28}
\sisetup{output-decimal-marker={,}, group-separator={.}, group-minimum-digits=4, per-mode=symbol, mode=match}
\captionsetup{font=small, labelfont=bf, labelsep=endash, justification=justified,
  singlelinecheck=true, skip=5pt}
\captionsetup[table]{position=top}
\hypersetup{colorlinks=true, linkcolor=nro-tinta, urlcolor=nro-axon, citecolor=nro-axon,
  filecolor=nro-axon, bookmarksnumbered=true, pdfcreator={nro-aacc.cls - NeuroDynamics}}
\urlstyle{same}
\pdfstringdefDisableCommands{\def\&{\string&}}
%% o código: moldura fina, fundo claro, o número da linha na margem
\lstset{basicstyle=\ttfamily\small, columns=fullflexible, keepspaces=true, frame=single,
  rulecolor=\color{nro-linha}, backgroundcolor=\color{nro-fundoclaro}, numbers=left,
  numberstyle=\tiny\color{nro-claro}, numbersep=6pt, breaklines=true, captionpos=t,
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
%% 14. A FOLHA: o cabeçalho e o rodapé do NRO-PUB-002, desenhados em
%%     posição fixa em toda folha (inclusive nas dos anexos). As medidas
%%     são as do doc-nro.js: a logo a 10,2 mm do topo, com 8,6 mm de
%%     altura; o emissor, o título e o código alinhados à direita, a
%%     12,6, 16,8 e 21 mm; a linha do rodapé a 10,5 mm da borda de baixo.
%% ------------------------------------------------------------
\pagestyle{empty}
\let\ps@plain\ps@empty
\newcommand\nro@corpo[1]{\fontsize{#1}{\dimexpr#1pt*6/5\relax}\selectfont}
\newcommand\nro@notarodape{%
  Registro destinado à análise do aproveitamento de AACC pelo Colegiado do curso. Contém dados
  pessoais do estudante e informações da \nro@dado{equipe/nome}; não deve ser divulgado para outros fins.}
\AddToHook{shipout/background}{%
  \setlength\unitlength{1mm}%
  \normalfont\sffamily\color{nro-tinta}%
  \nro@desenhamarca
  % o cabeçalho
  \nro@selogo
    {\put(15,-18.8){\includegraphics[height=8.6mm]{\nro@logo}}}%
    {\put(15,-16.5){\nro@corpo{12.5}\bfseries NeuroDynamics}}%
  \put(197.5,-12.6){\llap{\nro@corpo{9.5}\bfseries\nro@dado{serie/emissor}}}%
  \put(197.5,-16.8){\llap{\nro@corpo{9.5}\nro@dado{serie/titulo}}}%
  \put(197.5,-21){\llap{\nro@corpo{9.5}\nro@codigo\ Rev.~\nro@dado{serie/revisao}}}%
  % o rodapé: a nota, a linha, o código e a página
  \put(105,-283.4){\makebox(0,0)[b]{\parbox[b]{172mm}{\centering
    \nro@corpo{7.2}\itshape\color{nro-cinza}\nro@notarodape}}}%
  \put(15,-286.6){{\color{nro-linha}\rule{182.5mm}{0.2mm}}}%
  \put(15,-290){\nro@corpo{7.2}\color{nro-claro}\nro@codigo\ Rev.~\nro@dado{serie/revisao}%
    \ \textperiodcentered\ \nro@dado{estudante/nome}}%
  \put(197.5,-290){\llap{\nro@corpo{7.2}\color{nro-claro}Página \thepage\ de \pageref*{LastPage}}}%
}

%% ------------------------------------------------------------
%% 15. OS TÍTULOS — as partes numeradas em romano, as seções como os
%%     Heading 1–3 do NRO-PUB-002 (Arial sem negrito, 20/16/14 pt; aqui
%%     um pouco menores, para um relatório longo).
%% ------------------------------------------------------------
\titleformat{\section}{\nro@corpo{17}\color{nro-tinta}}
  {\textcolor{nro-claro}{\thesection}}{0.7em}{}
\titlespacing*{\section}{0pt}{16pt plus 4pt minus 2pt}{5pt plus 2pt}
\titleformat{\subsection}{\nro@corpo{13.5}\color{nro-tinta}}
  {\textcolor{nro-claro}{\thesubsection}}{0.6em}{}
\titlespacing*{\subsection}{0pt}{11pt plus 3pt minus 1pt}{3pt plus 1pt}
\titleformat{\subsubsection}{\nro@corpo{11.5}\bfseries\color{nro-h3}}
  {\thesubsubsection}{0.6em}{}
\titlespacing*{\subsubsection}{0pt}{9pt plus 2pt}{2pt}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{1}

%% o rótulo: caixa alta, negrito, pequeno — o das tabelas do template
\newcommand\nro@rotulo[1]{{\nro@corpo{6.9}\bfseries\MakeUppercase{#1}}}
%% o olho: IBM Plex Mono, caixa alta — o eyebrow da marca
\newcommand\nro@olho[1]{{\ttfamily\nro@corpo{8.2}\color{nro-claro}\MakeUppercase{#1}}}
%% para os arquivos da equipe e o texto do membro: o nome da equipe e o rótulo
\newcommand\NRO{\nro@nome}
\newcommand\rotulo[1]{\nro@rotulo{#1}}

\newcounter{parte}
\renewcommand\thepart{\Roman{parte}}
%% \parte[apresentação]{Título}: folha nova, o olho "Parte III" e o título
\NewDocumentCommand\parte{o m}{%
  \clearpage
  \refstepcounter{parte}%
  \phantomsection
  \addcontentsline{toc}{part}{\protect\numberline{\Roman{parte}}#2}%
  \nro@definircontexto{Parte \Roman{parte}}%
  {\nro@olho{Parte \Roman{parte}}\par\vspace{1mm}%
   {\nro@corpo{23}\bfseries\raggedright #2\par}\vspace{2.5mm}%
   \textcolor{nro-tinta}{\rule{24mm}{0.6mm}}\par}%
  \IfValueT{#1}{\vspace{2mm}{\nro@corpo{10.5}\color{nro-cinza}#1\par}}%
  \vspace{4mm}}
\titlecontents{part}[9mm]{\addvspace{7pt}\nro@corpo{10.5}\bfseries}
  {\contentslabel[\textcolor{nro-claro}{\thecontentslabel}]{9mm}}{}{\hfill\contentspage}[\addvspace{1pt}]
\titlecontents{section}[9mm]{\nro@corpo{10}}
  {\contentslabel[\textcolor{nro-claro}{\thecontentslabel}]{9mm}}{}
  {\titlerule*[0.6pc]{\textcolor{nro-linha}{.}}\contentspage}
%% o sumário
\newcommand\sumario{%
  \clearpage
  {\nro@olho{Sumário}\par\vspace{1mm}{\nro@corpo{17}O que este relatório contém\par}\vspace{3mm}}%
  {\setlength\parskip{1.2pt}\@starttoc{toc}}\clearpage}

%% ------------------------------------------------------------
%% 16. AS CAIXAS
%% ------------------------------------------------------------
\tcbset{nro/base/.style={enhanced, breakable, boxrule=0.35mm, arc=1.2mm,
  left=2.6mm, right=2.6mm, top=1.8mm, bottom=1.8mm, fontupper=\nro@corpo{9.5},
  before skip=5pt, after skip=7pt}}
%% o que preencher: amarela no rascunho, vermelha na versão final
\newtcolorbox{nro@caixapreencher}{nro/base,
  colback=\sefinal{nro-pulso!9}{nro-mielina!14}, colframe=\sefinal{nro-pulso}{nro-mielina},
  coltext=nro-tinta, fontupper=\nro@corpo{9.2}}
\newcommand\nro@tagpreencher{%
  {\ttfamily\nro@corpo{7.6}\bfseries\color{\sefinal{nro-pulso-texto}{nro-mielina-texto}}%
   \sefinal{PENDENTE}{PREENCHER}}\quad}
%% \preencher[rótulo curto]{o que escrever aqui} — some quando você escreve
\NewDocumentCommand\preencher{o +m}{%
  \par
  \begin{nro@caixapreencher}%
    \nro@pendencia{\IfValueTF{#1}{#1}{\nro@contexto}}%
    \nro@tagpreencher #2%
  \end{nro@caixapreencher}}
%% a marca, no meio do texto, do dado que falta
\newcommand\nro@marca[1]{%
  \begingroup\setlength\fboxsep{0.8pt}%
  \colorbox{\sefinal{nro-pulso!18}{nro-mielina!30}}{%
    \nro@corpo{8.6}\strut\color{\sefinal{nro-pulso-texto}{nro-mielina-texto}}[#1]}%
  \endgroup}
%% o que falta numa atividade (uma seção, a evidência, a figura)
\newcommand\nro@caixafalta[1]{%
  \begin{nro@caixapreencher}%
    {\ttfamily\nro@corpo{7.6}\bfseries\color{\sefinal{nro-pulso-texto}{nro-mielina-texto}}FALTA}\quad #1%
  \end{nro@caixapreencher}}
%% o roteiro do tipo (só no rascunho)
\newtcolorbox{nro@caixaroteiro}[1]{nro/base, colback=nro-fundoclaro, colframe=nro-linha,
  boxrule=0.25mm, title={#1}, coltitle=nro-tinta, colbacktitle=nro-fundo,
  fonttitle=\nro@corpo{8.6}\bfseries, toptitle=0.8mm, bottomtitle=0.8mm, fontupper=\nro@corpo{9}}
%% uma nota neutra, e um alerta
\newtcolorbox{nota}[1][]{nro/base, colback=nro-fundoclaro, colframe=nro-fundo, boxrule=0.3mm,
  fontupper=\nro@corpo{9.5}, #1}
\newtcolorbox{nro@alerta}{nro/base, colback=nro-mielina!14, colframe=nro-mielina,
  fontupper=\nro@corpo{9.5}}
%% a instrução curta, embaixo de um título (só no rascunho)
\newcommand\nro@instrucao[1]{\sefinal{}{{\nro@corpo{8.8}\itshape\color{nro-cinza}#1\par}}}
\newcommand\instrucao[1]{\nro@instrucao{#1}}

%% a figura provisória: a caixa técnica "FIG.", que é pendência
\NewDocumentCommand\figuraprovisoria{O{55mm} m}{%
  \nro@pendencia{\nro@contexto: figura provisória}%
  \begin{tikzpicture}
    \fill[nro-fundoclaro] (0,0) rectangle (0.82\linewidth,#1);
    \draw[nro-fundo, line width=0.2pt, step=4mm] (0,0) grid (0.82\linewidth,#1);
    \draw[\sefinal{nro-pulso}{nro-mielina}, line width=0.8pt] (0,0) rectangle (0.82\linewidth,#1);
    \node[font=\ttfamily\bfseries\nro@corpo{15}, text=nro-claro] at (0.41\linewidth,0.5*#1+5mm) {FIG.};
    \node[text width=0.7\linewidth, align=center, font=\nro@corpo{9}, text=nro-cinza]
      at (0.41\linewidth,0.5*#1-4mm) {#2};
  \end{tikzpicture}}
%% a fonte da figura ou da tabela (ABNT)
\newcommand\fonte[1]{\par\vspace{-2pt}{\centering\nro@corpo{8.5}\color{nro-cinza}Fonte: #1\par}}

%% ------------------------------------------------------------
%% 17. AS TABELAS DO TEMPLATE — borda fina, rótulo cinza em caixa
%%     alta, como a e.tabela e a e.ficha do doc-nro.js
%% ------------------------------------------------------------
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{Y}{>{\raggedright\arraybackslash}X}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcommand\nro@cab[1]{\cellcolor{nro-fundo}\nro@rotulo{#1}}
%% a ficha: RÓTULO | valor, um por linha
\newcommand\nro@fichatab[2][34mm]{%
  \par\begingroup\nro@corpo{9.2}\renewcommand\arraystretch{1.35}%
  \noindent\begin{tabularx}{\linewidth}{|>{\columncolor{nro-fundo}\raggedright\arraybackslash}p{#1}|Y|}\hline
    #2
  \end{tabularx}\par\endgroup}
\newcommand\nro@par[2]{\nro@rotulo{#1} & #2 \\ \hline}
%% a ficha técnica (as linhas vêm prontas da lógica)
\newcommand\nro@linhaficha[2]{\nro@rotulo{#1} & #2 \\ \hline}
\newcommand\nro@tabelaficha[1]{%
  \par\vspace{0.5mm}{\nro@olho{Ficha técnica}}\par\vspace{0.3mm}%
  \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.3}%
  \noindent\begin{tabularx}{\linewidth}{|>{\columncolor{nro-fundo}\raggedright\arraybackslash}p{40mm}|Y|}\hline
    #1
  \end{tabularx}\endgroup\par\vspace{1mm}}

%% ------------------------------------------------------------
%% 18. A ATIVIDADE, NA FOLHA
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
  \vspace{6mm}%
  \textcolor{nro-tinta}{\rule{\linewidth}{0.6mm}}\par\vspace{1.5mm}%
  \nro@olho{Atividade \arabic{atividade}\nro@seatvdado{tipo}{ \textperiodcentered\ \nro@atvtiponome}{}}\par\vspace{0.6mm}%
  {\nro@corpo{15}\bfseries\raggedright\nro@atvtitulo\par}\vspace{2.5mm}%
  % a ficha da atividade: dois pares por linha em cima, uma linha inteira embaixo
  \setlength\nro@larga{\dimexpr(\linewidth-58mm-8\tabcolsep-5\arrayrulewidth)*54/100\relax}%
  \setlength\nro@largb{\dimexpr\linewidth-58mm-8\tabcolsep-5\arrayrulewidth-\nro@larga\relax}%
  \setlength\nro@largtoda{\dimexpr\nro@larga+\nro@largb+29mm+4\tabcolsep+2\arrayrulewidth\relax}%
  \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.3}%
  \noindent\begin{tabular}{|>{\columncolor{nro-fundo}}m{29mm}|>{\raggedright\arraybackslash}m{\nro@larga}|>{\columncolor{nro-fundo}}m{29mm}|>{\raggedright\arraybackslash}m{\nro@largb}|}\hline
    \nro@rotulo{Projeto} & \nro@seatvdado{projeto}{\nro@atvdado{projeto}}{\nro@marca{o projeto}} &
    \nro@rotulo{Período} & \nro@atvperiodo \\ \hline
    \nro@rotulo{Papel} & \nro@seatvdado{papel}{\nro@atvdado{papel}}{\nro@marca{o papel}} &
    \nro@rotulo{Horas pedidas} & \textbf{\nro@atvhoras} \\ \hline
    \nro@rotulo{Modalidade} & \multicolumn{3}{>{\raggedright\arraybackslash}p{\nro@largtoda}|}{\nro@atvmodalidade} \\ \hline
    \nro@rotulo{Quem confirma} & \multicolumn{3}{>{\raggedright\arraybackslash}p{\nro@largtoda}|}{%
      \nro@seatvdado{supervisor}{\nro@atvdado{supervisor}}{\nro@marca{quem confirma}}} \\ \hline
    \nro@rotulo{Registros} & \multicolumn{3}{>{\raggedright\arraybackslash}p{\nro@largtoda}|}{\nro@atvregistros} \\ \hline
    \nro@rotulo{Competências} & \multicolumn{3}{>{\raggedright\arraybackslash}p{\nro@largtoda}|}{\nro@atvcompetencias} \\ \hline
    \nro@rotulo{Disciplinas} & \multicolumn{3}{>{\raggedright\arraybackslash}p{\nro@largtoda}|}{\nro@atvdisciplinas} \\ \hline
  \end{tabular}\par\endgroup
  \vspace{1.5mm}%
  % o roteiro do tipo, no rascunho
  \sefinal{}{\nro@roteiro}}
\ExplSyntaxOn
\cs_new_protected:Npn \nro@roteiro
  {
    \__nro_se_dado:nT { tipo/\l__nro_atv_tipo_tl/roteiro }
      {
        \begin{nro@caixaroteiro} { Roteiro~do~tipo~\enquote{ \__nro_tipo_nome:n { \l__nro_atv_tipo_tl } }:~o~que~quem~avalia~procura }
          \begin{itemize} [ leftmargin = 4.5mm , itemsep = 0.5pt , topsep = 1pt ]
            \__nro_dado:n { tipo/\l__nro_atv_tipo_tl/roteiro }
          \end{itemize}
        \end{nro@caixaroteiro}
      }
  }
\ExplSyntaxOff
\newcommand\nro@fechaatividade{\par\vspace{2mm}}

%% as seções da atividade: "A3.2 Minha contribuição"
\newcommand\nro@titulosecao[2]{%
  \par\Needspace{5\baselineskip}\vspace{3.5mm}%
  \refstepcounter{secaoatv}%
  \belowpdfbookmark{\theatividade.\arabic{secaoatv} #2}{nro-\theatividade-\arabic{secaoatv}}%
  \nro@definircontexto{\theatividade\ \textperiodcentered\ #2}%
  {\nro@corpo{11.5}\bfseries\color{nro-tinta}%
   \textcolor{nro-claro}{\theatividade.\arabic{secaoatv}}\hspace{2.2mm}#2\par}%
  \vspace{0.8mm}%
  \nro@instrucao{#1}}
\newcommand\nro@novasecao[3]{% ambiente, título, instrução
  \NewDocumentEnvironment{#1}{}{%
    \nro@exigiratividade{#1}\nro@secao{#1}\nro@titulosecao{#3}{#2}}{\par}}
\nro@novasecao{contexto}{Contexto e problema}
  {Em que projeto isto aconteceu, que problema havia para resolver e por que ele importava. Quem não conhece a equipe precisa entender.}
\nro@novasecao{contribuicao}{Minha contribuição}
  {Na primeira pessoa: o que VOCÊ fez, decidiu e entregou, separado do que a equipe fez. Nomeie quem trabalhou com você.}
\nro@novasecao{desenvolvimento}{Desenvolvimento técnico}
  {Como foi feito: o método, as ferramentas, os cálculos, as decisões e os porquês, com figuras. É aqui que o nível técnico aparece.}
\nro@novasecao{resultados}{Resultados}
  {O que saiu, com números, unidades e comparação com o que se esperava. O que funcionou e o que não funcionou.}
\nro@novasecao{aprendizados}{Aprendizados e relação com o curso}
  {O que você aprendeu que a sala de aula não deu, o que ela deu e você aplicou, e o que faria diferente.}
%% as evidências: a seção e a tabela
\NewDocumentEnvironment{evidencias}{}{%
  \nro@exigiratividade{evidencias}\nro@secao{evidencias}%
  \nro@titulosecao{Uma linha por evidência: o que é, o identificador (o código no SOMA, o commit, o arquivo), o que ela mostra e onde quem avalia confere. Sem evidência, a atividade não conta.}{Evidências}%
  \nro@abreevidencias\ignorespaces}{\nro@fechaevidencias\par}
\newcommand\nro@linhaevidencia[5]{%
  \texttt{#1} & #2 & {\ttfamily\nro@corpo{7.9}#3} & #4 & #5 \\ \hline}
\newcommand\nro@tabelaevidencias[1]{%
  \begingroup\nro@corpo{8.4}\renewcommand\arraystretch{1.3}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{|C{8mm}|L{24mm}|L{38mm}|Y|L{36mm}|}\hline
    \nro@cab{ID} & \nro@cab{Tipo} & \nro@cab{Identificador} & \nro@cab{O que mostra} & \nro@cab{Onde conferir} \\ \hline
    \endhead
    #1
  \end{xltabular}\endgroup}

%% ------------------------------------------------------------
%% 19. A CAPA, O REQUERIMENTO, OS QUADROS DO PEDIDO, AS PENDÊNCIAS
%% ------------------------------------------------------------
\newcommand\capa{%
  \thispagestyle{empty}%
  \vspace*{8mm}%
  \nro@olho{Relatório de atividades \textperiodcentered\ AACC}\par\vspace{2mm}%
  {\nro@corpo{25}\bfseries\raggedright Aproveitamento de Atividades Acadêmicas\\Curriculares Complementares\par}%
  \vspace{3mm}\textcolor{nro-tinta}{\rule{24mm}{0.6mm}}\par\vspace{3mm}%
  {\nro@corpo{11}\color{nro-cinza}Relatório das atividades realizadas na \campo{equipe/nome},
   para análise do \campo{estudante/colegiado} da Universidade Federal de Minas Gerais.\par}%
  \vspace{12mm}%
  {\nro@corpo{20}\raggedright\campo{estudante/nome}\par}\vspace{1.2mm}%
  {\nro@corpo{11}\color{nro-cinza}\campo{estudante/curso} \textperiodcentered\ matrícula \campo{estudante/matricula}\par}%
  \vspace{7mm}%
  \nro@fichatab[40mm]{%
    \nro@par{Colegiado}{\campo{estudante/colegiado}}
    \nro@par{Na equipe}{\campo{membro/cargo}, \campo{membro/departamento}.
      \nro@textosituacao{Egresso}{Membro ativo}, \nro@periodomembro.
      Registro \campo{membro/registro} no SOMA.}
    \nro@par{Pedido}{\nro@setematividades
      {\textbf{\nro@escrevetotalhoras}, equivalentes a \textbf{\nro@escrevetotalcreditos}
       (\nro@hpc\,h por crédito), em \nro@natividades\ atividade(s) e \nro@nmodalidades\ modalidade(s).}
      {\nro@seauxlido{\nro@marca{nenhuma atividade}}{\textcolor{nro-cinza}{os totais saem na próxima compilação}}}}
    \nro@par{Norma}{\campo{equipe/norma}}
    \nro@par{Professor responsável}{\campo{equipe/professor} (\campo{equipe/departamentoprofessor})}
    \nro@par{Documento}{\texttt{\nro@codigo} Rev.~\nro@dado{serie/revisao} \textperiodcentered\ \nro@datadoc}}
  \vspace{6mm}%
  \nro@situacao
  \seexemplo{\begin{nota}[colback=nro-synapse!14, colframe=nro-synapse!75!black]
    \textbf{Exemplo fictício.} Este relatório foi escrito para mostrar o nível de detalhe e de
    compromisso que a equipe espera de um relatório de AACC. A pessoa, os códigos, os números e os
    dados são inventados e não correspondem a ninguém nem a registro algum do SOMA.
  \end{nota}}{}%
  \clearpage}
%% a situação do relatório: pode seguir ou não
\newcommand\nro@situacao{%
  \nro@seauxlido{%
    \nro@setempendencias
      {\begin{tcolorbox}[nro/base, colback=nro-pulso!10, colframe=nro-pulso, fontupper=\nro@corpo{10}]
        {\ttfamily\bfseries\nro@corpo{8}\color{nro-pulso-texto}NÃO ENCAMINHE}\quad
        \textbf{\nro@pendanteriores\ pendência(s).} O relatório ainda não está completo: a lista do
        que falta está na página \pageref*{nro:pendencias}. Nenhum parecer deve ser dado antes que ela zere.
       \end{tcolorbox}}
      {\begin{tcolorbox}[nro/base, colback=nro-vital!12, colframe=nro-vital!80!black, fontupper=\nro@corpo{10}]
        {\ttfamily\bfseries\nro@corpo{8}\color{nro-vital-texto}SEM PENDÊNCIAS}\quad
        Todos os campos, as seções e as evidências obrigatórios estão preenchidos. O relatório pode
        seguir para o parecer da equipe e do professor responsável (Parte~V).
       \end{tcolorbox}}}
    {\begin{nota}Compile de novo: a situação do relatório (as pendências e os totais) sai da segunda compilação.\end{nota}}}

%% o requerimento ao Colegiado
\newcommand\requerimento{%
  \clearpage
  \nro@olho{Requerimento}\par\vspace{1mm}%
  {\nro@corpo{17}Ao \campo{estudante/colegiado}\par}\vspace{1mm}%
  {\nro@corpo{10}\color{nro-cinza}Universidade Federal de Minas Gerais\par}\vspace{6mm}%
  Eu, \textbf{\campo{estudante/nome}}, estudante do curso de \campo{estudante/curso}, matrícula
  n\textordmasculine~\campo{estudante/matricula}, integrante da \campo{equipe/nome} \nro@periodomembro,
  venho requerer o aproveitamento de
  \nro@setematividades{\textbf{\nro@escrevetotalhoras} de Atividades Acadêmicas Curriculares
  Complementares, equivalentes a \textbf{\nro@escrevetotalcreditos}}{\nro@marca{as horas}},
  nos termos da \campo{equipe/norma}, conforme discriminado no Quadro~1.

  As atividades foram realizadas na \campo{equipe/nome}, no \campo{equipe/laboratorios}, sob a
  responsabilidade \doprofessor\ \campo{equipe/professor}, e estão descritas e comprovadas neste relatório:
  cada uma traz o que foi feito, como foi feito, o resultado e as evidências que permitem conferi-la.
  O relatório foi examinado pela direção da equipe e avaliado pelo professor responsável, conforme
  os pareceres da Parte~V.

  Subsidiariamente, caso o Colegiado não acolha a modalidade pedida para alguma atividade, requeiro
  que ela seja apreciada na modalidade alternativa indicada no Quadro~2, ou em outra que o Colegiado
  entenda cabível, no todo ou em parte.

  Nestes termos, peço deferimento.

  \vspace{4mm}%
  \campo{documento/cidade}, \nro@datadoc.
  \vspace{16mm}

  \nro@assinatura{\campo{estudante/nome}}{Matrícula \campo{estudante/matricula} \textperiodcentered\ \campo{estudante/email}}
  \clearpage}

%% os quadros do pedido
\newcommand\quadrospedido{%
  \nro@conferirmodalidades
  \nro@olho{Resumo do pedido}\par\vspace{1mm}%
  {\nro@corpo{17}O que se pede, e onde está cada coisa\par}\vspace{3mm}%
  \nro@setematividades{%
    {\nro@corpo{9.5}\textbf{Quadro 1} -- Horas pedidas por modalidade de aproveitamento\par}\vspace{1mm}%
    \nro@montarquadromodalidades
    \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.32}%
    \setlength\LTpre{0pt}\setlength\LTpost{2mm}%
    \begin{xltabular}{\linewidth}{|Y|L{24mm}|L{31mm}|L{17mm}|R{21mm}|L{25mm}|}\hline
      \nro@cab{Modalidade} & \nro@cab{Código no curso} & \nro@cab{Dispositivo da norma} &
      \nro@cab{Atividades} & \nro@cab{Horas} & \nro@cab{Créditos} \\ \hline\endhead
      \nro@linhas
      \multicolumn{4}{|r|}{\nro@rotulo{Total}} & \textbf{\nro@escrevetotalhoras} & \textbf{\nro@escrevetotalcreditos} \\ \hline
    \end{xltabular}\endgroup
    {\nro@corpo{8.4}\color{nro-cinza}Créditos calculados a \nro@hpc\,h por crédito. O código e o
     dispositivo são os do quadro de AACC do curso; o Colegiado pode reenquadrar (Parte~V).\par}
    \vspace{4mm}%
    {\nro@corpo{9.5}\textbf{Quadro 2} -- As atividades, com a modalidade pedida e a alternativa\par}\vspace{1mm}%
    \nro@montarquadroatividades
    \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.32}%
    \setlength\LTpre{0pt}\setlength\LTpost{2mm}%
    \begin{xltabular}{\linewidth}{|C{8mm}|Y|L{25mm}|L{27mm}|L{16mm}|R{13mm}|C{9mm}|C{8mm}|}\hline
      \nro@cab{Nº} & \nro@cab{Atividade} & \nro@cab{Tipo} & \nro@cab{Período} & \nro@cab{Modal.} &
      \nro@cab{Horas} & \nro@cab{Evid.} & \nro@cab{Pág.} \\ \hline\endhead
      \nro@linhas
    \end{xltabular}\endgroup}
   {\nro@seauxlido{\preencher[Pedido: nenhuma atividade]{O relatório ainda não tem nenhuma atividade (Parte~III).}}
     {\begin{nota}Os quadros se montam na segunda compilação.\end{nota}}}%
  \vspace{3mm}%
  \begin{nota}
    \textbf{Como conferir este relatório.} Os documentos emitidos pelo SOMA, o sistema de gestão da
    equipe --- a declaração de vínculo (Anexo~B) e as declarações de participação em eventos --- trazem
    um código verificador: qualquer pessoa confere a autenticidade em
    \textbf{\nro@dado{equipe/validacao}}, informando o código. Os demais registros citados (os
    certificados de treinamento, os arquivos controlados \texttt{NRO-XXX-YYY-Z}, as atividades, os
    apontamentos semanais e a presença no laboratório) ficam no SOMA e são apresentados ao Colegiado
    sempre que pedidos, pelo professor responsável ou pela direção da equipe. O Anexo~A lista as
    \nro@totalevidencias\ evidências citadas.
  \end{nota}
  \nro@listapendencias
  \clearpage}
\newcommand\nro@linhamodalidade[7]{%
  #2\newline{\ttfamily\nro@corpo{7.6}\color{nro-cinza}#1} & #3 & #4 & #5 & #6 & #7 \\ \hline}
\newcommand\nro@linhaatividade[8]{%
  \hyperref[nro:atv:#1]{\texttt{A#1}} & #2 & #3 & #4 & \texttt{#5}%
  \if\relax\detokenize{#6}\relax\else\newline{\color{nro-cinza}\texttt{alt.\,#6}}\fi
  & #7 & #8 & \pageref*{nro:atv:#1} \\ \hline}

%% a lista das pendências (da compilação anterior)
\ExplSyntaxOn
\cs_new_protected:Npn \nro@listapendencias
  {
    \bool_if:NT \g__nro_aux_lido_bool
      {
        \int_compare:nNnT { \g__nro_pend_ant_int } > { 0 }
          {
            \par \vspace { 3mm }
            \phantomsection \label { nro:pendencias }
            \begin { tcolorbox } [ nro/base , colback = \sefinal { nro-pulso!7 } { nro-mielina!10 } ,
                colframe = \sefinal { nro-pulso } { nro-mielina } , fontupper = \nro@corpo { 9 } ,
                title = { Pendências~(\int_use:N \g__nro_pend_ant_int):~o~que~ainda~falta~para~o~relatório~seguir } ,
                coltitle = nro-tinta , colbacktitle = \sefinal { nro-pulso!30 } { nro-mielina!45 } ,
                fonttitle = \nro@corpo { 9 } \bfseries ]
              \begin { enumerate } [ leftmargin = 7mm , itemsep = 0pt , topsep = 0pt , label = \arabic*. ]
                \seq_map_inline:Nn \g__nro_pend_seq { \__nro_item_pendencia:nn ##1 }
              \end { enumerate }
            \end { tcolorbox }
          }
      }
  }
\cs_new_protected:Npn \__nro_item_pendencia:nn #1 #2
  {
    \item #2 \hfill
    \hyperref [ nro:pend:#1 ] { \textcolor { nro-cinza } { p.~\pageref* { nro:pend:#1 } } }
  }
\ExplSyntaxOff

%% ------------------------------------------------------------
%% 20. AS PARTES QUE A EQUIPE ESCREVE, E AS QUE SE MONTAM
%% ------------------------------------------------------------
%% Parte I: a equipe (nro/institucional.tex)
\newcommand\parteinstitucional{%
  \parte[Esta parte é escrita e mantida pela direção da equipe, igual em todos os relatórios.
    Ela apresenta a \nro@dado{equipe/nome} ao Colegiado: o vínculo com a UFMG, a estrutura, o
    método de trabalho e como cada informação deste relatório pode ser conferida.]{A \NRO}%
  \IfFileExists{nro/institucional.tex}{\input{nro/institucional.tex}}
    {\preencher[Parte I: falta nro/institucional.tex]{Falta o arquivo \texttt{nro/institucional.tex}: baixe o template de novo.}}}

%% o catálogo das modalidades, para a Parte I
\newcommand\quadromodalidades{%
  \nro@montarcatalogo
  \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.32}%
  \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
  \begin{xltabular}{\linewidth}{|C{12mm}|L{38mm}|Y|L{48mm}|}\hline
    \nro@cab{Chave} & \nro@cab{Modalidade} & \nro@cab{O que é, na equipe} & \nro@cab{O que a comprova} \\ \hline\endhead
    \nro@linhas
  \end{xltabular}\endgroup}
\newcommand\nro@linhacatalogo[4]{\texttt{#1} & \textbf{#2} & #3 & #4 \\ \hline}

%% Parte II: a identificação
\newcommand\identificacao{%
  \section{Identificação}
  \nro@fichatab[40mm]{%
    \nro@par{Nome}{\campo{estudante/nome}}
    \nro@par{Curso}{\campo{estudante/curso}\secampo{estudante/ingresso}{, ingresso em \nro@dado{estudante/ingresso}}{}%
      \secampo{estudante/periodo}{, \nro@dado{estudante/periodo} período}{}}
    \nro@par{Matrícula}{\campo{estudante/matricula}}
    \nro@par{Colegiado}{\campo{estudante/colegiado}}
    \nro@par{E-mail}{\campo{estudante/email}}}
  \vspace{2mm}
  \nro@fichatab[40mm]{%
    \nro@par{Registro no SOMA}{\campo{membro/registro}}
    \nro@par{Situação}{\nro@textosituacao{Egresso da equipe}{Membro ativo}, \nro@periodomembro}
    \nro@par{Cargo atual ou último}{\campo{membro/cargo}}
    \nro@par{Departamento}{\campo{membro/departamento}}
    \nro@par{Projetos}{\secampo{membro/projetos}{\nro@dado{membro/projetos}}{\textcolor{nro-cinza}{--}}}
    \nro@par{Supervisor imediato}{\campo{membro/supervisor}}
    \nro@par{Dedicação média}{\campo{membro/dedicacao}\,h por semana}
    \nro@par{Declaração de vínculo}{\texttt{\campo{membro/vinculo}} \textperiodcentered\ código verificador
      \texttt{\campo{membro/verificador}}, conferível em \nro@dado{equipe/validacao} (Anexo~B)}}
  \subsection{Situação no projeto de extensão}
  \sesiex
    {\campo{estudante/nome} consta da equipe da ação de extensão \enquote{\campo{equipe/siextitulo}},
     registrada no SIEX/UFMG sob o n\textordmasculine~\campo{equipe/siexnumero} e coordenada
     \pelocoordenador\ \campo{equipe/siexcoordenador} (vigência: \campo{equipe/siexvigencia}), o que pode ser conferido
     no próprio SIEX.}
    {\campo{estudante/nome} não consta, até a data deste relatório, da equipe registrada no SIEX/UFMG
     da ação de extensão \enquote{\campo{equipe/siextitulo}} (n\textordmasculine~\campo{equipe/siexnumero}),
     coordenada \pelocoordenador\ \campo{equipe/siexcoordenador}. As atividades descritas foram realizadas no
     âmbito da \campo{equipe/nome}, no \campo{equipe/laboratorios}, sob a responsabilidade \doprofessor\
     \campo{equipe/professor},
     e estão comprovadas pelas evidências de cada atividade e pela declaração de vínculo emitida pelo
     SOMA (Anexo~B). A ausência do registro individual no SIEX é uma pendência administrativa da equipe,
     não da participação: o vínculo e as atividades estão documentados e podem ser conferidos.}}

%% a trajetória: \begin{trajetoria} \marco{2023-03}{…} \end{trajetoria}
\ExplSyntaxOn
\tl_new:N \g__nro_marcos_tl
\int_new:N \g__nro_marcos_int
\NewDocumentEnvironment { trajetoria } { }
  { \tl_gclear:N \g__nro_marcos_tl \int_gzero:N \g__nro_marcos_int }
  {
    \int_compare:nNnTF { \g__nro_marcos_int } = { 0 }
      { \preencher [ Trajetória:~nenhum~marco ] { Conte~a~sua~trajetória~na~equipe,~do~processo~seletivo~até~hoje,~com~\texttt{\textbackslash marco\{AAAA-MM\}\{o~que~aconteceu\}}. } }
      { \nro@tabelatrajetoria { \g__nro_marcos_tl } }
  }
\NewDocumentCommand \marco { m +m }
  {
    \int_gincr:N \g__nro_marcos_int
    \tl_gput_right:Nn \g__nro_marcos_tl { \nro@linhamarco {#1} {#2} }
    \ignorespaces
  }
%% os treinamentos feitos na equipe
\tl_new:N \g__nro_trein_tl
\int_new:N \g__nro_trein_int
\NewDocumentEnvironment { treinamentos } { }
  { \tl_gclear:N \g__nro_trein_tl \int_gzero:N \g__nro_trein_int }
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
\newcommand\nro@linhamarco[2]{\textcolor{nro-cinza}{\ttfamily\nro@corpo{8.6}\datacurta{#1}} & #2 \\}
\newcommand\nro@tabelatrajetoria[1]{%
  \par\begingroup\nro@corpo{9.8}\renewcommand\arraystretch{1.45}%
  \noindent\begin{tabularx}{\linewidth}{@{}R{22mm}!{\hspace{2.5mm}\color{nro-axon}\vrule width 0.6mm\hspace{3mm}}Y@{}}
    #1
  \end{tabularx}\endgroup\par}
\newcommand\nro@linhatreinamento[5]{\texttt{#1} & #2 & #3\,h & \datacurta{#4} & \texttt{#5} \\ \hline}
\newcommand\nro@tabelatreinamentos[1]{%
  \par\begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.3}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{|L{25mm}|Y|R{13mm}|L{19mm}|L{35mm}|}\hline
    \nro@cab{Código} & \nro@cab{Treinamento} & \nro@cab{Carga} & \nro@cab{Conclusão} & \nro@cab{Certificado} \\ \hline\endhead
    #1
  \end{xltabular}\endgroup\par}
%% os afastamentos: \afastamento{início}{fim}{motivo}, ou \semafastamentos
\newenvironment{afastamentos}{\nro@abreafastamentos\par}{%
  \nro@seafastamentos{}{\preencher[Afastamentos: não declarados]{Declare os afastamentos
    (\texttt{\textbackslash afastamento\{AAAA-MM\}\{AAAA-MM\}\{motivo\}}), ou escreva
    \texttt{\textbackslash semafastamentos}. Os meses afastados saem da conta da média semanal.}}\par}
\newcommand\afastamento[3]{%
  \nro@somaafastamento{#1}{#2}%
  \par\noindent\textcolor{nro-claro}{\textbullet}\ De \datacurta{#1} a \datacurta{#2}: #3\par}
\newcommand\semafastamentos{\nro@semafastamento
  Não houve afastamento, pausa nem interrupção da participação no período.\par}

%% Parte III: a abertura das atividades
\newcommand\parteatividades{%
  \parte[Uma seção por atividade. Cada uma traz a ficha (projeto, período, horas, modalidade pedida,
    quem confirma), o contexto, a contribuição individual, o desenvolvimento técnico, os resultados,
    as evidências e o que ela ensinou. O Quadro~2, no começo, lista todas.]{Atividades desenvolvidas}}

%% Parte IV: os quadros de síntese
\newcommand\quadrohoras{%
  \nro@consistencia
  \nro@setematividades{%
    \nro@montarquadrohoras
    \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.32}%
    \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
    \begin{xltabular}{\linewidth}{|Y|L{22mm}|R{17mm}|L{27mm}|}\hline
      \nro@cab{Modalidade} & \nro@cab{Atividades} & \nro@cab{Horas} & \nro@cab{Créditos} \\ \hline\endhead
      \nro@linhas
      \multicolumn{2}{|r|}{\nro@rotulo{Total pedido}} & \textbf{\nro@escrevetotalhoras} & \textbf{\nro@escrevetotalcreditos} \\ \hline
    \end{xltabular}\endgroup
    \nro@fichatab[62mm]{%
      \nro@par{Meses de vínculo considerados}{\nro@meses\ meses (\nro@periodocurto, descontados
        \nro@mesesafastamento\ de afastamento), cerca de \nro@semanas\ semanas}
      \nro@par{Média das horas pedidas}{\textbf{\nro@media\,h por semana}}
      \nro@par{Capacidade declarada}{\campo{membro/dedicacao}\,h por semana \texttimes\ \nro@semanas\ semanas
        $\approx$ \nro@capacidade}}
    \nro@semediaalta
      {\begin{nro@alerta}\textbf{A média passa de \nro@mediamaxima\,h por semana.} É possível, mas
        precisa de justificativa na memória de cálculo: quais períodos concentraram as horas e que
        registros o comprovam.\end{nro@alerta}}{}%
    \nro@secapacidadeexcedida
      {\begin{nro@alerta}\textbf{As horas pedidas passam da dedicação declarada} multiplicada pelas
        semanas de vínculo. Revise as horas ou a dedicação.\end{nro@alerta}}{}}
   {\begin{nota}O quadro de horas se monta na segunda compilação.\end{nota}}}
\newcommand\nro@marcado{\textcolor{nro-axon}{\ding{108}}}
\newcommand\nro@celulaatividade[2]{\texttt{#1}\hspace{1.5mm}#2}
\newcommand\matrizcompetencias{%
  \nro@setematividades{%
    \nro@montarmatriz
    \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.32}%
    \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
    \begin{xltabular}{\linewidth}{|Y|*{\nro@ncompetencias}{C{7mm}|}}\hline
      \nro@cab{Atividade}\nro@cabcompetencias \\ \hline\endhead
      \nro@linhas
      \multicolumn{1}{|r|}{\nro@rotulo{Atividades por competência}}\nro@totcompetencias \\ \hline
    \end{xltabular}\endgroup
    {\nro@corpo{8.6}\color{nro-cinza}As competências gerais do egresso de Engenharia, conforme o
     art.~4\textordmasculine\ da Resolução CNE/CES n\textordmasculine~2, de 24 de abril de 2019 (Diretrizes
     Curriculares Nacionais dos cursos de Engenharia):\par}
    \begin{description}[leftmargin=9mm, labelwidth=7mm, itemsep=0pt, parsep=0pt,
        font=\normalfont\nro@corpo{8.6}\bfseries\color{nro-cinza}]
      \nro@corpo{8.6}\color{nro-cinza}\nro@legendacompetencias
    \end{description}}
   {\begin{nota}A matriz se monta na segunda compilação.\end{nota}}}
\newcommand\quadrodisciplinas{%
  \nro@setematividades{%
    \nro@montardisciplinas
    \begingroup\nro@corpo{9}\renewcommand\arraystretch{1.32}%
    \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
    \begin{xltabular}{\linewidth}{|Y|L{45mm}|}\hline
      \nro@cab{Disciplina do curso} & \nro@cab{Atividades em que foi aplicada} \\ \hline\endhead
      \nro@linhas
    \end{xltabular}\endgroup}
   {\begin{nota}O quadro das disciplinas se monta na segunda compilação.\end{nota}}}
\newcommand\nro@linhadisciplina[2]{#1 & #2 \\ \hline}
\newcommand\nro@semdisciplinas{\multicolumn{2}{|l|}{\textcolor{nro-cinza}{Nenhuma disciplina indicada
  nas atividades (o campo \texttt{disciplinas}).}} \\ \hline}
%% a autoavaliação (a tabela; a justificativa é texto do membro)
\newcommand\nro@tabelaautoavaliacao{%
  \par\begingroup\nro@corpo{9}\renewcommand\arraystretch{1.32}%
  \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
  \begin{xltabular}{\linewidth}{|Y|R{14mm}|R{26mm}|R{18mm}|}\hline
    \nro@cab{Critério} & \nro@cab{Peso} & \nro@cab{Minha nota (0--10)} & \nro@cab{Pontos} \\ \hline\endhead
    \nro@linhas
    \multicolumn{3}{|r|}{\nro@rotulo{Autoavaliação (0--100)}} & \textbf{\nro@totalautoavaliacao} \\ \hline
  \end{xltabular}\endgroup\par}
\newcommand\nro@linhaauto[4]{#1 & #2 & #3 & #4 \\ \hline}

%% ------------------------------------------------------------
%% 21. OS CAMPOS DO PDF E AS ASSINATURAS
%% ------------------------------------------------------------
\renewcommand*\LayoutTextField[2]{#2}
\renewcommand*\LayoutCheckField[2]{#2}
\newcounter{nrocampo}
%% \nro@campo[opções]{largura}{altura}: um campo de texto (ou a caixa, se impresso)
%% A borda é desenhada pelo LaTeX (sai igual na tela e no papel); o campo
%% do PDF vai por cima, transparente e sem borda.
\newcommand\nro@moldura[3]{% cor, largura, altura
  {\color{#1}\setlength\fboxrule{0.25mm}\setlength\fboxsep{0pt}%
   \fbox{\rule{0pt}{\dimexpr#3-0.5mm\relax}\hspace*{\dimexpr#2-0.5mm\relax}}}}
\newcommand\nro@campo[3][]{%
  \stepcounter{nrocampo}%
  \makebox[#2][l]{\rlap{\nro@moldura{nro-linha}{#2}{#3}}%
    \seformulario{\TextField[name=nro.campo.\arabic{nrocampo}, width=#2, height=#3,
      borderwidth=0, bordercolor={}, backgroundcolor={}, charsize=9pt, #1]{}}{}}}
\newcommand\nro@caixinha{%
  \stepcounter{nrocampo}%
  \raisebox{-0.6mm}{\makebox[3.6mm][l]{\rlap{\nro@moldura{nro-tinta}{3.6mm}{3.6mm}}%
    \seformulario{\CheckBox[name=nro.opcao.\arabic{nrocampo}, width=3.6mm, height=3.6mm,
      borderwidth=0, bordercolor={}, backgroundcolor={}]{}}{}}}}
\newcommand\nro@opcao[1]{\mbox{\nro@caixinha\hspace{1.8mm}{\nro@corpo{9.5}#1}}}
%% a assinatura: a linha, o nome e o que a pessoa é
\newcommand\nro@assinatura[2]{%
  \par\noindent
  \begin{minipage}[t]{95mm}
    \textcolor{nro-tinta}{\rule{95mm}{0.3mm}}\par\vspace{0.6mm}
    {\nro@corpo{9.5}\bfseries #1\par}
    {\nro@corpo{8.6}\color{nro-cinza}#2\par}
  \end{minipage}\par}
\newcommand\nro@linhadata{\nro@rotulo{Data}\hspace{2mm}\nro@campo{30mm}{6mm}}

%% ------------------------------------------------------------
%% 22. PARTE V — A DECLARAÇÃO E OS PARECERES
%% ------------------------------------------------------------
\newcommand\pareceres{%
  \parte[A declaração do estudante e os três pareceres que o relatório atravessa: o da direção da
    equipe, o do professor responsável, que atribui a nota, e a deliberação do Colegiado. Os campos
    podem ser preenchidos no próprio PDF ou à mão; a assinatura pode ser digital (gov.br).]{Declaração e pareceres}%
  \nro@conferirpartes
  \begin{Form}%
  \nro@declaracao
  \nro@parecerequipe
  \nro@parecerprofessor
  \nro@deliberacao
  \end{Form}}

\newcommand\nro@declaracao{%
  \section{Declaração do estudante}
  Declaro, para os devidos fins, que:
  \begin{enumerate}[label=\alph*), leftmargin=7mm, itemsep=1.5pt]
    \item as informações deste relatório são verdadeiras e as atividades descritas foram realizadas por
      mim, nos períodos indicados, no âmbito da \campo{equipe/nome};
    \item as horas pedidas correspondem a trabalho efetivamente realizado, não foram contadas duas vezes
      neste relatório e não foram nem serão aproveitadas em outra atividade acadêmica (estágio, iniciação
      científica, monitoria, outra AACC ou disciplina);
    \item as evidências citadas existem e serão apresentadas ao Colegiado, ao professor responsável ou à
      direção da equipe sempre que pedidas;
    \item não incluí informação confidencial da equipe nem dado pessoal de terceiros sem autorização, e
      as figuras de projeto foram liberadas pelo supervisor;
    \item estou ciente de que a declaração falsa leva à anulação do aproveitamento e às sanções previstas
      nas normas da UFMG e da \campo{equipe/nome}.
  \end{enumerate}
  \vspace{3mm}
  \campo{documento/cidade}, \nro@datadoc.\par
  \vspace{14mm}
  \nro@assinatura{\campo{estudante/nome}}{Matrícula \campo{estudante/matricula}}}

\newcommand\nro@parecerequipe{%
  \section{Parecer da direção da equipe}
  \nro@instrucao{Preenchido por quem dirige a equipe, depois de conferir o relatório com os registros do SOMA.}
  {\nro@corpo{9.8}A direção da \campo{equipe/nome} conferiu este relatório com os registros da equipe e verificou que:\par}
  \vspace{1mm}
  \begingroup\nro@corpo{9.2}\renewcommand\arraystretch{1.45}%
  \noindent\begin{tabularx}{\linewidth}{|Y|C{12mm}|C{12mm}|C{15mm}|}\hline
    \nro@cab{Item conferido} & \nro@cab{Sim} & \nro@cab{Não} & \nro@cab{Em parte} \\ \hline
    O vínculo, o cargo e o período declarados conferem com o quadro de pessoal. & \nro@caixinha & \nro@caixinha & \nro@caixinha \\ \hline
    As atividades descritas conferem com os registros do SOMA (atividades, arquivos, apontamentos e presença). & \nro@caixinha & \nro@caixinha & \nro@caixinha \\ \hline
    As horas pedidas são compatíveis com a dedicação registrada no período. & \nro@caixinha & \nro@caixinha & \nro@caixinha \\ \hline
    As evidências citadas existem e estão acessíveis a quem avalia. & \nro@caixinha & \nro@caixinha & \nro@caixinha \\ \hline
    Os supervisores indicados em \enquote{Quem confirma} foram consultados e confirmam as atividades. & \nro@caixinha & \nro@caixinha & \nro@caixinha \\ \hline
    O relatório não expõe informação confidencial da equipe nem dado pessoal de terceiros. & \nro@caixinha & \nro@caixinha & \nro@caixinha \\ \hline
  \end{tabularx}\endgroup\par
  \vspace{2mm}
  \nro@rotulo{Horas confirmadas pela equipe}\hspace{2mm}\nro@campo{28mm}{6mm}\hfill
  \nro@opcao{Encaminhar ao professor}\hspace{5mm}\nro@opcao{Devolver para ajustes}\par
  \vspace{2mm}
  \nro@rotulo{Observações}\par\vspace{0.8mm}
  \noindent\nro@campo[multiline=true]{\linewidth}{19mm}\par
  \vspace{9mm}
  \nro@assinatura{\campo{equipe/dirigente}}{\campo{equipe/cargodirigente} \textperiodcentered\ \campo{equipe/nome}}
  \vspace{1.5mm}\nro@linhadata\par}

\newcommand\nro@parecerprofessor{%
  \clearpage
  \section{Parecer e nota do professor responsável}
  \nro@instrucao{Preenchido pelo professor responsável, que atribui a nota pelo barema abaixo.}
  {\nro@corpo{9.8}Avaliei este relatório pelos critérios abaixo. Cada critério recebe uma nota de 0 a 10;
   os pontos são a nota multiplicada pelo peso e dividida por 10, e a nota final é a soma dos pontos
   (0 a \nro@somapesos).\par}
  \vspace{1mm}
  \nro@montarbarema
  \begingroup\nro@corpo{8.6}\renewcommand\arraystretch{1.34}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{|L{34mm}|C{10mm}|Y|C{17mm}|C{17mm}|}\hline
    \nro@cab{Critério} & \nro@cab{Peso} & \nro@cab{O que se espera para a nota máxima} & \nro@cab{Nota (0--10)} & \nro@cab{Pontos} \\ \hline\endhead
    \nro@linhas
    \multicolumn{3}{|r|}{\nro@rotulo{Nota final (0--100)}} & \multicolumn{2}{c|}{\nro@campo{30mm}{6.5mm}} \\ \hline
  \end{xltabular}\endgroup
  {\nro@corpo{8.6}\color{nro-cinza}Conceitos da UFMG: A (90--100), B (80--89), C (70--79), D (60--69),
   E (40--59) e F (0--39).\par}
  \vspace{2mm}
  \nro@rotulo{Conceito}\hspace{2mm}\nro@campo{12mm}{6mm}\hspace{8mm}%
  \nro@rotulo{Horas que recomendo aproveitar}\hspace{2mm}\nro@campo{28mm}{6mm}\par
  \vspace{2mm}
  \nro@opcao{Recomendo o aproveitamento integral}\hspace{5mm}%
  \nro@opcao{Parcial}\hspace{5mm}%
  \nro@opcao{Não recomendo}\par
  \vspace{2mm}
  \nro@rotulo{Parecer}\par\vspace{0.8mm}
  \noindent\nro@campo[multiline=true]{\linewidth}{30mm}\par
  \vspace{9mm}
  \nro@assinatura{\campo{equipe/professor}}{\campo{equipe/departamentoprofessor} \textperiodcentered\ Universidade Federal de Minas Gerais}
  \vspace{1.5mm}\nro@linhadata\par}
\newcommand\nro@linhabarema[4]{%
  \textbf{#2} & #3 & {\nro@corpo{8.2}#4} & \nro@campo{13mm}{6mm} & \nro@campo{13mm}{6mm} \\ \hline}

\newcommand\nro@deliberacao{%
  \clearpage
  \section{Deliberação do Colegiado}
  \nro@instrucao{Espaço do Colegiado. Se ele tem formulário próprio, este relatório vai como anexo.}
  {\nro@corpo{9.8}Espaço reservado ao \campo{estudante/colegiado}. As modalidades pedidas estão no Quadro~1
   e as alternativas, no Quadro~2; o Colegiado pode aprovar as horas em outra modalidade ou código do
   curso, no todo ou em parte.\par}
  \vspace{1mm}
  \nro@montarcolegiado
  \begingroup\nro@corpo{8.8}\renewcommand\arraystretch{1.5}%
  \setlength\LTpre{1mm}\setlength\LTpost{2mm}%
  \begin{xltabular}{\linewidth}{|C{7mm}|Y|R{17mm}|C{24mm}|C{42mm}|}\hline
    \nro@cab{Nº} & \nro@cab{Modalidade pedida} & \nro@cab{Horas pedidas} & \nro@cab{Horas aprovadas} & \nro@cab{Atividade ou código atribuído} \\ \hline\endhead
    \nro@linhas
    \nro@linhacolegiado{}{\textcolor{nro-cinza}{Reenquadramento (se houver)}}{}
    \nro@linhacolegiado{}{\textcolor{nro-cinza}{Reenquadramento (se houver)}}{}
  \end{xltabular}\endgroup
  \nro@opcao{Deferido integralmente}\hspace{6mm}\nro@opcao{Deferido parcialmente}\hspace{6mm}\nro@opcao{Indeferido}\par
  \vspace{2.5mm}
  \nro@rotulo{Total aprovado}\hspace{2mm}\nro@campo{26mm}{6mm}\hspace{7mm}%
  \nro@rotulo{Reunião ou ata}\hspace{2mm}\nro@campo{34mm}{6mm}\par
  \vspace{2mm}
  \nro@rotulo{Observações}\par\vspace{0.8mm}
  \noindent\nro@campo[multiline=true]{\linewidth}{22mm}\par
  \vspace{9mm}
  \nro@assinatura{Coordenação do Colegiado}{\campo{estudante/colegiado}}
  \vspace{1.5mm}\nro@linhadata\par}
\newcommand\nro@linhacolegiado[3]{#1 & #2 & #3 & \nro@campo{20mm}{5.5mm} & \nro@campo{38mm}{5.5mm} \\ \hline}

%% ------------------------------------------------------------
%% 23. OS ANEXOS E AS REFERÊNCIAS
%% ------------------------------------------------------------
\newcounter{nroanexo}
\renewcommand\thenroanexo{\Alph{nroanexo}}
%% Anexo A: o índice das evidências (monta-se sozinho)
\newcommand\anexoevidencias{%
  \parte[Os documentos que acompanham o relatório. O Anexo~A se monta sozinho, com as evidências
    citadas nas atividades; os demais são os PDFs anexados pelo estudante.]{Anexos}%
  \refstepcounter{nroanexo}%
  \section*{Anexo \thenroanexo\ -- Índice das evidências}
  \addcontentsline{toc}{section}{\protect\numberline{\thenroanexo}Índice das evidências}
  Todas as evidências citadas neste relatório, na ordem em que aparecem. O identificador é o que se
  informa a quem guarda o registro; os documentos emitidos pelo SOMA se conferem em
  \textbf{\nro@dado{equipe/validacao}}.\par\vspace{1mm}
  \nro@indiceevidencias}
\newcommand\nro@linhaindice[6]{\texttt{#1} & \texttt{#2} & #3 & {\ttfamily\nro@corpo{7.6}#4} & #5 & #6 \\ \hline}
\newcommand\nro@tabelaindice[1]{%
  \begingroup\nro@corpo{8.2}\renewcommand\arraystretch{1.3}%
  \setlength\LTpre{1mm}\setlength\LTpost{1mm}%
  \begin{xltabular}{\linewidth}{|C{8mm}|C{8mm}|L{23mm}|L{36mm}|Y|L{33mm}|}\hline
    \nro@cab{ID} & \nro@cab{Ativ.} & \nro@cab{Tipo} & \nro@cab{Identificador} & \nro@cab{O que mostra} & \nro@cab{Onde conferir} \\ \hline\endhead
    #1
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
         \nro@olho{Anexo \thenroanexo\ \textperiodcentered\ #1}}}]{#2}}
    {\section*{Anexo \thenroanexo\ -- #1}%
     \addcontentsline{toc}{section}{\protect\numberline{\thenroanexo}#1}%
     \seexemplo
       {\begin{nota}\raggedright No exemplo, este anexo foi omitido. No relatório de verdade, aqui
          entram as páginas de \nolinkurl{#2}.\end{nota}}
       {\preencher[Anexo \thenroanexo: falta o PDF]{Anexe o PDF: salve-o como \nolinkurl{#2}
          (a pasta \texttt{anexos/} já existe no template).}}}}
%% as referências (ABNT)
\defbibheading{nro}[Referências]{\section*{#1}\addcontentsline{toc}{section}{\protect\numberline{}#1}}
\newcommand\referencias{\printbibliography[heading=nro]}

%% ------------------------------------------------------------
%% 24. OS ARQUIVOS DA EQUIPE: o que se sabe dela e as regras
%% ------------------------------------------------------------
\InputIfFileExists{nro/equipe.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/equipe.tex}}
\InputIfFileExists{nro/modalidades.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/modalidades.tex}}
\InputIfFileExists{nro/tipos.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/tipos.tex}}
\InputIfFileExists{nro/avaliacao.tex}{}{\ClassWarningNoLine{nro-aacc}{Falta nro/avaliacao.tex}}

\endinput
