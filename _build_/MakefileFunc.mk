# common rule
define common-rule
    @echo ------------------------------------------------------------------------------------------------------------------------
	@echo creating $@ "<-------" depends on $?
	@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	@rm -f $@
endef