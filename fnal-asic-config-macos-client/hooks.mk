# Constants
FNAL_ASIC_COMPUTE_VERSION := 0.3.1

WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Dependencies
override FNAL_ASIC_COMPUTE_REPO := $(WORKDIR_DEPS)/fnal-asic-compute-$(FNAL_ASIC_COMPUTE_VERSION)
$(FNAL_ASIC_COMPUTE_REPO):
	@echo "Loading FNAL ASIC compute..."
	mkdir -p $(WORKDIR_DEPS)
	curl -sL https://github.com/ic-designer/fnal-asic-compute/archive/refs/tags/$(FNAL_ASIC_COMPUTE_VERSION).tar.gz | tar xz -C $(WORKDIR_DEPS)
	test -d $@
	@echo

# Targets
.PHONY: hook-install
 hook-install: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) install WORKDIR_ROOT=$(WORKDIR_ROOT)

.PHONY: hook-test
hook-test: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) test WORKDIR_ROOT=$(WORKDIR_ROOT)

.PHONY: hook-uninstall
hook-uninstall: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) uninstall WORKDIR_ROOT=$(WORKDIR_ROOT)
