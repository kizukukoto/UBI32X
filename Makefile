DEBUG := &> /dev/null
# Arguments
ifeq ($(strip $(SHOW)),y)
	DEBUG :=
endif
# Variables
SOURCE := $(shell pwd)
# Config
CONFIG_DIR := config
# Toolchain
TOOLCHAIN_DIR := ubi32_sdk
TOOLCHAIN_INSTALL_DIR := opt
# Filesystem
BUILD_DIR := build
FILESYSTEM_DIR := filesystem
# Kernel
KERNEL_DIR := kernel
KERNEL_CONFIG := kernel.conf
KERNEL_VERSION := 2.6.36
KERNEL_CROSS := ubicom32-elf-
KERNEL_LINUX_KARCH := ubicom32
KERNEL_MAKEOPTS	:= -C $(SOURCE)/$(KERNEL_DIR)/$(KERNEL_VERSION) CROSS_COMPILE="$(KERNEL_CROSS)" ARCH="$(KERNEL_LINUX_KARCH)" KBUILD_HAVE_NLS=no CONFIG_SHELL="$(BASH)"
# System
SYSTEM_DIR:= system
SYSTEM_CONFIG := system.conf
BUSYBOX_CONFIG := busybox.conf
BUSYBOX_VERSION := 1.18.1
SYSTEM_CROSS := ubicom32-linux-uclibc-
SYSTEM_ROOT_DIR := rootfs
-include $(SOURCE)/$(CONFIG_DIR)/$(SYSTEM_CONFIG)
# Tools
TOOLS_DIR := tools
# Bootloader
BOOTLOADER_DIR := bootloader
BOOTLOADER_CONFIG := bootloader.conf
-include $(SOURCE)/$(CONFIG_DIR)/$(BOOTLOADER_CONFIG)
FLASH_SECTOR_SIZE := $$(($(EXTFLASH_MAX_PAGE_SIZE_KB) * 1024 ))
FLASH_SECTOR_MASK := $$(($(FLASH_SECTOR_SIZE) - 1 ))
# Release
RELEASE_DIR := release
RELEASE_CONFIG := release.conf
-include $(SOURCE)/$(CONFIG_DIR)/$(RELEASE_CONFIG)

all: toolchain environment dependency make_tools make_filesystem make_bootloader make_kernel make_system make_release

-include $(SOURCE)/toolchain.mk
-include $(SOURCE)/environment.mk
-include $(SOURCE)/dependency.mk
-include $(SOURCE)/tools.mk
-include $(SOURCE)/filesystem.mk
-include $(SOURCE)/bootloader.mk
-include $(SOURCE)/kernel.mk
-include $(SOURCE)/system.mk
-include $(SOURCE)/release.mk

clean: clean_kernel clean_system clean_tools clean_bootloader clean_release clean_filesystem
	@echo -e "\033[32m  LOG       Clean\033[0m"
	@echo  "  CLEAN     "/$(BUILD_DIR)
	@rm -rf $(SOURCE)/$(BUILD_DIR)

.PHONY: all toolchain environment dependency make_filesystem make_kernel make_system make_tools make_bootloader make_release clean clean_kernel clean_system clean_tools clean_bootloader clean_release clean_filesystem
    
    
