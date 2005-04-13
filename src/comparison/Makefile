all: comparison.html 

db: scm-comparison.pdf

comparison.dtd: gen-dtd.pl
	perl $< > $@
	
comparison.html: render.pl scm-comparison.xml comparison.dtd
	perl render.pl

FILES = bk-license.html \
		compare-ml.xsl \
		comparison.dtd \
		comparison.html \
		gen-dtd.pl \
		Makefile \
		render.pl \
		render-docbook.pl \
		scm-comparison.xml

docbook/scm-comparison.xml: scm-comparison.xml render-docbook.pl $(PERL_MODULES)
	perl render-docbook.pl

scm-comparison.pdf: docbook/scm-comparison.xml
	db2pdf -c /etc/sgml/catalog -d './mystyle.dsl#print' $<

arc: all-files.tar.gz

all-files.tar.gz: $(FILES)
	mkdir arc-temp
	mkdir arc-temp/XML
	mkdir arc-temp/XML/CompareML
	for i in $(FILES) ; do cp $$i arc-temp/$$i ; done
	mv arc-temp SCM-Comparison
	tar -czvf $@ SCM-Comparison
	rm -fr SCM-Comparison

upload: all arc $(FILES)
	rsync --progress -v --rsh=ssh --relative all-files.tar.gz $(FILES) shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/comparison

xslt: comparison-xsl.html
	
comparison-xsl.html: scm-comparison.xml compare-ml.xsl
	xsltproc compare-ml.xsl scm-comparison.xml > $@

