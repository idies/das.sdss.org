/*! @file segment_list.c
 * @brief Tools for linked lists of segments
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

/*! Free an allocated segment, making sure the next and previous refs are NULL
 * 
 * @param s a pointer to the segment to free
 */
void
free_segment_link(segment_link /*@owned@*/ /*@null@*/ *s)
{
  segment_link *n; /* the next to delete */
  if (s == NULL)
    return;
  assert(s->previous == NULL);
  while(s!=NULL)
    {
      n = s;
      s = (segment_link *) s->next;
      free(n);
    }
}

/*! Add a segment_link to the linked list of segment_links
 *
 * @param previous a pointer to the previous segment_link
 * @param ends a structure holding pointers to the first and last elements in the list
 * @param s a segment with the contents of the new segment_link
 */
void
link_segment(segment_link /*@null@*/ /*@dependent@*/ *previous,
	     slist_ends /*@partial@*/ *ends,
	     segment s)
{
  segment_link *newlink; /* the segment_link that will follow the inserted one */
  segment *newseg; /* a link to the new segment */
  segment_link *new_next; /* node prior to new one */
  segment_link *new_previous; /* node after new one */

  newlink = (segment_link *) malloc(sizeof(segment_link));
  assert(newlink != NULL);
  newseg = &newlink->segment;
  newseg->run = s.run;
  newseg->rerun = s.rerun;
  newseg->camcol = s.camcol;
  newseg->field = s.field;
  newseg->nfields = s.nfields;
    
  if (previous == NULL) 
    {
      new_next = ends->first;
      new_previous = NULL;
    }
  else 
    {
      new_next = (segment_link *) previous->next;
      new_previous = previous;
    }

  newlink->next = (segment_link_pointer) new_next;
  newlink->previous = (segment_link_pointer) new_previous;

  if (new_next != NULL)
    new_next->previous = (segment_link_pointer) newlink;
  
  if (new_previous == ends->last) 
    ends->last = newlink;

  if (new_previous != NULL)
    new_previous->next = (segment_link_pointer) newlink;
  else
    {
      assert(ends->first == (segment_link *) newlink->next);
      ends->first = newlink;
    }
}

/*! Print the segment list
 * 
 * @param first a pointer to the first segment in the list
 * @param out the output file discriptor 
 *
 */
void 
print_segments (segment_link /*@null@*/ *first, FILE *out)
{
  segment_link *c; /* pointer to the segment being printed */

  if (first == NULL)
    return;

  /* write the output */
  fprintf (out, "#run\trerun\tcamcol\tfield\tnfields\n");
  for (c = first; c != NULL; c = (segment_link *) c->next)
    {
      fprintf (out, "%d\t%d\t%d\t%d\t%d\n",
	       c->segment.run, c->segment.rerun, 
	       c->segment.camcol, c->segment.field, c->segment.nfields);
    }
}

