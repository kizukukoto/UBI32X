# makefile for lzma

LZMA	:= lzma-4.32.6

all: lzma

clean:
	@rm -rf ./$(LZMA)

lzma:
	@tar xzvf $(LZMA).tar.gz;
	@cd $(LZMA); ./configure;
	@cd $(LZMA); make;

.PHONY: clean

