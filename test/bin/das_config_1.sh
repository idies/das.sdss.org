#!/bin/bash
#===================================================================
#                       das_config_1.sh
#
# Author: Eric H. Neilsen, Jr.
# Date: $Date: 2008/03/03 17:05:29 $
# Version: $Name:  $
# Revision: $Revision: 1.1 $
#
# Test the das_config function
#===================================================================

SUCCESS=0
FAILURE=1

if diff <(src/print_das_config data/das1.conf) data/print_das_config.out ; then 
    exit $SUCCESS 
else 
    exit $FAILURE 
fi
