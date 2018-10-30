# posix development tools
STRIP :=strip
NM    :=nm
# compiler tool chain
CC    :=clang
AR    :=ar
LD    :=ld
TOOLS :=$(MAKE) $(STRIP) $(NM) $(CC) $(AR) $(LD)
