##############################################################################
#<AUTO>
#
# FILE: fitsCheck.tcl
#
#<HTML>
# Check a FITS file against the data model.
#</HTML>
#
#</AUTO>
##############################################################################

##############################################################################
#<AUTO EXTRACT>
#
# TCL VERB: fitsCheck
#
# <HTML>
# Check a FITS file against its template.  The template is assumed to
# be in the directory $DM_DIR/flatFiles, with the name "root.html", where
# "root" is the first part of the file name up to its first "-" or "." (after
# the leading path has been stripped off).  If the parameter "root" is
# specified, then that is used instead.  Both parameters and tables are
# checked.  For parameters, only their presence is check --- the values and
# comments are not checked.  An warning is issued if a parameter is missing or
# if extra parameters are present.  For tables, the values of the TTYPEn
# keywords are checked case sensitive.  To do so case-insensitive, specify the
# "-nocase" parameter.
# <p>
# Returns 1 if errors were found, else 0.
#</HTML>
#</AUTO>
##############################################################################
set fitsCheckArgs {
    {fitsCheck "Check a FITS file against its data model template\n" }
    {<file>     STRING   ""  file     "name of file to check"}
    {[root]     STRING   ""  root     "root name of template file"}
    {-optional  STRING   ""  optional "optional keywords"}
    {-nocase    CONSTANT "1" nocase   "compare TTYPEn fields case-insensitive"}
}
ftclHelpDefine dmProcs fitsCheck [shTclGetHelpInfo fitsCheck $fitsCheckArgs]

