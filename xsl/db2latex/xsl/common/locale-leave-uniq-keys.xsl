<?xml version='1.0'?>
<!--############################################################################# 
|	$Id: locale-leave-uniq-keys.xsl,v 1.1 2005/12/05 08:19:41 rpopov Exp $
|- #############################################################################
|	Author: Vitaly Ostanin <vyt@altlinux.ru>
|
|   PURPOSE:
|	This stylesheet parse localisation files from DB2LaTeX and Norman Walsh's 
|       DocBook stylesheet for leave uniq keys. Duplicated keys (in both stylesheets)
|       moved to include with XML Inclusions.
|
|       For invoking this style see Makefile
|
| WARNING: this style works only with $lang.xml files. 
| WARNING: It doesn't sync l10n.xml l10n.dtd l10n.xsl
|
+ ############################################################################## -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl"
                version='1.0'>

  <xsl:variable name="docbook.common.path">http://docbook.sourceforge.net/release/xsl/current/common/</xsl:variable>

  <!-- This template work on each of languages, specified in DocBook l10n.xml -->
  <xsl:template match="l:l10n">
    <!-- File with DocBook localization for current language -->
    <xsl:variable name="docbook-l10n-file" select="concat($docbook.common.path,@language,'.xml')"/>
    <!-- File with DB2LaTeX localization for current language -->
    <xsl:variable name="db2latex-l10n-file" select="concat(@language,'.xml')"/>
    <!-- Output file, contains include for DocBook localization and DB2LaTeX addons for current language -->
    <xsl:variable name="xinclude-db2latex-l10n-file" select="concat('locale-source.',$db2latex-l10n-file)"/>

    <xsl:variable name="docbook-l10n" select="document($docbook-l10n-file)"/>
    <xsl:variable name="db2latex-l10n" select="document($db2latex-l10n-file)"/>

    <xsl:if test="not(element-available('exsl:document'))">
      <xsl:message terminate="yes">
        <xsl:text>Error: this style requires support for extension 'exsl:document'</xsl:text>
      </xsl:message>
    </xsl:if>
    <exsl:document href="{$xinclude-db2latex-l10n-file}"
                   method="xml"
                   encoding="US-ASCII"
                   indent="yes">
      <xsl:copy>
        <xsl:attribute name="language">
          <xsl:value-of select="@language"/>
        </xsl:attribute>
        <xsl:attribute name="english-language-name">
          <xsl:value-of select="@english-language-name"/>
        </xsl:attribute>
        <xi:include xmlns:xi="http://www.w3.org/2001/XInclude"
          href="{concat($docbook-l10n-file,'#xpointer(/*/node())')}"/>
        <xsl:for-each select="$db2latex-l10n/localization/gentext">
          <xsl:if test="not($docbook-l10n/l:l10n/l:gentext/@key=@key)">
            <l:gentext key="{@key}" text="{@text}"/>
          </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="$db2latex-l10n/localization/dingbat">
          <xsl:if test="not($docbook-l10n/l:l10n/l:dingbat/@key=@key)">
            <l:dingbat key="{@key}" text="{@text}"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:copy>
    </exsl:document>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
