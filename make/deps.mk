# Constants
CONFIGURATOR_RULES_BRANCH := main
FNAL_ASIC_COMPUTE_BRANCH := main

WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)
WORKDIR_DEPS = $(WORKDIR_ROOT)/deps

# Dependencies
override CONFIGURATOR_RULES.MK := $(WORKDIR_DEPS)/make-configurator-rules/make-configurator-rules.mk
$(CONFIGURATOR_RULES.MK):
	@echo "Loading FNAL ASIC Compute Rules..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-configurator-rules.git --branch $(CONFIGURATOR_RULES_BRANCH) \
			$(WORKDIR_DEPS)/make-configurator-rules
	test -f $@
	@echo

override FNAL_ASIC_COMPUTE_REPO := $(WORKDIR_DEPS)/fnal-asic-compute-$(FNAL_ASIC_COMPUTE_BRANCH)
$(FNAL_ASIC_COMPUTE_REPO):
	@echo "Loading FNAL ASIC compute..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/fnal-asic-compute.git --branch $(FNAL_ASIC_COMPUTE_BRANCH) \
			$(WORKDIR_DEPS)/fnal-asic-compute-$(FNAL_ASIC_COMPUTE_BRANCH)
	test -d $@
	@echo
