#!/bin/bash
#===================================================================
#                   segment_overlap_1.sh
#
# Author: Eric H. Neilsen, Jr.
# Date: $Date: 2008/03/11 15:44:32 $
# Version: $Name:  $
# Revision: $Revision: 1.1 $
#
# Test the segment_overlap function
#===================================================================

SUCCESS=0
FAILURE=1

if diff -b <(src/segment_overlap data/userlist.tsv data/reflist.tsv) data/overlap.tsv ; then 
    exit $SUCCESS 
else 
    exit $FAILURE 
fi
