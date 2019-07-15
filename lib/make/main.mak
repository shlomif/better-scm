DEVEL_VER_USE_CACHE = 1

D = dest
TARGET = $(D)

WML_FLAGS += -DLATEMP_THEME=better-scm -I $$HOME/apps/wml
WML_FLAGS += $(COMMON_PREPROC_FLAGS)
TTML_FLAGS += $(COMMON_PREPROC_FLAGS)

DOCS_COMMON_DEPS = lib/MyNavData.pm lib/MyNavLinks.pm lib/MyManageNews.pm lib/template.wml

all: dummy

include lib/make/shlomif_common.mak
include lib/make/include.mak
include lib/make/rules.mak

# IMAGES += $(addprefix $(D)/win32_build/,bootstrap/curl.exe bootstrap/build.bat static/zip.exe static/unzip.exe dynamic/fcs.zip)

WML_FLAGS += -DLATEMP_THEME=better-scm
LATEMP_WML_FLAGS += $(COMMON_PREPROC_FLAGS) -I $$HOME/apps/wml $(SCM_WML_FLAGS)
TTML_FLAGS += $(COMMON_PREPROC_FLAGS)

WML_RENDER = LATEMP_WML_FLAGS="$(LATEMP_WML_FLAGS)" $1 bin/render $(D)
# needed by rules.mak / non-fastrender make test
SCM_INCLUDE_WML_RENDER = $(WML_RENDER) $(patsubst $(SCM_SRC_DIR)/%.wml,%,$<)

PROCESS_ALL_INCLUDES = ALWAYS_MIN=1 perl bin/post-incs-v2.pl --mode=minify \
               --minifier-conf=bin/html-min-cli-config-file.conf \
               --source-dir=$(TARGET) \
               --dest-dir=$(TARGET) \
               --

DOCS_COMMON_DEPS = lib/MyNavData.pm lib/MyNavLinks.pm lib/MyManageNews.pm lib/template.wml

all_deps: make-dirs

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

$(ALL_HTACCESSES): $(D)/%.htaccess: $(SCM_SRC_DIR)/%my_htaccess.conf
	$(call COPY)

T2_SVGS__BASE := $(filter %.svg,$(SCM_IMAGES_DEST))
T2_SVGS__MIN := $(T2_SVGS__BASE:%.svg=%.min.svg)
T2_SVGS__svgz := $(T2_SVGS__BASE:%.svg=%.svgz)

$(T2_SVGS__MIN): %.min.svg: %.svg
	minify --svg-decimals 3 -o $@ $<

$(T2_SVGS__svgz): %.svgz: %.min.svg
	gzip --best -n < $< > $@

min_svgs: $(T2_SVGS__MIN) $(T2_SVGS__svgz)

SASS_STYLE = compressed
# SASS_STYLE = expanded
SASS_CMD = sass --style $(SASS_STYLE)

SCM_CSS_TARGETS = $(D)/style.css

$(SCM_CSS_TARGETS): $(D)/%.css: lib/sass/%.scss $(COMMON_SASS_DEPS)
	$(SASS_CMD) $< $@

css_targets: $(SCM_CSS_TARGETS)

fastrender: $(SCM_DOCS:%=$(SCM_SRC_DIR)/%.wml) all_deps
	@echo $(MAKE) fastrender
	@$(call WML_RENDER,) $(SCM_DOCS)
	@$(PROCESS_ALL_INCLUDES) $(SCM_DOCS)

SUBDIRS = $(addprefix $(D)/,$(SCM_DIRS))

make-dirs: $(SUBDIRS)
	@mkdir -p $(SUBDIRS)

bulk-make-dirs:
	@mkdir -p $(SUBDIRS)
