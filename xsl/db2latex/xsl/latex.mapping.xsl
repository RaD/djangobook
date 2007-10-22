<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY % xsldoc.ent SYSTEM "./xsldoc.ent"> %xsldoc.ent; ]>
<!--#############################################################################
|      $Id: latex.mapping.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
|- #############################################################################
|      $Author: rpopov $
|
|   PURPOSE:
+ ############################################################################## -->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    exclude-result-prefixes="doc" version='1.0'>

	<!--############################################################################# -->
	<!-- DOCUMENTATION                                                                -->
	<doc:reference id="latex.mapping" xmlns="">
		<referenceinfo>
			<releaseinfo role="meta">
			$Id: latex.mapping.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
			</releaseinfo>
			<authorgroup>
				&ramon; &james;
			</authorgroup>
			<copyright>
			<year>2000</year> <year>2001</year> <year>2002</year> <year>2003</year>
			<holder>Ramon Casellas</holder>
			</copyright>
			<revhistory>
				<doc:revision rcasver="1.11" entity="rev_2003_05"/>
			</revhistory>
		</referenceinfo>
		<title>The &DB2LaTeX; mapping system <filename>latex.mapping.xsl</filename></title>
		<partintro>
			<section><title>Introduction</title>
			<para>The &DB2LaTeX; mapping system centralises the mapping
			of &DocBook; tags (e.g. <doc:db>chapter</doc:db>)
			to &LaTeX; commands (e.g. <function>chapter</function>).
			It uses an auxiliary file, <filename>latex.mapping.xml</filename>,
			to define the start and end of each mapping.
			You can override this <quote>mapping file</quote>
			in order to customise &DB2LaTeX;.</para>
			</section>
		</partintro>
	</doc:reference>
	<!--############################################################################# -->

	<doc:param name="latex.mapping.xml">
		<refpurpose>The primary mapping file</refpurpose>
		<doc:description>
			&DB2LaTeX; will search for mappings in this file.
			The value of this variable must be an XML document.
			If mappings cannot be found in this file, &DB2LaTeX; will
			search the <link linkend="var.latex.mapping.xml.default">default mapping file</link>.
		</doc:description>
		<doc:samples>
			<simplelist type='inline'>
				&test_mapping;
			</simplelist>
		</doc:samples>
	</doc:param>
    <xsl:param name="latex.mapping.xml" select="document('latex.mapping.xml')"/>

	<doc:variable name="latex.mapping.xml.default">
		<refpurpose>The default mapping file</refpurpose>
		<doc:description>
			Defines the mapping file that &DB2LaTeX; will search
			when it cannot find a template in the
			<link linkend="param.latex.mapping.xml">primary mapping file</link>.
			The value of this variable must be an XML document.
		</doc:description>
	</doc:variable>
    <xsl:variable name="latex.mapping.xml.default" select="document('latex.mapping.xml')"/>

	<!--############################################################################# -->
	<!-- DOCUMENTATION -->
	<doc:template name="latex.mapping" xmlns="">
		<refpurpose>Perform &DocBook; to &LaTeX; mapping</refpurpose>
	</doc:template>
	<!--############################################################################# -->



    <xsl:template name="latex.mapping">
	<xsl:param name="object"  select="."/>
	<xsl:param name="keyword" select="local-name($object)"/>
	<xsl:param name="role" 	  select="begin"/>
	<xsl:param name="string">
		<xsl:call-template name="extract.object.title">
			<xsl:with-param name="object" select="$object"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="use.label"	select="1"/>
	<xsl:param name="use.hypertarget" 	select="1"/>
	<xsl:variable name="id">
	    <xsl:choose>
		<xsl:when test="$object/@id"> <xsl:value-of select="$object/@id"/> </xsl:when>
		<xsl:otherwise> <xsl:value-of select="generate-id($object)"/> </xsl:otherwise>
	    </xsl:choose>
	</xsl:variable>
	<xsl:variable name="title">
	    <xsl:choose>
		<xsl:when test="starts-with(local-name($object),'informal')">
			<xsl:if test="$string!=''">
				<xsl:message>Ignoring title for <xsl:value-of select="local-name($object)"/>.</xsl:message>
			</xsl:if>
		</xsl:when>
		<xsl:when test="$string=''">
		    <xsl:call-template name="gentext.element.name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="normalize-space($string)"/>
		</xsl:otherwise>
	    </xsl:choose>
	</xsl:variable>
	
	<xsl:choose>
	    <xsl:when test="($latex.mapping.xml/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/@text 
	     		and ($latex.mapping.xml/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/@text!=''">
		<xsl:call-template name="string-replace">
		    <xsl:with-param name="to"><xsl:value-of select="$id"/></xsl:with-param>
		    <xsl:with-param name="from">%id%</xsl:with-param>
		    <xsl:with-param name="string">
			<xsl:call-template name="string-replace">
			    <xsl:with-param name="to"><xsl:value-of select="$title"/></xsl:with-param>
			    <xsl:with-param name="from">%title%</xsl:with-param>
			    <xsl:with-param name="string">
				<xsl:value-of select="($latex.mapping.xml/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/@text"/>
			    </xsl:with-param>
			</xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	    </xsl:when>

	    <xsl:when test="($latex.mapping.xml/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/line">
		<xsl:for-each select="($latex.mapping.xml/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/line">
		    <xsl:call-template name="string-replace">
			<xsl:with-param name="to"><xsl:value-of select="$id"/></xsl:with-param>
			<xsl:with-param name="from">%id%</xsl:with-param>
			<xsl:with-param name="string">
			    <xsl:call-template name="string-replace">
				<xsl:with-param name="to"><xsl:value-of select="$title"/></xsl:with-param>
				<xsl:with-param name="from">%title%</xsl:with-param>
				<xsl:with-param name="string" select="."/>
			    </xsl:call-template>
			</xsl:with-param>
		    </xsl:call-template>
		</xsl:for-each>
		</xsl:when>

	    <xsl:when test="($latex.mapping.xml.default/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/@text
			and ($latex.mapping.xml.default/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/@text!=''">
		<xsl:call-template name="string-replace">
		    <xsl:with-param name="to"><xsl:value-of select="$id"/></xsl:with-param>
		    <xsl:with-param name="from">%id%</xsl:with-param>
		    <xsl:with-param name="string">
			<xsl:call-template name="string-replace">
			    <xsl:with-param name="to"><xsl:value-of select="$title"/></xsl:with-param>
			    <xsl:with-param name="from">%title%</xsl:with-param>
			    <xsl:with-param name="string">
				<xsl:value-of select="($latex.mapping.xml.default/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/@text"/>
			    </xsl:with-param>
			</xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
	    </xsl:when>
	    <xsl:when test="($latex.mapping.xml.default/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])">
		<xsl:for-each select="($latex.mapping.xml.default/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])/line">
		    <xsl:call-template name="string-replace">
			<xsl:with-param name="to"><xsl:value-of select="$id"/></xsl:with-param>
			<xsl:with-param name="from">%id%</xsl:with-param>
			<xsl:with-param name="string">
			    <xsl:call-template name="string-replace">
				<xsl:with-param name="to"><xsl:value-of select="$title"/></xsl:with-param>
				<xsl:with-param name="from">%title%</xsl:with-param>
				<xsl:with-param name="string" select="."/>
			    </xsl:call-template>
			</xsl:with-param>
		    </xsl:call-template>
		</xsl:for-each>
		</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="no">
					<xsl:text>Warning: Unable to find LaTeX mapping for &#10;</xsl:text>
					<xsl:text>KEYWORD:</xsl:text><xsl:value-of select="$keyword"/><xsl:text>&#10;</xsl:text>
					<xsl:text>ROLE:</xsl:text><xsl:value-of select="$role"/><xsl:text>&#10;</xsl:text>
				</xsl:message>
			</xsl:otherwise>
	</xsl:choose>
    </xsl:template>




    <xsl:template name="map.begin">
	<xsl:param name="object"  select="."/>
	<xsl:param name="keyword" select="local-name($object)"/>
	<xsl:param name="string">
		<xsl:call-template name="extract.object.title">
			<xsl:with-param name="object" select="$object"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:call-template name="latex.mapping">
	    <xsl:with-param name="keyword" select="$keyword"/>
	    <xsl:with-param name="role">begin</xsl:with-param>
	    <xsl:with-param name="string" select="$string"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template name="map.end">
	<xsl:param name="object"  select="."/>
	<xsl:param name="keyword" select="local-name($object)"/>
	<xsl:param name="role" 	  select="begin"/>
	<xsl:param name="string">
		<xsl:call-template name="extract.object.title">
			<xsl:with-param name="object" select="$object"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:call-template name="latex.mapping">
	    <xsl:with-param name="keyword" select="$keyword"/>
	    <xsl:with-param name="string" select="$string"/>
	    <xsl:with-param name="role">end</xsl:with-param>
	</xsl:call-template>
    </xsl:template>

	<doc:template name="extract.object.title">
		<refpurpose>Choose a title for an object</refpurpose>
		<doc:description>
			Processes the <sgmltag class="startag">title</sgmltag> child
			of the specified object. Uses the context node as the default object.
		</doc:description>
		<doc:variables>
			<itemizedlist>
				<listitem><simpara><xref linkend="param.latex.apply.title.templates"/></simpara></listitem>
			</itemizedlist>
		</doc:variables>
		<doc:params>
			<variablelist>
				<varlistentry><term>object</term><listitem><simpara>The node for which a title is desired.</simpara></listitem></varlistentry>
			</variablelist>
		</doc:params>
	</doc:template>
	<xsl:template name="extract.object.title">
		<xsl:param name="object"  select="."/>
		<xsl:choose>
			<xsl:when test="$latex.apply.title.templates='1'">
				<xsl:apply-templates select="$object/title" mode="latex"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="normalize-scape">
					<xsl:with-param name="string" select="$object/title"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<doc:template match="title" mode="latex">
		<refpurpose>Process <doc:db>title</doc:db> elements</refpurpose>
		<doc:description>
			<para>Applies templates with no mode. This template is called by <xref linkend="template.extract.object.title"/>.</para>
			<para>This differs from the modeless <doc:db>title</doc:db>
			templates because they suppress the output of titles.</para>
		</doc:description>
	</doc:template>
	<xsl:template match="title" mode="latex"><xsl:apply-templates/></xsl:template>

</xsl:stylesheet>

