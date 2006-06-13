
RSYNC = rsync --progress --verbose --rsh=ssh

DEVEL_VER_USE_CACHE = 1

D = dest

WML_FLAGS = -DLATEMP_THEME=better-scm
TTML_FLAGS = -I $$HOME/.latemp/lib -I lib

LATEMP_WML_FLAGS =$(shell latemp-config --wml-flags)

DOCS_COMMON_DEPS = template.wml lib/MyNavData.pm lib/MyNavLinks.pm lib/MyManageNews.pm

all: dummy

include include.mak
include rules.mak



# IMAGES += $(addprefix $(D)/win32_build/,bootstrap/curl.exe bootstrap/build.bat static/zip.exe static/unzip.exe dynamic/fcs.zip)

dummy: latemp_targets news_feeds 

WML_FLAGS += --passoption=2,-X3074 --passoption=3,-I../lib/ \
	--passoption=3,-w -I../lib/ -DROOT~. $(LATEMP_WML_FLAGS)

RSS_FEED = $(D)/rss.xml

news_feeds: $(RSS_FEED)

$(RSS_FEED): gen-feeds.pl lib/MyManageNews.pm
	perl -Ilib gen-feeds.pl --rss2-out="$@"

.PHONY: 


src/comparison/comparison.html: src/comparison/scm-comparison.xml
	(cd src/comparison && make)

upload_beta: all
	cd $(D) && \
	$(RSYNC) -r * shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/__Beta-Site/
	
upload_stable: all
	cd $(D) && \
	$(RSYNC) -r * shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/

upload_bk: all
	cd $(D) && \
	$(RSYNC) -r * shlomif@shell.berlios.de:/home/groups/better-scm/htdocs/__Bk-essay-f567j/

upload_bk2: all
	cd $(D) && \
	$(RSYNC) -r * shlomif@iglu.org.il:Home-Site/__Bk-essay-f567j/

