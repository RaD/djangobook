<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY % xsldoc.ent SYSTEM "./xsldoc.ent"> %xsldoc.ent; ]>
<!--############################################################################# 
|	$Id: vars.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $		
|- #############################################################################
|	$Author: rpopov $
|
|   PURPOSE: User and stylesheets XSL variables 
+ ############################################################################## -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    exclude-result-prefixes="doc" version='1.0'>


    <doc:reference id="vars" xmlns="">
	<referenceinfo>
	    <releaseinfo role="meta">
		$Id: vars.mod.xsl,v 1.1 2005/12/05 08:19:40 rpopov Exp $
	    </releaseinfo>
	    <authorgroup>
		<author><surname>Casellas</surname><firstname>Ramon</firstname></author>
		<author><surname>Devenish</surname><firstname>James</firstname></author>
	    </authorgroup>
	    <copyright>
		<year>2000</year><year>2001</year><year>2002</year><year>2003</year>
		<holder>Ramon Casellas</holder>
	    </copyright>
	</referenceinfo>

	<title>XSL Variables and Parameters</title>

	<partintro>
	    <section><title>Introduction</title>

		<para>This is technical reference documentation for the DocBook XSL
		    Stylesheets. It documents (some of) the parameters, templates, and
		    other elements of the stylesheets.</para>
	    </section>
	</partintro>
    </doc:reference>


    <!--############################################################################# 
    |  COMMON VARIABLES
    |- #############################################################################
    |	$Author: rpopov $
    |
    + ############################################################################## -->
    <xsl:variable name="default-classsynopsis-language">java</xsl:variable>

    <xsl:variable name="author.othername.in.middle" select="1"/>
    <xsl:variable name="refentry.xref.manvolnum" select="1"/>
    <xsl:variable name="funcsynopsis.style">kr</xsl:variable>
    <xsl:variable name="funcsynopsis.decoration" select="1"/>
    <xsl:variable name="function.parens">0</xsl:variable>
    <xsl:variable name="refentry.generate.name" select="1"/>

	<doc:param name="show.comments" xmlns="">
	<refpurpose> Display <sgmltag class="element">comment</sgmltag> elements? </refpurpose>
	<refdescription>
		<para>Control the display of <sgmltag class="element">comment</sgmltag>s and <sgmltag class="element">remark</sgmltag>s.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="show.comments" select="1"/>

    <xsl:variable name="section.autolabel" select="1"/>
    <xsl:variable name="section.label.includes.component.label" select="0"/>
    <xsl:variable name="chapter.autolabel" select="1"/>
    <xsl:variable name="preface.autolabel" select="0"/>
    <xsl:variable name="part.autolabel" select="1"/>
    <xsl:variable name="qandadiv.autolabel" select="1"/>
    <xsl:variable name="autotoc.label.separator" select="'. '"/>
    <xsl:variable name="qanda.inherit.numeration" select="1"/>
    <xsl:variable name="qanda.defaultlabel">number</xsl:variable>
    <xsl:param name="biblioentry.item.separator">, </xsl:param>
	<doc:param name="toc.section.depth" xmlns="">
	<refpurpose> Cull table-of-contents entries that are deeply nested </refpurpose>
	<refdescription>
		<para>Specifies the maximum depth before sections are omitted from the table of contents.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="toc.section.depth">4</xsl:param>

	<doc:param name="section.depth" xmlns="">
	<refpurpose> Control the automatic numbering of section, parts, and chapters </refpurpose>
	<refdescription>
		<para>
		Specifies the maximum depth before sections cease to be uniquely numbered.
		This is passed to LaTeX using the <literal>secnumdepth</literal> counter.
		Therefore, it is possible to use a value of <quote>0</quote> (zero) to disable section numbering.
		A value of <quote>-1</quote> will disable the numbering of parts and chapters, too.
		</para>
	</refdescription>
	</doc:param>
    <xsl:param name="section.depth">4</xsl:param>
    <xsl:variable name="graphic.default.extension"></xsl:variable>
    <xsl:variable name="check.idref">1</xsl:variable>
    <!--
    <xsl:variable name="link.mailto.url"></xsl:variable>
    <xsl:variable name="toc.list.type">dl</xsl:variable>
    -->

	<doc:param name="use.role.for.mediaobject" xmlns="">
	<refpurpose> Control <sgmltag class="element">mediaobject</sgmltag> selection methods </refpurpose>
	<refdescription>
		<para>This controls how DB2LaTeX behaves when a <sgmltag class="element">figure</sgmltag> contains
		multiple <sgmltag class="element">mediaobject</sgmltag>s. When enabled, DB2LaTeX will choose
		the mediaobject with the "LaTeX" or "TeX" role, if present. Otherwise, the first mediaobject
		is chosen.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="use.role.for.mediaobject">1</xsl:param>

	<doc:param name="preferred.mediaobject.role" xmlns="">
	<refpurpose> Control <sgmltag class="element">mediaobject</sgmltag> selection methods </refpurpose>
	<refdescription>
		<para>When <xref linkend="param.use.role.for.mediaobject"/> is enabled, this variable
		can be used to specify the mediaobject role that your document uses for LaTeX output.
		DB2LaTeX will try to use this role before using the "LaTeX" or "TeX" roles.
		For example, some authors may choose to set this to "PDF".</para>
	</refdescription>
	</doc:param>
	<xsl:param name="preferred.mediaobject.role"></xsl:param>

	<doc:param name="formal.title.placement" xmlns="">
	<refpurpose> Specifies where formal component titles should occur </refpurpose>
	<refdescription>
		<para>
			Titles for the formal object types (figure, example, quation, table, and procedure)
			can be placed before or after those objects. The keyword <quote>before</quote>
			is recognised. All other strings qualify as <quote>after</quote>.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="formal.title.placement">
		figure not_before
		example before
		equation not_before
		table before
		procedure before
	</xsl:param>

	<doc:param name="insert.xref.page.number" xmlns="">
	<refpurpose> Control the appearance of page numbers in cross references </refpurpose>
	<refdescription>
		<para>
			When enabled, <sgmltag class="element">xref</sgmltag>s will include page
			numbers after their generated cross-reference text.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="insert.xref.page.number">0</xsl:param>

	<doc:param name="ulink.show" xmlns="">
	<refpurpose> Control the display of URLs after ulinks </refpurpose>
	<refdescription>
		<para>
		When this option is enabled, and a ulink has a URL that is different
		from the displayed content, the URL will be typeset after the content.
		If the URL and content are identical, only one of them will appear.
		Otherwise, the URL is hyperlinked and the content is not.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="ulink.show">0</xsl:param>

	<doc:param name="ulink.footnotes" xmlns="">
	<refpurpose> Control the generation of footnotes for ulinks </refpurpose>
	<refdescription>
		<para>
		When this option is enabled, a ulink that has content different to its
		URL will have an associated footnote. The contents of the footnote
		will be the URL. If the ulink is within a footnote, the URL is shown
		after the content.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="ulink.footnotes">0</xsl:param>

	<doc:param name="ulink.protocols.relaxed" xmlns="">
	<refpurpose> Control string comparison for <sgmltag class="element">ulink</sgmltag>s </refpurpose>
	<refdescription>
		<para>
		When this options is enabled,...
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="ulink.protocols.relaxed">0</xsl:param>

    <!--############################################################################# 
    | 	LaTeX VARIABLES
    |- #############################################################################
    |	$Author: rpopov $
    |
    |   PURPOSE: User and stylesheets XSL variables 
    + ############################################################################## -->

	<doc:param name="latex.override" xmlns="">
	<refpurpose> Override DB2LaTeX's preamble with a custom preamble. </refpurpose>
	<refdescription>
		<para>
		When this variable is set, the entire DB2LaTeX premable will be superseded.
		<emphasis>You should not normally need or want to use this.</emphasis>
		It may cause LaTeX typesetting problems. This is a last resort or
		<quote>expert</quote> feature.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.override"></xsl:param>

	<doc:param name="latex.entities" xmlns="">
	<refpurpose> Control Unicode character handling. </refpurpose>
	<refdescription>
		<para>
		Normally, XSLT processors will convert SGML character entities into
		Unicode characters and DB2LaTeX doesn't have much chance to do anything
		toward converting them to LaTeX equivalents. We do not yet know how we
		can solve this problem best.
		</para>
		<para>
		Proposed values: 'catcode', 'unicode', 'extension'.
		Currently only 'catcode' is supported. All other values will
		cause no special handling except for certain mappings in MathML.
		In future, perhaps the 'unicode' LaTeX package could be of assistance.
		'Extension' could be an XSLT extension that handles the characters
		using a mapping table.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.entities"></xsl:param>

	<doc:param name="latex.alt.is.latex" xmlns="">
	<refpurpose> Control the escaping of <sgmltag class="element">alt</sgmltag> text </refpurpose>
	<refdescription>
		<para>
		Text within <sgmltag class="element">alt</sgmltag> elements is assumed to
		be valid LaTeX and is passed through unescaped by default. If this is not
		appropriate for your document, set this variable to something other than
		'1'.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.alt.is.latex">1</xsl:param>

	<doc:param name="latex.alt.is.preferred" xmlns="">
	<refpurpose> Control the use of <sgmltag class="element">alt</sgmltag> text </refpurpose>
	<refdescription>
		<para>
		By default, DB2LaTeX assumes that <sgmltag class="element">alt</sgmltag>
		text should be typeset in preference to any 
		<sgmltag class="element">mediaobject</sgmltag>s.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.alt.is.preferred">1</xsl:param>

	<!--
	<doc:variable name="latex.figure.position" xmlns="">
	<refpurpose> How to place floats. </refpurpose>
	<refdescription>
		<para>
		This variable is used as the positioning argument for floats.
		In future, this may be replaced by a dynamic mechanism that can
		honour DocBook placement attributes.
		</para>
	</refdescription>
	</doc:variable>
    <xsl:variable name="latex.figure.position">[hbt]</xsl:variable>
	-->

	<doc:param name="latex.apply.title.templates" xmlns="">
	<refpurpose> Whether to apply templates for component titles. </refpurpose>
	<refdescription>
		<para>
		Controls whether component titles will be generated by
		applying templates or by conversion to string values.
		When enabled, templates will be applied. This enables template
		expression in titles but may have problematic side-effects such
		as nested links.
		</para>
		<note>
			<para>
				This variable does not influence all <sgmltag class="element">title</sgmltag>
				elements. Some may have their own configuration variables or be non-configurable.
			</para>
		</note>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.apply.title.templates">1</xsl:param>





	<doc:param name="latex.apply.title.templates.admonitions" xmlns="">
	<refpurpose> Whether to apply templates for admonition titles. </refpurpose>
	<refdescription>
		<para>
		Controls whether admonition titles will be generated by
		applying templates or by conversion to string values.
		When enabled, templates will be applied.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.apply.title.templates.admonitions">1</xsl:param>






	<doc:param name="latex.graphics.formats" xmlns="">
	<refpurpose> Control <sgmltag class="element">imagedata</sgmltag> selection. </refpurpose>
	<refdescription>
		<para>This controls how DB2LaTeX behaves when a <sgmltag class="element">mediaobject</sgmltag> contains
		multiple <sgmltag class="element">imagedata</sgmltag>. When non-empty, DB2LaTeX will exclude
		imagedata that have a format no listed within this variable.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.graphics.formats"></xsl:param>






	<doc:param name="latex.caption.swapskip" xmlns="">
	<refpurpose> Improved typesetting of captions  </refpurpose>
	<refdescription>
		<para>
		DB2LaTeX supports <link linkend="param.formal.title.placement">$formal.title.placement</link>
		as a mechanism for choosing whether captions will appear above or below the objects they describe.
		<!--
		($formal.title.placement is described in the <ulink
		url="http://docbook.sourceforge.net/release/xsl/current/doc/html/formal.title.placement.html">DocBook
		XSL Stylesheet HTML Parameter Reference</ulink>.)
		-->
		However, LaTeX will often produce an ugly result when captions occur
		above their corresponding content. This usually arises because of
		unsuitable \abovecaptionskip and \belowcaptionskip.
		</para>
		<para>
		This variable, when set to '1', authorises DB2LaTeX to swap the caption
		'skip' lengths when a caption is placed <emphasis>above</emphasis> its
		corresponding content. This is enabled by default.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.caption.swapskip">1</xsl:param>





	<doc:param name="latex.titlepage.file" xmlns="">
	<refpurpose> DB2LaTeX allows using an (externally generated) cover page  </refpurpose>
	<refdescription>
		<para>
		You may supply a LaTeX file that will supersede DB2LaTeX's default
		cover page or title. If the value of this variable is non-empty, the
		generated LaTeX code includes \input{filename}. Otherwise, it uses the
		\maketitle command.
		</para>
		<warning><para>
			Bear in mind that using an external cover page breaks the
			"encapsulation" of DocBook. Further revisions of these stylesheets
			will add chunking support, and the automation of the cover file
			generation.
		</para></warning>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.titlepage.file">title</xsl:param>




	<doc:param name="latex.documentclass" xmlns="">
	<refpurpose> DB2LaTeX document class </refpurpose>
	<refdescription>
		<para>
		This variable is normally empty and the stylesheets will determine
		the correct document class according to whether the document is a
		book or an article. If you wish to use your own document class,
		put its non-empty value in this variable. It will apply for both
		books and articles.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.documentclass"></xsl:param>

	<doc:param name="latex.documentclass.common" xmlns="">
	<refpurpose> DB2LaTeX document class options  </refpurpose>
	<refdescription>
		<para>
		These are the first options to be passed to <literal>\documentclass</literal>
		(The common options are
		<!--
		set to <literal>french,english</literal>
		-->
		blank
		by default.)
		They will be augmented or superseded by article/book options (see $latex.documentclass.article and $latex.documentclass.book) and pdftex/dvips options (see $latex.documentclass.pdftex and $latex.documentclass.dvips).
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.documentclass.common"></xsl:param>

	<doc:param name="latex.documentclass.article" xmlns="">
	<refpurpose> DB2LaTeX document class options for articles</refpurpose>
	<refdescription>
		<para>
		The article options are set to <literal>a4paper,10pt,twoside,twocolumn</literal> by default.
		These are the intermediate options to be passed to <literal>\documentclass</literal>,
		between the common options and the pdftex/dvips options.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.documentclass.article">a4paper,10pt,twoside,twocolumn</xsl:param>

	<doc:param name="latex.documentclass.book" xmlns="">
	<refpurpose> DB2LaTeX document class options for books</refpurpose>
	<refdescription>
		<para>
		The book options are set to <literal>a4paper,10pt,twoside,openright</literal> by default.
		These are the intermediate options to be passed to <literal>\documentclass</literal>,
		between the common options and the pdftex/dvips options.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.documentclass.book">a4paper,10pt,twoside,openright</xsl:param>

	<doc:param name="latex.documentclass.pdftex" xmlns="">
	<refpurpose> DB2LaTeX document class options for pdfTeX output</refpurpose>
	<refdescription>
		<para>
		The pdfTeX options are empty by default.
		These are the last options to be passed to <literal>\documentclass</literal>
		and override the common/article/book options.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.documentclass.pdftex"></xsl:param>

	<doc:param name="latex.documentclass.dvips" xmlns="">
	<refpurpose> DB2LaTeX document class options for dvips output</refpurpose>
	<refdescription>
		<para>
		The dvips options are empty by default.
		These are the last options to be passed to <literal>\documentclass</literal>
		and override the common/article/book options.
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.documentclass.dvips"></xsl:param>

	<doc:param name="latex.admonition.path" xmlns="">
	<refpurpose> LaTeX location for admonition graphics </refpurpose>
	<refdescription>
		<para>The file path that will be passed to LaTeX in order to find admonition graphics.</para>
		<para>An empty value suppresses the use of admonition graphics.</para>
		<para>If your figures are in <quote>the current directory</quote> then use a value of
		<quote>.</quote> (i.e. the full stop or period on its own) to signify this.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.admonition.path">figures</xsl:param>


	<doc:param name="latex.admonition.imagesize" xmlns="">
	<refpurpose> DB2LaTeX graphics admonitions size</refpurpose>
	<refdescription>
		<para>
			Is passed as an optional parameter for <literal>\includegraphics</literal> and
			can take on any such legal values (or be empty).
		</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.admonition.imagesize">width=1cm</xsl:param>


	<!--
	<xsl:param name="latex.chapter.label">1</xsl:param>

    <doc:param name="latex.chapter.hypertarget" xmlns="">
	<refpurpose> Hypertarget Chapters  </refpurpose>
	<refdescription>
	    <para>
	    </para>
	</refdescription>
    </doc:param>
    <xsl:param name="latex.chapter.hypertarget">1</xsl:param>
	-->


	<doc:param name="latex.biblio.output" xmlns="">
	<refpurpose> Control which references are cited in the bibliography </refpurpose>
	<refdescription>
		<para>
		The DB2LaTeX generated bibliography (bibitems) may either
		include all biblioentries found in the document, or only thee ones explicitly
		cited with <sgmltag class="element">citation</sgmltag>.
		</para>
	    <para>Two values are possible: <quote>all</quote> or <quote>cited</quote>.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.biblio.output">all</xsl:param>


	<doc:param name="latex.bibfiles" xmlns="">
	<refpurpose>
		Control the output of the \bibliography{.bib}.
	</refpurpose>
	<refdescription>
		<para>The value of this parameter is output.</para>
		<para>An example is <quote><filename>citations.bib</filename></quote>,
		if your BibTeX file has that name.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.bibfiles"></xsl:param>


	<doc:param name="latex.bibwidelabel" xmlns="">
	<refpurpose> Adjust bibliography formatting </refpurpose>
	<refdescription>
		<para>The environment bibliography accepts a parameter that indicates
		the widest label, which is used to correctly format the bibliography
		output. The value of this parameter is output inside the
		<literal>\begin{thebibliography[]}</literal> LaTeX command.</para>
	</refdescription>
	</doc:param>
	<xsl:param name="latex.bibwidelabel">WIDELABEL</xsl:param>

	<!--
	<xsl:variable name="latex.dont.label">0</xsl:variable>
	<xsl:variable name="latex.dont.hypertarget">0</xsl:variable>
	-->

	<doc:param name="latex.use.ucs" xmlns="">
		<refpurpose> Choose whether to use the <productname>unicode</productname> LaTeX package</refpurpose>
		<refdescription><para>See the <productname>unicode</productname> documentation for details.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.ucs">0</xsl:param>

	<doc:param name="latex.ucs.options" xmlns="">
		<refpurpose>Select the optional parameter(s) for the <productname>unicode</productname> LaTeX package</refpurpose>
		<refdescription><para>See the <productname>unicode</productname> documentation for details.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.ucs.options"></xsl:param>

	<doc:param name="latex.babel.language" xmlns="">
		<refpurpose>Select the optional parameter for the <productname>babel</productname> LaTeX package</refpurpose>
		<refdescription>
			<para>See the <productname>babel</productname> documentation for details.</para>
			<para>Although DB2LaTeX will try to choose the correct babel options for your
			document, you may need to specify the correct choice here. The special value
			of 'none' (without the quotes) will cause DB2LaTeX to skip babel configuration.</para>
		</refdescription>
	</doc:param>
	<xsl:param name="latex.babel.language"></xsl:param>

	<doc:param name="latex.use.isolatin1" xmlns="">
		<refpurpose>Toggle the use of the <productname>isolatin1</productname> LaTeX package</refpurpose>
		<refdescription>
			<warning><para>
			This option is deprecated. See <xref linkend="variable.latex.inputenc"/>.
			</para></warning>
		</refdescription>
	</doc:param>
	<xsl:variable name="latex.use.isolatin1">0</xsl:variable>

	<doc:param name="latex.inputenc" xmlns="">
		<refpurpose>Control the use of the <productname>inputenc</productname> LaTeX package</refpurpose>
		<refdescription>
			<para>
			If this option is non-empty, the <productname>inputenc</productname> package
			will be used with the specified encoding. This should agree with the your driver
			file. For example, the default value of <literal>latin1</literal>
			is compatible with <filename>docbook.xsl</filename>, which contains
			<literal><![CDATA[<xsl:output method="text" encoding="ISO-8859-1" indent="yes"/>]]></literal>
			</para>
			<para>
			If this option is empty, the <productname>inputenc</productname> package
			will not be invoked by <productname>DB2LaTeX</productname>.
			</para>
			<segmentedlist>
				<title>Common Combinations</title>
				<segtitle>Output Encoding</segtitle><segtitle><productname>inputenc</productname> Option</segtitle>
				<seglistitem><seg>ISO-8859-1</seg><seg>latin1</seg></seglistitem>
				<seglistitem><seg>UTF-8</seg><seg>utf8<footnote><simpara>When used in conjunction with a package such as <productname>unicode</productname>.</simpara></footnote></seg></seglistitem>
			</segmentedlist>
			<para>
			<productname>inputenc</productname> is a <productname>LaTeX</productname> base package.
			</para>
		</refdescription>
	</doc:param>
	<xsl:variable name="latex.inputenc">latin1</xsl:variable>

	<doc:param name="latex.fontenc" xmlns="">
		<refpurpose> Options for the <productname>fontenc</productname> package </refpurpose>
		<refdescription>
		</refdescription>
	</doc:param>
	<xsl:variable name="latex.fontenc"></xsl:variable>

	<doc:param name="latex.use.hyperref" xmlns="">
		<refpurpose>Toggle the use of the <productname>hyperref</productname> LaTeX package</refpurpose>
		<refdescription><para>This is used extensively for hyperlinking within documents.</para></refdescription>
	</doc:param>
	<xsl:variable name="latex.use.hyperref">1</xsl:variable>

	<doc:param name="latex.use.fancybox" xmlns="">
		<refpurpose>Toggle the use of the <productname>fancybox</productname> LaTeX package</refpurpose>
		<refdescription><para>This is essential for admonitions.</para></refdescription>
	</doc:param>
	<xsl:variable name="latex.use.fancybox">1</xsl:variable>

	<doc:param name="latex.use.fancyvrb" xmlns="">
		<refpurpose>Toggle the use of the <productname>fancyvrb</productname> LaTeX package</refpurpose>
		<refdescription><para>Provides support for tabbed whitespace in verbatim environments.
		See also <xref linkend="param.latex.fancyvrb.tabsize"/>.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.fancyvrb">1</xsl:param>

	<doc:param name="latex.fancyvrb.tabsize" xmlns="">
		<refpurpose>Choose indentation for tabs in verbatim environments</refpurpose>
		<refdescription><para>When <xref linkend="param.latex.use.fancyvrb"/> is enabled,
		this variable sets the width of a tab in terms of an equivalent number of spaces.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.fancyvrb.tabsize">3</xsl:param>

	<doc:template name="latex.fancyvrb.options" xmlns="">
		<refpurpose>Insert <productname>LaTeX</productname> options for <productname>fancyvrb</productname> Verbatim environments</refpurpose>
	</doc:template>
	<xsl:template name="latex.fancyvrb.options"/>

	<doc:param name="latex.use.fancyhdr" xmlns="">
		<refpurpose>Toggle the use of the <productname>fancyhdr</productname> LaTeX package</refpurpose>
		<refdescription><para>Provides page headers and footers. Disabling support for
		this package will make headers and footer go away.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.fancyhdr">1</xsl:param>

	<doc:param name="latex.use.parskip" xmlns="">
		<refpurpose>Toggle the use of the <productname>parskip</productname> &latex; package</refpurpose>
		<doc:description>
			<para>Use <quote>block</quote> paragraph style instead of indentation.</para>
		</doc:description>
		<doc:notes>
			<para><productname>parskip</productname> introduces vertical whitespace between
			paragraphs and list items. However, &db2latex;'s <doc:db>toc</doc:db> and
			<doc:db>lot</doc:db> templates attempt to suppress this whitespace.</para>
		</doc:notes>
		<doc:seealso>
			<itemizedlist>
				<listitem><simpara><xref linkend="template.para"/></simpara></listitem>
			</itemizedlist>
		</doc:seealso>
	</doc:param>
	<xsl:param name="latex.use.parskip">0</xsl:param>

	<doc:param name="latex.use.subfigure" xmlns="">
		<refpurpose>Toggle the use of the <productname>subfigure</productname> LaTeX package</refpurpose>
		<refdescription><para>Used to provide nice layout of multiple mediaobjects in figures.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.subfigure">1</xsl:param>

	<doc:param name="latex.use.rotating" xmlns="">
		<refpurpose>Toggle the use of the <productname>rotating</productname> LaTeX package</refpurpose>
	</doc:param>
	<xsl:param name="latex.use.rotating">1</xsl:param>

	<doc:param name="latex.use.tabularx" xmlns="">
		<refpurpose>Toggle the use of the <productname>tabularx</productname> LaTeX package</refpurpose>
		<refdescription><para>Used to provide certain table features. Has some incompatabilities
		with packages, but also solves some conflicts that the regular tabular
		environment has.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.tabularx">1</xsl:param>

	<doc:param name="latex.use.dcolumn" xmlns="">
		<refpurpose>Toggle the use of the <productname>dcolumn</productname> LaTeX package</refpurpose>
		<refdescription>
		<warning><para>
			Currently, <productname>dcolumn</productname> support does not function
			correctly.
		</para></warning>
		<para>
			<productname>dcolumn</productname> provides support for the <literal>char</literal>
			alignment of table cells.
		</para>
		<formalpara><title>See Also</title>
		<itemizedlist>
			<listitem><simpara><xref linkend="latex.decimal.point"/></simpara></listitem>
		</itemizedlist>
		</formalpara>
		</refdescription>
	</doc:param>
	<xsl:param name="latex.use.dcolumn">0</xsl:param>

	<xsl:param name="latex.decimal.point"/>

	<doc:param name="latex.use.ltxtable" xmlns="">
		<refpurpose>Toggle the use of the <productname>ltxtable</productname> LaTeX package</refpurpose>
		<refdescription>
		<note><para>
		This is not implemented as true ltxtable support, yet.
		It uses longtable until we can integrate proper ltxtable support.
		One the feature is supported, it should probably be enabled by
		default!
		</para></note>
		<para>If this package is used then tables will be have the capability
		to run over multiple pages when necessary.</para>
		<warning><para>
		Cells spanning multiple columns may require extra passes with LaTeX
		in order for column widths to 'converge'.
		</para></warning>
		</refdescription>
	</doc:param>
	<xsl:param name="latex.use.ltxtable">0</xsl:param>

	<doc:param name="latex.use.umoline" xmlns="">
		<refpurpose>Toggle the use of the <productname>umoline</productname> LaTeX package</refpurpose>
		<refdescription><para>Provide underlining.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.umoline">0</xsl:param>

	<doc:param name="latex.use.url" xmlns="">
		<refpurpose>Toggle the use of the <productname>url</productname> LaTeX package</refpurpose>
		<refdescription><para>Provide partial support for hyperlinks.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.url">1</xsl:param>

	<doc:param name="latex.use.makeidx" xmlns="">
		<refpurpose>Toggle the use of the <productname>makeidx</productname> LaTeX package</refpurpose>
		<refdescription><para>Support index generation.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.makeidx">1</xsl:param>

	<doc:param name="latex.use.varioref" xmlns="">
		<refpurpose>Toggle the use of the <productname>varioref</productname> LaTeX package</refpurpose>
		<refdescription><para>Support index generation.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.use.varioref">
		<!--
		<xsl:message>vars.mod.xsl: <xsl:value-of select="$insert.xref.page.number"/></xsl:message>
		-->
		<xsl:if test="$insert.xref.page.number='1'">1</xsl:if>
	</xsl:param>

	<doc:param name="latex.varioref.options" xmlns="">
		<refpurpose>Options for the <productname>varioref</productname> LaTeX package</refpurpose>
		<refdescription><para>Support index generation.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.varioref.options">
		<xsl:if test="$latex.language.option!='none'">
			<xsl:value-of select="$latex.language.option" />
		</xsl:if>
	</xsl:param>

	<doc:template name="latex.vpageref.options" xmlns="">
		<refpurpose>Toggle the use of the <productname>varioref</productname> LaTeX package</refpurpose>
		<refdescription><para>Support index generation.</para></refdescription>
	</doc:template>
	<xsl:template name="latex.vpageref.options">on this page</xsl:template>

	<doc:param name="latex.generate.indexterm" xmlns="">
		<refpurpose> Enable the generation of indexterms </refpurpose>
		<refdescription><para>Support index generation.</para></refdescription>
	</doc:param>
	<xsl:param name="latex.generate.indexterm">1</xsl:param>

	<doc:param name="latex.hyphenation.tttricks" xmlns="">
	<refpurpose> DB2LaTeX hyphenation linebreak tricks </refpurpose>
	<refdescription>
		<para>
		Usually, LaTeX does not perform hyphenation in <quote>teletype</quote> (monospace)
		text. This can lead to formatting problems. But certain monospace texts, such as
		URLs and filenames, have <quote>natural</quote> breakpoints such as full stops
		and slashes. DB2LaTeX's <quote>tttricks</quote> exploit a hyphenation trick in
		order to provide line wrapping in the middle of monospace text. Set this to '1'
		to enable these tricks (they are not enabled by default). See also the FAQ.
		</para>
	</refdescription>
	</doc:param>
    <xsl:variable name="latex.hyphenation.tttricks">0</xsl:variable>

	<doc:param name="latex.hyperref.param.common" xmlns="">
	<refpurpose> DB2LaTeX hyperref options</refpurpose>
	<refdescription>
		<para>
		In addition to this variable, you can specify additional options using
		<literal>latex.hyperref.param.pdftex</literal> or <literal>latex.hyperref.param.dvips</literal>.
		</para>
	</refdescription>
	</doc:param>
    <xsl:variable name="latex.hyperref.param.common">bookmarksnumbered,colorlinks,backref, bookmarks, breaklinks, linktocpage</xsl:variable>

	<doc:param name="latex.hyperref.param.pdftex" xmlns="">
	<refpurpose> DB2LaTeX hyperref options for pdfTeX output</refpurpose>
	<refdescription>
		<para>
		See the hyperref documentation for further information.
		</para>
	</refdescription>
	</doc:param>
	<xsl:variable name="latex.hyperref.param.pdftex">pdfstartview=FitH</xsl:variable>

	<doc:param name="latex.hyperref.param.dvips" xmlns="">
	<refpurpose> DB2LaTeX hyperref options for dvips output</refpurpose>
	<refdescription>
		<para>
		See the hyperref documentation for further information.
		</para>
	</refdescription>
	</doc:param>
	<xsl:variable name="latex.hyperref.param.dvips"></xsl:variable>

    <xsl:variable name="latex.fancyhdr.lh">Left Header</xsl:variable>
    <xsl:variable name="latex.fancyhdr.ch">Center Header</xsl:variable>
    <xsl:variable name="latex.fancyhdr.rh">Right Header</xsl:variable>
    <xsl:variable name="latex.fancyhdr.lf">Left Footer</xsl:variable>
    <xsl:variable name="latex.fancyhdr.cf">Center Footer</xsl:variable>
    <xsl:variable name="latex.fancyhdr.rf">Right Footer</xsl:variable>
	
    <doc:param name="latex.step.title.style" xmlns="">
	<refpurpose> Control the style of step titles  </refpurpose>
	<refdescription>
	    <para>Step titles are typeset in small caps but if
		this option is set to a LaTeX command, such as <literal>\textit</literal>, then
		that command will precede the title and it will be typeset accordingly.</para>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.step.title.style">\bf</xsl:variable>

    <doc:param name="latex.book.article.title.style" xmlns="">
	<refpurpose> Control the style of article titles within books </refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.book.article.title.style">\Large\textbf</xsl:variable>

    <doc:param name="latex.article.title.style" xmlns="">
	<refpurpose> Control the style of article titles </refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.article.title.style">\textbf</xsl:variable>

    <doc:param name="latex.pagestyle" xmlns="">
	<refpurpose> Override DB2LaTeX's choice of LaTeX page numbering style </refpurpose>
	<refdescription>
	    <para>By default, DB2LaTeX will choose the 'plain' or 'fancy' page styles,
		depending on <xref linkend="param.latex.use.fancyhdr"/>. If non-empty, this
		variable overrides the automatic selection. An example would be the literal
		string 'empty', to eliminate headers and page numbers.</para>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.pagestyle"></xsl:variable>

    <doc:param name="latex.procedure.title.style" xmlns="">
	<refpurpose> Control the style of procedure titles  </refpurpose>
	<refdescription>
	    <para>Procedure titles are typeset in small caps but if
		this option is set to a LaTeX command, such as <literal>\textit</literal>, then
		that command will precede the title and it will be typeset accordingly.</para>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.procedure.title.style">\sc</xsl:variable>

	<doc:param xmlns="">
		<refpurpose> Control the style of equation captions  </refpurpose>
		<doc:description>
			<para>The titles of <doc:db>formalpara</doc:db>s are typeset in the bold typeface by default.
			This parameter can be set to an alternative &latex; command, such as <function>textit</function> (or empty).</para>
		</doc:description>
	</doc:param>
	<xsl:param name="latex.formalpara.title.style">\textbf</xsl:param>

    <doc:param name="latex.equation.caption.style" xmlns="">
	<refpurpose> Control the style of equation captions  </refpurpose>
	<refdescription>
	    <para>Figure captions are typeset in the default typeface (usually 'roman') but if
		this option is set to a LaTeX command, such as <literal>\textit</literal>, then
		that command will precede the caption and it will be typeset accordingly.</para>
	</refdescription>
    </doc:param>
    <xsl:param name="latex.equation.caption.style"></xsl:param>

    <doc:param name="latex.example.caption.style" xmlns="">
	<refpurpose> Control the style of example captions  </refpurpose>
	<refdescription>
	    <para>Figure captions are typeset in the default typeface (usually 'roman') but if
		this option is set to a LaTeX command, such as <literal>\textit</literal>, then
		that command will precede the caption and it will be typeset accordingly.</para>
	</refdescription>
    </doc:param>
    <xsl:param name="latex.example.caption.style"></xsl:param>

    <doc:param name="latex.figure.caption.style" xmlns="">
	<refpurpose> Control the style of figure captions  </refpurpose>
	<refdescription>
	    <para>Figure captions are typeset in the default typeface (usually 'roman') but if
		this option is set to a LaTeX command, such as <literal>\textit</literal>, then
		that command will precede the caption and it will be typeset accordingly.</para>
	</refdescription>
    </doc:param>
    <xsl:param name="latex.figure.caption.style"></xsl:param>

    <doc:param name="latex.figure.title.style" xmlns="">
	<refpurpose> Control the style of figure titles  </refpurpose>
	<refdescription>
	    <para>Figure titles are typeset in the default typeface (usually 'roman') but if
		this option is set to a LaTeX command, such as <literal>\textit</literal>, then
		that command will precede the title and it will be typeset accordingly.</para>
	</refdescription>
    </doc:param>
    <xsl:param name="latex.figure.title.style"></xsl:param>

    <doc:param name="latex.table.caption.style" xmlns="">
	<refpurpose> Control the style of table captions  </refpurpose>
	<refdescription>
	    <para>Figure captions are typeset in the default typeface (usually 'roman') but if
		this option is set to a LaTeX command, such as <literal>\textit</literal>, then
		that command will precede the caption and it will be typeset accordingly.</para>
	</refdescription>
    </doc:param>
    <xsl:param name="latex.table.caption.style"></xsl:param>

    <doc:param name="latex.pdf.support" xmlns="">
	<refpurpose> Controls the output of LaTeX commands to support the generation 
	    of PDF files.</refpurpose>
	<refdescription>
	    <para>If this parameter is set to 1, the stylesheets generate code to 
		detect if it is either <literal>latex</literal> or <literal>pdflatex</literal>
		the shell command that is being used to compile the LaTeX text file. Some
		packages (<literal>graphicx</literal>, <literal>hyperref</literal>) are used
		with the right parameters. Finally, the graphic extensions declared, to use in
		<literal>\includegraphics</literal> commands depends also on which command is
		being used. If this parameter is set to zero, such code is not generated (which 
		does not mean that the file cannot compile with pdflatex, but some strange issues 
		may appear). <emphasis>DEFAULT: 1</emphasis> Only more code is generated. 
	    </para>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.pdf.support">1</xsl:variable>


    <doc:param name="latex.fancybox.options" xmlns="">
	<refpurpose> </refpurpose>
	<refdescription>
			<!--
			<xsl:if test="@role">
				<xsl:choose>
					<xsl:when test="@role='small'">
						<xsl:text>,fontsize=\small</xsl:text>
					</xsl:when>
					<xsl:when test="@role='large'">
						<xsl:text>,fontsize=\large</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
			-->
	</refdescription>
    </doc:param>
    <xsl:template name="latex.fancybox.options">
	<xsl:apply-templates/>
	</xsl:template>


    <doc:param name="latex.thead.row.entry" xmlns="">
	<refpurpose> Format the output of tabular headings. </refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:template name="latex.thead.row.entry">
	<xsl:apply-templates/>
	</xsl:template>

    <doc:param name="latex.tfoot.row.entry" xmlns="">
	<refpurpose> Format the output of tabular footers. </refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:template name="latex.tfoot.row.entry">
	<xsl:apply-templates/>
	</xsl:template>



    <doc:param name="latex.math.support" xmlns="">
	<refpurpose> Controls the output of LaTeX packages and commands to support 
	    documents with math commands and environments..</refpurpose>
	<refdescription>
	    <para>If this parameter is set to 1, the stylesheets generate code to 
		<emphasis>DEFAULT: 1</emphasis> Only more code is generated. 
	    </para>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.math.support">1</xsl:variable>



    <doc:param name="latex.output.revhistory" xmlns="">
	<refpurpose> Controls  if the revision history table is generated as the first document 
	    table.
	</refpurpose>
	<refdescription>
	    <para>If this parameter is set to 1, the stylesheets generate code to 
		<emphasis>DEFAULT: 1</emphasis> Only more code is generated. 
	    </para>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.output.revhistory">1</xsl:variable>




    <xsl:variable name="latex.book.preamble.pre">
    </xsl:variable>

    <xsl:variable name="latex.book.preamble.post">
    </xsl:variable>

    <doc:param name="latex.book.varsets" xmlns="">
	<refpurpose> 
	    All purpose commands to change text width, height, counters, etc.
		Defaults to a two-sided margin layout.
	</refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.book.varsets">
	<xsl:text>\usepackage{anysize}&#10;</xsl:text>
	<xsl:text>\marginsize{3cm}{2cm}{1.25cm}{1.25cm}&#10;</xsl:text>
    </xsl:variable>

    <doc:param name="latex.book.begindocument" xmlns="">
	<refpurpose> 
	    Begin document command
	</refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.book.begindocument">
	<xsl:text>\begin{document}&#10;</xsl:text>
    </xsl:variable>





    <doc:param name="latex.book.afterauthor" xmlns="">
	<refpurpose> 
	    LaTeX code that is output after the author (e.g. 
	    <literal>\makeindex, \makeglossary</literal>
	</refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.book.afterauthor">
	<xsl:text>% --------------------------------------------&#10;</xsl:text>
	<xsl:text>\makeindex&#10;</xsl:text>
	<xsl:text>\makeglossary&#10;</xsl:text>
	<xsl:text>% --------------------------------------------&#10;</xsl:text>
    </xsl:variable>




    <doc:param name="latex.book.end" xmlns="">
	<refpurpose> 
	    LaTeX code that is output  at the end of the document
	    <literal>\end{document}</literal>
	</refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.book.end">
	<xsl:text>% --------------------------------------------&#10;</xsl:text>
	<xsl:text>% End of document&#10;</xsl:text>
	<xsl:text>% --------------------------------------------&#10;</xsl:text>
	<xsl:text>\end{document}&#10;</xsl:text>
    </xsl:variable>



    <!--############################################################################# 
    | 	XSL VARIABLES FOR ARTICLES	
    |- #############################################################################
    |	$Author: rpopov $
    |
    + ############################################################################## -->



    <xsl:variable name="latex.article.preamble.pre">
    </xsl:variable>

    <xsl:variable name="latex.article.preamble.post">
    </xsl:variable>

    <doc:param name="latex.article.begindocument" xmlns="">
	<refpurpose> The begin document </refpurpose>
	<refdescription>The value of this variable is output from the article template
	    <xref linkend="template.article"/> after the author command. The default value
	    (shown below) is just the begin document command. Users of the XSL LaTeX
	    stylesheet may override this parameter in order to output what they want.
	</refdescription>
	<refreturn><literal>\begin{document}</literal></refreturn>
    </doc:param>
    <xsl:variable name="latex.article.begindocument">
	<xsl:text>\begin{document}&#10;</xsl:text>
    </xsl:variable>


    <doc:param name="latex.article.varsets" xmlns="">
	<refpurpose> Controls what is output after the LaTeX preamble. </refpurpose>
	<refdescription>
	    <para>Default values decrease edge margins and allow a large quantity of figures to be set on each page. </para>
	</refdescription>
    </doc:param>

    <xsl:variable name="latex.article.varsets">
	<xsl:text>
		\usepackage{anysize}
		\marginsize{2cm}{2cm}{2cm}{2cm}
	    \renewcommand\floatpagefraction{.9}
	    \renewcommand\topfraction{.9}
	    \renewcommand\bottomfraction{.9}
	    \renewcommand\textfraction{.1}
	</xsl:text>
    </xsl:variable>




    <doc:param name="latex.maketitle" xmlns="">
	<refpurpose> The <literal>\maketitle</literal> for books and articles. </refpurpose>
	<refdescription>
		<para>Some users may wish to override or eliminate <literal>\maketitle</literal>.</para>
		<note><para>Does not apply to <sgmltag class="element">article</sgmltag>s within <sgmltag class="element">book</sgmltag>s.</para></note>
		<para>By default, uses LaTeX <literal>\maketitle</literal> with the 'empty' pagestyle
		for the first page. The page style of subsequent pages is determined by
		<xref linkend="template.generate.latex.pagestyle"/>.</para>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.maketitle">
	<xsl:text>{\maketitle</xsl:text>
	<xsl:call-template name="generate.latex.pagestyle"/>
	<xsl:text>\thispagestyle{empty}}&#10;</xsl:text>
    </xsl:variable>


    <doc:param name="latex.article.end" xmlns="">
	<refpurpose> Controls what is output at the end of the article. Basically the <literal>\end{document}</literal>
	    command, with some markup comments.	</refpurpose>
	<refdescription>
	</refdescription>
    </doc:param>
    <xsl:variable name="latex.article.end">
	<xsl:text>&#10;</xsl:text>
	<xsl:text>% --------------------------------------------&#10;</xsl:text>
	<xsl:text>% End of document&#10;</xsl:text>
	<xsl:text>% --------------------------------------------&#10;</xsl:text>
	<xsl:text>\end{document}&#10;</xsl:text>
    </xsl:variable>



</xsl:stylesheet>

