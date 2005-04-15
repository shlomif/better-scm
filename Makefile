
RSYNC = rsync --progress --verbose --rsh=ssh

DEVEL_VER_USE_CACHE = 1

D = dest

WML_FLAGS = -DBERLIOS=BERLIOS

include include.mak
# IMAGES_PRE1 = $(shell cd src && (ls *.tar.gz *.zip *.patch *.css *.png bk/*.html aegis/*.txt subversion/*.txt))
IMAGES = $(addprefix $(D)/,$(IMAGES_PRE1))

# WML_FLAGS = -DBERLIOS=BERLIOS

HTMLS = $(addprefix $(D)/,$(HTMLS_PROTO))

INCLUDES = lib/MyNavData.pm lib/MyNavLinks.pm

# SUBDIRS_WITH_INDEXES = $(D)/win32_build $(D)/win32_build/bootstrap $(D)/win32_build/dynamic $(D)/win32_build/static
SUBDIRS_WITH_INDEXES = 

SUBDIRS = $(SUBDIRS_WITH_INDEXES) $(D) $(addprefix $(D)/,$(SUBDIRS_PROTO))

INDEXES = $(addsuffix /index.html,$(SUBDIRS_WITH_INDEXES))

# IMAGES += $(addprefix $(D)/win32_build/,bootstrap/curl.exe bootstrap/build.bat static/zip.exe static/unzip.exe dynamic/fcs.zip)

all: dummy

WML_FLAGS += --passoption=2,-X3074 --passoption=3,-I../lib/ \
	--passoption=3,-w -I../lib/ -DROOT~.

dummy : $(SUBDIRS) $(HTMLS) $(IMAGES) $(RAW_SUBDIRS) $(INDEXES)

$(SUBDIRS) :: % : 
	@if [ ! -e $@ ] ; then \
		mkdir $@ ; \
	fi

$(HTMLS) :: $(D)/% : src/%.wml template.wml $(INCLUDES)
	(cd src && wml $(WML_FLAGS) -DFILENAME="$(patsubst src/%.wml,%,$<)"  $(patsubst src/%,%,$<)) > $@

$(IMAGES) :: $(D)/% : src/%
	cp -f $< $@

$(RAW_SUBDIRS) :: $(D)/% : src/%
	rm -fr $@
	cp -r $< $@

.PHONY: 


src/comparison/comparison.html: src/comparison/scm-comparison.xml
	(cd src/comparison && make)

# Build index.html pages for the appropriate sub-directories.
$(INDEXES) :: $(D)/%/index.html : src/% gen_index.pl
	perl gen_index.pl $< $@

upload_beta: all
	cd $(D) && \
	$(RSYNC) -r * shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/__Beta-Site/
	
upload_stable: all
	cd $(D) && \
	$(RSYNC) -r * shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/

