<?xml version='1.0'?>
<!--############################################################################# 
|	$Id: graphic.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
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
    <doc:reference id="graphic" xmlns="">
	<referenceinfo>
	    <releaseinfo role="meta">
		$Id: graphic.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
	    </releaseinfo>
	<authorgroup>
	    <author> <firstname>Ramon</firstname> <surname>Casellas</surname> </author>
	    <author> <firstname>James</firstname> <surname>Devenish</surname> </author>
	</authorgroup>
	    <copyright>
		<year>2000</year> <year>2001</year> <year>2002</year> <year>2003</year>
		<holder>Ramon Casellas</holder>
	    </copyright>
	</referenceinfo>

	<title>Graphics <filename>graphic.mod.xsl</filename></title>
	<partintro>
	    <section><title>Introduction</title>
		<para></para>
	    </section>
	</partintro>
    </doc:reference>




    <xsl:template match="screenshot">
	<xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="screeninfo">
    </xsl:template>


    <xsl:template match="graphic">
		<xsl:text>&#10;&#10;</xsl:text>
		<xsl:call-template name="inlinegraphic"/>
		<xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>


    <xsl:template match="inlinegraphic" name="inlinegraphic">
		<xsl:text>\includegraphics{</xsl:text>
		<xsl:choose>
			<xsl:when test="@entityref">
				<xsl:value-of select="unparsed-entity-uri(@entityref)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@fileref"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>}</xsl:text>
    </xsl:template>
</xsl:stylesheet>
