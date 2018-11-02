PathRoot:=..
MAINDIR := $(PathRoot)/main
MODULES  = add subtract multiply divide
SUBDIRS := $(MODULES:%=$(PathRoot)/%)

.PHONY: all $(SUBDIRS) clean

all: $(SUBDIRS)
	@echo ""
	@echo "<<<< main >>>>"
	@$(MAKE) --no-print-directory -C $(MAINDIR)

$(SUBDIRS):
	@echo ""
	@echo "<<<<" $(notdir $@) ">>>>"
	@$(MAKE) --no-print-directory -C $@

clean:
	@dirs='$(SUBDIRS)'; for dir in $$dirs; do echo ; echo $$dir; $(MAKE) clean --no-print-directory -C $$dir; done
	@echo ; echo main; $(MAKE) clean --no-print-directory -C $(MAINDIR)
