PathRoot :=..
Component:=$(notdir $(CURDIR))
SRCS     := $(wildcard *.c)
PROG    :=$(PathRoot)/_build_/$(Component).exe#        : program file
all: $(PROG)
include $(PathRoot)/_build_/MakefileLibs.mk
include $(PathRoot)/_build_/MakefileComponent.mk

COMPONENTS  = add
COMPONENTS += divide
COMPONENTS += multiply
COMPONENTS += subtract

# output directory
OBJDIR     =obj
DUMPDIR    =reverse
RELEASEDIR =release
# output file
MAP     :=$(PROG:%.exe=%.map)#                         : map file
RELEASE :=$(RELEASEDIR)/$(PROG)#                       : program file for release
DASMR   :=$(DUMPDIR)/$(PROG:%.exe=%.dasmr)#            : disassembler file(release)
DASM    :=$(DUMPDIR)/$(PROG:%.exe=%.dasm)#             : disassembler file
NMF     :=$(DUMPDIR)/$(PROG:%.exe=%.nm)#               : nm file
HEAD    :=$(DUMPDIR)/$(PROG:%.exe=%.header)#           : header file
LDD     :=$(DUMPDIR)/$(PROG:%.exe=%.ldd)#              : use dll list
ARC     :=$(OBJDIR)/$(Component).a
DEPS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.d))#    : dependent file
PPS     :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.pp))#   : preprocessed file
ASMS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.s))#    : assembler file
OBJS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.o))#    : object file
DASMS   :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.dasm))# : disassembler file
NMS     :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.nm))#   : nm file
OUTPUTS :=$(PROG) $(MAP) $(RELEASE) $(DASMR) $(DASM) $(NMF) $(HEAD) $(LDD) $(DEPS) $(PPS) $(ASMS) $(OBJS) $(DASMS) $(NMS)

# common rule
define common-rule
    @echo ------------------------------------------------------------------------------------------------------------------------
	@echo creating $@ "<-------" depends on $?
	@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@rm -f $@
endef

# targets
.PHONY: clean version test
preprocess: $(PPS)
assemble: $(ASMS)
release: $(RELEASE)
release-dump: $(DASMR)
dump: $(DASMS) $(NMS) $(DASM) $(NMF) $(HEAD) $(LDD)
ifneq ($(findstring $(MAKECMDGOALS),$(origin clean)$(origin version)$(origin test)),)
-include $(DEPS)
endif
clean:
	@echo cleaning output file...; ls $(OUTPUTS) 2>/dev/null | sort | sed 's/^/\t/' | tee clean.log; rm -f $(OUTPUTS)
version:
	@echo checking tool version...; bash version.sh $(TOOLS) | tee version.log
test:
	@$(PROG) test a b c; echo returned : $$?

# depend source code file
$(DEPS): $(OBJDIR)/%.d: %.c $(MAKEFILE_LIST)
	$(common-rule)
	$(CC) -MM $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< | sed -e 's%$*.o%$(dir $@)$*.o $@%' > $@
$(PPS): $(OBJDIR)/%.pp: %.c $(OBJDIR)/%.d
	$(common-rule)
	$(CPP) $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< $(OUTPUT_OPTION)
$(ASMS): $(OBJDIR)/%.s: %.c $(OBJDIR)/%.d
	$(common-rule)
	$(CAS) $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< $(OUTPUT_OPTION)
$(OBJS): $(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
	$(common-rule)
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< $(OUTPUT_OPTION)

# depend object file
$(PROG): $(OBJS)
	$(common-rule)
	$(CC) $(CFLAGS) -Wl,-Map=$(MAP) $(LIBS) $^ $(OUTPUT_OPTION)
$(DASMS): $(OBJDIR)/%.dasm: $(OBJDIR)/%.o
	$(common-rule)
	$(DUMP) -d $^ > $@
$(NMS): $(OBJDIR)/%.nm: $(OBJDIR)/%.o
	$(common-rule)
	$(NM) -o -g $^ > $@

# depend program file
$(RELEASE): $(PROG)
	$(common-rule)
	$(STRIP) $^ $(OUTPUT_OPTION)
$(DASM): $(PROG)
	$(common-rule)
	$(DUMP) -d $^ > $@
$(NMF): $(PROG)
	$(common-rule)
	$(NM) -o -g $^ > $@
$(HEAD): $(PROG)
	$(common-rule)
	$(DUMP) -x $^ > $@
$(LDD): $(PROG)
	$(common-rule)
	$(DUMP) -p $^ | grep 'DLL Name:' > $@

# depend release program file
$(DASMR): $(RELEASE)
	$(common-rule)
	$(DUMP) -d $^ > $@
