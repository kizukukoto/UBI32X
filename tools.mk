make_tools:
	@echo -e "\033[32m  LOG       Tools\033[0m"
	@echo  "  CHECK     /$(TOOLS_DIR)/bin/lzma"
	@[ -s $(SOURCE)/$(TOOLS_DIR)/bin/lzma ] || { \
		echo  "  MAKE      /$(TOOLS_DIR)/src/lzma"; \
		$(MAKE) -C $(SOURCE)/$(TOOLS_DIR)/src/lzma $(DEBUG); \
		echo  "  CHECK     /$(TOOLS_DIR)/src/lzma/lzma-4.32.6/src/lzma/lzma"; \
		if [ -s $(SOURCE)/$(TOOLS_DIR)/src/lzma/lzma-4.32.6/src/lzma/lzma ]; then \
			echo  "  COPY      /$(TOOLS_DIR)/src/lzma/lzma-4.32.6/src/lzma/lzma"; \
			cp $(SOURCE)/$(TOOLS_DIR)/src/lzma/lzma-4.32.6/src/lzma/lzma $(SOURCE)/$(TOOLS_DIR)/bin; \
		else \
			echo -e "\033[33m  LOG       Missing /$(TOOLS_DIR)/src/lzma/lzma-4.32.6/src/lzma/lzma\033[0m"; \
			exit 1; \
		fi \
	}
	@echo  "  CHECK     /$(TOOLS_DIR)/bin/squashfs"
	@[ -s $(SOURCE)/$(TOOLS_DIR)/bin/mksquashfs ] || { \
		echo  "  MAKE      /$(TOOLS_DIR)/src/squashfs"; \
		$(MAKE) -C $(SOURCE)/$(TOOLS_DIR)/src/squashfs $(DEBUG); \
		echo  "  CHECK     /$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/mksquashfs"; \
		if [ -s $(SOURCE)/$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/mksquashfs ]; then \
			echo  "  COPY      /$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/mksquashfs"; \
			cp $(SOURCE)/$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/mksquashfs $(SOURCE)/$(TOOLS_DIR)/bin; \
		else \
			echo -e "\033[33m  LOG       Missing /$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/mksquashfs\033[0m"; \
			exit 1; \
		fi; \
		echo  "  CHECK     /$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/unsquashfs"; \
		if [ -s $(SOURCE)/$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/unsquashfs ]; then \
			echo  "  COPY      /$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/unsquashfs"; \
			cp $(SOURCE)/$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/unsquashfs $(SOURCE)/$(TOOLS_DIR)/bin; \
		else \
			echo -e "\033[33m  LOG       Missing /$(TOOLS_DIR)/src/squashfs/squashfs-tools-4.0/unsquashfs\033[0m"; \
			exit 1; \
		fi \
	}

clean_tools:
	@echo -e "\033[32m  LOG       Tools\033[0m"
	@echo  "  CLEAN     /$(TOOLS_DIR)/src/kconfig"
	@$(MAKE) -C $(SOURCE)/$(TOOLS_DIR)/src/kconfig clean $(DEBUG)
	@echo  "  CLEAN     /$(TOOLS_DIR)/bin/mconf"
	@rm -f $(SOURCE)/$(TOOLS_DIR)/bin/mconf
	@echo  "  CLEAN     /$(TOOLS_DIR)/src/lzma"
	@$(MAKE) -C $(SOURCE)/$(TOOLS_DIR)/src/lzma clean $(DEBUG)
	@echo  "  CLEAN     /$(TOOLS_DIR)/bin/lzma"
	@rm -f $(SOURCE)/$(TOOLS_DIR)/bin/lzma
	@echo  "  CLEAN     /$(TOOLS_DIR)/src/squashfs"
	@$(MAKE) -C $(SOURCE)/$(TOOLS_DIR)/src/squashfs clean $(DEBUG)
	@echo  "  CLEAN     /$(TOOLS_DIR)/bin/mksquashfs"
	@rm -f $(SOURCE)/$(TOOLS_DIR)/bin/mksquashfs
	@echo  "  CLEAN     /$(TOOLS_DIR)/bin/unsquashfs"
	@rm -f $(SOURCE)/$(TOOLS_DIR)/bin/unsquashfs

