/*! @file merge_segments.c
 * @brief read a list of segments and merge them into a minimal sorted set
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "segments.h"
#include "segment_list.h"
#include "merge_segments.h"

/*! Read segments from a tsv file into a sorted minimal linked list, and write
 *
 * @param in the input file
 * @param out the output file
 */
void
merge_segments (FILE * in, FILE * out)
{
  segment s;	     /* the current working segment */
  slist_ends ends = {NULL, NULL}; /* the limits of the segment list */
  segment_link /*@null@*/ /*@dependent@*/ *c = NULL; /* pointed to segment in list being consedered */
  segment_link /*@null@*/ /*@dependent@*/ *n = NULL; /* pointed to segment after one being consedered */
  int last_field;		/* the last field in the new segment */
  bool eof_found;               /* end of file marker encounetered */

  /* If we reach the end of the input right away, exist without doing anything */
  eof_found = !read_segment(in, &s);
  if (eof_found)
    {
      return;
    }
  
  link_segment(NULL, &ends, s);

  /* Work through the remaining input lines */
  while (read_segment(in, &s))
    {
      last_field = s.field + s.nfields - 1;

      /* Find the location in the list to put the new entry. */

      /* c points to the segment after which we will add the new segment */

      /* Start from the end, because this will be faster if the input 
       * already in order.
       */
      c = ends.last;
      while (c != NULL 
	     && s.run < c->segment.run)
	c = (segment_link *) c->previous;
      while (c != NULL 
	     && s.run == c->segment.run 
	     && s.rerun < c->segment.rerun)
	c = (segment_link *) c->previous;
      while (c != NULL
	     && s.run == c->segment.run 
	     && s.rerun == c->segment.rerun 
	     && s.camcol < c->segment.camcol)
	c = (segment_link *) c->previous;
      while (c != NULL 
	     && s.run == c->segment.run 
	     && s.rerun == c->segment.rerun 
	     && s.camcol == c->segment.camcol
	     && s.field < c->segment.field)
	c = (segment_link *) c->previous;

      /* check for potential merges */
      /* See if the s can be merged with the segment that preceeds it */
      if (c != NULL 
	  && s.run == c->segment.run && s.rerun == c->segment.rerun 
	  && s.camcol == c->segment.camcol)
	{
	  /* check whether the previous segment completely includes s */
	  if (c->segment.field + c->segment.nfields - 1 >= last_field)
	    {
	      continue;
	    }
	  /* check whether we can expand the previous segment to include s */
	  if (c->segment.field + c->segment.nfields >= s.field)
	    {
	      c->segment.nfields = last_field - c->segment.field + 1;
	      continue;
	    }
	}
      
      /* See if s can be merged by the segment that follows it */
      n = c == NULL ? ends.first : (segment_link *) c->next; 
      if (n != NULL 
	  && s.run == n->segment.run && s.rerun == n->segment.rerun 
	  && s.camcol == n->segment.camcol)
	{
	  /* check whether s overlaps the next one */
	  if (last_field >= n->segment.field - 1)
	    {
	      last_field = n->segment.field + n->segment.nfields - 1 > last_field
		? n->segment.field + n->segment.nfields - 1: last_field;
	      n->segment.field = s.field;
	      n->segment.nfields = last_field - n->segment.field + 1;
	      continue;
	    }
	}

      link_segment(c, &ends, s);

      /* print_segments(ends.first, stderr); */
      
    }

  print_segments(ends.first, out);
  fflush(out);

  free_segment_link (ends.first);
  
}
