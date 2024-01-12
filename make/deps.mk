# Constants
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

BOXERBIRD_BRANCH := main
FNAL_ASIC_COMPUTE_VERSION := 0.3.1

# Dependencies
override BOXERBIRD.MK := $(WORKDIR_DEPS)/make-boxerbird/boxerbird.mk
$(BOXERBIRD.MK):
	@echo "Loading Boxerbird..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-boxerbird.git --branch $(BOXERBIRD_BRANCH) \
			$(WORKDIR_DEPS)/make-boxerbird
	@echo

override FNAL_ASIC_COMPUTE_REPO := $(WORKDIR_DEPS)/fnal-asic-compute-$(FNAL_ASIC_COMPUTE_VERSION)
$(FNAL_ASIC_COMPUTE_REPO):
	@echo "Loading FNAL ASIC compute..."
	mkdir -p $(WORKDIR_DEPS)
	curl -sL https://github.com/ic-designer/fnal-asic-compute/archive/refs/tags/$(FNAL_ASIC_COMPUTE_VERSION).tar.gz | tar xz -C $(WORKDIR_DEPS)
	test -d $@
	@echo
