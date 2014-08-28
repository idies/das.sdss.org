/*! @file read_segment.c
 * @brief read a segments from a TSV file
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "segments.h"

/*! Read a segment from a TSV file
 *
 * @param in file descriptor pointer from which to read the segment
 * @param s pointer to the segment into which to load the data
 * @return true if a segment was loaded
 */
bool
read_segment (FILE * in, segment /*@out@*/ *s)
{
  char line[TSV_LINE_LENGTH];	/* a buffer of the line input */
  char *read_check;		/* a pointer to the read string returned by fgets */
  int cols_read;		/* number of columns read from the file */

  line[0] = '#';
  line[1] = '\0';
  read_check = line;
  while (line[0] == '#')
    {
      read_check = fgets (line, TSV_LINE_LENGTH, in);
      /* if we get back a null string, no segments can be read */
      if (read_check == NULL)
	{
	  return false;
	}
    }
  cols_read = sscanf (line, "%d%d%d%d%d",
		      &(s->run), &(s->rerun), 
		      &(s->camcol), &(s->field),
		      &(s->nfields));
  assert (cols_read == 5);

  return true;
}

