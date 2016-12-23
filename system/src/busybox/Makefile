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
		tar jxf busybox-$(VERSION).tar.bz2; \
		chmod +w -R ./busybox-$(VERSION); \
		patch -p0 < busybox-$(VERSION).tar.bz2.alpha.diff; \
	fi
	@sed -e 's|@@CROSS_COMPILER@@|$(TPATH_UC)/bin/$(CROSS_COMPILE)|' .config -i .config;
	@sed -e 's|@@CFLAGS@@|$(CFLAGS) -I$(SOURCE)/$(SYSTEM_DIR)/include/shared|' .config -i .config;
	@sed -e 's|@@TARGET@@|$(SOURCE)/$(BUILD_DIR)/$(FILESYSTEM_DIR)|' .config -i .config;
	@mv .config ./busybox-$(VERSION);

oldconfig: patch
	@cd busybox-$(VERSION); make oldconfig &> /dev/null;

busybox:
	@cd busybox-$(VERSION); make;
	@cd busybox-$(VERSION); make install;

.PHONY: busybox patch clean



