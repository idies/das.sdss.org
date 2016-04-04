/*! @file raDecToXY
 * @brief Convert RA, Dec to X, Y pixel coordinates
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "coord_xform.h"

int
main (int argc, const char *argv[])
{
  const char *filename;
  double ra, dec;
  double row, col;
  double node, incl;
  FILE *fp;
  trans t[5];

  if (argc != 4)
    exit(EXIT_FAILURE);

  filename = argv[1];
  ra = strtod(argv[2], NULL);
  dec = strtod(argv[3], NULL);
  
  read_trans(filename, t, &node, &incl);

  eqToPix(ra, dec, t[1], node, incl, &row, &col);
  
  printf("%g\t%g\n",row,col);

  exit (EXIT_SUCCESS);

}
