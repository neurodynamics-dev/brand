%% ============================================================
%% nro-apostila.cls: material didático da NeuroDynamics (apostilas,
%% trilhas de formação, guias de estudo), no modelo de documento
%% controlado da equipe (NRO-PUB-002) e no modo operacional do design
%% system da marca (conjunto primário: Cortex, Axon e Synapse).
%%
%% Quem escreve o material edita só o arquivo principal (veja
%% modelo-apostila.tex). Esta classe cuida do resto:
%%   - a folha: o cabeçalho e o rodapé do NRO-PUB-002 (departamento,
%%     título, código e revisão), em toda folha menos nas capas;
%%   - a capa, a capa de cada parte e a contracapa, em Cortex chapado;
%%   - a estrutura de estudo: parte, nível, tópico, e dentro do tópico
%%     o quadro de aplicação ao produto, as fontes de estudo e os
%%     exercícios;
%%   - o que se monta sozinho a partir do conteúdo: o sumário, os
%%     tópicos e os níveis na capa de cada parte, os totais, a ficha de
%%     progresso e o histórico de revisões.
%%
%% As fontes são as do design system, embarcadas em fonts/: Archivo nos
%% títulos e rótulos, Instrument Sans no texto, IBM Plex Mono só nos
%% códigos e dados. O cabeçalho continua o do NRO-PUB-002, na métrica
%% da Arial (TeX Gyre Heros). Por isso a classe pede LuaLaTeX (no
%% Overleaf: Menu, Compilador, LuaLaTeX).
%%
%% O sumário, os totais e a ficha de progresso vêm do .aux da
%% compilação anterior: compile duas vezes (o latexmk faz isso).
%% ============================================================
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesClass{nro-apostila}[2026/10/27 1.0 Material didatico - NeuroDynamics]

\RequirePackage{iftex}
\ifluatex\else
  \ClassError{nro-apostila}{Esta classe precisa do LuaLaTeX}
    {Compile com lualatex (no Overleaf: Menu, Compilador, LuaLaTeX). As fontes da marca (Archivo, Instrument Sans e IBM Plex Mono) só carregam nele.}
\fi

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper,10pt]{article}

%% ------------------------------------------------------------
%% 1. OS PACOTES (todos do TeX Live básico do Overleaf)
%% ------------------------------------------------------------
\RequirePackage[brazilian]{babel}
\RequirePackage{fontspec}
\RequirePackage{microtype}
\RequirePackage[a4paper, top=32mm, bottom=26mm, left=22mm, right=22mm]{geometry}
\RequirePackage[table]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{array, tabularx, xltabular, booktabs, multirow}
\RequirePackage{enumitem}
\RequirePackage[most]{tcolorbox}
\RequirePackage{tikz}
\usetikzlibrary{calc, arrows.meta, positioning, shapes.misc, fit, backgrounds}
\RequirePackage{lastpage}
\RequirePackage{needspace}
\RequirePackage{caption}
\RequirePackage[autostyle]{csquotes}
\RequirePackage{listings}
\RequirePackage{ragged2e}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\RequirePackage{hyperref}
\RequirePackage{bookmark}

%% ------------------------------------------------------------
%% 2. AS CORES: as do design system (tokens/palette.css). O conjunto
%%    primário (Cortex) com os neutros; Synapse só como acento, e só
%%    sobre fundo escuro.
%% ------------------------------------------------------------
\definecolor{nro-tinta}{HTML}{1D1D1F}         % sulco medium: o texto
\definecolor{nro-cinza}{HTML}{616C68}         % sulco light: rótulos, legendas
\definecolor{nro-texto2}{HTML}{4A4F4D}        % o texto secundário
\definecolor{nro-regua}{HTML}{D9DEDC}         % as linhas finas das tabelas
\definecolor{nro-pia}{HTML}{C4CCC9}           % pia medium: réguas
\definecolor{nro-pia-claro}{HTML}{E8EDEB}
\definecolor{nro-medula-claro}{HTML}{F7F4EE}
\definecolor{nro-cortex}{HTML}{00352F}        % cortex dark
\definecolor{nro-axon}{HTML}{00594F}          % cortex primary
\definecolor{nro-cortex-medio}{HTML}{A9CCC4}
\definecolor{nro-cortex-claro}{HTML}{E3EFEC}
\definecolor{nro-synapse}{HTML}{CEDC00}
%% o cabeçalho e o rodapé do NRO-PUB-002 (os cinzas do doc-nro.js)
\definecolor{nro-cab-cinza}{RGB}{96,96,99}
\definecolor{nro-cab-claro}{RGB}{138,138,143}
\definecolor{nro-cab-linha}{RGB}{150,150,155}

%% ------------------------------------------------------------
%% 3. AS FONTES (embarcadas em fonts/)
%% ------------------------------------------------------------
\newcommand\nro@fontdir{fonts/}
\IfFileExists{\nro@fontdir InstrumentSans-Regular.ttf}{}{%
  \ClassError{nro-apostila}{Não encontrei a pasta fonts/ com as fontes da marca}
    {Ela vem no template (Archivo, Instrument Sans e IBM Plex Mono, todas OFL). Baixe o ZIP de novo e mantenha a pasta fonts/ ao lado do arquivo principal.}}
\defaultfontfeatures{Ligatures=TeX}
\setmainfont{InstrumentSans-Regular.ttf}[
  Path=\nro@fontdir,
  BoldFont=InstrumentSans-SemiBold.ttf,
  ItalicFont=InstrumentSans-Italic.ttf,
  BoldItalicFont=InstrumentSans-MediumItalic.ttf]
\setsansfont{InstrumentSans-Regular.ttf}[
  Path=\nro@fontdir,
  BoldFont=InstrumentSans-SemiBold.ttf,
  ItalicFont=InstrumentSans-Italic.ttf,
  BoldItalicFont=InstrumentSans-MediumItalic.ttf]
\setmonofont{IBMPlexMono-Regular.ttf}[
  Path=\nro@fontdir, BoldFont=IBMPlexMono-SemiBold.ttf, Scale=0.88]
