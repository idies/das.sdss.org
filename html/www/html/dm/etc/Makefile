INSTALL_DIR = $(DM_DIR)

default:
	@echo Please invoke this makefile using sdssmake. >&2
	@exit 1

all: 

clean :
	@ echo in .
	rm -f *~ core *.bak *.orig *.old .\#* \#*\#

install:
	@if [ "$(INSTALL_DIR)" = "" ]; then \
		echo You have not specified a destination directory >&2; \
		exit 1; \
	fi
	@rm -fr $(INSTALL_DIR)/etc
	@mkdir -m 775 $(INSTALL_DIR)/etc
	@cp -p *.tcl Makefile $(INSTALL_DIR)/etc
