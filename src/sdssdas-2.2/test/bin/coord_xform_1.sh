#!/bin/bash
#===================================================================
#                   coord_xform_1.sh
#
# Author: Eric H. Neilsen, Jr.
# Date: $Date: 2008/10/15 18:47:57 $
# Version: $Name:  $
# Revision: $Revision: 1.3 $
#
# Test the coord_xform functions
#===================================================================

SUCCESS=0
FAILURE=1

epsilon=0.01

ra=29.03398992
dec=151.60248756000001
node=65.524950000000004
incl=15.210721530000001
mu=$(src/eq2gc $node $incl $ra $dec | cut -f 1)
nu=$(src/eq2gc $node $incl $ra $dec | cut -f 2)

DELTA=$(echo "($mu - 203.85)^2 > $epsilon^2" | bc -l)
if test $DELTA -gt 0 ; then
    exit $FAILURE
fi

DELTA=$(echo "($nu - 18.76)^2 > $epsilon^2" | bc -l )
if test $DELTA -gt 0 ; then
    exit $FAILURE
fi


mu=28.739118600000001
nu=142.62730127999998
node=9.2836188899999996
incl=12.88101915
ra=$(src/gc2eq $node $incl $mu $nu | cut -f 1)
dec=$(src/gc2eq $node $incl $mu $nu | cut -f 2)

if test $(echo "($ra - 216.98035465)^2 > $epsilon^2" | bc -l) -gt 0 ; then
    exit $FAILURE
fi

if test $(echo "($dec - 32.18903570)^2 > $epsilon^2" | bc -l) -gt 0 ; then
    exit $FAILURE
fi


exit $SUCCESS
