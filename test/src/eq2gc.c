/*! @file eq2gc.c
 * @brief convert equatorial coordinates to great circle coords for testing
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "coord_xform.h"

int
main (int argc, const char *argv[])
{
  double node, incl;
  double ra, dec;
  double mu, nu;

  switch (argc)
    {
    case 5:
      node = strtod(argv[1], NULL);
      incl = strtod(argv[2], NULL);
      ra = strtod(argv[3], NULL);
      dec = strtod(argv[4], NULL);
      break;
    default:
      printf ("Incorrect number of args (4 required, %d supplied)\n", argc-1);
      exit (EXIT_FAILURE);
    }

  atEqToGC(ra, dec, &mu, &nu, node, incl);

  printf("%g\t%g\n", mu, nu);

  exit (EXIT_SUCCESS);

}
