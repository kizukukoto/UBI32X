dependency:
	@echo -e "\033[32m  LOG       Dependency\033[0m" 
	@echo  "  CHECK     "/$(CONFIG_DIR)/$(KERNEL_CONFIG)
	@[ -s $(SOURCE)/$(CONFIG_DIR)/$(KERNEL_CONFIG) ] || { echo -e "\033[33m  LOG       Missing "/$(CONFIG_DIR)/$(KERNEL_CONFIG)"\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(CONFIG_DIR)/$(BOOTLOADER_CONFIG)
	@[ -s $(SOURCE)/$(CONFIG_DIR)/$(BOOTLOADER_CONFIG) ] || { echo -e "\033[33m  LOG       Missing "/$(CONFIG_DIR)/$(BOOTLOADER_CONFIG)"\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(CONFIG_DIR)/$(SYSTEM_CONFIG)
	@[ -s $(SOURCE)/$(CONFIG_DIR)/$(SYSTEM_CONFIG) ] || { echo -e "\033[33m  LOG       Missing "/$(CONFIG_DIR)/$(SYSTEM_CONFIG)"\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(CONFIG_DIR)/$(BUSYBOX_CONFIG)
	@[ -s $(SOURCE)/$(CONFIG_DIR)/$(BUSYBOX_CONFIG) ] || { echo -e "\033[33m  LOG       Missing "/$(CONFIG_DIR)/$(BUSYBOX_CONFIG)"\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(CONFIG_DIR)/$(RELEASE_CONFIG)
	@[ -s $(SOURCE)/$(CONFIG_DIR)/$(RELEASE_CONFIG) ] || { echo -e "\033[33m  LOG       Missing "/$(CONFIG_DIR)/$(RELEASE_CONFIG)"\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(TOOLS_DIR)"/bin/elf2bin"
	@[ -s $(SOURCE)/$(TOOLS_DIR)"/bin/elf2bin" ] || { echo -e "\033[33m  LOG       Missing "/$(TOOLS_DIR)"/bin/elf2bin\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(TOOLS_DIR)"/bin/mkimage"
	@[ -s $(SOURCE)/$(TOOLS_DIR)"/bin/mkimage" ] || { echo -e "\033[33m  LOG       Missing "/$(TOOLS_DIR)"/bin/mkimage\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(TOOLS_DIR)"/bin/seama"
	@[ -s $(SOURCE)/$(TOOLS_DIR)"/bin/seama" ] || { echo -e "\033[33m  LOG       Missing "/$(TOOLS_DIR)"/bin/seama\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(BOOTLOADER_DIR)"/include/ocm_size.h"
	@[ -s $(SOURCE)/$(CONFIG_DIR)/$(KERNEL_CONFIG) ] || { echo -e "\033[33m  LOG       Missing "/$(BOOTLOADER_DIR)"/include/ocm_size.h\033[0m"; exit 1; }
	@echo  "  CHECK     "/$(BOOTLOADER_DIR)"/mainexec.elf"
	@[ -s $(SOURCE)/$(BOOTLOADER_DIR)"/mainexec.elf" ] || { echo -e "\033[33m  LOG       Missing "/$(BOOTLOADER_DIR)"/mainexec.elf\033[0m"; exit 1; }
	@if [ "$(CONFIG_UBICOM32_MODULE_NA)" == "y" ]; then \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv4.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv4.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv4.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv6.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv6.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv6.ko\033[0m"; exit 1; }; \
	else \
		if [ "$(CONFIG_UBICOM32_MODULE_QOS)" == "y" ] || [ "$(CONFIG_UBICOM32_MODULE_SHAPER)" == "y" ]; then \
			echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv4.ko"; \
			[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv4.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv4.ko\033[0m"; exit 1; }; \
			echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv6.ko"; \
			[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv6.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_na_connection_manager_ipv6.ko\033[0m"; exit 1; }; \
		fi \
	fi
	@if [ "$(CONFIG_UBICOM32_MODULE_QOS)" == "y" ]; then \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_db.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_db.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_db.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker_tcp.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_tcp.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker_tcp.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker_udp.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_udp.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker_udp.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker_datagram.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_datagram.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_tracker_datagram.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_default.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_default.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_default.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_user_rules.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_user_rules.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_user_rules.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_bittorrent.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_bittorrent.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_bittorrent.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_http.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_http.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_http.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_http_content.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_http_content.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier_http_content.ko\033[0m"; exit 1; }; \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier.ko ] || { echo -e "\033[33m  LOG       Missing "/$(SYSTEM_DIR)"/include/modules/net/ubicom_streamengine_classifier.ko\033[0m"; exit 1; }; \
	fi
	@if [ "$(CONFIG_UBICOM32_MODULE_SHAPER)" == "y" ]; then \
		echo  "  CHECK     "/$(SYSTEM_DIR)"/include/modules/net/sch_ubicom_streamengine.ko"; \
		[ -s $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/sch_ubicom_streamengine.ko ] || { echo -e "\033[33m  LOG       Missing "/	$(SYSTEM_DIR)"/include/modules/net/sch_ubicom_streamengine.ko\033[0m"; exit 1; }; \
	fi
