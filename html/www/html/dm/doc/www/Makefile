INSTALL_DIR = $(DM_DIR)

TCL_DOCS	= paramCheck.html \
		  fitsCheck.html \
		  planCheck.html \
		  imgCheck.html \
		  mtCheck.html


# Default rules for compiling
ETC = ../../etc
VPATH=$(ETC)
.SUFFIXES: .tcl .html
.tcl.html:
	tcl2html $(ETC)/$*.tcl > $*.html

default:
	@echo Please invoke this makefile using sdssmake. >&2
	@exit 1

all: index.html

clean :
	@$(SDSSTOOLS_DIR)/bin/clean
	rm -f $(TCL_DOCS) index.html

install:
	@if [ "$(INSTALL_DIR)" = "" ]; then \
		echo You have not specified a destination directory >&2; \
		exit 1; \
	fi
	@rm -rf $(INSTALL_DIR)/doc/www
	@mkdir -m 775  $(INSTALL_DIR)/doc/www
	cp -p *.html   $(INSTALL_DIR)/doc/www
	cp -p Makefile $(INSTALL_DIR)/doc/www

make:
	@/bin/rm -f Makefile~
	@mv Makefile Makefile~
	@sed 1,/\^#START_DEPEND/\!d Makefile~ > Makefile
	@echo "" >> Makefile
	@for h in $(TCL_DOCS); do \
		f="`echo $$h | sed -e 's%\\.html%%'`";\
		echo $$f.html:"	"$$f.tcl >> Makefile;\
	done

index.html : $(TCL_DOCS)
	htmlSearch -index dm > index.html

#===========================================================================
# INCLUDE FILE DEPENDENCIES
#===========================================================================
#
# include file dependencies.
# All lines below START_DEPEND are machine generated; Do Not Edit
# 
#START_DEPEND

paramCheck.html:	paramCheck.tcl
fitsCheck.html:	fitsCheck.tcl
planCheck.html:	planCheck.tcl
imgCheck.html:	imgCheck.tcl
mtCheck.html:	mtCheck.tcl
