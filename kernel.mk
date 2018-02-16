make_kernel:
	@echo -e "\033[32m  LOG       Kernel\033[0m"
	@if [ -s $(SOURCE)/$(BUILD_DIR)/vmlinux.elf ]; then \
		echo -e -n "\033[33m  LOG       Do you want to rebuild kernel? (y/n): \033[0m"; \
		read rebuild; \
		if [ "$$rebuild" == "y" ]; then \
			echo  "  COPY      /$(CONFIG_DIR)/$(KERNEL_CONFIG)"; \
			cp $(SOURCE)/$(CONFIG_DIR)/$(KERNEL_CONFIG) $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/.config; \
			echo  "  CONFIG    /$(KERNEL_DIR)/$(KERNEL_VERSION)"; \
			$(MAKE) $(KERNEL_MAKEOPTS) oldconfig  $(DEBUG); \
			echo  "  COPY      /$(BOOTLOADER_DIR)/include/ocm_size.h"; \
			cp $(SOURCE)/$(BOOTLOADER_DIR)/include/ocm_size.h $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/arch/ubicom32/include/asm/ocm_size.h; \
			echo  "  MAKE      /$(KERNEL_DIR)/$(KERNEL_VERSION)"; \
			$(MAKE) $(KERNEL_MAKEOPTS) $(DEBUG); \
			echo  "  CHECK     /$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux"; \
			if [ -s $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux ]; then \
				cp $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux $(SOURCE)/$(BUILD_DIR)/vmlinux.elf; \
			else \
				echo -e "\033[33m  LOG       Missing /$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux\033[0m"; \
				exit 1; \
			fi \
		fi \
	else \
		echo  "  COPY      /$(CONFIG_DIR)/$(KERNEL_CONFIG)"; \
		cp $(SOURCE)/$(CONFIG_DIR)/$(KERNEL_CONFIG) $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/.config; \
		echo  "  CONFIG    /$(KERNEL_DIR)/$(KERNEL_VERSION)"; \
		$(MAKE) $(KERNEL_MAKEOPTS) oldconfig  $(DEBUG); \
		echo  "  COPY      /$(BOOTLOADER_DIR)/include/ocm_size.h"; \
		cp $(SOURCE)/$(BOOTLOADER_DIR)/include/ocm_size.h $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/arch/ubicom32/include/asm/ocm_size.h; \
		echo  "  MAKE      /$(KERNEL_DIR)/$(KERNEL_VERSION)"; \
		$(MAKE) $(KERNEL_MAKEOPTS) $(DEBUG); \
		echo  "  CHECK     /$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux"; \
		if [ -s $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux ]; then \
			echo  "  COPY      $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux"; \
			cp $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux $(SOURCE)/$(BUILD_DIR)/vmlinux.elf; \
		else \
			echo -e "\033[33m  LOG       Missing /$(KERNEL_DIR)/$(KERNEL_VERSION)/vmlinux\033[0m"; \
			exit 1; \
		fi \
	fi
	@echo  "  CHECK     /$(BUILD_DIR)/vmlinux.elf"
	@[ -s $(SOURCE)/$(BUILD_DIR)/vmlinux.elf ] || { echo -e "\033[33m  LOG       Missing /$(BUILD_DIR)/vmlinux.elf\033[0m"; exit 1; }

clean_kernel:
	@echo -e "\033[32m  LOG       Kernel\033[0m"
	@echo  "  CLEAN     /$(KERNEL_DIR)/$(KERNEL_VERSION)"
	@$(MAKE) -C $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION) clean $(DEBUG)
	@rm -f $(SOURCE)/$(BUILD_DIR)/vmlinux.elf

