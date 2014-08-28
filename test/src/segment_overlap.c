/*! @file segment_overlap.c
 * @brief print the overlap between two segment lists
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "segments.h"
#include "segment_list.h"

int
main (int argc, const char *argv[])
{
  const char *in1_fn; /* file name of input file 1 */
  FILE *in1;         /* input file 1*/
  const char *in2_fn; /* file name of input file 2 */
  FILE *in2;         /* input file 2*/

  switch (argc)
    {
    case 3:
      in1_fn = argv[1];
      in2_fn = argv[2];
      break;
    default:
      printf ("Incorrect number of args (2 required, %d supplied)\n", argc);
      exit (EXIT_FAILURE);
    }

  in1 = fopen(in1_fn, "r");
  if (in1 == NULL)
    exit (EXIT_FAILURE);
  in2 = fopen(in2_fn, "r");
  if (in2 == NULL)
    exit (EXIT_FAILURE);

  seglist_overlap(in1, in2, stdout);
  
  (void) fclose(in1);
  (void) fclose(in2);

  exit (EXIT_SUCCESS);

}
