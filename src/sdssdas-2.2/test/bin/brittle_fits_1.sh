#!/bin/bash
#===================================================================
#                   brittle_fits_1.sh
#
# Author: Eric H. Neilsen, Jr.
# Date: $Date: 2008/04/16 20:54:25 $
# Version: $Name:  $
# Revision: $Revision: 1.2 $
#
# Test the brittle_fits functions
#===================================================================

SUCCESS=0
FAILURE=1

RUN=$(src/brittle_hdrint data/tsField-003836-3-41-0257.fit RUN)
TFIELDS=$(src/brittle_hdrint data/tsField-003836-3-41-0257.fit TFIELDS 1)

if test ! "$RUN" -eq 3836 ; then
    exit $FAILURE
fi

if test ! "$TFIELDS" -eq 98 ; then
    exit $FAILURE
fi

A=$(src/brittle_fitscell data/tsField-003836-3-41-0257.fit 8 1)
if test ! "$A" = 187.337 ; then
    exit $FAILURE
fi

exit $SUCCESS

