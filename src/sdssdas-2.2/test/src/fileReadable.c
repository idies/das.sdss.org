/*! @file fileReadable
 * @brief check whether a file is readable
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include "file_readable.h"

int
main (int argc, const char *argv[])
{
  const char *filename;

  if (argc != 2)
    exit(EXIT_FAILURE);

  filename = argv[1];
  
  if (file_readable(filename))
    printf("yes\n");
  else
    printf("no\n");

  exit (EXIT_SUCCESS);

}
