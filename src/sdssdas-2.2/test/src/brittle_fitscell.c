/*! @file brittle_fitscell.c
 * @brief read a double from a cell in a fits table
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
  int offset = 0;
  char keyword[9];
  const char *filename;
  int skipped = 0; 
  double value = 0;
  FILE *fp;
  char b; 

  keyword[8] = '\0';

  switch (argc)
    {
    case 4:
      hdu = (int) strtol(argv[3], NULL, 10);
      filename = argv[1];
      offset = (int) strtol(argv[2], NULL, 10);
      break;
    case 3:
      filename = argv[1];
      offset = (int) strtol(argv[2], NULL, 10);
      break;
    default:
      printf ("Incorrect number of args\n");
      exit (EXIT_FAILURE);
    }
  
  fp = fopen(filename, "r");

  assert(fp!=NULL);

  /* skip to requested hdu */
  skipped = 0;
  while (skipped <= hdu)
    {
      (void) fits_pass_hdr(fp);
      skipped++;
    }

  /* skip to requested byte */
  skipped = 0;
  while (skipped < offset)
    {
      (void) fread(&b,1,1,fp);
      skipped++;
    }
  
  (void) fits_read_cell(fp, &value, sizeof(value));

  printf("%g\n",value);

  exit (EXIT_SUCCESS);

}
