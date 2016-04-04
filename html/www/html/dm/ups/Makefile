SHELL = /bin/sh
#
default :
	echo "Please invoke this makefile using sdssmake"

all:
	date

install :
	@if [ "$(DM_DIR)" = "" ]; then \
		echo You have not specified a destination directory >&2; \
		exit 1; \
	fi 
	@rm -rf $(DM_DIR)/ups
	@mkdir -m 775 $(DM_DIR)/ups
	@/bin/cp -p Makefile  $(DM_DIR)/ups
	@/bin/cp -p dm.table  $(DM_DIR)/ups
#	$(SDSSTOOLS_DIR)/bin/install_ups_table dm.table $(DM_DIR)/ups

clean :
	rm -f *~ core *.bak *.orig *.old .#* #*#
