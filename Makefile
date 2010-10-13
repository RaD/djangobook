BUILDFARM=../docbookxml.farm
DOCLANG=ru
CSS=djangobook.css

include $(BUILDFARM)/make/default-variables.mk

BASE_NAME=djangobook
PROF_NAME=$(BASE_NAME)
XML_NAME=$(BASE_NAME).xml
TEX_NAME=$(BASE_NAME).tex
HTML_NAME=$(BASE_NAME).html
XML_PROF_NAME=$(BASE_NAME)-prof.xml
TUNED_NAME=$(XML_PROF_NAME).tuned
PDF_NAME=$(BASE_NAME).pdf
HTML_NAME=$(BASE_NAME).html
FO_NAME=$(BASE_NAME).fo
RTF_NAME=$(BASE_NAME).rtf
WORDML_NAME=$(BASE_NAME).wordml.xml

PROFPARAMS= --stringparam "profile.os" "$(OSNAME)" \
	--stringparam "profile.vendor" "$(DBNAME)" \
	--stringparam "profile.lang" "$(DOCLANG)"

XML_SOURCES=chap01.xml chap02.xml chap03.xml chap04.xml \
	chap05.xml chap06.xml chap07.xml chap08.xml \
	chap09.xml chap10.xml chap11.xml chap12.xml \
	chap13.xml chap14.xml chap15.xml chap16.xml \
	chap17.xml chap18.xml chap19.xml chap20.xml \
	appendix_a.xml appendix_b.xml appendix_c.xml \
	appendix_d.xml appendix_e.xml appendix_f.xml \
	appendix_g.xml appendix_h.xml

all: html

html: $(HTML_NAME)
	xsltproc --nonet -o toc.py $(BUILDFARM)/xsl/docbook-pytoc.xsl $(XML_PROF_NAME)
	mv toc.py HTML/$(BASE_NAME)/

pdf: $(PDF_NAME)

wordml: $(WORDML_NAME)

DJZIP=djangobook.html.zip

zip:
	mkdir ./zip;
	for i in HTML/$(BASE_NAME)/*.html; do \
	    echo `basename $$i`; \
	    cat $$i | \
	    sed 's/^.*<body[^>]*>//' | \
	    sed 's/<\/body>.*$$//' \
	    > ./zip/`basename $$i`; \
	done;
	cp -r HTML/$(BASE_NAME)/toc.py HTML/$(BASE_NAME)/pics ./zip/;
	cd ./zip; \
	zip --move --quiet --recurse-paths ../$(DJZIP) ./*; \
	cd -; \
	rmdir ./zip; \

koi2utf: $(XML_NAME) $(XML_SOURCES)
	for i in $(XML_NAME) $(XML_SOURCES); do \
		sed 's/koi8-r/utf-8/' < $$i | \
		iconv -f koi8-r -t utf-8 > $$i.U; \
		mv $$i $$i.K; \
		mv $$i.U $$i; \
	done;

utf2koi: $(XML_NAME) $(XML_SOURCES)
	for i in $(XML_NAME) $(XML_SOURCES); do \
		sed 's/utf-8/koi8-r/' < $$i | \
		iconv -f utf-8 -t koi8-r > $$i.K; \
		mv $$i $$i.U; \
		mv $$i.K $$i; \
	done;

include $(BUILDFARM)/make/common.mk

