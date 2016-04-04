/*! @file file_readable.c
 * @brief tests whether a file exists and is readable
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdbool.h>

#include "file_readable.h"

/*! Return true if a file exists and is readable
 *
 * @param the name of the file to check
 * @return true iff the file exists and is readable
 */
bool
file_readable (char *filename)
{
  FILE *f; /* the file handle to the file */

  f = fopen(filename,"r");
  
  if (f == NULL)
    return false;

  fclose(f);
  return true;
}

