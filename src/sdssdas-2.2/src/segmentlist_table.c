/*! @file segmentlist_table.c
 * @brief read a list of segments and write an xhtml table
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "das_config.h"
#include "segments.h"
#include "segmentlist_table.h"

/*! read sigments from a TSV and write a formatted html table
 * 
 * @param in file pointer from which to read the TSV
 * @param out file pointer to which to write the html
 * @param list_id the serial number of the list to read
 * @param config the structure holding the configuation of the DAS
 */
void
segmentlist_table (FILE *in, FILE *out, char *list_id, das_config config)
{
  segment s={0,0,0,0,0}; /* the next segment to print */
  segment p={0,0,0,0,0}; /* the most recent segment printed */
  bool open_row; /* we have an open row in our table */
  bool need_new_row; /* the current segment starts a new row */
  char segment_url[MAX_URLBASE_LENGTH]; /* The url for a segment */

  fprintf(out,"<div class=\"segment-list\">\n");
  fprintf(out,"<table class=\"segment-list\">\n");
  fprintf(out,"<thead>\n");
  fprintf(out,"<tr class=\"top\">\n");
  fprintf(out," <th>link</th>\n");
  fprintf(out," <th>run</th>\n");
  fprintf(out," <th>rerun</th>\n");
  fprintf(out," <th>camcol</th>\n");
  fprintf(out," <th>fields</th>\n");
  fprintf(out,"</tr>\n");
  fprintf(out,"</thead>\n");
  
  open_row = false;
  need_new_row = true;

  while (read_segment(in,&s)) 
    {
      need_new_row = s.run!=p.run || s.rerun != p.rerun || s.camcol != p.camcol;
      if (open_row && need_new_row)
	{
	  fprintf(out," </td>\n</tr>\n");
	  open_row = false;
	}
      if (!open_row)
	{
	  (void) snprintf(segment_url, MAX_URLBASE_LENGTH,
			  "%s/segments?LIST=%s&RUN=%d&RERUN=%d&CAMCOL=%d",
			  config.cgi_url, list_id, s.run, s.rerun, s.camcol);
	  fprintf(out,"<tr class=\"segment\">\n");
	  fprintf(out," <td class=\"segment\"><a href=\"%s\">%s</a></td>\n", 
		  segment_url, segment_url);
	  fprintf(out," <td class=\"run\">%d</td>\n", s.run);
	  fprintf(out," <td class=\"rerun\">%d</td>\n", s.rerun);
	  fprintf(out," <td class=\"camcol\">%d</td>\n", s.camcol);
	  fprintf(out," <td class=\"fields\">");
	  memcpy(&p,&s,sizeof(segment));
	  open_row = true;
	}
      if (s.nfields == 1)
	{
	  fprintf(out,"%d ", s.field);
	}
      else
	{
	  fprintf(out,"%d-%d ", 
		  s.field, s.field + s.nfields - 1);
	}
    }
  if (open_row)
    {
      fprintf(out," </td>\n</tr>\n");
      open_row = false;
    }

  fprintf(out,"</table>\n");
  fprintf(out,"</div>\n");
}

