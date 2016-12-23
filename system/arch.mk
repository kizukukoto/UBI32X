# UBICOM32
#############################################################################

CC_PATH := $(TPATH_UC)
CROSS_COMPILE	:= ubicom32-linux-uclibc-
HOST_TYPE		:= ubicom32-linux-uclibc
HOST_CPU		:= ubicom32
HOST_ARCH		:= ubicom32-elf
KERNEL_CROSS_COMPILE := ubicom32-elf-

CC		= $(CROSS_COMPILE)gcc
CXX		= $(CROSS_COMPILE)g++
AS		= $(CROSS_COMPILE)as
AR		= $(CROSS_COMPILE)ar
LD		= $(CROSS_COMPILE)ld
RANLIB	= $(CROSS_COMPILE)ranlib
STRIP	= $(CROSS_COMPILE)strip
OBJCOPY	= $(CROSS_COMPILE)objcopy
CPU_BIG_ENDIAN=y

CFLAGS += -Os -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D__ARCH_USE_MMU__ -D__UCLIBC__ -fno-strict-aliasing -pipe -march=ubicom32v5 -DUBICOM32_ARCH_VERSION=5 -DIP8000 -D$(HOST_CPU) -I$(TPATH_UC)/ubicom32-linux-uclibc/runtime/usr/include
CFLAGS += -mfdpic -muclibc -fmath-errno -ftrapping-math -fweb -mhard-float

LDFLAGS = -march=ubicom32v5
export CPUFLAGS=-pipe -march=ubicom32v5 -Os -DUBICOM32_ARCH_VERSION=5 -D__ubicom32__ -DIP8000 -D__EXPORTED_HEADERS__ -I$(TPATH_UC)/ubicom32-linux-uclibc/runtime/usr/include
PARALLEL = $(shell grep -c processor /proc/cpuinfo|xargs expr 2 \*)
