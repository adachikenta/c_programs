CC    :=clang
AR    :=ld -r -o
LD    :=clang
TOOLS :=$(MAKE) $(CC) $(AR) $(LD)
