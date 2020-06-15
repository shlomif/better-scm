DEVEL_VER_USE_CACHE = 1

D = dest
TARGET = $(D)

TTML_FLAGS += $(COMMON_PREPROC_FLAGS)

DOCS_COMMON_DEPS = lib/MyNavData.pm lib/MyNavLinks.pm lib/MyManageNews.pm

all: dummy

include lib/make/shlomif_common.mak
include lib/make/include.mak
include lib/make/rules.mak

# IMAGES += $(addprefix $(D)/win32_build/,bootstrap/curl.exe bootstrap/build.bat static/zip.exe static/unzip.exe dynamic/fcs.zip)

TTML_FLAGS += $(COMMON_PREPROC_FLAGS)

PROCESS_ALL_INCLUDES = ALWAYS_MIN=1 perl bin/post-incs-v2.pl --mode=minify \
               --minifier-conf=bin/html-min-cli-config-file.conf \
               --source-dir=$(TARGET) \
               --dest-dir=$(TARGET) \
               --

DOCS_COMMON_DEPS = lib/MyNavData.pm lib/MyNavLinks.pm lib/MyManageNews.pm

all_deps: make-dirs

dummy: latemp_targets news_feeds min_svgs css_targets

RSS_FEED = $(D)/rss.xml

news_feeds: $(RSS_FEED)

GEN_FEED = bin/gen-feeds.pl

$(RSS_FEED): $(GEN_FEED) lib/MyManageNews.pm
	perl -Ilib $(GEN_FEED) --rss2-out="$@"

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

$(ALL_HTACCESSES): $(D)/%.htaccess: $(SCM_SRC_DIR)/%my_htaccess.conf
	$(call COPY)

T2_SVGS__BASE := $(filter %.svg,$(SCM_IMAGES_DEST))
T2_SVGS__MIN := $(T2_SVGS__BASE:%.svg=%.min.svg)
T2_SVGS__svgz := $(T2_SVGS__BASE:%.svg=%.svgz)

SVG_MINIFY = minify --svg-precision 5 -o $@ $<
DISABLE_MINIFY_DUE_TO_DISAPPEARING_ARCS = 1

ifeq ($(DISABLE_MINIFY_DUE_TO_DISAPPEARING_ARCS), 1)
	SVG_MINIFY = $(call COPY)
endif

$(T2_SVGS__MIN): %.min.svg: %.svg
	$(call SVG_MINIFY)

$(T2_SVGS__svgz): %.svgz: %.min.svg
	gzip --best -n < $< > $@

min_svgs: $(T2_SVGS__MIN) $(T2_SVGS__svgz)

SASS_STYLE = compressed
# SASS_STYLE = expanded
SASS_CMD = sass --style $(SASS_STYLE)

SCM_CSS_TARGETS = $(D)/alternate1.css $(D)/style.css

$(SCM_CSS_TARGETS): $(D)/%.css: lib/sass/%.scss $(COMMON_SASS_DEPS)
	$(SASS_CMD) $< $@

css_targets: $(SCM_CSS_TARGETS)

fastrender: all_deps
	@echo $(MAKE) fastrender
	perl bin/tt-render.pl
	@$(PROCESS_ALL_INCLUDES) $(SCM_DOCS) $$(cat lib/make/tt2.txt)

SUBDIRS = $(addprefix $(D)/,$(COMMON_DIRS) $(SCM_DIRS))

make-dirs: $(SUBDIRS)
	@mkdir -p $(SUBDIRS)

bulk-make-dirs:
	@mkdir -p $(SUBDIRS)
