/*! @file merge_segment_pipe.c
 * @brief Read a segment list from stdin and write a merged, ordered one to stdout
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "segments.h"

int
main (int argc, const char *argv[])
{
  merge_segments(stdin, stdout);
  exit (EXIT_SUCCESS);
}
