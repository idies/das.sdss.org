/*! @file brittle_hdrint.c
 * @brief read an integer fits header keyword value
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "brittle_fits.h"

int
main (int argc, const char *argv[])
{
  int hdu = 0;
  char keyword[9];
  const char *filename;
  int skipped = 0; 
  int value = 0;
  FILE *fp;

  keyword[8] = '\0';

  switch (argc)
    {
    case 4:
      hdu = (int) strtol(argv[3], NULL, 10);
      filename = argv[1];
      strncpy(keyword,argv[2],8);
      break;
    case 3:
      filename = argv[1];
      strncpy(keyword,argv[2],8);
      break;
    default:
      printf ("Incorrect number of args\n");
      exit (EXIT_FAILURE);
    }
  
  fp = fopen(filename, "r");

  assert(fp!=NULL);

  while (skipped < hdu)
    {
      (void) fits_pass_hdr(fp);
      skipped++;
    }
  
  (void) fits_hdr_int(fp, &value, keyword);

  printf("%d\n",value);

  exit (EXIT_SUCCESS);

}