proc fitsCheck {args} {
    upvar #0 fitsCheckArgs formal_list
    if {[shTclParseArg $args $formal_list fitsCheck] == 0} {
	return
    }
    if {! [ftclPassed $args $formal_list -optional]} {set optional ""}
    set caseInsensitive [ftclPassed $args $formal_list -nocase]

    # Initial output
    echo "FITS file $file"

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

    # Read the relevant part
    set ok 0
    set err 0
    set pass 0
    set input [open $template r]
    while {[gets $input line] != -1} {
	if {[regexp -nocase {^ *<!-- *AUTOCHECK +(begin|end) +hdu +([0-9]+) *--> *$} \
		$line junk where hdu]} {
	    set currentHdu $hdu
	    if {[regexp -nocase "^begin$" $where]} {
		# Start a new HDU
		if {$pass == 1} {
		    error "fitsCheck: two 'AUTOCHECK begin hdu' lines not spearated by a 'AUTOCHECK end hdu' line in the template file '$template'"
		}
		if {[info exists keywords]} {unset keywords}
		set currentHdu $hdu
		set pass 1
		set ok 1
	    } else {
		# Finished an HDU.  Compare it to the test file.
		if {$hdu != $currentHdu} {
		    error "fitsCheck: mismatched HDUs in template file '$template': $line"
		}
		echo "  HDU $hdu"

		# Read the HDU from the test file
		if {$hdu == 0} {
		    set fit [regNew]
		    if {[catch {fitsRead $fit $file -hdu $hdu} errMsg]} {
			echo "    couldn't read HDU $hdu: $errMsg"
			set err 1
			set pass 0
			continue
		    }
		} else {
		    set fit [tblColNew]
		    if {[catch {fitsRead $fit $file -hdu $hdu -binary} errMsg]} {
			echo "    couldn't read HDU $hdu: $errMsg"
			set err 1
			set pass 0
			continue
		    }
		}

		# Compare headers
		set i 0
		while {! [catch {set line [hdrGetLineCont $fit.hdr $i]}]} {
		    incr i
		    set results [hdrLineParse $line]
		    if {$results == ""} {continue}
		    if {[scan $results "%s %s %s %s" key type value comment] \
			    == 3} {
			set comment ""
		    }
		    if {[catch {keylget keywords $key} results]} {
			if {[lsearch $optional $key] == -1} {
			    echo "    extra keyword $key"
			    set err 1
			}
		    } else {
			if {[lindex $results 0] != $type} {
			    echo "    mismatched types for keyword $key: [lindex $results 0], $type"
			    set err 1
			}
			keyldel keywords $key
		    }
		}
		if {$hdu == 0} {
		    # PDU.  Test region size parameters.
		    if {[catch {keylget keywords NAXIS results}]} {
			error "fitsCheck: missing NAXIS keyword from template file '$template'"
		    }
		    keyldel keywords NAXIS
		    set naxis [lindex $results 1]
		    set nrows [exprGet $fit.nrow]
		    set ncols [exprGet $fit.ncol]
		    set n 0
		    if {$nrows > 0} {
			if {[catch {keylget keywords NAXIS2 results}]} {
			    echo "    extra keyword NAXIS2"
			    set err 1
			} else {
			    if {$nrows != [lindex $results 1]} {
				echo "    mismatched NAXIS2 values: [lindex  $results 1], $nrows"
				set err 1
			    }
			    keyldel keywords NAXIS2
			}
			incr n
		    }
		    if {$ncols > 0} {
			if {[catch {keylget keywords NAXIS1 results}]} {
			    echo "    extra keyword NAXIS1"
			    set err 1
			} else {
			    if {$ncols != [lindex $results 1]} {
				echo "    mismatched NAXIS1 values: [lindex $results 1], $ncols"
				set err 1
			    }
			    keyldel keywords NAXIS1
			}
			incr n
		    }
		    if {$n != $naxis} {
			echo "    mismatch NAXIS values: $naxis, $n"
			set err 1
		    }

		    # Skip BITPIX and SIMPLE test.  Also skip BSCALE and
		    # BZERO, since fitsRead swallows it.
		    # TODO: should test BITPIX
		    catch {keyldel keywords BITPIX}
		    catch {keyldel keywords SIMPLE}
		    catch {keyldel keywords BSCALE}
		    catch {keyldel keywords BZERO}

		    # Clean up
		    regDel $fit
		} else {
		    # Not a PDU.  Test TBLCOL stuff.

		    # Test number of fields.
		    set nFields [lindex [lindex [tblInfoGet $fit] 1] 1]
		    if {[catch {keylget keywords TFIELDS results}]} {
			error "fitsCheck: missing TFIELDS keyword from template file '$template'"
		    } else {
			if {[lindex $results 1] != $nFields} {
			    echo "    mismatched number of fields: [lindex $results 1], $nFields"
			    set err 1
			}
			keyldel keywords TFIELDS
		    }

		    # Test each field
		    loop i 0 $nFields {
			set n [expr $i+1]
			set info [tblFldInfoGet $fit -col $i]
			switch [keylget info TYPE] {
			    DOUBLE {set type D}
			    FLOAT  {set type E}
			    INT    {set type J}
			    USHORT {set type U}
			    SHORT  {set type I}
			    STR    {set type A}
			    default {error "fitsCheck: unrecognized data type '[keylget info TYPE]'"}
			}
			set dim [keylget info DIM]
			if {[llength $dim] > 1} {
			    set len 1
			    if {[llength $dim] > 2} {set dims ")"}
			    loop j 1 [llength $dim] {
				if {$type == "A" && $j == [llength $dim]-1} {
				    set len [expr $len * ([lindex $dim $j]-1)]
				} else {
				    set len [expr $len * [lindex $dim $j]]
				}
				if {[llength $dim] > 2} {
				    if {$j > 1} {set dims ",$dims"}
				    set dims "[lindex $dim $j]$dims"
				}
			    }
			    set type $len[set type]
			}
			if {[llength $dim] > 2} {
			    set dims "($dims"
			    if {[catch {keylget keywords TDIM$n} tdim]} {
				echo "    extra keyword TDIM$n"
				set err 1
			    } else {
				if {$dims != [lindex $tdim 1]} {
				    echo "    mismatched keyword TDIM$n: '[lindex $tdim 1]', '$dims'"
				    set err 1
				}
				keyldel keywords TDIM$n
			    }
			}
			if {[catch {keylget keywords TFORM$n} tform]} {
			    echo "    extra keyword TFORM$n"
			    set err 1
			} else {
			    set type2 [lindex $tform 1]
			    if {[llength $type] == 1} {
				if {$type!=$type2 && "1[set type]" != $type2} {
				    echo "    mismatched keyword TFORM$n: '$type2', '$type'"
				    set err 1
				}
			    } else {
				if {$type != $type2} {
				    echo "    mismatched keyword TFORM$n:, '$type2', '$type'"
				    set err 1
				}
			    }
			    keyldel keywords TFORM$n
			}
			if {[catch {keylget keywords TTYPE$n} tform]} {
			    echo "    extra keyword TTYPE$n"
			    set err 1
			} else {
			    if {$caseInsensitive} {
				if {! [regexp -nocase "^[keylget info TTYPE]$" \
					[lindex [keylget keywords TTYPE$n] 1]]} {
				    echo "    mismatched keyword TTYPE$n: '[lindex [keylget keywords TTYPE$n] 1]', '[keylget info TTYPE]'"
				    set err 1
				}
			    } else {
				if {[keylget info TTYPE] != \
					[lindex [keylget keywords TTYPE$n] 1]} {
				    echo "    mismatched keyword TTYPE$n: '[lindex [keylget keywords TTYPE$n] 1]', '[keylget info TTYPE]'"
				    set err 1
				}
			    }
			    keyldel keywords TTYPE$n
			}
		    }

		    # Skip XTENSION, BITPIX, NAXIS, NAXIS1, NAXIS2, PCOUNT,
		    # and GCOUNT.
		    # TODO: Should test PCOUNT and GCOUNT.
		    foreach key {XTENSION BITPIX NAXIS NAXIS1 NAXIS2 PCOUNT GCOUNT} {
			keyldel keywords $key
		    }

		    # Clean up
		    tblColDel $fit
		}

		# Test for missing table keywords
		if {[llength $keywords] > 0} {
		    # Ignore keywords TZEROx and TUNITx, since tblCol stuff
		    # swallows these.
		    # TODO: should check these keywords.
		    set missing ""
		    foreach key [keylkeys keywords] {
			if {[regexp {^(TZERO|TUNIT)[0-9]+$} $key] == 0} {
			    set found 0
			    foreach opt $optional {
				if {$opt == $key} {set found 1; break}
			    }
			    if {$found == 0} {
				lappend missing $key
			    }
			}
		    }
		    if {[llength $missing] > 0} {
			paramsEcho "    missing keywords" $missing
			set err 1
		    }
		}
		set pass 0
	    }
	} elseif {[regexp -nocase "^ *<!--.*--> *$" $line]} {
	} elseif {$pass && [regexp "^END *$" $line] == 0} {
	    set results [hdrLineParse $line]
	    if {$results != ""} {
		if {[scan $results "%s %s %s %s" key type value \
			comment] == 3} {
		    set comment ""
		}
		keylset keywords $key "$type $value $comment"
	    }
	}
    }
    close $input

    # Error if template contains no AUTOCHECK lines
    if {$ok == 0} {
	error "fitsCheck: no 'AUTOCHECK' lines in template file '$template'"
    }

    return $err
}

