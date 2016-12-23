# makefile for squashfs

SQUASHFS := squashfs-tools-4.0

all: squashfs

clean:
	@rm -rf ./$(SQUASHFS)

squashfs:
	@tar xzvf $(SQUASHFS).tar.gz;
	@cd $(SQUASHFS); make;

.PHONY: clean

