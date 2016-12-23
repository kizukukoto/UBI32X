toolchain:
	@echo -e "\033[32m  LOG       Toolchain\033[0m" 
	@echo  "  CHECK     "/$(TOOLCHAIN_INSTALL_DIR)/$(TOOLCHAIN_DIR)
	@if [ -d /$(TOOLCHAIN_INSTALL_DIR)/$(TOOLCHAIN_DIR) ]; then \
		if [[ $EUID -ne 0 ]]; then \
			exit 0; \
		else \
			echo -e "\033[33m  LOG       You are building in superuser mode\033[0m"; \
			exit 1; \
		fi \
	else \
		echo -e "\033[33m  LOG       Missing toolchain install\033[0m"; \
		echo  "  CHECK     "/$(TOOLCHAIN_DIR); \
		if [ -d /$(SOURCE)/$(TOOLCHAIN_DIR) ]; then \
			if [[ $EUID -ne 0 ]]; then \
				echo -e "\033[33m  LOG       You need to be in superuser mode\033[0m"; \
				exit 1; \
			else \
				echo  "  COPY      "/$(TOOLCHAIN_DIR); \
				cp -rf /$(SOURCE)/$(TOOLCHAIN_DIR) /opt; \
				echo -e "\033[33m  LOG       You may build in normal user mode\033[0m"; \
				exit 1; \
			fi \
		else \
			echo -e "\033[33m  LOG       Missing toolchain source\033[0m"; \
			exit 1; \
		fi \
	fi
