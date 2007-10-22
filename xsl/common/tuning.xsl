<?xml version='1.0' encoding="koi8-r"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:alt="http://docs.altlinux.ru"
                version='1.0'>

<!-- $Id: tuning.xsl,v 1.2 2006/12/13 12:51:47 rpopov Exp $ -->

<!-- 
     Stylesheet for tuning DocBook/XML documents.
     
     This style doing:
     - Replacing of spaces around 'mdash' in the text nodes (for lang='ru')
     - Optional stripping 'ulink' with duplicated url's
     - Optional checking 'ulink' inside 'revhistory'
     - Optional stripping of 'revhistory'
     - Checking depth level for subquotes inside quotes (quote can contain only 1 subquote)
     - Removing empty lines around listings
     - Replacing in listings tabs to 8 spaces
     
     This style is not integrated into original DocBook XSL stylesheets, for using it:
     - Apply this style
     - Apply original DocBook styles to output of this style

     Comments are in Russian only, sorry.

     Author of this file: Vitaly Ostanin <vyt@altlinux.ru>
     Author of arrange.xsl: Anton V. Boyarshinov <boyarsh@ru.echo.fr>
     -->

<!-- FIXME: учитывать атрибут xml:space, когда появится в DTD, или попробовать 
     определять тип текста (CDATA) -->


<xsl:output method="xml" 
            encoding="koi8-r"
            doctype-public="-//OASIS//DTD DocBook XML V4.2//EN"
            doctype-system="http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"/>

<!-- Параметр указывает, через какое количество повторений оставлять дубликаты ulink 
     (с повторяющимися url) -->
<!-- Первое (в исходном XML-документе) вхождение ulink оставляется всегда, остальные 
     дубликаты оставляются, если их позиция от начала документа кратна данному параметру -->
<!-- Например, при значении параметра 10 будут оставлены повторяющиеся ulink:
     1-й, 10-й, 20-й и т.д. -->
<!-- При значении параметра 0 или 1 будут оставлены все дубликаты, а при очень большом значении
     будут убраны все дубликаты (кроме первого, который и не повторяется) -->
<!-- FIXME: уточнить перевод "оставлять дубликаты после" -->
<xsl:param name="ulink.leave.duplicates.after" select="1"/>

<!-- Значение 1 удаляет revhistory -->
<xsl:param name="revhistory.strip" select="0"/>

<!-- Значение 1 проверяет наличие ulink внутри revhistory. 
     Например, если в revhistory и в title есть дубликаты ulink, то
     в revhistory ulink останется (в chapter revhistory обязательно указывается до title), 
     а в title - нет. -->
