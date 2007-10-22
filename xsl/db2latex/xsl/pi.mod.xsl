<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY % xsldoc.ent SYSTEM "./xsldoc.ent"> %xsldoc.ent; ]>
<!--############################################################################# 
|	$Id: pi.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
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
    <doc:reference id="pi" xmlns="">
	<referenceinfo>
	    <releaseinfo role="meta">
		$Id: pi.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
	    </releaseinfo>
	<authorgroup>
	    <author> <firstname>Ramon</firstname> <surname>Casellas</surname> </author>
	    <author> <firstname>James</firstname> <surname>Devenish</surname> </author>
	</authorgroup>
	    <copyright>
		<year>2000</year> <year>2001</year><year>2002</year><year>2003</year>
		<holder>Ramon Casellas</holder>
	    </copyright>
	</referenceinfo>

	<title>Processing Instructions</title>

	<partintro>
	    <section><title>Introduction</title>
		<para></para>
	    </section>
	</partintro>
    </doc:reference>


    <doc:template match="processing-instruction()" xmlns="">
	<refpurpose> Processing Instruction XSL template.  </refpurpose>
	<refdescription>
	</refdescription>
    </doc:template>


    <xsl:template match="processing-instruction()">
    </xsl:template>

	<doc:template match="processing-instruction('latex')" xmlns="">
		<refpurpose>Output arbitrary &latex; text</refpurpose>
		<doc:description>
			The contents of this processing instruction will
			output directly by &DB2LaTeX;. This allows the
			inclusion of &latex;-specific instructions that
			will be recognised only by &latex; stylesheets.
			For example, <literal><![CDATA[<?latex \sloppy?>]]></literal>
			would insert <literal>\sloppy</literal> into the output
			without any character escaping.
		</doc:description>
	</doc:template>
	<xsl:template match="processing-instruction('latex')">
		<xsl:value-of select="."/>
	</xsl:template>

	<doc:template match="processing-instruction('db2latex')" xmlns="">
		<refpurpose>Output arbitrary &latex; text</refpurpose>
		<doc:description>
		The contents of this processing instruction will
		output directly by &DB2LaTeX;. This allows the
		inclusion of &latex;-specific instructions that
		will be recognised only by &DB2LaTeX; stylesheets.
		For example, <literal><![CDATA[<?latex \sloppy?>]]></literal>
		would insert <literal>\sloppy</literal> into the output
		without any character escaping.
		</doc:description>
	</doc:template>
	<xsl:template match="processing-instruction('db2latex')">
		<xsl:value-of select="."/>
	</xsl:template>

    <xsl:template match="processing-instruction('rcas')">
	<xsl:processing-instruction name="dbhtml">
	    <xsl:value-of select="."/>
	</xsl:processing-instruction>
    </xsl:template>

    <xsl:template name="process.cmdsynopsis.list">
	<xsl:param name="cmdsynopses"/><!-- empty node list by default -->
	<xsl:param name="count" select="1"/>

	<xsl:choose>
	    <xsl:when test="$count>count($cmdsynopses)"></xsl:when>
	    <xsl:otherwise>
		<xsl:variable name="cmdsyn" select="$cmdsynopses[$count]"/>

		<dt>
		    <a>
			<xsl:attribute name="href">
			    <xsl:call-template name="label.id">
				<xsl:with-param name="object" select="$cmdsyn"/>
			    </xsl:call-template>
			</xsl:attribute>

			<xsl:choose>
			    <xsl:when test="$cmdsyn/@xreflabel">
				<xsl:call-template name="xref.xreflabel">
				    <xsl:with-param name="target" select="$cmdsyn"/>
				</xsl:call-template>
			    </xsl:when>
			    <xsl:otherwise>
				<!-- RCAS Fixme 
				<xsl:call-template name="xref.cmdsynopsis">
				    <xsl:with-param name="target" select="$cmdsyn"/>
				</xsl:call-template>-->
			    </xsl:otherwise>
			</xsl:choose>
		    </a>
		</dt>

		<xsl:call-template name="process.cmdsynopsis.list">
		    <xsl:with-param name="cmdsynopses" select="$cmdsynopses"/>
		    <xsl:with-param name="count" select="$count+1"/>
		</xsl:call-template>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:template>

    <xsl:template match="processing-instruction('dbcmdlist')">
	<xsl:variable name="cmdsynopses" select="..//cmdsynopsis"/>

	<xsl:if test="count($cmdsynopses)&lt;1">
	    <xsl:message><xsl:text>No cmdsynopsis elements matched dbcmdlist PI, perhaps it's nested too deep?</xsl:text>
	    </xsl:message>
	</xsl:if>

	<dl>
	    <xsl:call-template name="process.cmdsynopsis.list">
		<xsl:with-param name="cmdsynopses" select="$cmdsynopses"/>
	    </xsl:call-template>
	</dl>
    </xsl:template>

    <!-- ==================================================================== -->

    <xsl:template name="process.funcsynopsis.list">
	<xsl:param name="funcsynopses"/><!-- empty node list by default -->
	<xsl:param name="count" select="1"/>

	<xsl:choose>
	    <xsl:when test="$count>count($funcsynopses)"></xsl:when>
	    <xsl:otherwise>
		<xsl:variable name="cmdsyn" select="$funcsynopses[$count]"/>

		<dt>
		    <a>
			<xsl:attribute name="href">
			    <xsl:call-template name="label.id">
				<xsl:with-param name="object" select="$cmdsyn"/>
			    </xsl:call-template>
			</xsl:attribute>

			<xsl:choose>
			    <xsl:when test="$cmdsyn/@xreflabel">
				<xsl:call-template name="xref.xreflabel">
				    <xsl:with-param name="target" select="$cmdsyn"/>
				</xsl:call-template>
			    </xsl:when>
			    <xsl:otherwise>
				<!-- RCAS Fixme 
				<xsl:call-template name="xref.funcsynopsis">
				    <xsl:with-param name="target" select="$cmdsyn"/>
				</xsl:call-template>
				-->
			    </xsl:otherwise>
			</xsl:choose>
		    </a>
		</dt>

		<xsl:call-template name="process.funcsynopsis.list">
		    <xsl:with-param name="funcsynopses" select="$funcsynopses"/>
		    <xsl:with-param name="count" select="$count+1"/>
		</xsl:call-template>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:template>

    <xsl:template match="processing-instruction('dbfunclist')">
	<xsl:variable name="funcsynopses" select="..//funcsynopsis"/>

	<xsl:if test="count($funcsynopses)&lt;1">
	    <xsl:message><xsl:text>No funcsynopsis elements matched dbfunclist PI, perhaps it's nested too deep?</xsl:text>
	    </xsl:message>
	</xsl:if>

	<dl>
	    <xsl:call-template name="process.funcsynopsis.list">
		<xsl:with-param name="funcsynopses" select="$funcsynopses"/>
	    </xsl:call-template>
	</dl>
    </xsl:template>

    <!-- ==================================================================== -->

</xsl:stylesheet>
