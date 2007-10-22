<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY % xsldoc.ent SYSTEM "./xsldoc.ent"> %xsldoc.ent; ]>
<!--############################################################################# 
|	$Id: para.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
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
	<doc:reference id="para" xmlns="">
		<referenceinfo>
			<releaseinfo role="meta">
				$Id: para.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
			</releaseinfo>
			<authorgroup>
				&ramon;
				&james;
			</authorgroup>
			<copyright>
				<year>2000</year> <year>2001</year> <year>2002</year> <year>2003</year>
				<holder>Ramon Casellas</holder>
			</copyright>
			<revhistory>
				<doc:revision rcasver="1.8" entity="rev_2003_05"/>
			</revhistory>
		</referenceinfo>
		<title>Paragraphs <filename>para.mod.xsl</filename></title>
		<partintro>
			<para>The file <filename>para.mod.xsl</filename> contains the
			XSL template for <doc:db>para</doc:db>, <doc:db>simpara</doc:db> and <doc:db>formalpara</doc:db>.</para>
			<doc:variables>
				<itemizedlist>
					<listitem><simpara><xref linkend="param.latex.use.parskip"/></simpara></listitem>
					<listitem><simpara><xref linkend="param.latex.formalpara.title.style"/></simpara></listitem>
				</itemizedlist>
			</doc:variables>
		</partintro>
	</doc:reference>




	<doc:template match="para|simpara" xmlns="">
		<refpurpose>Process <doc:db>para</doc:db> and <doc:db>simpara</doc:db> elements</refpurpose>
		<doc:description>
			<para>
				Starts new lines above and below its contents.
				Thus, consecutive <doc:db>para</doc:db>s will have
				one blank line between them.
			</para>
		</doc:description>
		<doc:variables>
			<itemizedlist>
				<listitem><simpara><xref linkend="param.latex.use.parskip"/></simpara></listitem>
			</itemizedlist>
		</doc:variables>
		<doc:notes>
			<para>In &latex;, there is no distinction between <doc:db>para</doc:db> and <doc:db>simpara</doc:db>.</para>
			<para>The accuracy of block elements within <sgmltag>para</sgmltag>s is unknown.</para>
			<para><doc:todo>The use of <sgmltag>para</sgmltag> within <doc:db>footnote</doc:db>s is unproven.</doc:todo></para>
		</doc:notes>
		<doc:samples>
			<simplelist type='inline'>
				&test_blocks;
			</simplelist>
		</doc:samples>
		<doc:seealso>
			<itemizedlist>
				<listitem><simpara><xref linkend="template.para-noline"/></simpara></listitem>
			</itemizedlist>
		</doc:seealso>
	</doc:template>
	<xsl:template match="para|simpara">
		<xsl:text>&#10;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

	<doc:template match="formalpara" xmlns="">
		<refpurpose>Process <doc:db>formalpara</doc:db> elements</refpurpose>
		<doc:description>
			<para>
				Starts new lines above and below its contents.
			</para>
		</doc:description>
		<doc:variables>
			<itemizedlist>
				<listitem><simpara>The <doc:db>title</doc:db> is typeset using <xref linkend="param.latex.formalpara.title.style"/></simpara></listitem>
			</itemizedlist>
		</doc:variables>
		<doc:notes>
			<para>The accuracy of block elements within <doc:db>formalpara</doc:db>s is unknown.</para>
			<para><doc:todo>The use of <sgmltag>formalpara</sgmltag> within <doc:db>footnote</doc:db>s is unproven.</doc:todo></para>
		</doc:notes>
		<doc:samples>
			<simplelist type='inline'>
				&test_blocks;
			</simplelist>
		</doc:samples>
	</doc:template>
	<xsl:template match="formalpara">
		<xsl:text>&#10;{</xsl:text>
		<xsl:value-of select="$latex.formalpara.title.style"/>
		<xsl:text>{</xsl:text>
		<xsl:apply-templates select="self::title"/>
		<xsl:text>}} </xsl:text>
		<xsl:apply-templates select="*[not(self::title)]"/>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

	<doc:template xmlns="">
		<refpurpose>Suppressed paragraphs</refpurpose>
		<doc:description>
			<para>
				These paragraphs are not separated like normal paragraphs.
			</para>
		</doc:description>
		<doc:variables>
			&no_var;
		</doc:variables>
		<doc:notes>
			<para>This template exists to handle &latex; problems with
			<function>par</function> in certain contexts. <doc:todo>These
			problems should be periodically reviewed by the &db2latex; team.</doc:todo></para>
		</doc:notes>
		<doc:samples>
			<simplelist type='inline'>
				&test_blocks;
			</simplelist>
		</doc:samples>
	</doc:template>
	<xsl:template match="textobject/para|step/para|entry/para|question/para" name="para-noline">
		<xsl:if test="position()&gt;1">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<xsl:if test="position()&lt;last()">
			<xsl:text> </xsl:text>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
