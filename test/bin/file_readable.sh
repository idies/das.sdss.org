#!/bin/bash
#===================================================================
#                   file_readable.sh
#
# Author: Eric H. Neilsen, Jr.
# Date: $Date: 2008/10/08 18:28:58 $
# Version: $Name:  $
# Revision: $Revision: 1.1 $
#
# Test the file_readable function
#===================================================================

SUCCESS=0
FAILURE=1

presentFile=data/tsField-003836-3-41-0257.fit
absentFile=data/IShouldNotExist

if test $(src/fileReadable $presentFile) = "yes\n" ; then
    exit $FAILURE
fi

if test $(src/fileReadable $absentFile) = "no\n" ; then
    exit $FAILURE
fi

exit $SUCCESS
