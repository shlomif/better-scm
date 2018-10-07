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

dummy: latemp_targets news_feeds min_svgs css_targets

WML_FLAGS += --passoption=2,-X3074 --passoption=3,-I../lib/ \
	--passoption=3,-w -I../lib/ -DROOT~. $(LATEMP_WML_FLAGS) \
	--passoption=7,-Simgsize,summary

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
	$(RSYNC) -a $(D)/ $(UPLOAD_BASE)/__Beta-Site/

upload_stable: all
	$(RSYNC) -a $(D)/ $(UPLOAD_BASE)/

TEST_TARGETS = Tests/*.{py,t}
htacc = $(addsuffix /.htaccess,$(1))

ALL_HTACCESSES = $(call htacc,$(D))

dummy: htaccesses_target

htaccesses_target: $(ALL_HTACCESSES)

$(ALL_HTACCESSES): $(D)/%.htaccess: $(BERLIOS_SRC_DIR)/%my_htaccess.conf
	$(call COPY)

T2_SVGS__BASE := $(filter %.svg,$(BERLIOS_IMAGES_DEST))
T2_SVGS__MIN := $(T2_SVGS__BASE:%.svg=%.min.svg)
T2_SVGS__svgz := $(T2_SVGS__BASE:%.svg=%.svgz)

$(T2_SVGS__MIN): %.min.svg: %.svg
	minify --svg-decimals 3 -o $@ $<

$(T2_SVGS__svgz): %.svgz: %.min.svg
	gzip --best < $< > $@

min_svgs: $(T2_SVGS__MIN) $(T2_SVGS__svgz)

SASS_STYLE = compressed
# SASS_STYLE = expanded
SASS_CMD = sass --style $(SASS_STYLE)

BERLIOS_CSS_TARGETS = $(D)/style.css

$(BERLIOS_CSS_TARGETS): $(D)/%.css: lib/sass/%.scss $(COMMON_SASS_DEPS)
	$(SASS_CMD) $< $@

css_targets: $(BERLIOS_CSS_TARGETS)
