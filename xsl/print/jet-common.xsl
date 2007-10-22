<?xml version="1.0" encoding="koi8-r"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="../db2latex/xsl/docbook-alt.xsl"/>
  <xsl:variable name="latex.math.support">1</xsl:variable>
  <xsl:variable name="latex.use.ltxtable">1</xsl:variable>
  <xsl:param name="latex.use.fancyvrb" select="'1'"/>
  <xsl:param name="latex.use.hyperref" select="'1'"/>
  <xsl:param name="latex.hyperref.param.common"
	     select="'unicode,colorlinks=true,a4paper'"/>
  <xsl:param name="ulink.footnotes">1</xsl:param>
  <xsl:variable name="latex.use.fancyhdr">0</xsl:variable>
  <xsl:variable name="latex.use.fancybox">1</xsl:variable>
  <xsl:variable name="latex.admonition.path"></xsl:variable>
  <xsl:param name="latex.documentclass.book">12pt</xsl:param>
  <xsl:variable name="latex.hyphenation.tttricks">1</xsl:variable>
  <xsl:param name="latex.document.font">default</xsl:param>

  <!-- Отключаем ruler'ы вокруг таблиц и картинок -->  
  <xsl:template name="latex.float.preamble" />

  <!-- чтобы не перекрывало установки пакета geometry -->  
  <xsl:variable name="latex.book.varsets">
  </xsl:variable>
  
  <xsl:variable name="latex.book.preamblestart">
    <xsl:text>\ifx\pdfoutput\undefined</xsl:text>
    <xsl:text>\documentclass[</xsl:text>
    <xsl:value-of select="$latex.documentclass.common"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="$latex.documentclass.book"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="$latex.documentclass.pdftex"/>
    <xsl:text>]{</xsl:text>
    <xsl:choose>
      <xsl:when test="$latex.documentclass!=''"><xsl:value-of select="$latex.documentclass"/></xsl:when>
      <xsl:otherwise><xsl:text>book</xsl:text></xsl:otherwise>
    </xsl:choose>
    <xsl:text>}
    </xsl:text>
    <xsl:text>\else
    </xsl:text>
    <xsl:text>\documentclass[pdftex,</xsl:text>
    <xsl:value-of select="$latex.documentclass.common"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="$latex.documentclass.book"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="$latex.documentclass.dvips"/>
    <xsl:text>]{</xsl:text>
    <xsl:choose>
      <xsl:when test="$latex.documentclass!=''"><xsl:value-of select="$latex.documentclass"/></xsl:when>
      <xsl:otherwise><xsl:text>book</xsl:text></xsl:otherwise>
    </xsl:choose>
    <xsl:text>}
    </xsl:text>
    <xsl:text>
      \fi
      \usepackage[a4paper,hmargin={3cm,2cm},vmargin={3cm,2.5cm},twoside]{geometry}
      \usepackage{longtable,citehack,enumerate}
    </xsl:text>
    <xsl:choose>
      <xsl:when test="$unicode.mapping.languages='ru'">
      <xsl:text>\usepackage{indentfirst}</xsl:text></xsl:when>
    </xsl:choose>

    <!-- Сделать еще исправлений, чтобы в английской версии отступа у
	 параграфов не было, но разгон между параграфами был больше -->
    <xsl:text>
      %\usepackage{example}
      \usepackage{footnpag}
      \usepackage{fancyhdr}
      \pagestyle{fancy}
      \fancyhf{}
      \fancyhead[RE]{{\small\slshape \leftmark}}
      \fancyhead[LO]{{\small\slshape \rightmark}}
      \fancyhead[LE,RO]{\thepage}
      %\fancyfoot[RE,LO]{\textit{\small\copyright\; ``Инфосистемы Джет'', \number\year}}
      \fancyfoot[C]{}
      \renewcommand{\headrulewidth}{0.2pt}
      \renewcommand{\footrulewidth}{0pt}
      
      %\parsep 0pt plus 1pt
      %\itemsep 0pt plus 1pt
    </xsl:text>

    <xsl:choose>
      <xsl:when test="$unicode.mapping.languages='ru'">
	<xsl:text>
	  % оформление подписей под плавающими объектами
	  \usepackage{caption2}
	  %\captionstyle{indent}%
	  \renewcommand\captionfont{\normalsize}%
	  %\setcaptionmargin{\leftmargin}
	  %\setlength\captionindent{\parindent}
	  \renewcommand\captionlabeldelim{.}
	  \onelinecaptionstrue
      </xsl:text></xsl:when>
    </xsl:choose>
    
    <xsl:text>
      \renewcommand{\topfraction}{.9}
      \renewcommand{\textfraction}{.1}
      \renewcommand{\bottomfraction}{.9}
      \renewcommand{\floatpagefraction}{.9}
      %\renewcommand{\dblfloatpagefraction}{\floatpagefraction}
      \setcounter{topnumber}{4}
      \setcounter{bottomnumber}{4}
      \setcounter{totalnumber}{4}
      \setlength{\floatsep}{8pt plus 2pt minus 2pt}
      \setlength{\textfloatsep}{8pt plus 2pt minus 2pt}
      \setlength{\intextsep}{6pt plus 2pt minus 2pt}
    </xsl:text>
  </xsl:variable>

  <xsl:template match="book/title" mode="maketitle.mode">
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="book/subtitle" mode="maketitle.mode">
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:variable name="latex.maketitle">
    <xsl:text>
      \thispagestyle{empty}
      \begin{titlepage}
      \rule{0pt}{1cm}
      \vspace{25mm}
      \begin{flushright}
      \par{\sffamily\textsl{\textbf{\Huge\booktitle\rule{0pt}{1cm}}}}
      \end{flushright}
      \vspace{30mm}
      \begin{center}
      \par{\sffamily\LARGE\booksubtitle}
      \end{center}
      %    \vfill
      %    \begin{center}
      %    \textbf{\copyright\; ``Инфосистемы Джет'', \number\year}
      %    \end{center}
      \end{titlepage}
      \clearpage
      \thispagestyle{empty}
      \rule{0pt}{1cm}
      %    \vfill
      %    {\textbf выходные данные и авторы?}
      \clearpage
    </xsl:text>
  </xsl:variable>
  <xsl:param name="latex.document.font">times</xsl:param>
  
  <xsl:variable name="latex.book.begin.document">
    \begin{document}
    \frenchspacing%
    \righthyphenmin=2%
    \sloppy%
  </xsl:variable>
</xsl:stylesheet>
