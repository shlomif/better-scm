DEVEL_VER_USE_CACHE = 1

D = dest

WML_FLAGS += -DLATEMP_THEME=better-scm -I $$HOME/apps/wml
WML_FLAGS += $(COMMON_PREPROC_FLAGS)
TTML_FLAGS += $(COMMON_PREPROC_FLAGS)

DOCS_COMMON_DEPS = lib/MyNavData.pm lib/MyNavLinks.pm lib/MyManageNews.pm lib/template.wml

all: dummy

include lib/make/shlomif_common.mak
include lib/make/include.mak
include lib/make/rules.mak

# IMAGES += $(addprefix $(D)/win32_build/,bootstrap/curl.exe bootstrap/build.bat static/zip.exe static/unzip.exe dynamic/fcs.zip)

dummy: latemp_targets news_feeds

WML_FLAGS += --passoption=2,-X3074 --passoption=3,-I../lib/ \
	--passoption=3,-w -I../lib/ -DROOT~. $(LATEMP_WML_FLAGS)

RSS_FEED = $(D)/rss.xml

news_feeds: $(RSS_FEED)

GEN_FEED = bin/gen-feeds.pl

$(RSS_FEED): $(GEN_FEED) lib/MyManageNews.pm
	perl -Ilib $(GEN_FEED) --rss2-out="$@"

src/comparison/comparison.html.wml: src/comparison/scm-comparison.xml
	touch $@

src/comparison/index.html.wml: src/comparison/scm-comparison.xml
	touch $@

UPLOAD_BASE = hostgator:domains/better-scm/public_html

upload: upload_stable

upload_beta: all
	cd $(D) && \
	$(RSYNC) -a * $(UPLOAD_BASE)/__Beta-Site/

upload_stable: all
	cd $(D) && \
	$(RSYNC) -a * $(UPLOAD_BASE)/
