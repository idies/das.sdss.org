/*! @file raDecToField
 * @brief List all the fields that cover a given RA, Dec
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "find_fields.h"

int
main (int argc, const char *argv[])
{
  const char *filename;
  double ra, dec;
  segment_def *seg_defs = NULL;
  int num_segs = 0;
  field_node_pointer f0 = NULL;
  field_node /*@dependent@*/ *f = NULL;
  int return_code = 0;
  int num_fields = 0;

  if (argc != 4)
    exit(EXIT_FAILURE);

  filename = argv[1];
  ra = strtod(argv[2], NULL);
  dec = strtod(argv[3], NULL);
  
  return_code = load_segment_defs(filename, &seg_defs, &num_segs);
  assert(return_code == 0);
  num_fields = matching_fields(ra, dec, seg_defs, num_segs, &f0);

  for(f = (field_node *)f0; f != NULL; f = (field_node *)f->next)
    printf("%d\t%d\t%d\t%d\t%f\t%f\n",
	   f->run, f->rerun, f->camcol, f->field,
	   f->row, f->col);
  
  free_field_list(&f0);

  free(seg_defs);
  exit (EXIT_SUCCESS);

}
