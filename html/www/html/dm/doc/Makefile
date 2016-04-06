INSTALL_DIR = $(DM_DIR)

default:
	@echo Please invoke this makefile using sdssmake. >&2
	@exit 1

all:
	(cd www ; echo In www; $(MAKE) $(MFLAGS) all);

clean :
	@ echo in .
	rm -f *~ core *.bak *.orig *.old *.toc dm_flat.ps \
	  .\#* \#*\# *.aux *.log *.dvi aperture.ps dm_flat_include.tex
	(cd www ; echo In www; $(MAKE) $(MFLAGS) clean);

install:
	@if [ "$(INSTALL_DIR)" = "" ]; then \
		echo You have not specified a destination directory >&2; \
		exit 1; \
	fi
	/bin/rm -fr    $(INSTALL_DIR)/doc
	mkdir -m 775   $(INSTALL_DIR)/doc
	cp -p Makefile $(INSTALL_DIR)/doc
	cp -p *ps $(INSTALL_DIR)/doc
	@ for f in www; do \
		mkdir -m 775 $(INSTALL_DIR)/doc/$$f; \
		(cd $$f; echo In $$f; $(MAKE) $(MFLAGS) install); \
	done


dm_flat.ps: dm_flat.dvi
	dvips dm_flat

dm_flat.dvi: dm_flat.tex dm_flat_include.tex
	latex dm_flat
	latex dm_flat


SECTIONS = \
	www/dm.home.html \
	www/filenames.html \
	www/fitsparamdoc.html \
	../flatFiles/PLAN.html \
	../flatFiles/REPORT.html \
	../flatFiles/FILES.html \
	../flatFiles/opConfig.html \
	../flatFiles/opECalib.html \
	../flatFiles/opBC.html \
	../flatFiles/opCamera.html \
	../flatFiles/mdReport.html \
	../flatFiles/mdR.html \
	../flatFiles/mtPlan.html \
	../flatFiles/mtParam.html \
	../flatFiles/mtObj.html \
	../flatFiles/exPlan.html \
	../flatFiles/exParam.html \
	../flatFiles/mtFC.html \
	../flatFiles/exPriMag.html \
	../flatFiles/exPhotom.html \
	../flatFiles/kaPlan.html \
	../flatFiles/kaParam.html \
	../flatFiles/koCat.html \
	../flatFiles/kaCalObj.html \
	../flatFiles/idReport.html \
	../flatFiles/idR.html \
	../flatFiles/idGang.html \
	../flatFiles/idFrameLog.html \
	../flatFiles/idB.html \
	../flatFiles/scPlan.html \
	../flatFiles/scParam.html \
	../flatFiles/scFang.html \
	../flatFiles/scFramePar.html \
	../flatFiles/scFrame.html \
	../flatFiles/scWingPar.html \
	../flatFiles/scWing.html \
	../flatFiles/scDiag.html \
	../flatFiles/asPlan.html \
	../flatFiles/asParam.html \
	../flatFiles/asCCDAstrom.html \
	../flatFiles/asTrans.html \
	../flatFiles/psPlan.html \
	../flatFiles/psParam.html \
	../flatFiles/psFF.html \
	../flatFiles/psCB.html \
	../flatFiles/psCT.html \
	../flatFiles/fpPlan.html \
	../flatFiles/fpParam.html \
	../flatFiles/fpFieldStat.html \
	../flatFiles/fpC.html \
	../flatFiles/fpBIN.html \
	../flatFiles/fpObjc.html \
	../flatFiles/fpAtlas.html \
	../flatFiles/fpM.html \
	../flatFiles/xePlan.html \
	../doc/www/RELEASE_NOTES.html

dm_flat_include.tex: $(SECTIONS)
	$(SDSSTOOLS_DIR)/bin/html2latex $(SECTIONS) > dm_flat_include.tex
