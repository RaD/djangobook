<?xml version='1.0'?>
<!--############################################################################# 
|	$Id: bridgehead.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
|- #############################################################################
|	$Author: rpopov $
|														
|   PURPOSE:
+ ############################################################################## -->

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    exclude-result-prefixes="doc" version='1.0'>

    <!--############################################################################# -->
    <!-- DOCUMENTATION                                                                -->
    <doc:reference id="bridgehead" xmlns="">
	<referenceinfo>
	    <releaseinfo role="meta">
		$Id: bridgehead.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
	    </releaseinfo>
		<authorgroup>
		<author><firstname>Ramon</firstname> <surname>Casellas</surname></author>
		<author><firstname>James</firstname> <surname>Devenish</surname></author>
		</authorgroup>
	    <copyright>
		<year>2000</year> <year>2001</year> <year>2002</year> <year>2003</year>
		<holder>Ramon Casellas</holder>
	    </copyright>
	</referenceinfo>

	<title>BridgeHead <filename>bridgehead.mod.xsl</filename></title>
	<partintro>
	    <section><title>Introduction</title>
		<para>Handle the <sgmltag class="element">bridgehead</sgmltag> element.</para>
	    </section>
	</partintro>
    </doc:reference>


	<doc:template match="bridgehead" xmlns="">
	<refpurpose>
		A free-floating heading.
	</refpurpose>
	<refdescription>
		<para>
		Renders un-numbered section headings.
		For <literal>renderas</literal> values of sect1, sect2, and sect3, LaTeX <quote>star</quote> commands (such as <literal>\section*</literal>) are used.
		Otherwise, a bold heading is put on a line of its own.
		</para>
	</refdescription>
	</doc:template>

    <xsl:template match="bridgehead" name="bridgehead">
    <xsl:param name="renderas"/>
    <xsl:param name="content"><xsl:apply-templates/></xsl:param>
	<xsl:choose>
		<xsl:when test="$renderas='sect1' or $renderas='sect2' or $renderas='sect3'">
			<xsl:text>&#10;\</xsl:text>
			<xsl:if test="$renderas='sect2'"><xsl:text>sub</xsl:text></xsl:if>
			<xsl:if test="$renderas='sect3'"><xsl:text>subsub</xsl:text></xsl:if>
			<xsl:text>section*{</xsl:text>
			<xsl:copy-of select="$content"/>
			<xsl:text>}</xsl:text>
			<xsl:call-template name="label.id"/>
			<xsl:text>&#10;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>&#10;&#10;</xsl:text>
			<xsl:text>\vspace{1em}\noindent{\bfseries </xsl:text><xsl:copy-of select="$content"/><xsl:text>}</xsl:text>
			<xsl:call-template name="label.id"/>
			<xsl:text>\par\noindent&#10;</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
    </xsl:template>

</xsl:stylesheet>