%% títulos: Archivo 600/700, entrelinha de letras -.015em (display: -.025em)
\newfontfamily\nro@titulo[Path=\nro@fontdir, BoldFont=Archivo-Bold.ttf, LetterSpace=-1.5]{Archivo-SemiBold.ttf}
\newfontfamily\nro@display[Path=\nro@fontdir, LetterSpace=-2.5]{Archivo-Bold.ttf}
%% rótulos: Archivo 600, caixa alta, espaçamento aberto (.14em)
\newfontfamily\nro@rotulofonte[Path=\nro@fontdir, LetterSpace=14]{Archivo-SemiBold.ttf}
\newfontfamily\nro@rotulomedio[Path=\nro@fontdir]{Archivo-Medium.ttf}
%% o cabeçalho do NRO-PUB-002 é em Arial; TeX Gyre Heros tem a mesma métrica
\IfFontExistsTF{texgyreheros-regular.otf}
  {\newfontfamily\nro@cabfonte[Extension=.otf, UprightFont=*-regular, BoldFont=*-bold]{texgyreheros}}
  {\newfontfamily\nro@cabfonte[Path=\nro@fontdir, BoldFont=InstrumentSans-SemiBold.ttf]{InstrumentSans-Regular.ttf}}
%% as letras que a Instrument Sans não tem (µ, Ω, ², ³, ≈, ≤, ≥, ±) vêm da Archivo
\newfontfamily\nro@glifos[Path=\nro@fontdir]{Archivo-Medium.ttf}
\RequirePackage{newunicodechar}
\newunicodechar{µ}{{\nro@glifos\char"00B5 }}
\newunicodechar{Ω}{{\nro@glifos\char"03A9 }}
\newunicodechar{²}{{\nro@glifos\char"00B2 }}
\newunicodechar{³}{{\nro@glifos\char"00B3 }}
\newunicodechar{≈}{{\nro@glifos\char"2248 }}
\newunicodechar{≤}{{\nro@glifos\char"2264 }}
\newunicodechar{≥}{{\nro@glifos\char"2265 }}
\newunicodechar{±}{{\nro@glifos\char"00B1 }}
\newcommand\nro@corpo[1]{\fontsize{#1}{\dimexpr#1pt*1.45\relax}\selectfont}

%% ------------------------------------------------------------
%% 4. OS DADOS DO DOCUMENTO (\documento{chave = valor, ...})
%% ------------------------------------------------------------
\pgfkeys{/nro/.cd,
  codigo/.store in=\nro@codigobase,
  numero/.store in=\nro@numero,
  revisao/.store in=\nro@revisao,
  emissor/.store in=\nro@emissor,
  tipo/.store in=\nro@tipo,
  categoria/.store in=\nro@categoria,
  titulo/.store in=\nro@titulo@doc,
  titulocurto/.store in=\nro@titulocurto,
  subtitulo/.store in=\nro@subtitulo,
  eixos/.store in=\nro@eixos,
  data/.store in=\nro@data,
  redator/.store in=\nro@redator,
  revisor/.store in=\nro@revisor,
  aprovador/.store in=\nro@aprovador,
  rotuloproduto/.store in=\nro@rotuloproduto,
  autor/.store in=\nro@autor,
  equipe/.store in=\nro@equipe,
}
\newcommand\nro@codigobase{NRO-XXX-000}
\newcommand\nro@numero{}
\newcommand\nro@revisao{A}
\newcommand\nro@emissor{Departamento}
\newcommand\nro@tipo{Manual ou guia}
\newcommand\nro@categoria{Material didático}
\newcommand\nro@titulo@doc{Título do material}
\newcommand\nro@titulocurto{}
\newcommand\nro@subtitulo{}
\newcommand\nro@eixos{}
\newcommand\nro@data{}
\newcommand\nro@redator{}
\newcommand\nro@revisor{}
\newcommand\nro@aprovador{}
\newcommand\nro@rotuloproduto{No produto}
\newcommand\nro@autor{}
\newcommand\nro@equipe{NeuroDynamics}
\NewDocumentCommand\documento{+m}{\pgfkeys{/nro/.cd,#1}}
%% o código com o número da cópia (NRO-PRO-014-1), que nunca quebra
\newcommand\nro@codigo{\nro@codigobase\ifx\nro@numero\@empty\else-\nro@numero\fi}
\DeclareRobustCommand\cod[1]{\mbox{\nro@rotulomedio #1}}
\newcommand\nro@tituloheader{\ifx\nro@titulocurto\@empty\nro@tipo: \nro@titulo@doc\else\nro@titulocurto\fi}
\newcommand\codigodocumento{\cod{\nro@codigo}}

%% ------------------------------------------------------------
%% 5. O TEXTO: 10 pt, Instrument Sans, alinhado à esquerda (nunca justificado)
%% ------------------------------------------------------------
\renewcommand\normalsize{%
  \@setfontsize\normalsize{10}{14.8}%
  \abovedisplayskip 9pt plus 3pt minus 4pt
  \abovedisplayshortskip 2pt plus 3pt
  \belowdisplayshortskip 6pt plus 3pt minus 3pt
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\renewcommand\small{\@setfontsize\small{9.2}{13}}
\renewcommand\footnotesize{\@setfontsize\footnotesize{8.4}{11.4}}
\setlength\parindent{0pt}
\setlength\parskip{6pt plus 2pt minus 1pt}
\setlength\emergencystretch{2em}
\AtBeginDocument{\color{nro-tinta}\RaggedRight\setlength\RaggedRightParindent{0pt}}
\setlist{itemsep=2pt, topsep=3pt, parsep=1pt, leftmargin=6mm}
\setlist[itemize]{label={\textcolor{nro-axon}{\textbullet}}}
\setlist[enumerate]{label={\nro@rotulomedio\color{nro-axon}\arabic*.}}
\DeclareCaptionFont{nrocinza}{\color{nro-texto2}}
\DeclareCaptionFont{nrorotulo}{\nro@rotulomedio\color{nro-tinta}}
\DeclareCaptionLabelSeparator{nrovirgula}{, }
\captionsetup{font={small,nrocinza}, labelfont=nrorotulo, labelsep=nrovirgula,
  justification=RaggedRight, singlelinecheck=false, skip=5pt}
\hypersetup{colorlinks=true, linkcolor=nro-tinta, urlcolor=nro-axon, citecolor=nro-axon,
  filecolor=nro-axon, bookmarksnumbered=false, pdfcreator={nro-apostila.cls, NeuroDynamics}}
\AtBeginDocument{%
  \hypersetup{pdftitle={\nro@codigo\space\nro@titulo@doc}, pdfauthor={\ifx\nro@autor\@empty\nro@equipe\else\nro@autor\fi},
    pdfsubject={\nro@categoria, Rev.~\nro@revisao}, pdfkeywords={\nro@codigo, NeuroDynamics}}}
\urlstyle{same}
%% o código de verdade: Plex Mono, o único uso da fonte monoespaçada
\DeclareRobustCommand\code[1]{{\ttfamily\let\_\nro@usbreak #1}}
\newcommand\nro@usbreak{\textunderscore\penalty0\hskip0pt\relax}
\lstset{basicstyle=\ttfamily\small, columns=fullflexible, keepspaces=true, frame=tb,
  rulecolor=\color{nro-pia}, framerule=0.4pt, numbers=left,
  numberstyle=\tiny\color{nro-cinza}, numbersep=6pt, breaklines=true, captionpos=t,
  xleftmargin=5mm, framexleftmargin=5mm, aboveskip=8pt, belowskip=8pt,
  keywordstyle=\bfseries, commentstyle=\color{nro-cinza}\itshape,
  stringstyle=\color{nro-axon}, showstringspaces=false, extendedchars=true}
\renewcommand\lstlistingname{Listagem}

%% ------------------------------------------------------------
%% 6. O QUE O DOCUMENTO SABE DE SI (do .aux): a estrutura de partes,
%%    níveis e tópicos, e os totais
%% ------------------------------------------------------------
\newcounter{nropt}\setcounter{nropt}{-1}   % partes: a primeira é a Parte 0
\newcounter{nrotp}                         % tópico dentro da parte
\newcounter{nrolv}                         % nível dentro da parte
\newcounter{nro@ntop}\newcounter{nro@nex}\newcounter{nro@npar}
\renewcommand\thenropt{\arabic{nropt}}
\renewcommand\thenrotp{\thenropt.\arabic{nrotp}}
\newcommand\iniciarpartes[1]{\setcounter{nropt}{\numexpr#1-1\relax}}  % a primeira parte passa a ser #1

\newcommand\nro@fichaitems{}
\newcommand\nro@fichaultima{-99}
%% \nro@regparte{n}{título}
\newcommand\nro@regparte[2]{\expandafter\gdef\csname nro@pt@#1\endcsname{#2}}
%% \nro@regnivel{parte}{índice}{nome}{descrição}
\newcommand\nro@regnivel[4]{%
  \expandafter\gdef\csname nro@lvn@#1@#2\endcsname{#3}%
  \expandafter\gdef\csname nro@lvd@#1@#2\endcsname{#4}}
%% \nro@reg{parte}{número}{nível}{título}: um tópico
\newcommand\nro@reg[4]{%
  \ifcsname nro@lvf@#1@#3\endcsname\else
    \expandafter\gdef\csname nro@lvf@#1@#3\endcsname{#2}\fi
  \expandafter\gdef\csname nro@lvl@#1@#3\endcsname{#2}%
  \ifcsname nro@lvc@#1@#3\endcsname
    \expandafter\xdef\csname nro@lvc@#1@#3\endcsname{\the\numexpr\csname nro@lvc@#1@#3\endcsname+1\relax}%
  \else\expandafter\gdef\csname nro@lvc@#1@#3\endcsname{1}\fi
  \ifnum\nro@fichaultima=#1 \else
    \xdef\nro@fichaultima{#1}%
    \g@addto@macro\nro@fichaitems{\nro@fichaparte{#1}}%
  \fi
  \g@addto@macro\nro@fichaitems{\nro@fichalinha{#2}{#3}{#4}{#1}}%
  \ifcsname nro@tpl@#1\endcsname\else\expandafter\gdef\csname nro@tpl@#1\endcsname{}\fi
  \expandafter\g@addto@macro\csname nro@tpl@#1\endcsname{\nro@tpitem{#2}{#4}}}
\newcommand\nro@totais[3]{\gdef\nro@t@partes{#1}\gdef\nro@t@topicos{#2}\gdef\nro@t@exercicios{#3}}
\newcommand\totalpartes{\ifdefined\nro@t@partes\nro@t@partes\else0\fi}
\newcommand\totaltopicos{\ifdefined\nro@t@topicos\nro@t@topicos\else0\fi}
\newcommand\totalexercicios{\ifdefined\nro@t@exercicios\nro@t@exercicios\else0\fi}
\AtEndDocument{\immediate\write\@auxout{\string\nro@totais{\arabic{nro@npar}}{\arabic{nro@ntop}}{\arabic{nro@nex}}}}

%% ------------------------------------------------------------
%% 7. A FOLHA: o cabeçalho e o rodapé do NRO-PUB-002, em posição fixa,
%%    alinhados à mancha de texto (22 mm). As capas desenham o próprio
%%    fundo. \nro@pagina diz que folha está sendo composta.
%% ------------------------------------------------------------
\pagestyle{empty}
\let\ps@plain\ps@empty
\def\nro@pagina{normal}
\newcommand\nro@logo[1]{nro/imagotipo-#1.png}
\AddToHook{shipout/background}{%
  \setlength\unitlength{1mm}%
  \normalfont\color{nro-tinta}%
  \nro@desenha}
\newcommand\nro@desenha{%
  \ifx\nro@pagina\nro@pg@capa\nro@fundocapa\gdef\nro@pagina{normal}\else
  \ifx\nro@pagina\nro@pg@parte\nro@fundoparte\gdef\nro@pagina{normal}\else
  \ifx\nro@pagina\nro@pg@contra\nro@fundocontra\gdef\nro@pagina{normal}\else
    \nro@cabecalho
  \fi\fi\fi}
\def\nro@pg@capa{capa}\def\nro@pg@parte{parte}\def\nro@pg@contra{contra}
\newcommand\nro@cabecalho{%
  % o cabeçalho do NRO-PUB-002: a logo à esquerda; o departamento, o título e o código à direita
  \put(22,-18.8){\includegraphics[height=8.6mm]{\nro@logo{preto}}}%
  \put(188,-12.6){\llap{\nro@cabfonte\bfseries\nro@corpo{9.5}\nro@emissor}}%
  \put(188,-16.8){\llap{\nro@cabfonte\nro@corpo{9.5}\nro@tituloheader}}%
  \put(188,-21){\llap{\nro@cabfonte\nro@corpo{9.5}\nro@codigo\ Rev.~\nro@revisao}}%
  % o rodapé: a linha, o código e a página
  \put(22,-286.6){{\color{nro-cab-linha}\rule{166mm}{0.2mm}}}%
  \put(22,-290){\nro@cabfonte\nro@corpo{7.2}\color{nro-cab-claro}\nro@codigo\ Rev.~\nro@revisao}%
  \put(188,-290){\llap{\nro@cabfonte\nro@corpo{7.2}\color{nro-cab-claro}Página \thepage\ de \pageref*{LastPage}}}}

%% ------------------------------------------------------------
%% 8. A ARTE: as ondas e a grade de pontos (Cortex, tons da própria
%%    família, transparência só nos tons do conjunto primário)
%% ------------------------------------------------------------
%% \nro@ondas{x0}{y0}{largura}{amplitude}{quantas}: um feixe de senoides que
%% se encontram nas pontas, na altura y0 (mm, de cima para baixo)
\newcommand\nro@ondas[5]{%
  \begin{tikzpicture}[overlay, x=1mm, y=-1mm]
    \foreach \k in {1,...,#5}{%
      \pgfmathsetmacro\nro@f{1.15+0.37*\k}%
      \pgfmathsetmacro\nro@p{53*\k}%
      \pgfmathsetmacro\nro@a{#4*(0.3+0.7*mod(\k*0.618,1))}%
      \pgfmathsetmacro\nro@o{0.28+0.5*mod(\k*0.377,1)}%
      \ifnum\k=4
        \draw[nro-synapse, line width=0.3pt, opacity=0.9]
      \else
        \draw[nro-cortex-medio, line width=0.22pt, opacity=\nro@o]
      \fi
        plot[domain=0:1, samples=160, smooth]
        ({#1+#3*\x}, {#2+\nro@a*sin(180*\x)*sin(360*\nro@f*\x+\nro@p)});
    }
  \end{tikzpicture}}
%% a grade de pontos de 9 por 5, em Axon
\newcommand\nro@pontos[2]{%
  \begin{tikzpicture}[overlay, x=1mm, y=-1mm]
    \foreach \i in {0,...,8}{\foreach \j in {0,...,4}{%
      \fill[nro-axon] ({#1+6.4*\i},{#2+6.4*\j}) circle (0.42);}}
  \end{tikzpicture}}

%% o fundo da capa: Cortex chapado, o feixe de ondas embaixo, a logo branca
\newcommand\nro@fundocapa{%
  \put(0,-297){\color{nro-cortex}\rule{210mm}{297mm}}%
  \put(0,0){\nro@pontos{140}{28}}%
  \put(0,0){\nro@ondas{0}{252}{210}{22}{14}}%
  \put(22,-31){\includegraphics[height=7.4mm]{\nro@logo{branco}}}%
  % o tipo do documento e o código, à direita, na mesma fonte e tamanho (regra de documento controlado)
  \put(188,-25){\llap{\nro@corpo{9}\color{nro-cortex-claro}\nro@tipo}}%
  \put(188,-30){\llap{\nro@corpo{9}\color{nro-cortex-claro}\nro@codigo}}%
  % o bloco de título: o emissor, o título em destaque, a síntese e a ficha do documento
  \put(22,-92){\parbox[t]{166mm}{\RaggedRight
    {\color{nro-synapse}\rule{15mm}{0.9mm}}\par\vspace{5.5mm}%
    {\nro@rotulofonte\nro@corpo{8.6}\color{nro-cortex-medio}\MakeUppercase{\nro@emissor}}\par\vspace{5mm}%
    {\nro@display\fontsize{44}{45}\selectfont\color{white}\hyphenpenalty=10000 \nro@titulo@doc\par}%
    \ifx\nro@subtitulo\@empty\else\vspace{7mm}%
      {\parbox{136mm}{\RaggedRight\nro@corpo{12}\linespread{1.2}\selectfont\color{nro-cortex-claro}\nro@subtitulo}}\par\fi
    \vspace{11mm}%
    {\color{nro-axon}\rule{166mm}{0.4pt}}\par\vspace{4mm}%
    \nro@capaficha{Autoria}{\nro@autor}\hfill
    \nro@capaficha{Data}{\nro@data}\hfill
    \nro@capaficha{Revisão}{\nro@revisao}}}}
\newcommand\nro@capaficha[2]{%
  \begin{minipage}[t]{52mm}\RaggedRight
    {\nro@corpo{8}\color{nro-cortex-medio}#1}\par\vspace{1mm}%
    {\nro@rotulomedio\nro@corpo{9.2}\color{white}#2}\par
  \end{minipage}}
%% o fundo da capa de parte: o campo Cortex em cima, com as ondas
\newcommand\nro@fundoparte{%
  \put(0,-118){\color{nro-cortex}\rule{210mm}{118mm}}%
  \put(0,-118.6){\color{nro-synapse}\rule{210mm}{0.6mm}}%
  \put(0,0){\nro@pontos{22}{20}}%
  \put(0,0){\nro@ondas{102}{34}{108}{20}{12}}}
%% o fundo da contracapa
\newcommand\nro@fundocontra{%
  \put(0,-297){\color{nro-cortex}\rule{210mm}{297mm}}%
  \put(0,0){\nro@ondas{0}{150}{210}{30}{14}}%
  \put(22,-31){\includegraphics[height=7.4mm]{\nro@logo{branco}}}%
  \put(188,-25){\llap{\nro@corpo{9}\color{nro-cortex-claro}\nro@tipo}}%
  \put(188,-30){\llap{\nro@corpo{9}\color{nro-cortex-claro}\nro@codigo}}}

%% ------------------------------------------------------------
%% 9. OS RÓTULOS E OS TÍTULOS
%% ------------------------------------------------------------
%% a capa: o fundo e o texto são desenhados na folha (seção 8)
\newcommand\capa{\clearpage\gdef\nro@pagina{capa}\thispagestyle{empty}\null\clearpage}
%% as fontes e os tamanhos, para quem escreve fora da classe
\newcommand\fonttitulo{\nro@titulo}
\newcommand\tamanho[1]{\nro@corpo{#1}}
%% o rótulo: Archivo 600, caixa alta, aberto
\newcommand\nro@rot[1]{{\nro@rotulofonte\nro@corpo{7.4}\MakeUppercase{#1}}}
\newcommand\rotulo[1]{\nro@rot{#1}}
\newcommand\nro@kicker[1]{\par\noindent{\color{nro-axon}\nro@rot{#1}}\par}
\newcommand\nro@regua{\par\vspace{5mm}\noindent{\color{nro-axon}\rule{14mm}{1.2mm}}\par\vspace{5mm}}
%% \pagina{rótulo}{Título}: folha nova, no sumário
\NewDocumentCommand\pagina{m m}{%
  \clearpage\phantomsection
  \addcontentsline{toc}{nropagina}{#2}%
  \nro@kicker{#1}\vspace{2.5mm}%
  {\nro@display\fontsize{29}{33}\selectfont\color{nro-cortex}\RaggedRight\hyphenpenalty=10000 #2\par}%
  \nro@regua}
\NewDocumentCommand\apendice{m}{\pagina{Apêndice}{#1}}
%% o parágrafo de abertura, maior
\newcommand\lede[1]{{\nro@corpo{12}\linespread{1.18}\selectfont\color{nro-cortex}#1\par}\vspace{1mm}}
%% títulos dentro de uma página (fora do sumário)
\newcommand\secao[1]{\par\Needspace{5\baselineskip}\vspace{5mm}{\nro@titulo\fontsize{14}{17}\selectfont\color{nro-cortex}\RaggedRight #1\par}\vspace{1.5mm}}
\newcommand\subsecao[1]{\par\Needspace{4\baselineskip}\vspace{3mm}{\nro@titulo\fontsize{11}{14}\selectfont\color{nro-tinta}\RaggedRight #1\par}\vspace{0.5mm}}

%% o sumário
\renewcommand\numberline[1]{\hb@xt@\@tempdima{\nro@titulo\color{nro-axon}\nro@corpo{8.4}#1\hfil}}
\renewcommand\@pnumwidth{9mm}
\renewcommand\@dotsep{2.2}
\newcommand\l@nropagina[2]{\par\addvspace{9pt plus 1pt}%
  {\parindent\z@ \rightskip\@tocrmarg \parfillskip-\rightskip \leavevmode
   {\nro@titulo\nro@corpo{11.4}\color{nro-cortex}#1}\nobreak\hfil
   \nobreak\hb@xt@\@pnumwidth{\hss{\nro@titulo\nro@corpo{10}\color{nro-axon}#2}}\par}}
\newcommand\l@nroparte[2]{\par\addvspace{11pt plus 2pt}%
  {\parindent\z@ \rightskip\@tocrmarg \parfillskip-\rightskip \leavevmode
   {\nro@titulo\nro@corpo{11.4}\color{nro-cortex}#1}\nobreak\hfil
   \nobreak\hb@xt@\@pnumwidth{\hss{\nro@titulo\nro@corpo{10}\color{nro-axon}#2}}\par}\addvspace{1pt}}
\newcommand\l@nrotopico[2]{{\nro@corpo{9}\color{nro-tinta}%
  \@dottedtocline{2}{0mm}{9mm}{#1}{{\nro@rotulomedio\color{nro-cinza}#2}}}}
\newcommand*\toclevel@nropagina{0}
\newcommand*\toclevel@nroparte{0}
\newcommand*\toclevel@nrotopico{1}
\renewcommand\@tocrmarg{12mm}
\newcommand\sumario{%
  \pagina{Conteúdo}{Sumário}%
  \vspace{-2mm}{\setlength\parskip{1.5pt}\@starttoc{toc}}}

%% ------------------------------------------------------------
%% 10. AS CAIXAS E OS BLOCOS DE UM TÓPICO
%% ------------------------------------------------------------
\tcbset{nro/base/.style={enhanced, frame hidden, boxrule=0pt, arc=0pt, outer arc=0pt,
  left=4.2mm, right=3.6mm, top=2.6mm, bottom=2.6mm, fontupper=\nro@corpo{9.3},
  before skip=7pt, after skip=8pt}}
%% o quadro de aplicação ao produto: Cortex claro, régua Axon à esquerda
\newtcolorbox{noproduto}{nro/base, colback=nro-cortex-claro, coltext=nro-tinta,
  borderline west={1.2mm}{0pt}{nro-axon}, before upper={\nro@rot{\nro@rotuloproduto}\par\vspace{1mm}\color{nro-axon}\color{nro-tinta}}}
%% uma nota neutra
\newtcolorbox{nota}[1][]{nro/base, colback=nro-pia-claro, coltext=nro-tinta,
  borderline west={1.2mm}{0pt}{nro-cinza}, before upper={\nro@rot{Nota}\par\vspace{1mm}}, #1}
%% o alerta: Cortex chapado, rótulo em Synapse (fundo escuro, texto branco)
\newtcolorbox{atencao}[1][Atenção]{nro/base, colback=nro-cortex, coltext=white,
  borderline west={1.2mm}{0pt}{nro-synapse},
  before upper={{\color{nro-synapse}\nro@rot{#1}}\par\vspace{1mm}}}
%% uma definição curta
\newtcolorbox{definicao}[1]{nro/base, colback=white, coltext=nro-tinta,
  frame hidden, borderline west={1.2mm}{0pt}{nro-cortex-medio},
  before upper={{\color{nro-axon}\nro@titulo\nro@corpo{10.2}#1}\par\vspace{0.6mm}}}
%% a ficha de um cartão (princípios, passos): régua Axon à esquerda, sem fundo
\newtcolorbox{nro@cartao}[1]{nro/base, colback=white, coltext=nro-texto2,
  borderline west={1.2mm}{0pt}{nro-axon}, before skip=3pt, after skip=3pt,
  before upper={{\color{nro-cortex}\nro@titulo\nro@corpo{10.4}#1}\par\vspace{0.8mm}}}
\newcommand\cartao[2]{\begin{nro@cartao}{#1}#2\end{nro@cartao}}
\NewDocumentEnvironment{cartoes}{O{2}}{%
  \begin{tcbraster}[raster columns=#1, raster equal height, raster column skip=4mm, raster row skip=2mm,
    raster before skip=2mm, raster after skip=2mm]}{\end{tcbraster}}
%% os números grandes (estatísticas): Cortex claro, número em Plex Mono (é dado)
\newlength\nro@stw
\NewDocumentEnvironment{estatisticas}{O{4}}{%
  \par\vspace{2mm}\noindent
  \setlength\nro@stw{\dimexpr(\linewidth-3mm*(#1-1))/#1-2\fboxsep\relax}}{\par\vspace{2mm}}
\newcommand\estatistica[2]{%
  \colorbox{nro-cortex-claro}{\parbox[c][22mm][c]{\nro@stw}{\centering
    {\ttfamily\bfseries\fontsize{25}{27}\selectfont\color{nro-axon}#1}\par\vspace{1.4mm}%
    {\color{nro-cinza}\nro@rot{#2}}}}\hfill}
%% o rótulo de um bloco (PARA ESTUDAR, PRATIQUE)
\newcommand\nro@rotbloco[1]{\par\Needspace{4\baselineskip}\vspace{3pt}{\color{nro-axon}\nro@rot{#1}}\par\vspace{1pt}\nopagebreak}
%% PARA ESTUDAR: um marcador "›" em Axon; \leitura é o link
\newlist{nro@estudar}{itemize}{1}
\setlist[nro@estudar]{label={\textcolor{nro-axon}{\nro@rotulomedio ›}}, leftmargin=5mm, itemsep=1.4pt, topsep=1pt, parsep=0pt}
\NewDocumentEnvironment{paraestudar}{}{\nro@rotbloco{Para estudar}\begin{nro@estudar}\nro@corpo{9.3}}{\end{nro@estudar}}
\NewDocumentCommand\leitura{m m}{\href{#1}{\color{nro-axon}\uline{#2}}}
%% PRATIQUE: os exercícios, numerados em Axon e contados para o total
\newif\ifnro@contar\nro@contartrue
%% \naocontarexercicios: os exercícios seguintes (de um modelo, por exemplo) não entram no total
\newcommand\naocontarexercicios{\nro@contarfalse}
\newlist{nro@pratique}{enumerate}{1}
\setlist[nro@pratique]{label={\nro@rotulomedio\color{nro-axon}\thenrotp.\arabic*}, leftmargin=10mm, itemsep=2pt, topsep=1pt, parsep=0pt}
\NewDocumentEnvironment{pratique}{}{\nro@rotbloco{Pratique}\begin{nro@pratique}\nro@corpo{9.3}}
  {\ifnro@contar\addtocounter{nro@nex}{\value{nro@pratiquei}}\fi\end{nro@pratique}\vspace{4pt}}
%% VOCÊ VAI APRENDER A: os objetivos, com ✓
\newlist{nro@aprender}{itemize}{1}
\setlist[nro@aprender]{label={\textcolor{nro-axon}{\ttfamily ✓}}, leftmargin=6mm, itemsep=2pt, topsep=2pt, parsep=0pt}
\NewDocumentEnvironment{aprender}{}{\nro@rotbloco{Você vai aprender a}\begin{nro@aprender}\nro@corpo{10}}{\end{nro@aprender}}

%% ------------------------------------------------------------
%% 11. PARTE, NÍVEL E TÓPICO
%% ------------------------------------------------------------
%% \begin{parte}{Título}{abertura} \item objetivo ... \end{parte}: a folha de abertura
%% da parte; no fim entram sozinhos os níveis (se houver) ou a lista dos tópicos
\NewDocumentEnvironment{parte}{m m}{%
  \clearpage
  \stepcounter{nropt}\stepcounter{nro@npar}%
  \setcounter{nrotp}{0}\setcounter{nrolv}{0}%
  \phantomsection
  \addcontentsline{toc}{nroparte}{Parte \thenropt: #1}%
  \protected@write\@auxout{}{\string\nro@regparte{\thenropt}{\unexpanded{#1}}}%
  \gdef\nro@pagina{parte}%
  \vspace*{2mm}%
  \begin{minipage}[t][60mm][b]{\linewidth}\RaggedRight
    {\color{nro-synapse}\nro@rot{Parte \ifnum\thenropt<10 0\fi\thenropt}}\par\vspace{4mm}%
    {\nro@display\fontsize{36}{39}\selectfont\color{white}\hyphenpenalty=10000 #1\par}\vspace{4mm}%
    {\parbox{138mm}{\RaggedRight\nro@corpo{11}\linespread{1.15}\selectfont\color{nro-cortex-claro}#2}}%
  \end{minipage}\par\vspace{17mm}
  \color{nro-tinta}%
  \begin{aprender}}
 {\end{aprender}\nro@partecorpo\clearpage}
\newlength\nro@cw
\newcommand\nro@partecorpo{%
  \setlength\nro@cw{\dimexpr(\linewidth-8mm)/3-2\fboxsep\relax}%
  \ifcsname nro@lvn@\thenropt @1\endcsname
    \nro@rotbloco{A trilha em três níveis}\vspace{1mm}%
    \noindent\nro@cartaonivel{1}\hfill\nro@cartaonivel{2}\hfill\nro@cartaonivel{3}\par
  \else
    \ifcsname nro@tpl@\thenropt\endcsname
      \nro@rotbloco{Tópicos desta parte}\vspace{1mm}%
      \nro@listatopicos
    \fi
  \fi}
\newcommand\nro@tpitem[2]{{\color{nro-axon}\nro@titulo\nro@corpo{8.8}#1}\hspace{1.2mm}{\nro@corpo{9}#2}\par\vspace{2.2mm}}
\newcommand\nro@listatopicos{%
  \colorbox{nro-cortex-claro}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\vspace{2mm}%
    \hspace{3mm}\begin{minipage}[t]{\dimexpr0.5\linewidth-9mm\relax}\RaggedRight
      \csname nro@tpl@\thenropt\endcsname
    \end{minipage}\vspace{1mm}}}}
\newcommand\nro@cartaonivel[1]{%
  \ifcase#1\or\def\nro@fundo{nro-cortex-claro}\def\nro@frente{nro-tinta}\def\nro@mini{nro-axon}%
          \or\def\nro@fundo{nro-cortex-medio}\def\nro@frente{nro-cortex}\def\nro@mini{nro-cortex}%
          \or\def\nro@fundo{nro-axon}\def\nro@frente{white}\def\nro@mini{nro-cortex-claro}\fi
  \ifcsname nro@lvn@\thenropt @#1\endcsname
    \colorbox{\nro@fundo}{\parbox[t][33mm][t]{\nro@cw}{\RaggedRight\color{\nro@frente}\vspace{2.6mm}%
      \hspace{3mm}\begin{minipage}[t]{\dimexpr\nro@cw-6mm\relax}\RaggedRight
        {\nro@titulo\nro@corpo{12}\csname nro@lvn@\thenropt @#1\endcsname}\par\vspace{1mm}%
        {\color{\nro@mini}\nro@corpo{8}\nro@faixa{\thenropt}{#1}}\par\vspace{1.6mm}%
        {\nro@corpo{8.6}\csname nro@lvd@\thenropt @#1\endcsname}%
      \end{minipage}}}%
  \fi}
%% "1.1 a 1.5, 5 tópicos" (da compilação anterior)
\newcommand\nro@faixa[2]{%
  \ifcsname nro@lvf@#1@#2\endcsname
    \csname nro@lvf@#1@#2\endcsname\ a \csname nro@lvl@#1@#2\endcsname,
    \csname nro@lvc@#1@#2\endcsname\ tópicos
  \fi}

%% \nivel{Básico}{descrição}: a faixa que abre cada nível, em folha nova
\NewDocumentCommand\nivel{m m}{%
  \clearpage
  \stepcounter{nrolv}%
  \protected@write\@auxout{}{\string\nro@regnivel{\thenropt}{\thenrolv}{\unexpanded{#1}}{\unexpanded{#2}}}%
  \noindent\colorbox{nro-cortex}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\vspace{2mm}%
    \hspace{2.6mm}{\color{white}\nro@rot{Nível #1}}\hspace{4mm}%
    {\color{nro-cortex-medio}\nro@corpo{8.6}\nro@faixa{\thenropt}{\thenrolv}}\vspace{2.2mm}}}\par
  \vspace{1.2mm}{\nro@corpo{9.2}\itshape\color{nro-cinza}#2\par}\vspace{2mm}}

%% \topico{Título}: a numeração é automática (parte.ordem); a régua em cima separa os tópicos
\NewDocumentCommand\topico{m}{%
  \par\Needspace{9\baselineskip}\vspace{4mm}%
  \stepcounter{nrotp}\stepcounter{nro@ntop}%
  \phantomsection
  \addcontentsline{toc}{nrotopico}{\protect\numberline{\thenrotp}#1}%
  \protected@write\@auxout{}{\string\nro@reg{\thenropt}{\thenrotp}{\thenrolv}{\unexpanded{#1}}}%
  \noindent{\color{nro-pia}\rule{\linewidth}{0.4pt}}\par\vspace{4mm}%
  {\nro@titulo\fontsize{14}{17}\selectfont\RaggedRight\color{nro-axon}\thenrotp\hspace{2mm}\color{nro-tinta}#1\par}\vspace{1mm}}

%% ------------------------------------------------------------
%% 12. AS TABELAS: o DataTable do design system. Régua de cima e de
%%     baixo na cor do texto, régua fina sob o cabeçalho, linhas finas
%%     claras entre as linhas, sem colunas riscadas e sem zebra.
%% ------------------------------------------------------------
\setlength\arrayrulewidth{0.35pt}
\arrayrulecolor{nro-tinta}
\setlength\tabcolsep{1.8mm}
\renewcommand\arraystretch{1.3}
\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcommand\reguatopo{\specialrule{0.7pt}{0pt}{0pt}}
\newcommand\reguameio{\specialrule{0.4pt}{0pt}{0pt}}
\newcommand\reguafina{\arrayrulecolor{nro-regua}\specialrule{0.35pt}{0pt}{0pt}\arrayrulecolor{nro-tinta}}
\newcommand\reguabase{\specialrule{0.7pt}{-0.35pt}{0pt}}
%% o cabeçalho de uma coluna: rótulo em Archivo, caixa alta, cinza
\newcommand\cab[1]{\leavevmode{\nro@rotulofonte\nro@corpo{7.2}\color{nro-cinza}\hyphenpenalty=10000 \MakeUppercase{#1}}}
%% a célula de rótulo de uma ficha (rótulo | valor)
\newcommand\celrot{\leavevmode\nro@rotulomedio\nro@corpo{8.4}\color{nro-cinza}}
%% o dado que falta: um traço claro (nunca um espaço em branco)
\newcommand\vazio{\textcolor{nro-pia}{\rule[0.6ex]{3mm}{0.4pt}}}
%% a fonte de uma figura ou tabela (ABNT)
\newcommand\fonte[1]{\par\vspace{-2pt}{\RaggedRight\nro@corpo{8.4}\color{nro-cinza}Fonte: #1\par}}

%% ------------------------------------------------------------
%% 13. O DIAGRAMA: os estilos de TikZ da marca, para mapas e cadeias
%% ------------------------------------------------------------
\tikzset{
  nro bloco/.style={rounded corners=0pt, fill=nro-cortex, text=white, align=left, inner sep=3.2mm,
    font=\nro@titulo\nro@corpo{10}},
  nro claro/.style={fill=nro-cortex-claro, text=nro-tinta, align=center, inner sep=2.4mm,
    font=\nro@corpo{8.8}},
  nro medio/.style={fill=nro-cortex-medio, text=nro-cortex, align=center, inner sep=2.4mm,
    font=\nro@corpo{8.8}},
  nro forte/.style={fill=nro-axon, text=white, align=center, inner sep=2.4mm,
    font=\nro@corpo{8.8}},
  nro moldura/.style={draw=nro-pia, line width=0.5pt, inner sep=0pt},
  nro seta/.style={-{Latex[length=1.8mm,width=1.4mm]}, line width=0.7pt, draw=nro-axon},
  nro ponte/.style={dash pattern=on 3pt off 2.2pt, line width=0.7pt, draw=nro-cortex-medio},
  nro rotulo/.style={font=\nro@corpo{7.8}\color{nro-axon}, text=nro-axon},
}

%% ------------------------------------------------------------
%% 14. O QUE FECHA O DOCUMENTO: glossário, ficha de progresso, controle,
%%     histórico de revisões e contracapa
%% ------------------------------------------------------------
\NewDocumentCommand\termo{m +m}{\nro@titulo\nro@corpo{9}#1 & \RaggedRight\nro@corpo{9}#2 \\ \reguafina}
\NewDocumentEnvironment{glossario}{}{%
  \par\begingroup\renewcommand\arraystretch{1.35}%
  \begin{longtable}{@{}L{34mm}L{\dimexpr\linewidth-34mm-4\tabcolsep\relax}@{}}\reguatopo
    \cab{Termo} & \cab{Significado} \\ \reguameio \endhead}
 {\reguabase\end{longtable}\endgroup}
%% a ficha de progresso: uma linha por tópico, montada do .aux
\newcommand\nro@caixa{\raisebox{-0.5mm}{\fbox{\rule{0pt}{2.6mm}\rule{2.6mm}{0pt}}}}
\newcommand\nro@fichaparte[1]{%
  \multicolumn{5}{@{}l}{\rule{0pt}{7mm}{\nro@titulo\nro@corpo{10.5}\color{nro-cortex}Parte #1: \csname nro@pt@#1\endcsname}} \\ \reguatopo
  \cab{} & \cab{Nº} & \cab{Tópico} & \cab{Nível} & \cab{Concluído em} \\ \reguameio}
\newcommand\nro@fichalinha[4]{%
  \nro@caixa & {\nro@titulo\color{nro-axon}\nro@corpo{9}#1} & \nro@corpo{9}#3 &
  \nro@corpo{9}\ifcsname nro@lvn@#4@#2\endcsname\csname nro@lvn@#4@#2\endcsname\else Comum\fi &
  {\nro@rotulomedio\nro@corpo{9}\color{nro-cinza}\_\_\_\_/\_\_\_\_/\_\_\_\_\_\_} \\ \reguafina}
\NewDocumentCommand\fichaprogresso{}{%
  \par\begingroup\renewcommand\arraystretch{1.5}%
  \begin{xltabular}{\linewidth}{@{}C{8mm}L{12mm}Y L{22mm}L{30mm}@{}}
    \nro@fichaitems
  \end{xltabular}\endgroup}
%% os dados de controle do documento (NRO-PUB-001/002)
\newcommand\nro@valorficha[1]{\ifx#1\@empty\textcolor{nro-pia}{a preencher}\else#1\fi}
\newcommand\controledocumento{%
  \par\begingroup\nro@corpo{9.3}\renewcommand\arraystretch{1.5}%
  \noindent\begin{tabularx}{\linewidth}{@{}>{\celrot}p{38mm}Y@{}}\reguatopo
    Código & \cod{\nro@codigo} \\ \reguafina
    Revisão & \nro@revisao \\ \reguafina
    Departamento emissor & \nro@emissor \\ \reguafina
    Tipo & \nro@tipo \\ \reguafina
    Data & \nro@valorficha\nro@data \\ \reguafina
    Redator & \nro@valorficha\nro@redator \\ \reguafina
    Revisor & \nro@valorficha\nro@revisor \\ \reguafina
    Aprovador & \nro@valorficha\nro@aprovador \\ \reguabase
  \end{tabularx}\endgroup\par}
%% o histórico de revisões: \linharevisao{data}{rev}{responsável}{mudanças}
\newcommand\linharevisao[4]{\cod{#1} & #2 & #3 & #4 \\ \reguafina}
\NewDocumentEnvironment{historico}{}{%
  \par\begingroup\nro@corpo{9}\renewcommand\arraystretch{1.4}%
  \begin{longtable}{@{}L{24mm}L{10mm}L{42mm}L{\dimexpr\linewidth-76mm-8\tabcolsep\relax}@{}}\reguatopo
    \cab{Data} & \cab{Rev.} & \cab{Responsável} & \cab{Mudanças} \\ \reguameio \endhead}
 {\reguabase\end{longtable}\endgroup}
%% a contracapa
\NewDocumentCommand\contracapa{m}{%
  \clearpage\gdef\nro@pagina{contra}\thispagestyle{empty}%
  \vspace*{58mm}\noindent
  {\color{nro-synapse}\rule{15mm}{0.9mm}}\par\vspace{6mm}%
  {\nro@display\fontsize{26}{29}\selectfont\color{white}\nro@equipe\par}\vspace{3mm}%
  \parbox{128mm}{\RaggedRight\nro@corpo{11.2}\linespread{1.2}\selectfont\color{nro-cortex-claro}#1}\par
  \clearpage}

\endinput
