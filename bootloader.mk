make_bootloader:
	@echo -e "\033[32m  LOG       Bootloader\033[0m"
	@echo  "  CHECK     /$(BUILD_DIR)/mainexec.elf"
	@[ -s $(SOURCE)/$(BUILD_DIR)/mainexec.elf ] || { echo  "  COPY      /$(BOOTLOADER_DIR)/mainexec.elf"; cp $(SOURCE)/$(BOOTLOADER_DIR)/mainexec.elf $(SOURCE)/$(BUILD_DIR); }

clean_bootloader:
	@echo -e "\033[32m  LOG       Bootloader\033[0m"
	@echo  "  CLEAN     /$(BUILD_DIR)/mainexec.elf"
	@rm -f $(SOURCE)/$(BUILD_DIR)/mainexec.elf

