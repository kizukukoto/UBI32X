environment:
	@echo -e "\033[32m  LOG       Environment\033[0m"
	@echo  "  CHECK     TPATH_UC"
	@[ "$(TPATH_UC)" == "/$(TOOLCHAIN_INSTALL_DIR)/$(TOOLCHAIN_DIR)" ] || { echo -e "\033[33m  LOG       Missing TPATH_UC environment variable\033[0m"; exit 1; }
	@echo  "  CHECK     TPATH_KC"
	@[ "$(TPATH_KC)" == "/$(TOOLCHAIN_INSTALL_DIR)/$(TOOLCHAIN_DIR)" ] || { echo -e "\033[33m  LOG       Missing TPATH_KC environment variable\033[0m"; exit 1;}
	@echo  "  CHECK     TPATH_LIBTGZ"	
	@[ "$(TPATH_LIBTGZ)" == "/$(TOOLCHAIN_INSTALL_DIR)/$(TOOLCHAIN_DIR)/lib.tgz" ] || { echo -e "\033[33m  LOG       Missing TPATH_LIBTGZ environment variable\033[0m"; exit 1;}
	@echo  "  CHECK     LD_LIBRARY_PATH"
	@[ "$(LD_LIBRARY_PATH)" == "/$(TOOLCHAIN_INSTALL_DIR)/$(TOOLCHAIN_DIR)/lib" ] || { echo -e "\033[33m  LOG       Missing LD_LIBRARY_PATH environment variable\033[0m"; exit 1;}
	@echo  "  CHECK     PATH"
	@[[ "$(PATH)" =~ "/$(TOOLCHAIN_INSTALL_DIR)/$(TOOLCHAIN_DIR)/bin" ]] || { echo -e "\033[33m  LOG       Missing PATH environment variable\033[0m"; exit 1;}
