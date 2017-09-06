# makefile for kconfig

KCONFIG	:= kconfig-2.6.38

all: kconfig

clean:
	@rm -rf ./$(KCONFIG)

kconfig:
	@tar xzvf $(KCONFIG).tar.gz;
	@patch -p0 < $(KCONFIG).tar.gz.diff
	@cd $(KCONFIG); make menuconfig;

.PHONY: clean

