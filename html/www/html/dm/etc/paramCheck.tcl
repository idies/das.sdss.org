##############################################################################
#<AUTO>
#
# FILE: paramCheck.tcl
#
#<HTML>
# Check a parameter file against the data model.
#</HTML>
#
#</AUTO>
##############################################################################

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: paramCheck
#
# <HTML>
# Check a parameter file against its template.  The template is assumed to
# be in the directory $DM_DIR/flatFiles, with the name "root.html", where
# "root" is the first part of the file name up to its first "-" or "." (after
# the leading path has been stripped off).  If the parameter "root" is
# specified, then that is used instead.  Both parameters and tables are
# checked.  For parameters, only their presence is check --- the values and
# comments are not checked.  A warning is issued if a parameter is missing or
# if extra parameters are present.  No errors are thrown for missing keywords
# which are specified with the parameter "-optional".  For plan and report
# files, the keywords "parameters" and "parametersDir" are always considered
# optional.
# <p>
# Returns 1 if errors were found, else 0.
#</HTML>
#</AUTO>
##############################################################################
set paramCheckArgs {
    {paramCheck "Check a parameter file against its data model template\n" }
    {<file>     STRING   ""  file     "name of file to check"}
    {[root]     STRING   ""  root     "root name of template file"}
    {-optional  STRING   ""  optional "optional keywords"}
}
ftclHelpDefine dmProcs paramCheck [shTclGetHelpInfo paramCheck $paramCheckArgs]

proc paramCheck {args} {
    upvar #0 paramCheckArgs formal_list
    if {[shTclParseArg $args $formal_list paramCheck] == 0} {
	return
    }
    if {! [ftclPassed $args $formal_list -optional]} {set optional ""}

    # Initial output
    echo "parameter file $file"

    # Test if file exists
    if {! [file exists $file]} {
	echo "    file doesn't exist"
	return 1
    }

    # Fetch the name of the template file to compare to
    if {$root == ""} {
	set root [file tail $file]
	set last [string length $root]
	foreach char {- .} {
	    set  index [string first $char $root]
	    if {$index > -1} {set last [min $index $last]}
	}
	set root [string range $root 0 [expr $last - 1]]
    }
    set template [envscan \$DM_DIR]/flatFiles/$root.html

    # Read the relevant part of the template file into a temporary file
    set pass 0
    set ok 0
    set tmp /tmp/paramCheck[pid]
    set output [open $tmp w]
    set input [open $template r]
    while {[gets $input line] != -1} {
	if {[regexp -nocase "^ *<!-- *AUTOCHECK +(begin|end) +param *--> *$" \
		$line junk where]} {
	    if {[regexp -nocase "^begin$" $where]} {
		if {$pass == 1} {
		    error "paramCheck: two 'AUTOCHECK begin param' lines not spearated by a 'AUTOCHECK end param' line in the template file '$template'"
		}
		set pass 1
		set ok 1
	    } else {
		if {$pass == 0} {
		    error "paramCheck: two 'AUTOCHECK end param' lines not spearated by a 'AUTOCHECK begin param' line in the template file '$template'"
		}
		set pass 0
	    }
	} elseif {[regexp -nocase "^ *<!--.*--> *$" $line]} {
	} elseif {$pass} {
	    regsub -all "#XX-XX-XX-XX" $line "XX-XX-XX-XX" line
	    puts $output $line 
	}
    }
    close $input
    close $output

    # Error if template contains no AUTOCHECK lines
    if {$ok == 0} {
	error "paramCheck: no 'AUTOCHECK' lines in template file '$template'"
    }

    # Read in the the slimmed-down template as a param file
    if {[catch {param2Chain $tmp templateParams} templateTables]} {
	error "paramCheck: error reading template file '$template': $templateTables"
    }
    exec rm $tmp

    # Read in the the test param file
    if {[catch {param2Chain $file params} tables]} {
	error "paramCheck: error reading param file '$file': $tables"
    }

    # Test that all of the parameters are present
    set err 0
    foreach key [keylkeys templateParams] {
	if {[catch {keyldel params $key}]} {
	    set found 0
	    foreach opt $optional {
		if {$opt == $key} {set found 1; break}
	    }
	    if {$found == 0} {
		echo "    missing parameter $key"
		set err 1
	    }
	}
    }

    # Is this a plan or report file?
    if {[string first Plan $root] > -1 || [string first Report $root] > -1} {
	# Remove optional generic plan/report parameters
	foreach key {parameters parametersDir} {
	    catch {keyldel params $key}
	}
    }

    # Test that there are no extra parameters.
    if {[llength $params] > 0} {
	paramsEcho "    extra parameters:" [keylkeys params]
	set err 1
    }

    # param2Chain doesn't bother read to check the schema when it reads a table
    # of a previously defined schema.  Thus, we must read the tables for the
    # test file using a different dervish shell.  The following commands return
    # a TCL keyed list, where the key is the name of a schema, and the value is
    # the result of "schemaGetFromType".
    set f [open "|dervish -noTk -command { \
	    set results \"\"; \
	    set tables \[param2Chain $file keys\]; \
	    foreach c \$tables { \
		echo \[chainSize \$c\]; \
	        set type \[chainTypeDefine \$c\]; \
		keylset results \$type \[schemaGetFromType \$type\]; \
	    }; echo \$results \
	}" r]
    while {[set line [gets $f]] != ""} {
	if {[string range $line 0 10] == "param count"} {
	    echo "    bad tables: $line"
	    set err 1
	    return $err
	} elseif {[string range $line 0 0] == "\{"} {
	    set allSchema $line
	}
    }
    if {![info exists allSchema]} {set allSchema ""}
    close $f
	    
    # Test tables.
    foreach c $templateTables {
	set type [chainTypeDefine $c]
	if {[keylget allSchema $type schema] == 0} {
	    echo "    missing table $type"
	    set err 1
	} else {
	    keyldel allSchema $type
	    set templateSchema [schemaGetFromType $type]
	    foreach key [keylkeys templateSchema] {
		set templateMemberType [keylget templateSchema $key]
		if {[keylget schema $key memberType] == 0} {
		    echo "    missing member $key in table $type"
		    set err 1
		} else {
		    if {$templateMemberType != $memberType} {
			echo "    wrong type for $key in table $type: want $templateMemberType, got $memberType"
			set err 1
		    }
		    keyldel schema $key
		}
	    }
	    if {[llength $schema] > 0} {
		paramsEcho "    extra members in table $type:" \
			[keylkeys schema]
		set err 1
	    }
	}
    }

    # Test that there are no extra tables.
    if {[llength $allSchema] > 0} {
	paramsEcho "    extra tables:" [keylkeys allSchema]
	set err 1
    }

    return $err
}

proc paramsEcho {leader params} {
    puts stdout $leader nonewline
    set offset [string length $leader]
    loop i 0 $offset {append blank " "}
    set i $offset
    foreach param $params {
	incr i [expr [string length $param] + 1]
	if {$i > 78} {
	    puts stdout "\n$blank" nonewline
	    set i [expr $offset + [string length $param] + 1]
	}
	puts stdout " $param" nonewline
    }
    puts stdout ""
}