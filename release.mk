make_release:
	@echo -e "\033[32m  LOG       Release\033[0m"
	@echo  "  ELF2BIN   /$(BUILD_DIR)/mainexec.elf"
	@$(SOURCE)/tools/bin/elf2bin -b __flash_entry_load_begin -e __flash_limit -f 0xff $(SOURCE)/$(BUILD_DIR)/mainexec.elf -o $(SOURCE)/$(BUILD_DIR)/mainexec.bin $(DEBUG)
	@echo  "  LZMA      /$(BUILD_DIR)/mainexec.bin"
	@$(SOURCE)/$(TOOLS_DIR)/bin/lzma -c $(SOURCE)/$(BUILD_DIR)/mainexec.bin > $(SOURCE)/$(BUILD_DIR)/mainexec.lzma
	@echo  "  ELF2BIN   /$(BUILD_DIR)/vmlinux.elf"
	@$(SOURCE)/$(TOOLS_DIR)/bin/elf2bin -b _begin -e _end -f 0xff -pad $(SOURCE)/$(BUILD_DIR)/vmlinux.elf -o $(SOURCE)/$(BUILD_DIR)/vmlinux.bin $(DEBUG)
	@echo  "  LZMA      /$(BUILD_DIR)/vmlinux.bin"
	@$(SOURCE)/$(TOOLS_DIR)/bin/lzma -c $(SOURCE)/$(BUILD_DIR)/vmlinux.bin > $(SOURCE)/$(BUILD_DIR)/vmlinux.lzma
	@echo  "  SOURCE    /$(BUILD_DIR)/upgrade.vars"
	@MAINEXEC_SDRAM_BEGIN_ADDR=0x`ubicom32-elf-nm $(SOURCE)/$(BUILD_DIR)/mainexec.elf | grep __sdram_begin | sed 's/ .*//'`; \
	UCLINUX_IMAGE_RUN_ADDR_DEC=$$(($$MAINEXEC_SDRAM_BEGIN_ADDR + $(APP_UCLINUX_MEM_START_ADDR))); \
	printf "START_ADDR=0x%x\n" $$UCLINUX_IMAGE_RUN_ADDR_DEC > $(SOURCE)/$(BUILD_DIR)/upgrade.vars; \
	printf "ENTRY_POINT=0x%x\n" $$UCLINUX_IMAGE_RUN_ADDR_DEC >> $(SOURCE)/$(BUILD_DIR)/upgrade.vars;
	@. $(SOURCE)/$(BUILD_DIR)/upgrade.vars; \
	echo  "  MKIMAGE   /$(BUILD_DIR)/upgrade.ub"; \
	$(SOURCE)/$(TOOLS_DIR)/bin/mkimage -A ubicom32 -O linux -T multi -C lzma -a $$START_ADDR -e $$ENTRY_POINT -n $(CONFIG_IDENTITY_STRING) -d $(SOURCE)/$(BUILD_DIR)/mainexec.lzma:$(SOURCE)/$(BUILD_DIR)/rootfs.img:$(SOURCE)/$(BUILD_DIR)/vmlinux.lzma $(SOURCE)/$(BUILD_DIR)/upgrade.ub $(DEBUG);
	@EXTRA_BYTES=$$(($(FLASH_SECTOR_SIZE) - (`stat $(SOURCE)/$(BUILD_DIR)/upgrade.ub -c %s` & $(FLASH_SECTOR_MASK)))); \
	dd oflag=append of=$(SOURCE)/$(BUILD_DIR)/upgrade.ub if=/dev/zero conv=block,notrunc count=$$EXTRA_BYTES bs=1 status=noxfer 2> /dev/null
	@echo  "  COPY      /$(BUILD_DIR)/upgrade.ub"
	@cp $(SOURCE)/$(BUILD_DIR)/upgrade.ub $(SOURCE)/$(BUILD_DIR)/release.img
	@echo  "  SEAMA     /$(BUILD_DIR)/release.img"
	@$(SOURCE)/$(TOOLS_DIR)/bin/seama -i $(SOURCE)/$(BUILD_DIR)/release.img -m dev=$(CONFIG_FWDEV) -m type=firmware -m signature=$(CONFIG_FIRMWARE_SIGNATURE) -m noheader=0
	@echo  "  MOVE      /$(BUILD_DIR)/release.img.seama"
	@mv $(SOURCE)/$(BUILD_DIR)/release.img.seama $(SOURCE)/$(BUILD_DIR)/$(RELEASE_DIR)/ubi32x_xxxx.bin
	@echo  "  REMOVE    /$(BUILD_DIR)/release.img"
	@rm -f $(SOURCE)/$(BUILD_DIR)/release.img
	@echo  "  SEAMA     /$(BUILD_DIR)/$(RELEASE_DIR)/ubi32x_xxxx.bin"
	@$(SOURCE)/$(TOOLS_DIR)/bin/seama -d $(SOURCE)/$(BUILD_DIR)/$(RELEASE_DIR)/ubi32x_xxxx.bin $(DEBUG)
	@echo  "  CHECK     /$(BUILD_DIR)/$(RELEASE_DIR)/ubi32x_xxxx.bin"
	@[ -s $(SOURCE)/$(BUILD_DIR)/$(RELEASE_DIR)/ubi32x_xxxx.bin ] || { echo -e "\033[33m  LOG       Missing /$(BUILD_DIR)/$(RELEASE_DIR)/ubi32x_xxxx.bin\033[0m"; exit 1; }
	@echo -e "\033[32m  LOG       Image\033[0m"
	@echo  "  FILE      /$(BUILD_DIR)/$(RELEASE_DIR)/ubi32x_xxxx.bin"

clean_release:
	@echo -e "\033[32m  LOG       Release\033[0m"
	@echo  "  CLEAN     /$(BUILD_DIR)/$(RELEASE_DIR)"
	@rm -f $(SOURCE)/$(BUILD_DIR)/$(RELEASE_DIR)/*.bin
	@echo  "  CLEAN     /$(BUILD_DIR)/mainexec.bin"
	@rm -f $(SOURCE)/$(BUILD_DIR)/mainexec.bin
	@echo  "  CLEAN     /$(BUILD_DIR)/mainexec.lzma"
	@rm -f $(SOURCE)/$(BUILD_DIR)/mainexec.lzma
	@echo  "  CLEAN     /$(BUILD_DIR)/vmlinux.bin"
	@rm -f $(SOURCE)/$(BUILD_DIR)/vmlinux.bin
	@echo  "  CLEAN     /$(BUILD_DIR)/vmlinux.lzma"
	@rm -f $(SOURCE)/$(BUILD_DIR)/vmlinux.lzma
	@echo  "  CLEAN     /$(BUILD_DIR)/upgrade.vars"
	@rm -f $(SOURCE)/$(BUILD_DIR)/upgrade.vars
	@echo  "  CLEAN     /$(BUILD_DIR)/upgrade.ub"
	@rm -f $(SOURCE)/$(BUILD_DIR)/upgrade.ub
	@echo  "  CLEAN     /$(BUILD_DIR)/rootfs.img"
	@rm -f $(SOURCE)/$(BUILD_DIR)/rootfs.img

