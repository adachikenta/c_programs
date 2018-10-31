OBJDIR   =$(PathRoot)/_build_/obj/$(Component)
OBJS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.o))
DEPS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.d))
OUTPUTS  =$(OBJS) $(DEPS)

ifeq ($(Component),main)
OUT     :=$(Component).exe
#MAP     :=$(OUT:%.exe=%.map)
ARCS    :=$(addprefix $(PathRoot)/_build_/obj/, $(SUBDIRS:%=%.a))
OUTPUTS +=$(OUT) $(MAP)
else
ARC     :=$(PathRoot)/_build_/obj/$(Component).a
OUTPUTS +=$(ARC)
endif
