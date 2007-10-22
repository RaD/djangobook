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

<!-- FIXME: ��������� ������� xml:space, ����� �������� � DTD, ��� ����������� 
     ���������� ��� ������ (CDATA) -->


<xsl:output method="xml" 
            encoding="koi8-r"
            doctype-public="-//OASIS//DTD DocBook XML V4.2//EN"
            doctype-system="http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"/>

<!-- �������� ���������, ����� ����� ���������� ���������� ��������� ��������� ulink 
     (� �������������� url) -->
<!-- ������ (� �������� XML-���������) ��������� ulink ����������� ������, ��������� 
     ��������� �����������, ���� �� ������� �� ������ ��������� ������ ������� ��������� -->
<!-- ��������, ��� �������� ��������� 10 ����� ��������� ������������� ulink:
     1-�, 10-�, 20-� � �.�. -->
<!-- ��� �������� ��������� 0 ��� 1 ����� ��������� ��� ���������, � ��� ����� ������� ��������
     ����� ������ ��� ��������� (����� �������, ������� � �� �����������) -->
<!-- FIXME: �������� ������� "��������� ��������� �����" -->
<xsl:param name="ulink.leave.duplicates.after" select="1"/>

<!-- �������� 1 ������� revhistory -->
<xsl:param name="revhistory.strip" select="0"/>

<!-- �������� 1 ��������� ������� ulink ������ revhistory. 
     ��������, ���� � revhistory � � title ���� ��������� ulink, ��
     � revhistory ulink ��������� (� chapter revhistory ����������� ����������� �� title), 
     � � title - ���. -->
