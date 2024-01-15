# Default hooks
.PHONY: hook-%
hook-%:
	@:

.PHONY: shared-hook-%
shared-hook-%:
	@:

# Targets
.PHONY: shared-hook-install
shared-hook-install: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) install

.PHONY: shared-hook-test
shared-hook-test: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) test

.PHONY: shared-hook-uninstall
shared-hook-uninstall: $(FNAL_ASIC_COMPUTE_REPO)
	$(MAKE) -C $(FNAL_ASIC_COMPUTE_REPO) uninstall
