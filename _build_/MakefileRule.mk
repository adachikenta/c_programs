.PHONY: clean

ifneq ($(findstring $(MAKECMDGOALS),$(origin clean)),)
-include $(DEPS)
endif

ifeq ($(Component),main)
$(OUT): $(OBJS) $(ARCS)
	$(common-rule)
	$(LD) $(FLAGS_CC) -Wl,-Map=$(MAP) $(LIBS) $^ $(OUTPUT_OPTION)
else
$(ARC): $(OBJS)
	$(common-rule)
	$(AR) $@ $^
endif

$(OBJS): $(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
	$(common-rule)
	$(CC) $(FLAGS_CC) $(FLAGS_DEFINE) $(FLAGS_INCLUDE) -c $< $(OUTPUT_OPTION)
$(DEPS): $(OBJDIR)/%.d: %.c $(MAKEFILE_LIST)
	$(common-rule)
	$(CC) -MM $(FLAGS_CC) $(FLAGS_DEFINE) $(FLAGS_INCLUDE) -c $< | sed -e 's%$*.o%$(dir $@)$*.o $@%' > $@

clean:
	@echo cleaning output file...; ls $(OUTPUTS) 2>/dev/null | sort | sed 's/^/\t/' | tee clean.log; rm -f $(OUTPUTS)
