# Constants
DESTDIR ?= $(error ERROR: Undefined variable DESTDIR)
HOMEDIR ?= $(error ERROR: Undefined variable HOMEDIR)
LIBDIR ?= $(error ERROR: Undefined variable LIBDIR)
PREFIX ?= $(error ERROR: Undefined variable PREFIX)
SRCDIR_ROOT ?= $(error ERROR: Undefined variable SRCDIR_ROOT)
WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)

override NAME := fnal-asic-compute-user
override PKGSUBDIR = $(NAME)/$(SRCDIR_ROOT)
override VERSION := $(shell git describe --always --dirty --broken 2> /dev/null)
override SRCDIR_CONFIG_FILES := $(shell cd $(SRCDIR_ROOT)/src && find . -type f)
override WORKDIR_DEPS = $(WORKDIR_ROOT)/deps
override WORKDIR_TEST = $(WORKDIR_ROOT)/test/$(NAME)/$(VERSION)

# Includes
include make/deps.mk
include $(BOXERBIRD.MK)

# Targets
.PHONY: private_clean
private_clean:
	@echo "INFO: Cleaning directories:"
	@$(if $(wildcard $(WORKDIR_DEPS)), rm -rfv $(WORKDIR_DEPS))
	@$(if $(wildcard $(WORKDIR_ROOT)), rm -rfv $(WORKDIR_ROOT))
	@$(if $(wildcard $(WORKDIR_TEST)), rm -rfv $(WORKDIR_TEST))
	@echo


.PHONY: private_install
private_install: \
		$(foreach f, $(SRCDIR_CONFIG_FILES), $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)/$(f) $(DESTDIR)/$(HOMEDIR)/$(f)) \
		$(FNAL_ASIC_COMPUTE_REPO)
	diff -r $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR) $(SRCDIR_ROOT)/src/
	@$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) check
	@echo "INFO: Installation complete."
	@echo

$(DESTDIR)/$(HOMEDIR)/%: $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)/%
	$(boxerbird::install-as-link)

$(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)/%: $(SRCDIR_ROOT)/src/%
	$(boxerbird::install-as-copy)


.PHONY: private_test
private_test: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) install DESTDIR=$(abspath $(WORKDIR_TEST))/$(PKGSUBDIR)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) test
	$(MAKE) uninstall DESTDIR=$(abspath $(WORKDIR_TEST))/$(PKGSUBDIR)


.PHONY: private_uninstall
private_uninstall: $(FNAL_ASIC_COMPUTE_REPO)
	@echo "INFO: Uninstalling $(NAME)"
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) uninstall
	@$(foreach s, $(SRCDIR_CONFIG_FILES), \
		rm -v $(DESTDIR)/$(HOMEDIR)/$(s); \
		test ! -e $(DESTDIR)/$(HOMEDIR)/$(s); \
		rm -dv $(dir $(DESTDIR)/$(HOMEDIR)/$(s)) 2> /dev/null || true;\
	)
	@\rm -rdfv $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR) 2> /dev/null || true
	@\rm -dv $(dir $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)) 2> /dev/null || true
	@\rm -dv $(DESTDIR)/$(LIBDIR) 2> /dev/null || true
	@echo "INFO: Unistallation complete."
	@echo
