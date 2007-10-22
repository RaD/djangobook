# -*- Makefile -*-

$(XML_PROF_NAME): $(XML_NAME) $(XML_SOURCES)
	xsltproc $(XSLTPARAMS) -o $(XML_PROF_NAME) \
		 $(PROFPARAMS) $(PROFILE_STYLE) $(XML_NAME)

$(TUNED_NAME): $(XML_PROF_NAME)
	xsltproc $(XSLTPROC_PARAMS) -o $(TUNED_NAME) \
	$(JETXSL_DIR)/common/tuning.xsl $(XML_PROF_NAME)

$(WORDML_NAME): $(TUNED_NAME)
	xsltproc -v --stringparam "template" "jetmanual.xml" -o $(WORDML_NAME) $(WORDML_STYLE) $(TUNED_NAME)

$(FO_NAME): $(TUNED_NAME)
	xsltproc -o $(FO_NAME) $(FO_STYLE) $(TUNED_NAME)

$(RTF_NAME): $(TUNED_NAME)
	xsltproc -o $(RTF_NAME) $(RTF_STYLE) $(TUNED_NAME)

$(TEX_NAME): $(TUNED_NAME)
	xsltproc $(XSLTPARAMS) -o $(TEX_NAME) $(PRINT_STYLE) $(TUNED_NAME)

$(PDF_NAME): $(TEX_NAME)
	$(PDFLATEX) $(PDFLATEX_OPTS) $(TEX_NAME) 
	while grep 'Label(s) may have changed' "`basename "$(TEX_NAME)" .tex`.log" > /dev/null 2>&1 ; do \
		$(PDFLATEX) $(PDFLATEX_OPTS) $(TEX_NAME) ; \
	done 
	mkdir -p ../PDF/ ; \
	mv -f *.pdf ../PDF/

$(HTML_NAME): $(TUNED_NAME)
	mkdir -p ../HTML/$(PROF_NAME)
	xsltproc $(XSLTPARAMS) $(ENCODING) -o $(HTML_NAME) $(HTML_STYLE) \
		 $(TUNED_NAME) ; \
	mv -f *.html ../HTML/$(PROF_NAME)

#compile-html: $(TUNED_NAME)
#	mkdir -p ../$(PROF_NAME)
#	xsltproc $(XSLTPARAMS) $(ENCODING) -o $(HTML_NAME) $(HTML_STYLE) \
#		 $(TUNED_NAME)
#	mv -f *.html ../$(PROF_NAME)

clean:
	@rm -f *~ *.aux *.fot *.glo *.idx *.log $(TUNED_NAME) $(XML_PROF_NAME) \
	       *.out *.tex *.toc semantic.cache* $(PDF_NAME) $(TEX_NAME) $(FO_NAME) $(RTF_NAME) 
