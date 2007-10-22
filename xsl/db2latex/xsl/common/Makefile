#
# $Id: Makefile,v 1.1 2005/12/05 08:19:41 rpopov Exp $
#
# Makefile for generating source locale files from DB2LaTeX and DocBook l10n
# Author: Vitaly Ostanin <vyt@altlinux.ru>
#
# WARNING: this Makefile works only with $lang.xml files. 
# WARNING: It doesn't sync l10n.xml l10n.dtd l10n.xsl
#

XSLTPROC_PARAMS		= --nonet --xinclude
SOURCE_STYLE		= locale-leave-uniq-keys.xsl
WORKING_STYLE		= locale-generate-working-files.xsl
DOCBOOK_L10N		= http://docbook.sourceforge.net/release/xsl/current/common/l10n.xml

generate-locale-working:
	xsltproc $(XSLTPROC_PARAMS) $(WORKING_STYLE) locale-source.*

generate-locale-source:
	xsltproc $(XSLTPROC_PARAMS) $(SOURCE_STYLE) $(DOCBOOK_L10N)
