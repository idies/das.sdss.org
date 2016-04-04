##############################################################################
#<AUTO>
#
# FILE: mtCheck.tcl
#
#<HTML>
# Check MT DA and pipeline outputs against the data model.
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
# Check the outputs of the mtDA system against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# An observing report should be specified; it and all its associated files will
# be checked.
# Returns the number of errors found.
# <p>
# For example:
# <PRE>
# mtDACheck mdReport-51115.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set mtDACheckArgs {
    {mtDACheck "Check MT DA input/outputs against the data model\n" }
    {<report>   STRING   ""  report   "report file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
    {-raw       CONSTANT ""  raw      "check one raw image"}
}
ftclHelpDefine dmProcs mtDACheck [shTclGetHelpInfo mtDACheck $mtDACheckArgs]

proc mtDACheck {args} {
    upvar #0 mtDACheckArgs formal_list
    if {[shTclParseArg $args $formal_list mtDACheck] == 0} {
	return
    }

    echo "MT DA check"

    # Check the report file
    set err [paramCheck $report -optional {parameters parametersDir}]
    set root [file dirname $report]

    # Read the report file
    foreach table [param2Chain $report params] {
	genericChainDestroy $table
    }

    # There should be no parameters file
    if {[keylget params parameters parameters]} {
	if {$parameters != ""} {
	    echo "    keyword 'parameters' should be missing or blank, but is set to '$parameters'"
	    incr err
	}
    }

    # Check CCD configuration files
    if {[keylget params configDir configDir] == 0} {
	set configDir .
    }
    if {[string range $configDir 0 0] != "/"} {
	set configDir $root/$configDir
    }
    foreach type {Config ECalib BC Voltages} {
	if {! [keylget params ccd$type file]} {
	    echo "    can't check 'ccd$type' file --- keyword missing"
	    incr err
	} elseif {$file == ""} {
	    echo "    no 'ccd$type' file specified to check"
	} else {
	    incr err [paramCheck $configDir/$file]
	}
    }

    # Check weather file
    if {! [regexp {mdReport-([0-9]+).par} [file tail $report] all mjd]} {
	echo "    can't get name for weather file"
    } else {
	incr err [paramCheck [format %s/idWeather-%05d.par $root $mjd]]
    }

    # Check one raw image.
    if {[ftclPassed $args $formal_list -raw]} {
	if {[catch {lindex [glob [file dirname $report]/mdR-*] 0} raw]} {
	    echo "    no raw images found in current directory"
	} else {
	    incr err [fitsCheck $raw]
	}
    }

    # Return number of errors found
    return $err
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: mtframesCheck
#
# <HTML>
# Check the outputs of the mtframes pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# Returns the number of errors found.
# <p>
# For example:
# <PRE>
# mtframesCheck mtPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set mtframesCheckArgs {
    {mtframesCheck "Check mtframes input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs mtframesCheck \
	[shTclGetHelpInfo mtframesCheck $mtframesCheckArgs]

proc mtframesCheck {args} {
    upvar #0 mtframesCheckArgs formal_list
    if {[shTclParseArg $args $formal_list mtframesCheck] == 0} {
	return
    }

    echo "MTFRAMES check"

    # Check the plan file
    set results [planCheck $plan]
    set err [lindex $results 0]
    set params [lindex $results 1]
    set root [file dirname $plan]
    
    # Check the mtProcessing file
    set outputDir [keylget params outputDir]
    if {[string range $outputDir 0 0] != "/"} {
	set outputDir $root/$outputDir
    }
    if {[catch {lindex [glob $outputDir/mtProcessing-*.log] 0} log]} {
	echo "    no output mtProcessing files found in 'outputDir'"
	incr err
    } else {
	incr err [paramCheck $log]
    }

    # Check one output mtObj file
    if {[catch {lindex [glob $outputDir/mtObj-*] 0} obj]} {
	echo "    no output mtObj files found in 'outputDir'"
	incr err
    } else {
	incr err [fitsCheck $obj -nocase]
	set hdr [hdrNew]
	hdrReadAsFits $hdr $obj
	echo "    VERSION [string trim [hdrGetAsAscii $hdr VERSION]]"
        hdrDel $hdr
    }

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check the report and config files
	set reportDir [keylget params reportDir]
	if {[string range $reportDir 0 0] != "/"} {
	    set reportDir $root/$reportDir
	}
	incr err [mtDACheck $reportDir/mdReport-[keylget params mjd].par \
		-noRaw]

	# Check one raw image
	set inputDir [keylget params inputDir]
	if {[string range $inputDir 0 0] != "/"} {
	    set inputDir $root/$inputDir
	}
	if {[catch {lindex [glob $inputDir/mdR-*] 0} raw]} {
	    echo "    no raw images found in 'inputDir'"
	    incr err
	} else {
	    incr err [fitsCheck $raw -nocase]
	}
    }

    # Return number of errors found
    return $err
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: excalCheck
#
# <HTML>
# Check the outputs of the excal pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# Returns the number of errors found.
# <p>
# For example:
# <PRE>
# excalCheck exPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set excalCheckArgs {
    {excalCheck "Check excal input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs excalCheck [shTclGetHelpInfo excalCheck $excalCheckArgs]

proc excalCheck {args} {
    upvar #0 excalCheckArgs formal_list
    if {[shTclParseArg $args $formal_list excalCheck] == 0} {
	return
    }

    echo "EXCAL check"

    # Check the plan file
    set results [planCheck $plan]
    set err [lindex $results 0]
    set params [lindex $results 1]
    set root [file dirname $plan]
    
    # Check the output file
    set outputDir [keylget params outputDir]
    if {[string range $outputDir 0 0] != "/"} {
	set outputDir $root/$outputDir
    }
    incr err [fitsCheck $outputDir/exPhotom-[keylget params mjd].fit -nocase]

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check the report file
	set reportDir [keylget params reportDir]
	if {[string range $reportDir 0 0] != "/"} {
	    set reportDir $root/$reportDir
	}
	incr err [paramCheck $reportDir/[keylget params reportFile]]

	# Check one object file
	if {[catch {lindex [glob $outputDir/mtObj-*] 0} obj]} {
	    echo "    no mtObj file found in 'outputDir'"
	    incr err
	} else {
	    incr err [fitsCheck $obj -nocase]
	}

	# Check one primaries file
	set fcDir [keylget params fcDir]
	if {[string range $fcDir 0 0] != "/"} {
	    set fcDir $root/$fcDir
	}
	if {[catch {lindex [glob $fcDir/*.par] 0} fc]} {
	    echo "    no primaries file found in 'fcDir'"
	    incr err
	} else {
	    incr err [paramCheck $fc mtFC]
	}
    }
}

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: kaliCheck
#
# <HTML>
# Check the outputs of the kali pipeline against the data model.
# The name of each file checked is printed to the screen along with any
# inconsistencies found.
# A plan file should be specified; it and all its associated files (including
# outputs and, optionally, inputs) will be checked.
# Returns the number of errors found.
# <p>
# For example:
# <PRE>
# kaliCheck kaPlan-1.par
# </PRE>
#</HTML>
#</AUTO>
##############################################################################
set kaliCheckArgs {
    {kaliCheck "Check kali input/outputs against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
    {-derived   CONSTANT ""  derived  "check derived inputs"}
}
ftclHelpDefine dmProcs kaliCheck [shTclGetHelpInfo kaliCheck $kaliCheckArgs]

proc kaliCheck {args} {
    upvar #0 kaliCheckArgs formal_list
    if {[shTclParseArg $args $formal_list kaliCheck] == 0} {
	return
    }

    echo "KALI check"

    # Check the plan file
    set results [planCheck $plan]
    set err [lindex $results 0]
    set params [lindex $results 1]
    set root [file dirname $plan]
    
    # Check one output file
    set outputDir [keylget params outputDir]
    if {[string range $outputDir 0 0] != "/"} {
	set outputDir $root/$outputDir
    }
    fitsCheck [lindex [glob $outputDir/kaCalObj-*] 0] -nocase

    # Check one known object catalog
    fitsCheck [lindex [glob \
	    [keylget params koDir]/[keylget params koFileBase]*] 0] koCat \
	    -nocase -optional "RUN INCL NODE EQUINOX KO_VER"

    # Check derived inputs
    if {[ftclPassed $args $formal_list -derived]} {
	# Check the report file
	set reportDir [keylget params reportDir]
	if {[string range $reportDir 0 0] != "/"} {
	    set reportDir $root/$reportDir
	}
	incr err [paramCheck $reportDir/[keylget params reportFile]]

	# Check one object file
	if {[catch {lindex [glob $outputDir/mtObj-*] 0} obj]} {
	    echo "    no mtObj file found in 'outputDir'"
	    incr err
	} else {
	    incr err [fitsCheck $obj -nocase]
	}

	# Check input exPhotom file
	incr err [fitsCheck $outputDir/exPhotom-[keylget params mjd].fit \
		-nocase]
    }
}
