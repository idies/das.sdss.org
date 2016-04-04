##############################################################################
#<AUTO>
#
# FILE: planCheck.tcl
#
#<HTML>
# Check a plan file against the data model.
#</HTML>
#
#</AUTO>
##############################################################################

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: planCheck
#
# <HTML>
# Check a generic plan file and its associated tunable parameters file
# for consistency against the data model.
# Returns a 2 element TCL list, where the first element is the number of files
# found in error, and the second element is a TCL keyed list of keywords from
# the plan file.
#</HTML>
#</AUTO>
##############################################################################
set planCheckArgs {
    {planCheck "Check a generic plan and tunable parameters file against the data model\n" }
    {<plan>     STRING   ""  plan     "plan file"}
}
ftclHelpDefine dmProcs planCheck \
	[shTclGetHelpInfo planCheck $planCheckArgs]

proc planCheck {args} {
    upvar #0 planCheckArgs formal_list
    if {[shTclParseArg $args $formal_list planCheck] == 0} {
	return
    }

    # Check the plan file
    set err [paramCheck $plan -optional "parameters parametersDir"]
    set root [file dirname $plan]
    
    # Read the plan file
    foreach table [param2Chain $plan params] {
	genericChainDestroy $table
    }

    # Check the parameter file
    if {[keylget params parametersDir parametersDir] == 0} {
	set parametersDir .
    }
    if {[string range $parametersDir 0 0] != "/"} {
	set parametersDir $root/$parametersDir
    }
    if {[keylget params parameters parameters] == 0} {
	echo "    can't check 'parameters' file --- keyword missing"
	incr err
    } else {
	incr err [paramCheck $parametersDir/$parameters]
    }

    return "$err {$params}"
}
