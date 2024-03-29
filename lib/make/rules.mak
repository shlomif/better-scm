SCM_SRC_DIR := src

SCM_DEST := $(D)

SCM_WML_FLAGS := $(WML_FLAGS) -DLATEMP_SERVER=scm

SCM_DOCS_DEST := $(patsubst %,$(SCM_DEST)/%,$(SCM_DOCS))

SCM_DIRS_DEST := $(patsubst %,$(SCM_DEST)/%,$(SCM_DIRS))

SCM_IMAGES_DEST := $(patsubst %,$(SCM_DEST)/%,$(SCM_IMAGES))

SCM_TARGETS := $(SCM_DEST) $(SCM_DIRS_DEST) $(SCM_IMAGES_DEST) $(SCM_DOCS_DEST)

$(SCM_DIRS_DEST) : $(SCM_DEST)/% :
	mkdir -p $@
	touch $@

$(SCM_IMAGES_DEST) : $(SCM_DEST)/% : $(SCM_SRC_DIR)/%
	$(call LATEMP_COPY)

$(SCM_DEST):
	mkdir -p $@
	touch $@
latemp_targets: $(SCM_TARGETS)

