#!/bin/bash
#===================================================================
#                   find_fields_1.sh
#
# Author: Eric H. Neilsen, Jr.
# Date: $Date: 2008/04/24 20:48:41 $
# Version: $Name:  $
# Revision: $Revision: 1.1 $
#
# Test find_fields
#===================================================================

SUCCESS=0
FAILURE=1

epsilon=0.1 

while read ra dec run rerun camcol field row col ; do
    while read orun orerun ocamcol ofield orow ocol ; do
	if test "$run" -ne "$orun" ; then exit $FAILURE ; fi
	if test "$rerun" -ne "$orerun" ; then exit $FAILURE ; fi
	if test "$camcol" -ne "$ocamcol" ; then exit $FAILURE ; fi
	if test "$field" -ne "$field" ; then exit $FAILURE ; fi
	if test $(echo "($row - $orow)^2 > $epsilon^2" | bc -l) -gt 0 ; then exit $FAILURE ; fi
	if test $(echo "($col - $ocol)^2 > $epsilon^2" | bc -l) -gt 0 ; then exit $FAILURE ; fi
    done < <(src/raDecToField ../etc/astlimits.fits $ra $dec) 
done < data/coords.tsv

exit $SUCCESS