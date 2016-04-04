/*! @file seglist_overlap.c
 * @brief generate a list of segments that is the intersetion of two others
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

/*! Return true if s1 is greater than s2, false otherwile
 *
 * @param s1 the first segment
 * @param s2 the second segment
 * @return true if s1 > s2
 *
 */
static bool
segment_gt (segment s1, segment s2)
{
  if (s1.run > s2.run)
    return true;
  if (s1.run < s2.run)
    return false;

  /* the runs are equal; compare by camcol */

  if (s1.camcol > s2.camcol)
    return true;
  if (s1.camcol < s2.camcol)
    return false;

  /* the camcol are also equal; compare by last field */

  if (s1.field + s1.nfields > s2.field + s2.nfields)
    return true;

  return false;

}

/*! Calculate the ovelap between two segments 
 *
 * @param in1 the first input segment
 * @param in2 the secondinput segment  
 * @param out a pointer to the segment which in the overlap
 * @return true if the segments overlap
 */
static bool
segment_overlap (segment in1, segment in2, segment /*@out@ */  * out)
{
  int end_field1;		/* the end field of the first input segment */
  int end_field2;		/* the end field of the second input segment */
  int end_field;		/* the end field of the overlap segment */

  if (in1.run != in2.run || in1.camcol != in2.camcol)
    return false;
  out->run = in2.run;
  out->camcol = in2.camcol;
  out->rerun = in2.rerun;

  out->field = in1.field > in2.field ? in1.field : in2.field;

  end_field1 = in1.field + in1.nfields - 1;
  end_field2 = in2.field + in2.nfields - 1;
  end_field = end_field1 < end_field2 ? end_field1 : end_field2;

  out->nfields = end_field - out->field + 1;

  return out->nfields > 0;

}

/*! Read segments from two sorted tsv files and generate a tsv of the overlap
 *
 * The overlap always contains the rerun number from the second list
 *
 * @param in1 the first input file
 * @param in2 the second input file
 * @param out the output file
 */
void
seglist_overlap (FILE * in1, FILE * in2, FILE * out)
{
  segment s1, s2;		/* the segment being compared */
  segment si;			/* the overlap segment */
  bool s1read, s2read;		/* true if the segment was read (no EOF found) */
  bool overlap;			/* true if we have found an overlap */

  s1read = read_segment (in1, &s1);
  s2read = read_segment (in2, &s2);

  while (s1read && s2read)
    {
      overlap = segment_overlap (s1, s2, &si);
      if (overlap)
	fprintf (out, "%d\t%d\t%d\t%d\t%d\n",
		 si.run, si.rerun, si.camcol, si.field, si.nfields);
      if (segment_gt (s1, s2))
	{
	  s2read = read_segment (in2, &s2);
	}
      else
	{
	  s1read = read_segment (in1, &s1);
	}
    }
}
