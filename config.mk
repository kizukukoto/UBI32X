config:
	@echo -e "\033[32m  LOG       Config\033[0m"
	@[ -s $(SOURCE)/$(TOOLS_DIR)/bin/mconf ] || { \
		echo  "  MAKE      /$(TOOLS_DIR)/src/kconfig"; \
		$(MAKE) -C $(SOURCE)/$(TOOLS_DIR)/src/kconfig $(DEBUG); \
		echo  "  CHECK     /$(TOOLS_DIR)/src/kconfig/kconfig-2.6.38/scripts/kconfig/mconf"; \
		if [ -s $(SOURCE)/$(TOOLS_DIR)/src/kconfig/kconfig-2.6.38/scripts/kconfig/mconf ]; then \
			echo  "  COPY      /$(TOOLS_DIR)/src/kconfig/kconfig-2.6.38/scripts/kconfig/mconf"; \
			cp $(SOURCE)/$(TOOLS_DIR)/src/kconfig/kconfig-2.6.38/scripts/kconfig/mconf $(SOURCE)/$(TOOLS_DIR)/bin; \
		else \
			echo -e "\033[33m  LOG       Missing /$(TOOLS_DIR)/src/kconfig/kconfig-2.6.38/scripts/kconfig/mconf\033[0m"; \
			exit 1; \
		fi \
	}
	@$(SOURCE)/$(TOOLS_DIR)/bin/mconf $(SOURCE)/kbuild

	@echo  "  UPDATE    /$(CONFIG_DIR)"

	@if [ "$(CONFIG_BOARD_WDBWVK0000NSL)" == "y" ] || [ "$(CONFIG_BOARD_WDBKSP0010BCH)" == "y" ] || [ "$(CONFIG_BOARD_WDBKSP0020BCH)" == "y" ]; then \
		sed -i '/CONFIG_NOBOARD=/c\# CONFIG_NOBOARD is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP7160RGW=/c\# CONFIG_IP7160RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8000RGW=/c\# CONFIG_IP8000RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8100RGW=/c\CONFIG_IP8100RGW=y' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
	elif [ "$(CONFIG_BOARD_DIR827A1)" == "y" ] || [ "$(CONFIG_BOARD_DIR857A1)" == "y" ]; then \
		sed -i '/CONFIG_NOBOARD=/c\# CONFIG_NOBOARD is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP7160RGW=/c\# CONFIG_IP7160RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8000RGW=/c\CONFIG_IP8000RGW=y' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8100RGW=/c\# CONFIG_IP8100RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
	elif [ "$(CONFIG_BOARD_DIR657A1)" == "y" ]; then \
		sed -i '/CONFIG_NOBOARD=/c\# CONFIG_NOBOARD is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP7160RGW=/c\CONFIG_IP7160RGW=y' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8000RGW=/c\# CONFIG_IP8000RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8100RGW=/c\# CONFIG_IP8100RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
	else \
		sed -i '/CONFIG_NOBOARD=/c\CONFIG_NOBOARD=y' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP7160RGW=/c\# CONFIG_IP7160RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8000RGW=/c\# CONFIG_IP8000RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		sed -i '/CONFIG_IP8100RGW=/c\# CONFIG_IP8100RGW is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
	fi
	@if [ "$(CONFIG_ARCH_UBICOM32)" == "y" ]; then \
		sed -i '/CONFIG_UBICOM32=/c\CONFIG_UBICOM32=y' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
		if [ "$(CONFIG_ARCH_UBICOM32_V5)" == "y" ]; then \
			sed -i '/CONFIG_UBICOM32_V4=/c\# CONFIG_UBICOM32_V4 is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
			sed -i '/CONFIG_UBICOM32_V5=/c\CONFIG_UBICOM32_V5=y' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
			if [ "$(CONFIG_ARCH_UBICOM32_IP8000AU)" == "y" ]; then \
				sed -i '/CONFIG_NR_CPUS=/c\CONFIG_NR_CPUS=4' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
			fi; \
			if [ "$(CONFIG_ARCH_UBICOM32_IP8260U)" == "y" ]; then \
				sed -i '/CONFIG_NR_CPUS=/c\CONFIG_NR_CPUS=5' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
			fi; \
		fi; \
		if [ "$(CONFIG_ARCH_UBICOM32_V4)" == "y" ]; then \
			sed -i '/CONFIG_UBICOM32_V4=/c\CONFIG_UBICOM32_V4=y' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
			sed -i '/CONFIG_UBICOM32_V5=/c\# CONFIG_UBICOM32_V5 is not set' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
			if [ "$(CONFIG_ARCH_UBICOM32_IP7160U)" == "y" ]; then \
				sed -i '/CONFIG_NR_CPUS=/c\CONFIG_NR_CPUS=4' $(SOURCE)/$(CONFIG_DIR)/kernel.conf; \
			fi; \
		fi; \
	fi

clean_config:
	@echo -e "\033[32m  LOG       Config\033[0m"
	@echo  "  CLEAN     /$(CONFIG_DIR)"
	@rm -f $(SOURCE)/$(CONFIG_DIR)/kernel.conf
	@rm -f $(SOURCE)/$(CONFIG_DIR)/system.conf
	@rm -f $(SOURCE)/$(CONFIG_DIR)/busybox.conf
	@rm -f $(SOURCE)/$(CONFIG_DIR)/bootloader.conf
	@rm -f $(SOURCE)/$(CONFIG_DIR)/release.conf
	@cp $(SOURCE)/$(CONFIG_DIR)/default/kernel.conf $(SOURCE)/$(CONFIG_DIR)
	@cp $(SOURCE)/$(CONFIG_DIR)/default/system.conf $(SOURCE)/$(CONFIG_DIR)
	@cp $(SOURCE)/$(CONFIG_DIR)/default/busybox.conf $(SOURCE)/$(CONFIG_DIR)
	@cp $(SOURCE)/$(CONFIG_DIR)/default/bootloader.conf $(SOURCE)/$(CONFIG_DIR)
	@cp $(SOURCE)/$(CONFIG_DIR)/default/release.conf $(SOURCE)/$(CONFIG_DIR)

