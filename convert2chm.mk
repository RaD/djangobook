HTML=$(wildcard *.html)
HTM=$(patsubst %.html,%.htm,$(HTML))

all:
	echo "Just copy convert2chm.mk to separate directory."
	echo "Then copy html files of djangobook to this directory."
	echo "Run 'make convert' and proceed to chm converter."

convert: $(HTM)

clean: $(HTM)
	rm -f $(HTM)

%.htm: %.html
	iconv -c -f utf-8 -t cp1251 $< | sed 's/utf-8/windows-1251/' > $*.htm
	mv $*.htm $<
