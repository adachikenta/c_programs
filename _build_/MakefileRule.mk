# targets
.PHONY: clean
all: $(PROG)
ifneq ($(findstring $(MAKECMDGOALS),$(origin clean)),)
-include $(DEPS)
endif
clean:
	@echo cleaning output file...; ls $(OUTPUTS) 2>/dev/null | sort | sed 's/^/\t/' | tee clean.log; rm -f $(OUTPUTS)

# depend source code file
$(DEPS): $(OBJDIR)/%.d: %.c $(MAKEFILE_LIST)
	$(common-rule)
	$(CC) -MM $(FLAGS_CC) $(FLAGS_DEFINE) $(FLAGS_INCLUDE) -c $< | sed -e 's%$*.o%$(dir $@)$*.o $@%' > $@
$(OBJS): $(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
	$(common-rule)
	$(CC) $(FLAGS_CC) $(FLAGS_DEFINE) $(FLAGS_INCLUDE) -c $< $(OUTPUT_OPTION)

# depend object file
$(ARC): $(OBJS)
	$(common-rule)
	$(AR) -r $@ $^
