OBJDIR   =$(PathMake)/obj/$(Module)
OBJLDIR  =$(PathMake)/obj/objlink
OBJS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.o))
DEPS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.d))
OUTPUTS  =$(OBJS) $(DEPS)

ifeq ($(Module),main)
OUT     :=$(PathMake)/$(Module).exe
MAP     :=$(OUT:%.exe=%.map)
OBJLINKS:= add subtract multiply divide
ARCS    :=$(addprefix $(OBJLDIR)/, $(OBJLINKS:%=%.a))
OUTPUTS +=$(OUT) $(MAP)
else
ARC     :=$(OBJLDIR)/$(Module).a
OUTPUTS +=$(ARC)
endif
