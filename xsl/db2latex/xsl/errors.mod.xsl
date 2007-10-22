<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
    <!--############################################################################# 
    |	$Id: errors.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
    |- #############################################################################
    |	$Author: rpopov $
    |														
    |   PURPOSE:
    + ############################################################################## -->


    <xsl:template match="*">
	<xsl:message>DB2LaTeX: Need to process XPath match <xsl:value-of select="concat(name(..),'/',name(.))"/></xsl:message>
	<xsl:text> [</xsl:text><xsl:value-of select="name(.)"/><xsl:text>] &#10;</xsl:text>
	<xsl:apply-templates/> 
	<xsl:text> [/</xsl:text><xsl:value-of select="name(.)"/><xsl:text>] &#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
