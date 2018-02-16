files-config = $(CONFIG_DIR)/$(KERNEL_CONFIG) \
	       $(CONFIG_DIR)/$(BOOTLOADER_CONFIG) \
	       $(CONFIG_DIR)/$(SYSTEM_CONFIG) \
	       $(CONFIG_DIR)/$(BUSYBOX_CONFIG) \
	       $(CONFIG_DIR)/$(RELEASE_CONFIG)
files-tools = $(TOOLS_DIR)/bin/elf2bin \
	      $(TOOLS_DIR)/bin/mkimage \
	      $(TOOLS_DIR)/bin/seama
files-bootloader = $(BOOTLOADER_DIR)/include/ocm_size.h \
	 	   $(BOOTLOADER_DIR)/mainexec.elf
ifeq ($(CONFIG_NETWORK),y)
ifeq ($(CONFIG_NETWORK_IPV4),y)
files-system-scripts = $(SYSTEM_DIR)/include/scripts/network.ipv4
endif
ifeq ($(CONFIG_NETWORK_IPV6),y)
files-system-scripts += $(SYSTEM_DIR)/include/scripts/network.ipv6
endif
ifeq ($(CONFIG_NETWORK_IPV6_ONLY),y)

endif
ifeq ($(CONFIG_NETWORK_HARDWARE),y)
ifeq ($(CONFIG_NETWORK_HARDWARE_IPV4),y)
files-system-modules = $(SYSTEM_DIR)/include/modules/network.hardware.ipv4.ko
endif
ifeq ($(CONFIG_NETWORK_HARDWARE_IPV6),y)
files-system-modules += $(SYSTEM_DIR)/include/modules/network.hardware.ipv6.ko
endif
ifeq ($(CONFIG_NETWORK_HARDWARE_QOS),y)
files-system-modules += $(SYSTEM_DIR)/include/modules/network.hardware.qos.tracker.ko \
	 		$(SYSTEM_DIR)/include/modules/network.hardware.qos.tracker_tcp.ko \
	 		$(SYSTEM_DIR)/include/modules/network.hardware.qos.tracker_udp.ko \
	 		$(SYSTEM_DIR)/include/modules/network.hardware.qos.tracker_datagram.ko \
	 		$(SYSTEM_DIR)/include/modules/network.hardware.qos.classifier.ko \
	 		$(SYSTEM_DIR)/include/modules/network.hardware.qos.classifier_bittorrent.ko \
			$(SYSTEM_DIR)/include/modules/network.hardware.qos.classifier_default.ko \
			$(SYSTEM_DIR)/include/modules/network.hardware.qos.classifier_http.ko \
			$(SYSTEM_DIR)/include/modules/network.hardware.qos.classifier_http_content.ko \
			$(SYSTEM_DIR)/include/modules/network.hardware.qos.classifier_telnet_echo.ko \
			$(SYSTEM_DIR)/include/modules/network.hardware.qos.classifier_user_rules.ko \
			$(SYSTEM_DIR)/include/modules/network.hardware.qos.db.ko
endif
ifeq ($(CONFIG_NETWORK_HARDWARE_SHAPER),y)
files-system-modules += $(SYSTEM_DIR)/include/modules/network.hardware.qos.shaper.ko
endif
endif
endif

dependency:
	@echo -e "\033[32m  LOG       Dependency\033[0m" 
	@$(foreach file, $(files-config), \
	 printf  "  CHECK     /$(file)"; \
	 echo ''; \
	 [ -f $(SOURCE)/$(file) ] || { echo -e "\033[33m  LOG       Missing /$(file)\033[0m"; exit 1; };)
	@$(foreach file, $(files-tools), \
	 printf  "  CHECK     /$(file)"; \
	 echo ''; \
	 [ -f $(SOURCE)/$(file) ] || { echo -e "\033[33m  LOG       Missing /$(file)\033[0m"; exit 1; };)
	@$(foreach file, $(files-bootloader), \
	 printf  "  CHECK     /$(file)"; \
	 echo ''; \
	 [ -f $(SOURCE)/$(file) ] || { echo -e "\033[33m  LOG       Missing /$(file)\033[0m"; exit 1; };)
	@$(foreach file, $(files-system-scripts), \
	 printf  "  CHECK     /$(file)"; \
	 echo ''; \
	 [ -f $(SOURCE)/$(file) ] || { echo -e "\033[33m  LOG       Missing /$(file)\033[0m"; exit 1; };)
	@$(foreach file, $(files-system-modules), \
	 printf  "  CHECK     /$(file)"; \
	 echo ''; \
	 [ -f $(SOURCE)/$(file) ] || { echo -e "\033[33m  LOG       Missing /$(file)\033[0m"; exit 1; };)

