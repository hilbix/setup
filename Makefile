#

.PHONY:	love
love:
	if [ -f ../Makefile ]; then $(MAKE) -C ..; else $(MAKE) all; fi

.PHONY:	all
all:	setup/.git

setup/.git:
	echo weird: missing '$@'
	@false

