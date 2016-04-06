##############################################################################
#<AUTO>
#
# FILE: imgCheck.tcl
#
#<HTML>
# Check imaging DA and pipeline outputs against the data model.
#</HTML>
#
#</AUTO>
##############################################################################

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: imgDACheck
#
# <HTML>
# Check the outputs of the imgDA system against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# An observing report should be specified; it and all its associated files will
# be checked.
# <p>
# For example:
# <PRE>
# imgDACheck idReport-51115.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set imgDACheckArgs {
    {imgDACheck "Check imaging DA input/outputs against the data model\n" }
    {<report>   STRING   ""  report   "report file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs imgDACheck [shTclGetHelpInfo imgDACheck $imgDACheckArgs]

proc imgDACheck {args} {
    upvar #0 imgDACheckArgs formal_list
    if {[shTclParseArg $args $formal_list imgDACheck] == 0} {
	return
    }

    echo "IMAGING DA check"

    # Check the report file
    set err [paramCheck $report -optional {parameters parametersDir}]
    set root [file dirname $report]

    # Read the report file
    foreach table [param2Chain $report params] {
	genericChainDestroy $table
    }

    # Check CCD configuration files, as well as the opCamera file
    if {[keylget params configDir configDir] == 0} {
	set configDir .
    }
    if {[string range $configDir 0 0] != "/"} {
	set configDir $root/$configDir
    }
    foreach type {Config ECalib BC Voltages Camera} {
	if {! [keylget params ccd$type file]} {
	    echo "    can't check 'ccd$type' file --- keyword missing"
	    incr err
	} elseif {$file == ""} {
	    echo "    no 'ccd$type' file specified to check"
	} else {
	    if {$type == "Voltages"} {
		# Check the voltages file for CCD 11 only
		set file $configDir/[format $file 11]
		if {! [file exists $file]} {
		    echo "    can't check ccd$type file --- '$file' not found"
		} else {
		    incr err [paramCheck $file opCCDLog]
		}
	    } else {
		set file $configDir/$file
		if {! [file exists $file]} {
		    echo "    can't check ccd$type file --- '$file' not found"
		} else {
		    incr err [paramCheck $file]
		}
	    }
	}
    }

    # NOTE: We cannot check a sample raw image, bias vector, or gang file
    # since these are not necessarily available on disk.  These should be
    # checked using the -derived option when checking ssc ouput.

    # Check the weather and idTapeSummary file
    regexp {^.*-([0-9][0-9][0-9][0-9][0-9]).par$} $report all mjd
    set weatherFile [format idWeather-%05d.par $mjd]
    set summaryFile [format idTapeSummary-%05d.par $mjd]
    foreach file "$weatherFile $summaryFile" {
	if {! [file exists $file]} {
	    echo "    can't check weather file --- '$file' not found"
	} else {
	    incr err [paramCheck $file]
	}
    }

    # Check one tape log, tar tape, and frame log file.
    foreach type {idTapeLog idTarTape idFrameLog} {
	if {[catch {set file [lindex [glob $type-*.par] 0]}]} {
	    echo "    can't check $type file --- no files found"
	} else {
	    incr err [paramCheck $file]
	}
    }

    # Return number of errors found
    return $err
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: biasCheck
#
# <HTML>
# Check the outputs of the bias pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# <p>
# For example:
# <PRE>
# biasCheck psPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set biasCheckArgs {
    {biasCheck "Check bias input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs biasCheck \
	[shTclGetHelpInfo biasCheck $biasCheckArgs]

proc biasCheck {args} {
    upvar #0 biasCheckArgs formal_list
    if {[shTclParseArg $args $formal_list biasCheck] == 0} {
	return
    }

    echo "BIAS check"

    # Check the plan file
    paramCheck $plan

    # Read the plan file
    foreach table [param2Chain $plan params] {
	genericChainDestroy $table
    }

    # Check one bias vector file
    set outputDir [keylget params outputDir]
    set run [keylget params run]
    fitsCheck [lindex [glob [format %s/idB-%06d-* $outputDir $run]] 0] -nocase

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check one raw image
	fitsCheck [lindex [glob [format %s/idR-%06d-* \
		[keylget params fieldInputDir] $run]] 0] -nocase
    }
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: sscCheck
#
# <HTML>
# Check the outputs of the SSC pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# <p>
# For example:
# <PRE>
# sscCheck scPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set sscCheckArgs {
    {sscCheck "Check ssc input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs sscCheck \
	[shTclGetHelpInfo sscCheck $sscCheckArgs]

proc sscCheck {args} {
    upvar #0 sscCheckArgs formal_list
    if {[shTclParseArg $args $formal_list sscCheck] == 0} {
	return
    }

    echo "SSC check"

    # Check the plan and parameter files
    set params [lindex [planCheck $plan] 1]

    # Check one fang file
    set outputDir [keylget params outputDir]
    set run [keylget params run]
    set camCol [keylget params camCol]
    set startField [keylget params startField]
    fitsCheck [format %s/scFang-%06d-%d-%04d.fit $outputDir $run \
	    $camCol $startField] -nocase

    # Check whole frames list file.  Don't check any frames files since
    # they're just copies of raw images.
    paramCheck [format %s/%s-%06d-%d.par $outputDir \
	    [keylget params frameFile] $run $camCol] scFramePar

    # Check wing star list file.  Don't check any wing files since
    # they're just sub-region copies (with no headers) of raw images.
    paramCheck [format %s/%s-%06d-%d.par $outputDir \
	    [keylget params wingFile] $run $camCol] scWingPar

    # Check diagnostics file.
    if {[keylget params diagnostics] > 0} {
	paramCheck [format %s/%s-%06d-%d.par $outputDir \
		[keylget params diagFile] $run $camCol] scDiag
    }

    # Check known object catalog
    fitsCheck [keylget params koDir]/[format \
	    [keylget params koFileBase]-%06d.fit $run] -nocase

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check one gang file
	fitsCheck [lindex [glob [format %s/idGang-%06d-* \
		[keylget params pGangInputDir] $run]] 0] -nocase \
		-optional {CAMROW CAMCOL}

	# Check one raw image
	if {[keylget params fieldInputDevice] == "disk"} {
	    fitsCheck [lindex [glob [format %s/idR-%06d-* \
		    [keylget params fieldInputDir] $run]] 0] -nocase
	}

	# Check CCD configuration files
	if {[catch {keylget params configDir} configDir]} {
	    set configDir .
	}
	paramCheck $configDir/[keylget params ccdConfig]
	paramCheck $configDir/[keylget params ccdECalib]
	paramCheck $configDir/[keylget params ccdBC]
	paramCheck $configDir/[keylget params ccdCamera]
    }
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: astromCheck
#
# <HTML>
# Check the outputs of the astrom pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# <p>
# For example:
# <PRE>
# astromCheck asPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set astromCheckArgs {
    {astromCheck "Check astrom input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs astromCheck \
	[shTclGetHelpInfo astromCheck $astromCheckArgs]

proc astromCheck {args} {
    upvar #0 astromCheckArgs formal_list
    if {[shTclParseArg $args $formal_list astromCheck] == 0} {
	return
    }

    echo "ASTROM check"

    # Check the plan and parameter files
    set params [lindex [planCheck $plan] 1]

    # Check the output files
    set outputDir [keylget params outputDir]
    set run [keylget params run]
    fitsCheck [format %s/asTrans-%06d.fit $outputDir $run] -nocase \
	    -optional {SSC02_ID SSC03_ID SSC04_ID SSC05_ID SSC06_ID SSC07_ID SSC08_ID SSC09_ID SSC10_ID SSC11_ID}
    paramCheck [format %s/asQA-%06d.par $outputDir $run]

    # Check known object catalog
    fitsCheck [keylget params koDir]/[keylget params koFile] koCat -nocase

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check the idReport file
	paramCheck [keylget params logFileDir]/[keylget params logFile] \
		idReport

	# Check one fang file
	set sscDirs [keylget params inputDirs]
	set camCol [lindex [keylkeys sscDirs] 0]
	set sscDir [keylget sscDirs $camCol]
	fitsCheck [lindex [glob $sscDir/scFang-*] 0] -nocase

	# Check CCD configuration files
	if {[catch {keylget params configDir} configDir]} {
	    set configDir .
	}
	paramCheck $configDir/[keylget params ccdConfig]
	paramCheck $configDir/[keylget params ccdCamera]
    }
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: psCheck
#
# <HTML>
# Check the outputs of the PS pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# <p>
# For example:
# <PRE>
# psCheck psPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set psCheckArgs {
    {psCheck "Check ps input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs psCheck \
	[shTclGetHelpInfo psCheck $psCheckArgs]

proc psCheck {args} {
    upvar #0 psCheckArgs formal_list
    if {[shTclParseArg $args $formal_list psCheck] == 0} {
	return
    }

    echo "PS check"

    # Check the plan and parameter files
    set params [lindex [planCheck $plan] 1]

    # Check the output files
    set outputDir [keylget params outputDir]
    set run [keylget params run]
    set camCol [keylget params camCol]
    fitsCheck [format %s/psCB-%06d-%d.fit $outputDir $run $camCol] -nocase
    fitsCheck [format %s/psCT-%06d-%d.fit $outputDir $run $camCol] -nocase

    # Check one flat-field vector file
    fitsCheck [lindex [glob [format %s/psFF-%06d-* $outputDir $run]] 0] -nocase

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check the old ps solution
	if {! [catch {keylget params ctFile} ctFile]} {
	    fitsCheck [keylget params ctFileDir]/$ctFile psCT -nocase
	}

	# Check the excal file
	if {! [catch {keylget params photomFile} photomFile]} {
	    fitsCheck [keylget params photomFileDir]/$photomFile \
		exPhotom -nocase
	}

	# Check one kali file
	if {! [catch {keylget params mtPatches} mtPatches]} {
	    set kali [lindex $mtPatches 0]
	    fitsCheck [lindex $kali 1]/[format [keylget params mtPatchFormat] \
		    [lindex $kali 0]] kaCalObj -nocase
	}

	# Check the astrometric calibration file
	fitsCheck [keylget params transFileDir]/[keylget params transFile] \
		asTrans -nocase

	# Check one bias vector file
	fitsCheck [lindex [glob [format %s/idB-%06d-* \
		[keylget params biasDir] $run]] 0] -nocase

	# Check one fang file
	set fangDir [keylget params fangDir]
	fitsCheck [lindex [glob [format %s/scFang-%06d-%d-* $fangDir \
		$run $camCol]] 0] -nocase

	# Check whole frames list file.  Don't check any frames files since
	# they're just copies of raw images.
	paramCheck [format %s/scFrame-%06d-%d.par $fangDir $run $camCol] \
		scFramePar

	# Check wing star list file.  Don't check any wing files since
	# they're just sub-region copies (with no headers) of raw images.
	paramCheck [format %s/scWing-%06d-%d.par $fangDir $run $camCol] \
		scWingPar

	# Check CCD configuration files
	if {[catch {keylget params configDir} configDir]} {
	    set configDir .
	}
	paramCheck $configDir/[keylget params ccdConfig]
	paramCheck $configDir/[keylget params ccdECalib]
	paramCheck $configDir/[keylget params ccdBC]
    }
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: framesCheck
#
# <HTML>
# Check the outputs of the frames pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# <p>
# For example:
# <PRE>
# framesCheck fpPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set framesCheckArgs {
    {framesCheck "Check frames input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs framesCheck \
	[shTclGetHelpInfo framesCheck $framesCheckArgs]

proc framesCheck {args} {
    upvar #0 framesCheckArgs formal_list
    if {[shTclParseArg $args $formal_list framesCheck] == 0} {
	return
    }

    echo "FRAMES check"

    # Check the plan and parameter files
    set params [lindex [planCheck $plan] 1]

    # Check one each of per-field outputs
    set outputDir [keylget params outputDir]
    set run [keylget params run]
    set camCol [keylget params camCol]
    set startField [keylget params startField]
    fitsCheck [format %s/fpFieldStat-%06d-%d-%04d.fit $outputDir $run \
	    $camCol $startField] -nocase
    fitsCheck [format %s/fpObjc-%06d-%d-%04d.fit $outputDir $run $camCol \
	    $startField] -nocase
    fitsCheck [format %s/fpC-%06d-u%d-%04d.fit $outputDir $run $camCol \
	    $startField] -nocase
    fitsCheck [format %s/fpBIN-%06d-u%d-%04d.fit $outputDir $run $camCol \
	    $startField] -nocase
    fitsCheck [format %s/fpM-%06d-u%d-%04d.fit $outputDir $run $camCol \
	    $startField] -nocase
    fitsCheck [format %s/fpAtlas-%06d-u%d-%04d.fit $outputDir $run $camCol \
	    $startField] -nocase

    # Check one known object catalog
    fitsCheck [keylget params koDir]/[keylget params koBrightGalaxies] koCat

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check the postage stamp inputs
	set psDir [keylget params psDir]
	fitsCheck $psDir/[format psCB-%06d-%d.fit $run $camCol] -nocase
	fitsCheck $psDir/[format psCT-%06d-%d.fit $run $camCol] -nocase

	# Check one flat-field vector file
	fitsCheck [lindex [glob [format $psDir/psFF-%06d-* $run]] 0] -nocase

	# Check one raw image
	if {[catch {fitsCheck [lindex [glob [format %s/idR-%06d-* \
		[keylget params imageDir] $run]] 0] -nocase}]} {
	    echo "couldn't find raw image to check"
	}

	# Check one bias vector
	if {[catch {fitsCheck [lindex [glob [format %s/idB-%06d-* \
		[keylget params biasDir] $run]] 0] -nocase}]} {
	    echo "couldn't find bias vector to check"
	}

	# Check CCD configuration files
	if {[catch {keylget params configDir} configDir]} {
	    set configDir .
	}
	paramCheck $configDir/[keylget params ccdConfig]
	paramCheck $configDir/[keylget params ccdECalib]
	paramCheck $configDir/[keylget params ccdBC]
    }
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: fcalibCheck
#
# <HTML>
# Check the outputs of the fcalib pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# <p>
# For example:
# <PRE>
# fcalibCheck pcPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set fcalibCheckArgs {
    {fcalibCheck "Check fcalib input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs fcalibCheck \
	[shTclGetHelpInfo fcalibCheck $fcalibCheckArgs]

proc fcalibCheck {args} {
    upvar #0 fcalibCheckArgs formal_list
    if {[shTclParseArg $args $formal_list fcalibCheck] == 0} {
	return
    }

    echo "FCALIB check"

    # Check the plan file
    paramCheck $plan

    # Read the plan file
    foreach table [param2Chain $plan params] {
	genericChainDestroy $table
    }

    # Check the parameter file
    if {[catch {keylget params parametersDir} parametersDir]} {
	set parametersDir .
    }
    paramCheck $parametersDir/[keylget params parameters]

    # Check the output files
    set outputDir [keylget params outputDir]
    set run [keylget params run]
    set camCol [keylget params camCol]
    fitsCheck [format %s/fcPCalib-%06d-%d.fit $outputDir $run $camCol] -nocase

    # Check one flat-field vector file
    fitsCheck [lindex [glob [format %s/psFF-%06d-* $outputDir $run]] 0] -nocase

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check the idReport file
	paramCheck [keylget params reportFile idReport

	# Check the excal file
	if {! [catch {keylget params photomFile} photomFile]} {
	    fitsCheck [keylget params photomDir]/exPhotom-[keylget params runDay].par \
		exPhotom -nocase
	}

	# Check one kali file
	if {! [catch {keylget params mtPatches} mtPatches]} {
	    set kali [lindex $mtPatches 0]
	    fitsCheck [lindex $kali 1]/[format [keylget params mtPatchFormat] \
		    [lindex $kali 0]] kaCalObj -nocase
	}

	# Check the astrometric calibration file
	fitsCheck [keylget params astromDir]/[format asTrans-%06d.fit $run] \
		asTrans -nocase

	# Check one fpObjc file
	set fangDir [keylget params fangDir]
	fitsCheck [lindex [glob [format %s/fpObjc-%06d-%d-* $fangDir \
		$run $camCol]] 0] -nocase
    }
}
