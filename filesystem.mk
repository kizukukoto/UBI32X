make_filesystem:
	@echo  -e "\033[32m  LOG       Filesystem\033[0m"
	@echo  "  CHECK     /$(BUILD_DIR)"
	@[ -d $(SOURCE)/$(BUILD_DIR) ] || { echo  "  CREATE    /$(BUILD_DIR)"; mkdir -p $(SOURCE)/$(BUILD_DIR); }
	@echo  "  CHECK     /$(BUILD_DIR)/$(RELEASE_DIR)"
	@[ -d $(SOURCE)/$(BUILD_DIR)/$(RELEASE_DIR) ] || { echo  "  CREATE    /$(BUILD_DIR)/$(RELEASE_DIR)"; mkdir -p $(SOURCE)/$(BUILD_DIR)/$(RELEASE_DIR); }

	@echo  "  REMOVE    /$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)"
	@rm -rf $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)
	
	@echo  "  COPY      /$(FILESYSTEM_DIR)"
	@cp -rf $(SOURCE)/$(FILESYSTEM_DIR) $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)

clean_filesystem:
	@echo -e "\033[32m  LOG       Filesystem\033[0m"
	@echo  "  CLEAN     /$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)"
	@rm -rf $(SOURCE)/$(BUILD_DIR)/$(SYSTEM_ROOT_DIR)

