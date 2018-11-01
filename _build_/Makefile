PathRoot :=..
MAINDIR := $(PathRoot)/main
include Makefile.mk
.PHONY: all $(SUBDIRS) clean
all: $(SUBDIRS)
	@echo ------------------------------------------------------------------------------------------------------------------------
	@echo main
	@$(MAKE) --no-print-directory -C $(MAINDIR)

$(SUBDIRS):
	@echo ------------------------------------------------------------------------------------------------------------------------
	@echo $@
	@$(MAKE) --no-print-directory -C $@

clean:
	@dirs='$(SUBDIRS)'; for dir in $$dirs; do echo $$dir; $(MAKE) clean --no-print-directory -C $$dir; done
	@$(MAKE) clean --no-print-directory -C $(MAINDIR)
