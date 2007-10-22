<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
[
<!ENTITY % iso-cyr1 PUBLIC "ISO 8879:1986//ENTITIES Russian Cyrillic//EN//XML"
                           "http://www.oasis-open.org/docbook/xmlcharent/0.3/iso-cyr1.ent">
%iso-cyr1;
<!ENTITY % iso-num PUBLIC "ISO 8879:1986//ENTITIES Numeric and Special Graphic//EN//XML"
                           "http://www.oasis-open.org/docbook/xmlcharent/0.3/iso-num.ent">
%iso-num;
]>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:w='http://schemas.microsoft.com/office/word/2003/wordml'
  xmlns:v='urn:schemas-microsoft-com:vml'
  xmlns:w10="urn:schemas-microsoft-com:office:word"
  xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
  xmlns:wx='http://schemas.microsoft.com/office/word/2003/auxHint'
  xmlns:o="urn:schemas-microsoft-com:office:office"
  xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
  xmlns:sl='http://schemas.microsoft.com/schemaLibrary/2003/core'
  xmlns:doc='http://www.oasis-open.org/docbook/xml/4.0'
  exclude-result-prefixes='doc'>

  <!-- 
       ******************************************************************** 
       (c) 2007 Ruslan Popov <radz@yandex.ru> DocBook XML -> WordML XML
       ********************************************************************
       $Id$
       ******************************************************************** 
       -->

  <xsl:output method="xml" indent='yes' standalone='yes' encoding='UTF-8'/>

  <doc:reference xmlns=''>
    <referenceinfo>
      <releaseinfo role='meta'>
        $Id$
      </releaseinfo>
      <author>
        <surname>Popov</surname>
        <firstname>Ruslan</firstname>
      </author>
      <copyright>
        <year>2007</year>
        <holder>Ruslan Popov</holder>
      </copyright>
      <revhistory>
        <revision>
          <revnumber>0.1</revnumber>
          <date>2007-09-25</date>
          <authorinitials>PRA</authorinitials>
          <revremark>
            <para>Initial version.</para>
          </revremark>
        </revision>
      </revhistory>
    </referenceinfo>

    <title>WordML Generation</title>

    <para>
      This stylesheet produces a WordML document from a DocBook source
      document.
    </para>

    <para>
      This stylesheet is based on Steve Ball's stylesheet.
    </para>

    <para>
      The "template" parameter specifies a WordML document to use as a
      template for the generated document.  The template is used to
      define the paragraph and character styles used by the generated
      document.  Any content in the template document is
      ignored.
    </para>
  </doc:reference>

  <xsl:param name='template'/>
  <xsl:variable name='templatedoc' select='document($template)'/>

  <xsl:template match="/">

    <xsl:if test='not($template)'>
      <xsl:message terminate='yes'>
	Please specify the template document with the "template"
	parameter
      </xsl:message>
    </xsl:if>
    <xsl:if test='not($templatedoc)'>
      <xsl:message terminate='yes'>
	Unable to open template document
      </xsl:message>
    </xsl:if>

    <xsl:processing-instruction name='mso-application'>
      <xsl:text>progid="Word.Document"</xsl:text>
    </xsl:processing-instruction>
    <xsl:text>
    </xsl:text>

    <xsl:variable name='info' select='book/bookinfo|article/articleinfo'/>
    <xsl:variable name='authors' select='$info/author|$info/authorinitials|$info/authorgroup/author|$info/authorgroup/editor'/>

    <w:wordDocument w:macrosPresent="no" w:embeddedObjPresent="no" w:ocxPresent="no">
      <xsl:attribute name='xml:space'>preserve</xsl:attribute>

      <o:DocumentProperties>
	<o:Author>
          <xsl:choose>
            <xsl:when test='$authors'>
              <xsl:apply-templates select='$authors[1]' mode='docprop.author'/>
	    </xsl:when>
	    <xsl:otherwise>Unknown</xsl:otherwise>
	  </xsl:choose>
	</o:Author>
	<o:LastAuthor>
          <xsl:choose>
            <xsl:when test='$info/revhistory/revision[1]/*[self::author|self::authorinitials]'>
	      <xsl:apply-templates select='$info/revhistory/revision[1]/*[self::author|self::authorinitials]' mode='docprop.author'/>
	    </xsl:when>
	    <xsl:when test='$authors'>
              <xsl:apply-templates select='$authors[1]' mode='docprop.author'/>
            </xsl:when>
            <xsl:otherwise>Unknown</xsl:otherwise>
          </xsl:choose>
        </o:LastAuthor>
	<o:Revision>
          <xsl:choose>
            <xsl:when test='$info/revhistory/revision[1]/revnumber'>
              <xsl:value-of select='$info/revhistory/revision[1]/revnumber'/>
            </xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
        </o:Revision>
        <o:TotalTime></o:TotalTime>

        <!-- dummy values -->
        <o:Created>2004-01-01T07:07:00Z</o:Created>
        <o:LastSaved>2004-01-01T08:08:00Z</o:LastSaved>

        <o:Pages>1</o:Pages>
        <o:Words>1</o:Words>
        <o:Characters>1</o:Characters>

        <!-- could derive this from author -->
        <o:Company>DocBook</o:Company>

        <o:Lines>1</o:Lines>
        <o:Paragraphs>1</o:Paragraphs>
        <o:CharactersWithSpaces>1</o:CharactersWithSpaces>
        <o:Version>11.6113</o:Version>
      </o:DocumentProperties>

      <!-- copy word document properties from template document -->
      <xsl:apply-templates select='$templatedoc/w:wordDocument/o:CustomDocumentProperties|$templatedoc/w:wordDocument/w:fonts|$templatedoc/w:wordDocument/w:lists|$templatedoc/w:wordDocument/w:styles' mode='copy'/>

      <w:docPr>
        <w:view w:val="print"/>
        <w:zoom w:percent="100"/>
        <w:doNotEmbedSystemFonts/>
        <w:attachedTemplate w:val=""/>
        <w:defaultTabStop w:val="720"/>
        <w:autoHyphenation/>
        <w:hyphenationZone w:val="357"/>
        <w:doNotHyphenateCaps/>
        <w:evenAndOddHeaders/>
        <w:characterSpacingControl w:val="DontCompress"/>
        <w:optimizeForBrowser/>
        <w:validateAgainstSchema/>
        <w:saveInvalidXML w:val="off"/>
        <w:ignoreMixedContent w:val="off"/>
        <w:alwaysShowPlaceholderText w:val="off"/>
        <w:footnotePr>
          <w:footnote w:type="separator">
            <w:p>
              <w:r>
                <w:separator/>
              </w:r>
            </w:p>
          </w:footnote>
          <w:footnote w:type="continuation-separator">
            <w:p>
              <w:r>
                <w:continuationSeparator/>
              </w:r>
            </w:p>
          </w:footnote>
        </w:footnotePr>
        <w:endnotePr>
          <w:endnote w:type="separator">
            <w:p>
              <w:r>
                <w:separator/>
              </w:r>
            </w:p>
          </w:endnote>
          <w:endnote w:type="continuation-separator">
            <w:p>
              <w:r>
                <w:continuationSeparator/>
              </w:r>
            </w:p>
          </w:endnote>
        </w:endnotePr>
        <w:compat>
          <w:breakWrappedTables/>
          <w:snapToGridInCell/>
          <w:wrapTextWithPunct/>
          <w:useAsianBreakRules/>
          <w:useWord2002TableStyleRules/>
        </w:compat>
        <w:docVars>
        </w:docVars>
      </w:docPr>

      <xsl:apply-templates/>

    </w:wordDocument>
  </xsl:template>

  <!-- копирование узлов из документа-шаблона -->
  <xsl:template match='*' mode='copy'>
    <xsl:copy>
      <xsl:for-each select='@*'>
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates mode='copy'/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='author|editor' mode='docprop.author'>
    <xsl:apply-templates select='firstname|personname/firstname' mode='docprop.author'/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select='surname|personname/surname' mode='docprop.author'/>
  </xsl:template>

  <xsl:template match='firstname|personname/firstname' mode='docprop.author'>
    <xsl:value-of select="."/>
  </xsl:template>
  
  <xsl:template match='authorinitials' mode='docprop.author'>
    <xsl:value-of select='.'/>
  </xsl:template>

  <xsl:template match='book|article'>
    <w:body>
      <xsl:apply-templates/>
    </w:body>
  </xsl:template>

  <!-- обработка дополнительного названия, обычно встречается в теге book -->
  <xsl:template match='subtitle'>
    <w:p>
      <w:pPr><w:pStyle w:val="a"/></w:pPr>
      <w:r><w:t><xsl:value-of select="."/></w:t></w:r>
    </w:p>
  </xsl:template>

  <!-- это пока игнорируем -->
  <xsl:template match="bookinfo"/>
  <xsl:template match="chapterinfo"/>

  <xsl:template match='chapter'>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- обработка заголовков -->
  <xsl:template match='title'>
    <xsl:choose>
      <xsl:when test="parent::book or parent::article">
	<w:p>
	  <w:pPr><w:pStyle w:val="a4"/></w:pPr>
	  <w:r><w:t><xsl:value-of select="."/></w:t></w:r>
	</w:p>
      </xsl:when>
      <xsl:when test="parent::chapter">
	<w:p>
	  <w:pPr><w:pStyle w:val="1"/></w:pPr>
	  <w:r><w:t><xsl:value-of select="."/></w:t></w:r>
	</w:p>
      </xsl:when>
      <xsl:when test="parent::section">
	<xsl:variable name="level" select="count(ancestor::section)+1"/>
	<xsl:variable name="style-for-section">
	  <xsl:choose>
	    <xsl:when test='$level&lt;5'>
	      <xsl:value-of select="$level"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:message>DocBook to WordML: recursive section &gt; 4 not supported, using level 4.</xsl:message>
	      <xsl:text>4</xsl:text>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	<w:p>
	  <w:pPr>
	    <w:pStyle>
	      <xsl:attribute name="w:val">
		<xsl:value-of select="$style-for-section"/>
	      </xsl:attribute>
	    </w:pStyle>
	  </w:pPr>
	  <w:r><w:t><xsl:value-of select="."/></w:t></w:r>
	</w:p>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="productname">
    <w:r>
      <w:t>
        <xsl:apply-templates/>
      </w:t>
    </w:r>
  </xsl:template>

  <xsl:template match='section'>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- обработка абзацев -->
  <xsl:template match='para'>
    <xsl:choose>
      <xsl:when test="para/figure">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="a"/>
          </w:pPr>
          <xsl:apply-templates/>
        </w:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- обработка текстовых узлов тега para -->
  <xsl:template match='para/text()[string-length(normalize-space(.)) != 0]'>
    <w:r>
      <w:t>
        <!-- здесь идёт нормализация пробелов -->
        <xsl:value-of select='normalize-space(.)'/>
        <!--
        <xsl:call-template name="spaces">
          <xsl:with-param name="value" select="."/>
        </xsl:call-template>
        -->
      </w:t>
    </w:r>
  </xsl:template>

  <xsl:template match='emphasis'>
    <w:r>
      <w:rPr>
          <w:b/>
      </w:rPr>
      <w:t><xsl:value-of select='.'/></w:t>
    </w:r>
  </xsl:template>

  <xsl:template match='screen'>
    <xsl:call-template name="verbatim">
      <xsl:with-param name="text" select="text()"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="verbatim">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="$text = ''"/>
      <xsl:when test="contains($text, '&#10;')">
        <w:p>
          <w:pPr>
            <w:pStyle w:val="a3"/>
          </w:pPr>
          <w:r>
            <w:t><xsl:value-of select="substring-before($text, '&#10;')"/></w:t>
          </w:r>
        </w:p>
	<xsl:call-template name="verbatim">
	  <xsl:with-param name="text" select="substring-after($text, '&#10;')"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="a3"/>
          </w:pPr>
          <w:r><w:t><xsl:value-of select="$text"/></w:t></w:r>
        </w:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- шаблон для обработки кавычек -->
  <xsl:template match="quote">
    <!-- этот код определяет надо ли вставлять пробел перед открывающей кавычкой -->
    <xsl:variable name="beforetpl">
      <xsl:call-template name="needspacebefore">
        <xsl:with-param name="value" select="preceding-sibling::node()"/>
      </xsl:call-template>
    </xsl:variable>
    <!-- этот код определяет надо ли вставлять пробел после закрывающей кавычки -->
    <xsl:variable name="aftertpl">
      <xsl:call-template name="needspaceafter">
        <xsl:with-param name="value" select="following-sibling::node()"/>
      </xsl:call-template>
    </xsl:variable>
    <!-- собственно вывод кавычек -->
    <w:r>
      <w:t>
        <xsl:variable name="text">
          <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:value-of select="concat($beforetpl,'&laquo;',$text,'&raquo;',$aftertpl)"/>
      </w:t>
    </w:r>
  </xsl:template>

  <!-- шаблон для определения необходимости наличия пробела перед
       тегом quote. -->
  <!-- логика: передан текстовый узел, получить его последний символ,
       проверить на точку и пробел, если их нет, то пробел
       необходим. -->
  <!-- todo: скорее всего надо будет добавить проверку текстовый ли
       это узел и сделать рекурсивный поиск текстовой части в сложном
       узле. -->
  <xsl:template name="needspacebefore">
    <xsl:param name="value"/>
    <xsl:variable name="symbol" select="substring($value,string-length($value)-1,1)"/>
    <xsl:choose>
      <!-- определение позиции необходимо для того случая, когда кавычки идут вначале абзаца -->
      <xsl:when test="$symbol = '.' or (2 = position() and normalize-space($value) = '')">
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="' '"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="needspaceafter">
    <xsl:param name="value"/>
    <xsl:variable name="symbol" select="substring($value,1,1)"/>
    <xsl:choose>
      <xsl:when test="$symbol = '.' or $symbol = '?' or $symbol = '!'">
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="' '"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="xref">
    <!-- этот код определяет надо ли вставлять пробел перед тэгом -->
    <xsl:variable name="beforetpl">
      <xsl:call-template name="needspacebefore">
        <xsl:with-param name="value" select="preceding-sibling::node()"/>
      </xsl:call-template>
    </xsl:variable>
    <!-- этот код определяет надо ли вставлять пробел после тэга -->
    <xsl:variable name="aftertpl">
      <xsl:call-template name="needspaceafter">
        <xsl:with-param name="value" select="following-sibling::node()"/>
      </xsl:call-template>
    </xsl:variable>
    <!-- собственно вывод ссылки -->
    <xsl:if test="$beforetpl = ' '">
      <w:r><w:t><xsl:value-of select="$beforetpl"/></w:t></w:r>
    </xsl:if>
    <w:r>
      <w:fldChar w:fldCharType="begin">
        <w:fldData>CNDJ6nn5us4RjIIAqgBLqQsCAAAACAAAAA4AAABfAFIAZQBmADEAOAAwADIANAA4ADYAMQA2AAAA</w:fldData>
      </w:fldChar>
    </w:r>
    <w:r><w:instrText><xsl:value-of select="concat(' REF _Ref',@linkend,' \h ')"/></w:instrText></w:r>
    <w:r><w:fldChar w:fldCharType="separate"/></w:r>
    <w:r><w:t>Рис. </w:t></w:r>
    <w:r><w:rPr><w:noProof/></w:rPr><w:t>1</w:t></w:r>
    <w:r><w:fldChar w:fldCharType="end"/></w:r>
    <xsl:if test="$aftertpl = ' '">
      <w:r><w:t><xsl:value-of select="$aftertpl"/></w:t></w:r>
    </xsl:if>
  </xsl:template>

  <!-- обработка изображений -->
  <xsl:template match="figure">
    <!-- само изображение -->
    <w:p>
      <xsl:apply-templates/>
    </w:p>
    <!-- подпись -->
    <xsl:variable name="imgrefid" select="@id"/>
    <xsl:variable name="imgnum">
      <xsl:number count="figure" level="any" format="1"/>
    </xsl:variable>
    <xsl:variable name="imgtitle" select="title"/>
    <aml:annotation w:type="Word.Bookmark.Start">
      <xsl:attribute name="aml:id">
        <xsl:value-of select="$imgnum"/>
      </xsl:attribute>
      <xsl:attribute name="w:name">
        <xsl:value-of select="concat('_Ref',$imgrefid)"/>
      </xsl:attribute>
    </aml:annotation>
    <w:p>
      <w:pPr><w:pStyle w:val="objectname"/></w:pPr>
      <w:r><w:t>Рис. </w:t></w:r>
      <w:r><w:fldChar w:fldCharType="begin"/></w:r>
      <w:r><w:instrText> SEQ Рис. \* ARABIC </w:instrText></w:r>
      <w:r><w:fldChar w:fldCharType="separate"/></w:r>
      <w:r><w:rPr><w:noProof/></w:rPr><w:t><xsl:value-of select="$imgnum"/></w:t></w:r>
      <w:r><w:fldChar w:fldCharType="end"/></w:r>
      <aml:annotation w:type="Word.Bookmark.End">
        <xsl:attribute name="aml:id">
          <xsl:value-of select="$imgnum"/>
        </xsl:attribute>
      </aml:annotation>
      <w:r><w:t><xsl:value-of select="concat('. ',$imgtitle)"/></w:t></w:r>
    </w:p>
  </xsl:template>

  <xsl:template match="imagedata">
    <!-- этот параметр надо вынести наружу -->
    <xsl:variable name="dir" select="'/home/rad/development/docbookxml/russneft-plan/'"/>
    <!-- подгружаем внешний файл -->
    <xsl:variable name="data" select="document(concat($dir,substring-before(@fileref,'.png'),'.xml'))"/>
    <xsl:variable name="width">
      <xsl:choose>
        <!-- определяем наличие аттрибута width у тега image во внешнем файле
             и получаем его значение, добавляя суффикс для указания сантиметров 
             -->
        <xsl:when test="($data/image)/@width and ($data/image)/@width != ''">
          <xsl:value-of select="concat(($data/image)/@width, 'cm')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'0cm'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="height">
      <xsl:choose>
        <xsl:when test="($data/image)/@height and ($data/image)/@height != ''">
          <xsl:value-of select="concat(($data/image)/@height, 'cm')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'0cm'"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <w:r>
      <w:pict>
        <w:binData>
          <xsl:attribute name="w:name">
            <xsl:value-of select="concat('wordml://',@fileref)"/>
          </xsl:attribute>
          <!-- вставляем изображение представленное в формате base64 -->
          <xsl:value-of select="($data/image)"/>
        </w:binData>
        <v:shape id="_x0000_i1025" type="#_x0000_t75">
          <xsl:attribute name="style">
            <xsl:value-of select="concat('width:',$width,';height:',$height)"/>
          </xsl:attribute>
          <v:imagedata o:title="star">
            <xsl:attribute name="src">
              <xsl:value-of select="concat('wordml://',@fileref)"/>
            </xsl:attribute>
          </v:imagedata>
        </v:shape>
      </w:pict>
    </w:r>
  </xsl:template>

  <!-- Шаблон для работы с нумерованным списком. -->
  <xsl:template match="orderedlist">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Шаблон для работы с ненумерованным списком. -->
  <xsl:template match="itemizedlist">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match='listitem/para'>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Шаблон для обработки элемента нумерованного списка в соответствии
       с его вложенностью (в другой список). -->
  <xsl:template match="listitem">
    <xsl:variable name="level">
      <xsl:choose>
        <xsl:when test="ancestor::orderedlist">
          <xsl:value-of select="count(ancestor::orderedlist)-1"/>
        </xsl:when>
        <xsl:when test="ancestor::itemizedlist">
          <xsl:value-of select="count(ancestor::itemizedlist)-1"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="ancestor::orderedlist">
          <xsl:value-of select="1."/>
        </xsl:when>
        <xsl:when test="ancestor::itemizedlist">
          <xsl:value-of select="'&middot;'"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <w:p>
      <w:pPr>
        <w:listPr>
          <!-- уровень вложенности списка -->
          <w:ilvl>
            <xsl:attribute name="w:val">
              <xsl:value-of select="$level"/>
            </xsl:attribute>
          </w:ilvl>
          <!-- стиль списка, см на <w:list w:ilfo="2"> в заголовке документа -->
          <w:ilfo w:val="1"/>
          <!-- какие-то параметры -->
          <wx:t wx:wTabBefore="0" wx.wTabAfter="180">
            <xsl:attribute name="wx:val">
              <xsl:value-of select="$type"/>
            </xsl:attribute>
          </wx:t>
        </w:listPr>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>

  <!-- хитрый шаблон для обработки пробелов -->
  <xsl:template name="spaces">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="contains($value,'  ')">
        <xsl:call-template name="spaces">
          <xsl:with-param name="value" 
            select="concat(substring-before($value,'  '),' ',substring-after($value,'  '))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