<xsl:param name="check.ulink.inside.revhistory" select="0"/>

  <!--Удаление пустых строк после листингов -->
  <xsl:template name="strip-space-after-listing">
    <xsl:param name="str"/>
    <xsl:if test="not(string-length(normalize-space($str))=0)">
      <xsl:choose>
        <xsl:when test="contains($str,'&#10;')">
          <xsl:value-of select="substring-before($str,'&#10;')"/>
          <xsl:text>&#10;</xsl:text>
          <xsl:call-template name="strip-space-after-listing">
            <xsl:with-param name="str" select="substring-after($str,'&#10;')"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$str"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!-- Удаление пустых строк вокруг листингов. Вызывается только для русского языка. -->
  <xsl:template name="strip-space-before-listing">
    <xsl:param name="str" select="."/>
    <xsl:choose>
      <xsl:when test="contains($str,'&#10;')">
        <xsl:choose>
          <xsl:when test="string-length(normalize-space(substring-before($str,'&#10;')))=0">
            <xsl:call-template name="strip-space-before-listing">
              <xsl:with-param name="str" select="substring-after($str,'&#10;')"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- Вызов удаления пустых строк после листингов -->
            <xsl:call-template name="strip-space-after-listing">
              <xsl:with-param name="str" select="$str"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- Вызов удаления пустых строк после листингов -->
        <xsl:call-template name="strip-space-after-listing">
          <xsl:with-param name="str" select="$str"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
   </xsl:template>

   <xsl:template name="replace-tabs">
     <xsl:param name="str"/>
     <xsl:choose>
       <xsl:when test="contains($str, '&#9;')">
         <xsl:value-of select="substring-before($str, '&#9;')"/>
         <xsl:text>        </xsl:text>
         <xsl:call-template name="replace-tabs">
           <xsl:with-param name="str" select="substring-after($str, '&#9;')"/>
         </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
         <xsl:value-of select="$str"/>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:template>

  <!-- Основной шаблон, обрабатывает пробельные символы вокруг длинного тире -->
  <!-- Срабатывает для текстовых узлов, у которых 
       ближайший из своего или родительский атрибутов lang равен 'ru' -->

  <xsl:template name="mdash.spaces" 
                match="text()[ancestor-or-self::*[@lang][position()=1][@lang='ru']]">
    <xsl:param name="str" select="."/>
    <!-- Ищем длинное тире (символы задаются номерами в unicode, чтобы не подключать 
         xml-iso-entities) -->
    <xsl:param name="search-for" select="'&#x2014;'"/>
    <!-- Заменяем на неразрывный пробел, длинное тире, и обычный пробел -->
    <xsl:param name="replace-with" select="'&#x00A0;&#x2014; '"/> 
    
    <!-- Если родителем текста является вывод программы, или листинг, то удаляем 
         пустые строки вокруг и выводим без удаления пробельных символов внутри -->
    <xsl:variable name="parent-name" select="name(parent::node())"/>
    <xsl:choose>
      <xsl:when test="$parent-name='screen' or
                      $parent-name='literallayout' or
                      $parent-name='computeroutput' or
                      $parent-name='programlisting'">
        <!-- Вызов удаления пустых строк вокруг листингов -->
        <xsl:call-template name="strip-space-before-listing">
          <xsl:with-param name="str">
            <!-- Перед передачей удалению пустых строк сначала заменяются символы табуляции на пробелы -->
            <xsl:call-template name="replace-tabs">
              <xsl:with-param name="str" select="."/>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <!-- Иначе обрабатываем длинное тире -->
      <xsl:otherwise>
        <xsl:choose>
          <!-- Проверяем, есть ли в строке длинное тире -->
          <xsl:when test="contains($str, $search-for)">
            <!-- Проверяем, совпадает ли первый символ строки до удаления пробельных
                 символов с первым символом после удаления. Если не совпадает, и строка 
                 до длинного тире не пуста, значит, в начале строки был 
                 пробел - выводим его. -->
            <xsl:if test="not (starts-with(normalize-space($str),substring($str, 1, 1))) 
                          and normalize-space(substring-before($str, $search-for))!=''">
              <xsl:text> </xsl:text>
            </xsl:if>
            <!-- Выводим строку до длинного тире с удалёнными пробельными символами -->
            <xsl:value-of select="normalize-space(substring-before($str, $search-for))"/>
            <!-- Выводим неразрывный пробел, длинное тире и пробел -->
            <!-- FIXME: заменить copy-of на value-of -->
            <xsl:copy-of select="$replace-with"/>
            <!-- Вызываем этот же шаблон, передавая в качестве строки для обработки остаток 
                 предыдущей строки (после длинного тире) -->
            <xsl:call-template name="mdash.spaces">
              <xsl:with-param name="str" select="substring-after($str, $search-for)"/>
              <xsl:with-param name="search-for" select="$search-for"/>
              <xsl:with-param name="replace-with" select="$replace-with"/>
            </xsl:call-template>
          </xsl:when>
          <!-- Если в обрабатываемой строке (уже) нет длинного тире, то проверяем, есть ли
               у неё братские элементы. Если есть, то просто выводим. Если нет, то строка 
               является единственным содержимым тега, поэтому нормализуем её перед выводом -->
          <!-- FIXME: Возможно, понадобится явно проверять, что братские элементы являются 
               узлами (preceding-sibling::node()), но я не могу представить другой вариант - 
               атрибутов у текста быть не может, комментарии за братский элемент текста не 
               считаются. Единственный непроверенный вариант - наличие processing-instruction() 
               рядом с текстом (если допустимо) -->
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="preceding-sibling::* or following-sibling::*">
                <xsl:value-of select="$str"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="normalize-space($str)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Копируем все атрибуты, комментарии и инструкции обработки -->
  <xsl:template match="@*|comment()|processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <!-- Шаблон, удаляющий revhistory, если параметр revhistory.strip не равен 0 -->
  <xsl:template match="revhistory">
    <xsl:if test="not($revhistory.strip)">
      <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  
  <!-- Шаблон для удаления ulink с повторяющимися значениями url -->
  <!-- FIXME: нужно как-то проверять ссылки, которые удалять нельзя, например, в перечислениях ссылок -->
  <!-- FIXME: сделать удаление повторений в пределах частей, а не во всём документе, если 
       понадобится. Средствами xpath 1.0 почти нереально, нужно посмотреть на exsl -->
  <xsl:template match="ulink">
    <!-- Если нужно проверять наличие ulink внутри revhistory, и в предках ulink есть 
         revhistory, то останавливаем выполнение и выводим сообщение об этом -->
    <xsl:if test="$check.ulink.inside.revhistory and ancestor::revhistory">
      <xsl:message terminate="yes">
        <xsl:text>&#10;Tuning: found ulink inside revhistory. </xsl:text>
        <xsl:text>For disabling this check set param 'check.ulink.inside.revhistory' to '0'.&#10;&#10;</xsl:text>
      </xsl:message>
    </xsl:if>
    <xsl:variable name="url" select="@url"/>
    <!-- Считаем позицию в наборе повторяющихся ulink от начала документа -->
    <xsl:variable name="position" select="count(preceding::ulink[@url=$url]) + 1"/>
    <xsl:choose>
      <!-- Если позиция первая, или кратна параметру ulink.leave.duplicates.after,
           то полностью копируем текущий ulink и продолжаем обработку -->
      <xsl:when test="$position=1 or 
                      ($position div $ulink.leave.duplicates.after = 
                      round ($position div $ulink.leave.duplicates.after))">
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <!-- Иначе ulink не копируем и продолжаем обработку (содержимое ulink в 
             дальнейшей обработке не пропадает) -->
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Копируем quote с проверкой глубины вложенности -->
  <xsl:template match="quote">
    <xsl:if test="count(ancestor::quote) &gt; 1">
      <xsl:message terminate="yes">
        <xsl:text>&#10;Tuning: Error: quote can contain only 1 subquote.&#10;&#10;</xsl:text>
      </xsl:message>
    </xsl:if>
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Изменяем ссылку на картинку, которая может быть вида '../somedoc/images/...' на
       'images/...' -->
<!--  <xsl:template match="graphic/@fileref|inlinegraphic/@fileref|imagedata/@fileref">
    <xsl:variable name="src" select="."/>
    <xsl:attribute name="fileref">
      <xsl:choose>
        <xsl:when test="contains($src,'/images/')">
          <xsl:text>images/</xsl:text>
          <xsl:value-of select="substring-after($src,'/images/')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$src"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>-->

  <!-- Копируем все атрибуты и элементы без изменений -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>
