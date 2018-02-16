# makefile for busybox

VERSION := $(BUSYBOX_VERSION)
SOURCE := $(SOURCE)
BUILD_DIR := $(BUILD_DIR)
SYSTEM_DIR := $(SYSTEM_DIR)
FILESYSTEM_DIR := $(FILESYSTEM_DIR)

-include ../../arch.mk

all: busybox

clean:
	@rm -rf ./busybox-$(VERSION)

patch:
	@if [ ! -d ./busybox-$(VERSION) ]; then \
		tar xzvf busybox-$(VERSION).tar.gz; \
		chmod +w -R ./busybox-$(VERSION); \
		patch -p0 < busybox-$(VERSION).tar.gz.diff; \
	fi
	sed -i '/CONFIG_CROSS_COMPILER_PREFIX=/c\CONFIG_CROSS_COMPILER_PREFIX="$(TPATH_UC)/bin/$(CROSS_COMPILE)"' .config;
	sed -i '/CONFIG_EXTRA_CFLAGS=/c\CONFIG_EXTRA_CFLAGS="$(CFLAGS) -I$(SOURCE)/$(SYSTEM_DIR)/include/shared"' .config;
	sed -i '/CONFIG_PREFIX=/c\CONFIG_PREFIX="$(SOURCE)/$(BUILD_DIR)/$(FILESYSTEM_DIR)"' .config;
	@mv .config ./busybox-$(VERSION);

oldconfig: patch
	@cd busybox-$(VERSION); make oldconfig &> /dev/null;

busybox:
	@cd busybox-$(VERSION); make;
	@cd busybox-$(VERSION); make install;

.PHONY: busybox patch clean



