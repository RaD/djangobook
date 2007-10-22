<?xml version='1.0'?>

<!--
############################################################################# 
$Id: docbook-alt.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $		
#############################################################################

PURPOSE:

This is alternative "parent" stylesheet.

It uses another schema for replacing entities in template name="scape"
(from normalize-scape.mod.xsl)

This schema allowed optional including unicode.mapping.$lang.xml for 
replacing entities. Languages must be specified string, each lang separated by space.
See param "unicode.mapping.languages".

This schema allowed including unicode mapping from file, specified by
param "unicode.mapping.local". It must be absolute path or relative to DB2LaTeX 
stylesheets.

Replacing priority is:
    $unicode.mapping.local
    unicode.mapping.$lang.xml (from $unicode.mapping.languages)
    $unicode.mapping.default

Thanks and thanks again to David Carlisle <davidc@nag.co.uk> for his 
explanations about XSLT and excellent job on MathML and LaTeX mappings!
       
############################################################################## -->

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    xmlns:exsl="http://exslt.org/common" 
    exclude-result-prefixes="doc"
    extension-element-prefixes="exsl"
    version='1.0'>

  <xsl:import href="docbook.xsl"/>

  <xsl:key name="character" match="character" use="unicode"/>
  <xsl:param name="unicode.mapping.local" select="''"/>
  <xsl:param name="unicode.mapping.default" select="'unicode.mapping.xml'"/>
  <xsl:param name="unicode.mapping.languages" select="''"/>
  <xsl:variable name="unicode.mapping.sources">
    <xsl:if test="not(function-available('exsl:node-set'))">
      <xsl:message terminate="yes">
	<xsl:text>
	  Error: this style requires support for extension 'exsl:node-set()'
	</xsl:text>
      </xsl:message>
    </xsl:if>
    <file><xsl:value-of select="$unicode.mapping.local"/></file>
    <xsl:call-template name="parse.unicode.mapping.languages">
      <xsl:with-param name="languages" select="$unicode.mapping.languages"/>
    </xsl:call-template>
    <file><xsl:value-of select="$unicode.mapping.default"/></file>
  </xsl:variable>
  
  <xsl:variable name="unicode.mapping.database" 
		select="document(exsl:node-set($unicode.mapping.sources)/file,document(''))/mapping"/>

  <xsl:template name="parse.unicode.mapping.languages">
    <xsl:param name="languages"/>
    <xsl:if test="contains($languages,' ')">
      <xsl:variable name="unicode.mapping.lang.file" 
		    select="concat('unicode.mapping.',substring-before($languages,' '),'.xml')"/>
      <xsl:if test="document($unicode.mapping.lang.file)">
	<file><xsl:value-of select="$unicode.mapping.lang.file"/></file>
      </xsl:if>
      <xsl:call-template name="parse.unicode.mapping.languages">
	<xsl:with-param name="languages" select="substring-after($languages,' ')"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="not(string-length($languages)=0)">
      <xsl:variable name="unicode.mapping.lang.file" select="concat('unicode.mapping.',$languages,'.xml')"/>
      <xsl:if test="document($unicode.mapping.lang.file)">
	<file><xsl:value-of select="$unicode.mapping.lang.file"/></file>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="scape">
    <xsl:param name="string"/>
    <xsl:if test="not(string-length($string)=0)">
      <xsl:variable name="char" select="substring($string,1,1)"/>
      <xsl:variable name="preferred">
	<xsl:for-each select="$unicode.mapping.database">
	  <preferred><xsl:value-of select="key('character',$char)/preferred"/></preferred>
	</xsl:for-each>
      </xsl:variable>
      <xsl:choose>
	<!-- Do not optimize it to variable calculation. I already test it for speed with xsltproc :) -->
	<xsl:when test="exsl:node-set($preferred)/preferred[not(string-length(.)=0)][1]">
	  <xsl:value-of select="exsl:node-set($preferred)/preferred[not(string-length(.)=0)][1]"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$char"/>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="scape">
	<xsl:with-param name="string" select="substring($string,2)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="scape-href">
    <xsl:param name="string"/>
    <xsl:call-template name="scape">
      <xsl:with-param name="string" select="$string"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="scape-url">
    <xsl:param name="string"/>
    <xsl:call-template name="scape">
      <xsl:with-param name="string" select="$string"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="example">
    <xsl:variable name="placement">
      <xsl:call-template name="generate.formal.title.placement">
	<xsl:with-param name="object" select="local-name(.)" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="caption">
      <xsl:text>{</xsl:text>
      <xsl:value-of select="$latex.example.caption.style"/>
      <xsl:text>{\caption{</xsl:text>
      <!-- WARNING: do not scape if title output already scaped by original title parsing -->
      <xsl:call-template name="scape">
	<xsl:with-param name="string">
	  <xsl:apply-templates select="title" mode="caption.mode"/>
	</xsl:with-param>
      </xsl:call-template>
      <xsl:text>}</xsl:text>
      <xsl:call-template name="label.id"/>
      <xsl:text>}}&#10;</xsl:text>
    </xsl:variable>
    <xsl:call-template name="map.begin"/>
    <xsl:if test="$placement='before'">
      <xsl:text>\captionswapskip{}</xsl:text>
      <xsl:value-of select="$caption"/>
      <xsl:text>\captionswapskip{}</xsl:text>
    </xsl:if>
    <xsl:apply-templates />
    <xsl:if test="$placement!='before'">
      <xsl:value-of select="$caption"/>
    </xsl:if>
    <xsl:call-template name="map.end"/>
  </xsl:template>
  
</xsl:stylesheet>
