#!/bin/bash
#===================================================================
#                   coord_xform_2.sh
#
# Author: Eric H. Neilsen, Jr.
# Date: $Date: 2008/04/18 18:25:49 $
# Version: $Name:  $
# Revision: $Revision: 1.1 $
#
# Test the coord_xform functions
#===================================================================

SUCCESS=0
FAILURE=1

epsilon=0.05

ra=187.40531920
dec=12.31948948

row=$(src/raDecToXY data/tsField-003836-3-41-0257.fit $ra $dec | cut -f 1)
col=$(src/raDecToXY data/tsField-003836-3-41-0257.fit $ra $dec | cut -f 2)

if test $(echo "($row - 123.0)^2 > $epsilon^2" | bc -l) -gt 0 ; then
    exit $FAILURE
fi

if test $(echo "($col - 456.0)^2 > $epsilon^2" | bc -l) -gt 0 ; then
    exit $FAILURE
fi

exit $SUCCESS
