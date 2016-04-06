/*! @file gc2eq.c
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
      mu = strtod(argv[3], NULL);
      nu = strtod(argv[4], NULL);
      break;
    default:
      printf ("Incorrect number of args (4 required, %d supplied)\n", argc-1);
      exit (EXIT_FAILURE);
    }

  atGCToEq(mu, nu, &ra, &dec, node, incl);

  printf("%g\t%g\n", ra, dec);

  exit (EXIT_SUCCESS);

}