# Parse a line as it appears in a HDR or a FITS header.  Return a TCL list
# containing the keyword, it's type (boolean, char, or number), and comment.
proc hdrLineParse {line} {
    if {[regexp {^END *$} $line]} {
	return ""
    } elseif {[regexp \
	    {^([A-Z0-9_-]+) *= *(T|F|[X0-9\.E+-]+|'.*') *(/.*|)$} \
	    $line junk key value comment]} {
	if {$value == "T" || $value == "F"} {
	    set type boolean
	} elseif {[string index $value 0] == "'"} {
	    set value [fitsStringStrip $value]
	    set type char
	} else {
	    set type number
	}
	return "$key $type $value $comment"
    } elseif {[regexp {^([A-Z0-9_-]+) *([^ =].*|)$} $line junk key value]} {
	if {$key == "COMMENT" || $key == "HISTORY"} {
	    return ""
	} else {
	    # fitsRead doesn't get these, so skip them.
	    return ""
	}
    } elseif {[regexp {^ *$} $line]} {
	return ""
    } else {
	error "hdrLineParse: badly formatted template file: $line"
    }
}

# Strip enclosing '' and enclosed leading and trailing blanks from a string.
# Returns the stripped string.
proc fitsStringStrip {string} {
    if {[string index $string 0] == "'"} {
	set string [string range $string 1 end]
    }
    set len [string length $string]
    if {[string index $string [expr $len - 1]] == "'"} {
	set string [string range $string 0 [expr $len-2]]
    }
    return [string trim $string]
}
