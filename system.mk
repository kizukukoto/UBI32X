make_system:
	@echo -e "\033[32m  LOG       System\033[0m"
	@if [ "$(CONFIG_NETWORK)" == "y" ]; then \
		if [ "$(CONFIG_NETWORK_IPV4)" == "y" ]; then \
			echo ""; \
		fi; \
		if [ "$(CONFIG_NETWORK_IPV6)" == "y" ]; then \
			echo ""; \
			if [ "$(CONFIG_NETWORK_IPV6_ONLY)" == "y" ]; then \
				echo ""; \
			fi; \
		fi; \
		if [ "$(CONFIG_NETWORK_HARDWARE)" == "y" ]; then \
			if [ "$(CONFIG_NETWORK_HARDWARE_IPV4)" == "y" ] && [ "$(CONFIG_NETWORK_IPV6_ONLY)" != "y"  ]; then \
				echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv4.ko; \
				cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv4.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
			fi; \
			if [ "$(CONFIG_NETWORK_HARDWARE_IPV6)" == "y" ] && [ "$(CONFIG_NETWORK_IPV6)" == "y"  ]; then \
				echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv6.ko; \
				cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_na_connection_manager_ipv6.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
			fi; \
			if [ "$(CONFIG_NETWORK_HARDWARE_IPV4)" == "y" ] || [ "$(CONFIG_NETWORK_HARDWARE_IPV6)" == "y" ]; then \
				if [ "$(CONFIG_NETWORK_HARDWARE_QOS)" == "y" ]; then \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_db.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_db.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_tcp.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_tcp.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_udp.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_udp.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_datagram.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_tracker_datagram.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_default.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_default.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_user_rules.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_user_rules.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_bittorrent.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_bittorrent.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_http.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_http.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_http_content.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier_http_content.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/ubicom_streamengine_classifier.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
				fi; \
				if [ "$(CONFIG_NETWORK_HARDWARE_SHAPER)" == "y" ]; then \
					echo  "  COPY      "/$(SYSTEM_DIR)/include/modules/net/sch_ubicom_streamengine.ko; \
					cp $(SOURCE)/$(SYSTEM_DIR)/include/modules/net/sch_ubicom_streamengine.ko $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)/lib/modules/net; \
				fi; \
			fi; \
		fi; \
	fi

	@if [ "$(CONFIG_BUSYBOX)" == "y" ]; then \
		echo  "  COPY      "/$(CONFIG_DIR)/$(BUSYBOX_CONFIG); \
		cp $(SOURCE)/$(CONFIG_DIR)/$(BUSYBOX_CONFIG) $(SOURCE)/$(SYSTEM_DIR)/src/busybox/.config; \
		echo  "  CONFIG    "/$(SYSTEM_DIR)/src/busybox; \
		$(MAKE) BUSYBOX_VERSION=$(BUSYBOX_VERSION) SOURCE=$(SOURCE) SYSTEM_DIR=$(SYSTEM_DIR) BUILD_DIR=$(BUILD_DIR) FILESYSTEM_DIR=$(SYSTEM_ROOT_DIR) -C $(SOURCE)/$(SYSTEM_DIR)/src/busybox oldconfig $(DEBUG); \
		echo  "  MAKE      "/$(SYSTEM_DIR)/src/busybox; \
		$(MAKE) BUSYBOX_VERSION=$(BUSYBOX_VERSION) SOURCE=$(SOURCE) SYSTEM_DIR=$(SYSTEM_DIR) BUILD_DIR=$(BUILD_DIR) FILESYSTEM_DIR=$(SYSTEM_ROOT_DIR) -C $(SOURCE)/$(SYSTEM_DIR)/src/busybox $(DEBUG); \
	fi

	@echo  "  CHECK     "/$(BUILD_DIR)/rootfs.img
	@if [ -s $(SOURCE)/$(BUILD_DIR)/rootfs.img ]; then \
		echo  "  REMOVE    "/$(BUILD_DIR)/rootfs.img; \
		rm -f $(SOURCE)/$(BUILD_DIR)/rootfs.img; \
	fi
	@echo  "  MKSQUASH  "/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)
	@fakeroot $(SOURCE)/$(TOOLS_DIR)/bin/mksquashfs $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR) $(SOURCE)/$(BUILD_DIR)/rootfs.img $(DEBUG);

	@echo  "  CHECK     "/$(BUILD_DIR)/rootfs.img
	@[ -s $(SOURCE)/$(BUILD_DIR)/rootfs.img ] || { echo -e "\033[33m  LOG       Missing "/$(BUILD_DIR)/rootfs.img"\033[0m"; exit 1; }

clean_system:
	@echo -e "\033[32m  LOG       System\033[0m"
	@echo  "  CLEAN     "/$(SYSTEM_DIR)/src/busybox
	@$(MAKE) BUSYBOX_VERSION=$(BUSYBOX_VERSION) -C $(SOURCE)/$(SYSTEM_DIR)/src/busybox clean $(DEBUG)
	

