# output directory
OBJDIR   =$(PathRoot)/_build_/obj/$(Component)
# output file
MAP     :=$(PROG:%.exe=%.map)#                         : map file
ARC     :=$(OBJDIR)/$(Component).a#                    : archive file
ARCS    :=$(addprefix $(OBJDIR)/, $(COMPONENTS:%.a=%/%.a))#    : object file
OBJS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.o))#    : object file
DEPS    :=$(addprefix $(OBJDIR)/, $(SRCS:%.c=%.d))#    : dependent file
OUTPUTS :=$(PROG) $(MAP) $(ARC) $(OBJS) $(DEPS)
