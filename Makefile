SRCDIR			= src
DMD					= dmd
CC					= gcc
RM					= rm -rf
SRCS				= link.d type.d repo.d main.d config.d path.d
TARGETS			= $(SRCS:%.d=$(SRCDIR)/%.d)
OBJS				= $(SRCS:%.d=%.o)
RESPROGRAM	= release/dmgr

all:	$(RESPROGRAM)
	chmod 555 $(RESPROGRAM)

$(RESPROGRAM): $(TARGETS) Makefile
	$(DMD) -of$@ $(TARGETS)

clean:
	$(RM) $(RESPROGRAM) $(OBJS)
