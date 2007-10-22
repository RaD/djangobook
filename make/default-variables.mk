# -*- mode: Makefile -*-

#alt DBXSL_DIR=/usr/share/xml/docbook/xsl-stylesheets
DBXSL_DIR=/usr/share/xml/docbook/stylesheet/nwalsh
JETXSL_DIR=$(DOC_TOP)/xsl

PDFLATEX=pdflatex
# options for pdflatex
PDFLATEX_OPTS= -interaction batchmode -output-format pdf

PRINT_STYLE=$(JETXSL_DIR)/print/jet-$(DOCLANG).xsl
#HTML_STYLE=$(DBXSL_DIR)/html/chunk.xsl
HTML_STYLE=$(DBXSL_DIR)/html/docbook.xsl
PROFILE_STYLE=$(DBXSL_DIR)/profiling/profile.xsl
FO_STYLE=$(DBXSL_DIR)/fo/docbook.xsl
RTF_STYLE=$(JETXSL_DIR)/docbook-rtf.xsl
WORDML_STYLE=$(JETXSL_DIR)/docbook-wordml.xsl

# common xsltproc params
XSLTPARAMS=--nonet --xinclude \
    --stringparam "html.stylesheet" "css/jet-docs.css" 

# Output encoding for html
ENCODING=--stringparam chunker.output.encoding koi8-r

ARRANGE_PARAMS= --stringparam tag-level1 book  --stringparam tag-level2 part --stringparam tag-level3 chapter



