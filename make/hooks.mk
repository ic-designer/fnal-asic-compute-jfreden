# Default hooks
.PHONY: hook-%
hook-%:
	@:

.PHONY: shared-hook-%
shared-hook-%:
	@:

# Targets
.PHONY: shared-hook-install
 hook-install: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) install WORKDIR_ROOT=$(WORKDIR_ROOT)

.PHONY: shared-hook-test
hook-test: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) test WORKDIR_ROOT=$(WORKDIR_ROOT)

.PHONY: shared-hook-uninstall
hook-uninstall: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) uninstall WORKDIR_ROOT=$(WORKDIR_ROOT)
