SHELL		= /bin/sh
PROD		=   DM
PRODDIRNAME	=   DM_DIR
PRODDIR		= $(DM_DIR)

.DEFAULT:
	@ echo ''
	@ echo '*** Finished updating target $@ ***'
	@ echo ''

#*******************************************************************************
#
# Build all targets in all subdirectories.
all :
	@ echo ""
	@ echo "Updating $(PROD) libraries and subdirectories."
	@ for subdir in app doc etc flatFiles limitFiles log pgm ups ; do \
		if [ -d $$subdir ]; then \
			(cd $$subdir; echo ""; echo "make all in ./$$subdir"; \
			 echo ""; $(MAKE) $(MFLAGS) all); \
		else \
			echo ""; \
			echo "Subdirectory does not exist: ./$$subdir"; \
			echo ""; \
		fi; \
	done

#*******************************************************************************
#
# Install things from the current directories to their proper places in
# $(PRODDIR).
#
#   o	A "decision" period is provided ("I'll give you n seconds ...").  The
#	length of the echo string (all spaces) is the maximum time that can be
#	waited, since the following sed does replacements on that input string.
#
# NOTE:	contrib   M U S T   last, as other make install delete directories.
#       ups MUST be installed before the doc directory as the doc directory
#       tries to copy things to the toman directory.
#

install :
	@ echo ""
	@ echo "Make sure the current $(PROD) directories under"
	@ echo ""
	@ echo "     `pwd`"
	@ echo ""
	@ echo "have the latest versions of the files.  These will be copied to the"
	@ echo "the destination during the install of $(PROD)."
	@ echo ""
	@ if [ "$(PRODDIR)" = "" ]; then \
		echo "The destination directory has not been specified.  Set the environment"	>&2; \
		echo "variable $(PRODDIRNAME)"							>&2; \
		echo ""; \
		exit 1; \
	fi
	@ if [ `(cd $(PRODDIR); pwd)` = `pwd` ]; then \
		echo "The destination directory is the same as the current directory."		>&2; \
		echo "The install will be aborted."						>&2; \
		echo ""; \
		exit 1; \
	fi
	@ echo "You will be installing in"
	@ echo ""
	@ echo "   $(PRODDIRNAME) = $(PRODDIR)"
	@ echo ""
	@ echo "I'll give you 5 seconds to think about it (control-C to abort) ..."
	@ for pos in          5 4 3 2 1; do \
	   echo "                              " | sed -e 's/ /'$$pos'/'$$pos; \
	   sleep 1; \
	done
	@ for subdir in app doc etc flatFiles limitFiles log pgm ups ; do \
		if [ -d $$subdir ]; then \
			if [ ! -r $(PRODDIR)/$$subdir ]; then \
				mkdir -m 775 $(PRODDIR)/$$subdir; \
			fi; \
			(cd $$subdir; echo ""; echo "make install in ./$$subdir"; echo ""; $(MAKE) $(MFLAGS) install); \
		else \
			echo "Subdirectory does not exist: ./$$subdir"; \
		fi; \
	done
	@cp Makefile $(PRODDIR)
#
#*******************************************************************************
#
# Clean up.
#
#   o	.uname~ is removed last.  This protects against future improper builds
#	(wrong platform) in case the clean fails for some reason.
#

clean :
	@ echo ""
	@ echo "Cleaning in . = `pwd`"
	@ echo ""
	@ $(SDSSTOOLS_DIR)/bin/clean
	@ for subdir in app doc etc flatFiles limitFiles log pgm ups ; do \
		if [ -d $$subdir ]; then \
			(cd $$subdir; echo ""; echo "Cleaning in ./$$subdir"; echo ""; $(MAKE) $(MFLAGS) clean); \
		else \
			echo "Subdirectory does not exist: ./$$subdir"; \
		fi; \
	done
	- rm -f .uname~

#*******************************************************************************
