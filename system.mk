make_system:
	@echo -e "\033[32m  LOG       System\033[0m"
	@$(foreach file, $(files-system-scripts), \
	 printf  "  COPY      /$(file)"; \
	 echo ''; \
	 cp $(SOURCE)/$(file) $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/etc/init.d;)
	@$(foreach file, $(files-system-modules), \
	 printf  "  COPY      /$(file)"; \
	 echo ''; \
	 cp $(SOURCE)/$(file) $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules;)

	@if [ "$(CONFIG_BUSYBOX)" == "y" ]; then \
		echo  "  COPY      /$(CONFIG_DIR)/$(BUSYBOX_CONFIG)"; \
		cp $(SOURCE)/$(CONFIG_DIR)/$(BUSYBOX_CONFIG) $(SOURCE)/$(SYSTEM_DIR)/src/busybox/.config; \
		echo  "  CONFIG    /$(SYSTEM_DIR)/src/busybox"; \
		$(MAKE) BUSYBOX_VERSION=$(BUSYBOX_VERSION) SOURCE=$(SOURCE) SYSTEM_DIR=$(SYSTEM_DIR) BUILD_DIR=$(BUILD_DIR) FILESYSTEM_DIR=$(SYSTEM_ROOT_DIR) -C $(SOURCE)/$(SYSTEM_DIR)/src/busybox oldconfig $(DEBUG); \
		echo  "  MAKE      /$(SYSTEM_DIR)/src/busybox"; \
		$(MAKE) BUSYBOX_VERSION=$(BUSYBOX_VERSION) SOURCE=$(SOURCE) SYSTEM_DIR=$(SYSTEM_DIR) BUILD_DIR=$(BUILD_DIR) FILESYSTEM_DIR=$(SYSTEM_ROOT_DIR) -C $(SOURCE)/$(SYSTEM_DIR)/src/busybox $(DEBUG); \
	fi

	@echo  "  CHECK     /$(BUILD_DIR)/rootfs.img"
	@if [ -s $(SOURCE)/$(BUILD_DIR)/rootfs.img ]; then \
		echo  "  REMOVE    /$(BUILD_DIR)/rootfs.img"; \
		rm -f $(SOURCE)/$(BUILD_DIR)/rootfs.img; \
	fi
	@echo  "  MKSQUASH  /$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)"
	@fakeroot $(SOURCE)/$(TOOLS_DIR)/bin/mksquashfs $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR) $(SOURCE)/$(BUILD_DIR)/rootfs.img $(DEBUG);

	@echo  "  CHECK     /$(BUILD_DIR)/rootfs.img"
	@[ -s $(SOURCE)/$(BUILD_DIR)/rootfs.img ] || { echo -e "\033[33m  LOG       Missing /$(BUILD_DIR)/rootfs.img\033[0m"; exit 1; }

clean_system:
	@echo -e "\033[32m  LOG       System\033[0m"
	@echo  "  CLEAN     /$(SYSTEM_DIR)/src/busybox"
	@$(MAKE) BUSYBOX_VERSION=$(BUSYBOX_VERSION) -C $(SOURCE)/$(SYSTEM_DIR)/src/busybox clean $(DEBUG)
	