<xsl:param name="check.ulink.inside.revhistory" select="0"/>

  <!--�������� ������ ����� ����� ��������� -->
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

  <!-- �������� ������ ����� ������ ���������. ���������� ������ ��� �������� �����. -->
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
            <!-- ����� �������� ������ ����� ����� ��������� -->
            <xsl:call-template name="strip-space-after-listing">
              <xsl:with-param name="str" select="$str"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- ����� �������� ������ ����� ����� ��������� -->
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

  <!-- �������� ������, ������������ ���������� ������� ������ �������� ���� -->
  <!-- ����������� ��� ��������� �����, � ������� 
       ��������� �� ������ ��� ������������ ��������� lang ����� 'ru' -->

  <xsl:template name="mdash.spaces" 
                match="text()[ancestor-or-self::*[@lang][position()=1][@lang='ru']]">
    <xsl:param name="str" select="."/>
    <!-- ���� ������� ���� (������� �������� �������� � unicode, ����� �� ���������� 
         xml-iso-entities) -->
    <xsl:param name="search-for" select="'&#x2014;'"/>
    <!-- �������� �� ����������� ������, ������� ����, � ������� ������ -->
    <xsl:param name="replace-with" select="'&#x00A0;&#x2014; '"/> 
    
    <!-- ���� ��������� ������ �������� ����� ���������, ��� �������, �� ������� 
         ������ ������ ������ � ������� ��� �������� ���������� �������� ������ -->
    <xsl:variable name="parent-name" select="name(parent::node())"/>
    <xsl:choose>
      <xsl:when test="$parent-name='screen' or
                      $parent-name='literallayout' or
                      $parent-name='computeroutput' or
                      $parent-name='programlisting'">
        <!-- ����� �������� ������ ����� ������ ��������� -->
        <xsl:call-template name="strip-space-before-listing">
          <xsl:with-param name="str">
            <!-- ����� ��������� �������� ������ ����� ������� ���������� ������� ��������� �� ������� -->
            <xsl:call-template name="replace-tabs">
              <xsl:with-param name="str" select="."/>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <!-- ����� ������������ ������� ���� -->
      <xsl:otherwise>
        <xsl:choose>
          <!-- ���������, ���� �� � ������ ������� ���� -->
          <xsl:when test="contains($str, $search-for)">
            <!-- ���������, ��������� �� ������ ������ ������ �� �������� ����������
                 �������� � ������ �������� ����� ��������. ���� �� ���������, � ������ 
                 �� �������� ���� �� �����, ������, � ������ ������ ��� 
                 ������ - ������� ���. -->
            <xsl:if test="not (starts-with(normalize-space($str),substring($str, 1, 1))) 
                          and normalize-space(substring-before($str, $search-for))!=''">
              <xsl:text> </xsl:text>
            </xsl:if>
            <!-- ������� ������ �� �������� ���� � ���̣����� ����������� ��������� -->
            <xsl:value-of select="normalize-space(substring-before($str, $search-for))"/>
            <!-- ������� ����������� ������, ������� ���� � ������ -->
            <!-- FIXME: �������� copy-of �� value-of -->
            <xsl:copy-of select="$replace-with"/>
            <!-- �������� ���� �� ������, ��������� � �������� ������ ��� ��������� ������� 
                 ���������� ������ (����� �������� ����) -->
            <xsl:call-template name="mdash.spaces">
              <xsl:with-param name="str" select="substring-after($str, $search-for)"/>
              <xsl:with-param name="search-for" select="$search-for"/>
              <xsl:with-param name="replace-with" select="$replace-with"/>
            </xsl:call-template>
          </xsl:when>
          <!-- ���� � �������������� ������ (���) ��� �������� ����, �� ���������, ���� ��
               � �ţ �������� ��������. ���� ����, �� ������ �������. ���� ���, �� ������ 
               �������� ������������ ���������� ����, ������� ����������� ţ ����� ������� -->
          <!-- FIXME: ��������, ����������� ���� ���������, ��� �������� �������� �������� 
               ������ (preceding-sibling::node()), �� � �� ���� ����������� ������ ������� - 
               ��������� � ������ ���� �� �����, ����������� �� �������� ������� ������ �� 
               ���������. ������������ ������������� ������� - ������� processing-instruction() 
               ����� � ������� (���� ���������) -->
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
  
  <!-- �������� ��� ��������, ����������� � ���������� ��������� -->
  <xsl:template match="@*|comment()|processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <!-- ������, ��������� revhistory, ���� �������� revhistory.strip �� ����� 0 -->
  <xsl:template match="revhistory">
    <xsl:if test="not($revhistory.strip)">
      <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  
  <!-- ������ ��� �������� ulink � �������������� ���������� url -->
  <!-- FIXME: ����� ���-�� ��������� ������, ������� ������� ������, ��������, � ������������� ������ -->
  <!-- FIXME: ������� �������� ���������� � �������� ������, � �� �� �ӣ� ���������, ���� 
       �����������. ���������� xpath 1.0 ����� ���������, ����� ���������� �� exsl -->
  <xsl:template match="ulink">
    <!-- ���� ����� ��������� ������� ulink ������ revhistory, � � ������� ulink ���� 
         revhistory, �� ������������� ���������� � ������� ��������� �� ���� -->
    <xsl:if test="$check.ulink.inside.revhistory and ancestor::revhistory">
      <xsl:message terminate="yes">
        <xsl:text>&#10;Tuning: found ulink inside revhistory. </xsl:text>
        <xsl:text>For disabling this check set param 'check.ulink.inside.revhistory' to '0'.&#10;&#10;</xsl:text>
      </xsl:message>
    </xsl:if>
    <xsl:variable name="url" select="@url"/>
    <!-- ������� ������� � ������ ������������� ulink �� ������ ��������� -->
    <xsl:variable name="position" select="count(preceding::ulink[@url=$url]) + 1"/>
    <xsl:choose>
      <!-- ���� ������� ������, ��� ������ ��������� ulink.leave.duplicates.after,
           �� ��������� �������� ������� ulink � ���������� ��������� -->
      <xsl:when test="$position=1 or 
                      ($position div $ulink.leave.duplicates.after = 
                      round ($position div $ulink.leave.duplicates.after))">
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <!-- ����� ulink �� �������� � ���������� ��������� (���������� ulink � 
             ���������� ��������� �� ���������) -->
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- �������� quote � ��������� ������� ����������� -->
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

  <!-- �������� ������ �� ��������, ������� ����� ���� ���� '../somedoc/images/...' ��
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

  <!-- �������� ��� �������� � �������� ��� ��������� -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>
