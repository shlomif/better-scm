
RSYNC = rsync --progress --verbose --rsh=ssh

DEVEL_VER_USE_CACHE = 1

D = dest

WML_FLAGS = -DBERLIOS=BERLIOS

IMAGES_PRE1 = $(shell cd src && (ls *.tar.gz *.zip *.patch *.css *.png bk/*.html aegis/*.txt subversion/*.txt))
IMAGES = $(addprefix $(D)/,$(IMAGES_PRE1))

# WML_FLAGS = -DBERLIOS=BERLIOS

HTMLS_PROTO = call-for-hosting.html index.html links.html mailing-list.html  \
	bk/index.html bk/relicensing_bk.html bk/response_to_rms.html             \
	aegis/index.html aegis/overcoming_childhood_diseases.html                \
	arch/index.html                                                          \
	monotone/index.html                                                      \
	subversion/index.html subversion/compelling_alternative.html             \
	vesta/index.html                                                         \
	docs/shlomif-evolution.html docs/nice_trys.html                          \
	comparison/index.html

HTMLS = $(addprefix $(D)/,$(HTMLS_PROTO))

INCLUDES_PROTO = std/logo.wml
INCLUDES = $(addprefix src/,$(INCLUDES_PROTO))

# SUBDIRS_WITH_INDEXES = $(D)/win32_build $(D)/win32_build/bootstrap $(D)/win32_build/dynamic $(D)/win32_build/static
SUBDIRS_WITH_INDEXES = 

SUBDIRS_PROTO = aegis arch bk subversion monotone vesta docs comparison

SUBDIRS = $(SUBDIRS_WITH_INDEXES) $(D) $(addprefix $(D)/,$(SUBDIRS_PROTO))

INDEXES = $(addsuffix /index.html,$(SUBDIRS_WITH_INDEXES))

# IMAGES += $(addprefix $(D)/win32_build/,bootstrap/curl.exe bootstrap/build.bat static/zip.exe static/unzip.exe dynamic/fcs.zip)

all: dummy

WML_FLAGS += --passoption=2,-X

dummy : $(SUBDIRS) $(HTMLS) $(IMAGES) $(RAW_SUBDIRS) $(INDEXES)

$(SUBDIRS) :: % : 
	@if [ ! -e $@ ] ; then \
		mkdir $@ ; \
	fi

$(HTMLS) :: $(D)/% : src/%.wml src/.wmlrc template.wml $(INCLUDES)
	(cd src && wml $(WML_FLAGS) -DFILENAME="$(patsubst src/%.wml,%,$<)"  $(patsubst src/%,%,$<)) > $@

$(IMAGES) :: $(D)/% : src/%
	cp -f $< $@

$(RAW_SUBDIRS) :: $(D)/% : src/%
	rm -fr $@
	cp -r $< $@

.PHONY: 

# Build index.html pages for the appropriate sub-directories.
$(INDEXES) :: $(D)/%/index.html : src/% gen_index.pl
	perl gen_index.pl $< $@

upload: all
	cd $(D) && \
	$(RSYNC) -r * shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/

