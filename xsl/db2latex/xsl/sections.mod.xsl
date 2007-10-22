<?xml version='1.0'?>
<!--############################################################################# 
|	$Id: sections.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
|- #############################################################################
|	$Author: rpopov $												
|														
|   PURPOSE: sections.
|   PENDING:
|	- Nested section|simplesect > 3 mapped to subsubsection*
|    - No sectinfo (!)
+ ############################################################################## -->

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    exclude-result-prefixes="doc" version='1.0'>



    <!--############################################################################# -->
    <!-- DOCUMENTATION                                                                -->
    <doc:reference id="sections" xmlns="">
	<referenceinfo>
	    <releaseinfo role="meta">
		$Id: sections.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
	    </releaseinfo>
	<authogroup>
	    <author> <firstname>Ramon</firstname> <surname>Casellas</surname> </author>
	    <author> <firstname>James</firstname> <surname>Devenish</surname> </author>
	</authogroup>
	    <copyright>
		<year>2000</year> <year>2001</year> <year>2002</year> <year>2003</year>
		<holder>Ramon Casellas</holder>
	    </copyright>
	</referenceinfo>

	<title>Sections <filename>sections.mod.xsl</filename></title>
	<partintro>
	    <section><title>Introduction</title>
		<para></para>
	    </section>
	</partintro>
    </doc:reference>





	<xsl:template match="sect1|sect2|sect3|sect4|sect5">
		<xsl:param name="bridgehead" select="ancestor::preface"/>
		<xsl:variable name="template">
			<xsl:value-of select="local-name(.)"/>
			<xsl:if test="$bridgehead"><xsl:text>*</xsl:text></xsl:if>
		</xsl:variable>
		<xsl:call-template name="map.begin">
			<xsl:with-param name="keyword" select="$template"/>
		</xsl:call-template>
		<xsl:apply-templates/>
	</xsl:template>

    <xsl:template match="sect1/title"/>
    <xsl:template match="sect2/title"/>
    <xsl:template match="sect3/title"/>
    <xsl:template match="sect4/title"/>
    <xsl:template match="sect5/title"/>


    <xsl:template match="section|simplesect">
		<xsl:param name="bridgehead" select="ancestor::preface"/>
		<xsl:param name="level" select="count(ancestor::section)+1"/>
		<xsl:variable name="template">
			<xsl:choose>
				<xsl:when test='$level&lt;6'>
					<xsl:text>sect</xsl:text>
					<xsl:value-of select="$level"/>
				</xsl:when>
				<xsl:otherwise> 
					<xsl:message>DB2LaTeX: recursive section|simplesect &gt; 5 Not  well Supported</xsl:message> 
					<xsl:text>sect6</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="$bridgehead"><xsl:text>*</xsl:text></xsl:if>
		</xsl:variable>
		<xsl:text>&#10;</xsl:text>
		<xsl:call-template name="map.begin">
			<xsl:with-param name="keyword" select="$template"/>
		</xsl:call-template>
		<xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="section/title"/>
    <xsl:template match="simplesect/title"/>

    <xsl:template match="sectioninfo"/>
    <xsl:template match="sect1info"/>
    <xsl:template match="sect2info"/>
    <xsl:template match="sect3info"/>
    <xsl:template match="sect4info"/>
    <xsl:template match="sect5info"/>

</xsl:stylesheet>
