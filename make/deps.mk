# Constants
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Load Bowerbird Dependency Tools
BOWERBIRD_DEPS.MK := $(WORKDIR_DEPS)/bowerbird-deps/bowerbird_deps.mk
$(BOWERBIRD_DEPS.MK):
	@curl --silent --show-error --fail --create-dirs -o $@ -L \
https://raw.githubusercontent.com/ic-designer/make-bowerbird-deps/\
main/src/bowerbird-deps/bowerbird-deps.mk
include $(BOWERBIRD_DEPS.MK)

# Load Dependencies
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-help,\
		https://github.com/ic-designer/make-bowerbird-help.git,main,bowerbird.mk)
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-githooks,\
		https://github.com/ic-designer/make-bowerbird-githooks.git,main,bowerbird.mk)
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-install-tools,\
		https://github.com/ic-designer/make-bowerbird-install-tools.git,main,bowerbird.mk)
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-test,\
		https://github.com/ic-designer/make-bowerbird-test.git,main,bowerbird.mk)

# Dependencies
CONFIGURATOR_RULES_BRANCH := main
CONFIGURATOR_RULES.MK := $(WORKDIR_DEPS)/make-configurator-rules/make-configurator-rules.mk
$(CONFIGURATOR_RULES.MK):
	@echo "Loading FNAL ASIC Compute Rules..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-configurator-rules.git --branch $(CONFIGURATOR_RULES_BRANCH) \
			$(WORKDIR_DEPS)/make-configurator-rules
	test -f $@
	@echo

FNAL_ASIC_COMPUTE_BRANCH := main
FNAL_ASIC_COMPUTE_REPO := $(WORKDIR_DEPS)/fnal-asic-compute-$(FNAL_ASIC_COMPUTE_BRANCH)
$(FNAL_ASIC_COMPUTE_REPO):
	@echo "Loading FNAL ASIC compute..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/fnal-asic-compute.git --branch $(FNAL_ASIC_COMPUTE_BRANCH) \
			$(WORKDIR_DEPS)/fnal-asic-compute-$(FNAL_ASIC_COMPUTE_BRANCH)
	test -d $@
	@echo
