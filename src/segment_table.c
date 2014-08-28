/** @file segment_table.c
 * @brief CGI program show data on a segment
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "file_readable.h"
#include "das_config.h"
#include "segments.h"
#include "segment_table.h"
#include "checked_link.h"

/*! Create an html table of frames in a given segment present in a tsv list
 * 
 * @param in file pointer from which TSV entries are read
 * @param out file pointer to which to write xhtml
 * @param run the run to list
 * @param rerun the rerun to list
 * @param camcol the camcol to list
 * @param zoom the zoom at which to see the images
 * @param config the SDSS DAS configuration structure
 */
void
segment_table (FILE * in, FILE * out,
	       int run, int rerun, int camcol, int zoom, das_config config)
{
  segment s;			/* the segment to add next */
  int field;			/* the field being shown */
  char *filter = "ugriz";	/* the filters to show */
  char filename[MAX_PATH_LENGTH];	/* the current file name */
  char dirname[MAX_PATH_LENGTH];	/* the current directory name */
  char filelink[MAX_PATH_LENGTH];	/* a link to a file (if it exists) */
  int zooms[] = { 0, 5, 10, 15, 20, 25, 30 };	/* the allowed zooms */
  int nzooms = 7;		/* the number of allowed zooms */
  int zoom_i;			/* index for iterating through zooms */
  bool valid_zoom;		/* parameter contained a valid zoom value */
  int i;                        /* filter index */
  int num_filters;              /* the number of filters */
  char zoom_fn[MAX_PATH_LENGTH]; /* the location of the zoom image */
  bool link_okay;               /* the file to be linked to exists */
  int zoom_rerun;               /* the rerun from which to get the zoom */
  num_filters = (int) strlen(filter);
  zoom_rerun = rerun;

  /* make sure the caller supplied a valid zoom */
  valid_zoom = false;
  for (zoom_i = 0; zoom_i < nzooms; zoom_i++)
    valid_zoom = valid_zoom || (zoom == zooms[zoom_i]);
  if (!valid_zoom)
    zoom = zooms[5];

  fprintf (out, "<h2>Files for the run as a whole </h2>");

  fprintf (out, "<div class=\"run-files\">\n");
  fprintf (out, "<table class=\"run-files\">\n");
  fprintf (out, "<thead>\n");
  fprintf (out, "<tr class=\"top\">\n");
  fprintf (out, " <th></th>\n");
  fprintf (out, " <th>Directory</th>\n");
  fprintf (out, " <th>File</th>\n");
  fprintf (out, "</tr>\n");
  fprintf (out, "</thead>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">Astrometric calibration</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/astrom", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "asTrans-%06d.fit", run);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">Photometric calibration</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/nfcalib", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "fcPCalib-%06d-%d.fit", 
		   run, camcol);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">Summary QA</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "QA/%d/%d/qa", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "summary-runQA-%d-%d.html", run,
	    rerun);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">Full QA</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "QA/%d/%d/qa", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "all-runQA-%d-%d.html", run, rerun);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">Frames QA</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "QA/%d/%d", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "qaFrames.html");
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">Astrometric calib. QA</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "QA/%d/%d", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "qaAstrom.html");
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">Photometric calib. QA</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "QA/%d/%d", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "qaNfcalib.html");
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");

  fprintf (out, "<tr>\n");
  fprintf (out, "<th align=\"right\">PSP QA</th>\n");
  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/objcs", run, rerun);
  (void) snprintf (filename, MAX_PATH_LENGTH, "pspQA-%06d.html",run);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, "", filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  (void) checked_link (config.imaging_url, config.imaging_root, 
		       dirname, filename, filelink, MAX_PATH_LENGTH);
  fprintf (out, "<td>%s</td>\n", filelink);
  fprintf (out, "</tr>\n");


  fprintf (out, "<tbody>\n");

  fprintf (out, "</tbody>\n");
  fprintf (out, "</table>\n");
  fprintf (out, "</div>\n");

  fprintf (out, "<h2>Files for each field</h2>");

  fprintf (out, "<div class=\"table-of-fields\">\n");
  fprintf (out, "<table class=\"table-of-fields\">\n");
  fprintf (out, "<thead>\n");
  fprintf (out, "<tr class=\"top\">\n");
  fprintf (out, "<th>Field</th>\n");
  fprintf (out, "<th>Zoom</th>\n");
  fprintf (out, "<th>Corrected frames</th>\n");
  fprintf (out, "<th>Binned frames</th>\n");
  fprintf (out, "<th>Masks</th>\n");
  fprintf (out, "<th>Others</th>\n");
  fprintf (out, "</tr>\n");
  fprintf (out, "</thead>\n");

  fprintf (out, "<tbody>\n");

  while (read_segment (in, &s))
    {
      if (s.run == run && s.rerun == rerun && s.camcol == camcol)
	{
	  for (field = s.field; field < s.field + s.nfields; field++)
	    {
	      fprintf (out, "<tr>\n");

	      fprintf (out, "<td>\n");
	      printf("<a href=\"%s/field?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d\">%d</a>\n",
		     config.cgi_url, s.run, s.rerun, s.camcol, field, field);
	      fprintf (out, "</td>\n");

	      fprintf (out, "<td class=\"zoom\">\n");
	      (void) snprintf(zoom_fn, MAX_PATH_LENGTH, 
		       "%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg",
		       config.imaging_root, run, zoom_rerun, camcol, run, camcol,
		       zoom_rerun, field, zoom);
	      /* If the zoom isn't available in the requested rerun, try and find
		 a zoom from another rerun. */
	      if (!file_readable(zoom_fn)) 
		{
		  for (zoom_rerun = 49; zoom_rerun >= 0; zoom_rerun--) {
		    (void) snprintf(zoom_fn, MAX_PATH_LENGTH, 
				    "%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg",
				    config.imaging_root, run, zoom_rerun, camcol, run, camcol,
				    zoom_rerun, field, zoom);
		    if (file_readable(zoom_fn)) break;
		  }
		}
	      
	      if (file_readable(zoom_fn))
		{
		  fprintf (out,
			   "<a href=\"%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z00.jpeg\"/>\n",
			   config.imaging_url, run, zoom_rerun, camcol, run, camcol,
			   zoom_rerun, field);
		  fprintf (out,
			   "<img class=\"zoom\" src=\"%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg\" alt=\"Field %d\" />\n",
			   config.imaging_url, run, zoom_rerun, camcol, run, camcol,
			   zoom_rerun, field, zoom, field);
		  fprintf (out,"</a>\n");
		}
	      else 
		{
		  fprintf (out,"<p>No image available</p>");
		}
	      fprintf (out, "</td>\n");

	      fprintf (out, "<td>");
	      fprintf (out, "<table class=\"corr\">\n<thead>\n");
	      fprintf (out, "</thead><tbody>");
	      for (i = 0; i < num_filters; i++)
		{
		  (void) snprintf (filename, MAX_PATH_LENGTH,
			    "fpC-%06d-%c%d-%04d.fit.gz", run, filter[i],
			    camcol, field);
		  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/corr/%d", run,
			    rerun, camcol);
		  fprintf (out,"<tr><th>%c</th>", filter[i]);
		  (void) checked_link (config.imaging_url, config.imaging_root, 
				       dirname, filename, filelink, MAX_PATH_LENGTH);
		  fprintf (out, "<td>%s</td></tr>\n", filelink);
		}
	      fprintf (out, "</tbody>\n</table>\n");
	      fprintf (out, "</td>");

	      fprintf (out, "<td>");
	      fprintf (out, "<table class=\"bin\">\n<thead>\n");
	      fprintf (out, "</thead><tbody>");
	      for (i = 0; i < num_filters; i++)
		{
		  (void) snprintf (filename, MAX_PATH_LENGTH,
			    "fpBIN-%06d-%c%d-%04d.fit", run, filter[i],
			    camcol, field);
		  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d", run,
			    rerun, camcol);
		  fprintf (out,"<tr><th>%c</th>", filter[i]);
		  (void) checked_link (config.imaging_url, config.imaging_root, 
				       dirname, filename, filelink, MAX_PATH_LENGTH);
		  fprintf (out, "<td>%s</td></tr>\n", filelink);
		}
	      fprintf (out, "</tbody>\n</table>\n");
	      fprintf (out, "</td>");

	      fprintf (out, "<td>");
	      fprintf (out, "<table class=\"mask\">\n<thead>\n");
	      fprintf (out, "</thead><tbody>");
	      for (i = 0; i < num_filters; i++)
		{
		  (void) snprintf (filename, MAX_PATH_LENGTH,
			    "fpM-%06d-%c%d-%04d.fit", run, filter[i], camcol,
			    field);
		  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d", run,
			    rerun, camcol);
		  fprintf (out,"<tr><th>%c</th>", filter[i]);
		  (void) checked_link (config.imaging_url, config.imaging_root, 
				       dirname, filename, filelink, MAX_PATH_LENGTH);
		  fprintf (out, "<td>%s</td></tr>\n", filelink);
		}
	      fprintf (out, "</tbody>\n</table>\n");
	      fprintf (out, "</td>");

	      fprintf (out, "<td><table class=\"field-misc\">\n<thead>\n");
	      fprintf (out, "</thead><tbody>");

	      (void) snprintf (filename, MAX_PATH_LENGTH,
			"drObj-%06d-%d-%d-%04d.fit", run, camcol, rerun,
			field);
	      (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/dr/%d",
			run, rerun, camcol);
	      link_okay = checked_link (config.imaging_url, config.imaging_root, 
				   dirname, filename, filelink, MAX_PATH_LENGTH);
	      if (!link_okay)
		{
		  (void) snprintf (filename, MAX_PATH_LENGTH,
				   "tsObj-%06d-%d-%d-%04d.fit", run, camcol, rerun,
				   field);
		  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",
				   run, rerun, camcol);
		  (void) checked_link (config.imaging_url, config.imaging_root, 
					    dirname, filename, filelink, MAX_PATH_LENGTH);
		}
	      fprintf (out,
		       "<tr><th align=\"right\">Calibrated object catalog</th>\n");
	      fprintf (out, "<td>%s</td>\n", filelink);
	      fprintf (out, "</tr>\n");

	      (void) snprintf (filename, MAX_PATH_LENGTH,
			"drField-%06d-%d-%d-%04d.fit", run, camcol, rerun,
			field);
	      (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/dr/%d",
			run, rerun, camcol);
	      link_okay = checked_link (config.imaging_url, config.imaging_root, 
				   dirname, filename, filelink, MAX_PATH_LENGTH);
	      if (!link_okay)
		{
		  (void) snprintf (filename, MAX_PATH_LENGTH,
				   "tsField-%06d-%d-%d-%04d.fit", run, camcol, rerun,
				   field);
		  (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",
				   run, rerun, camcol);
		  (void) checked_link (config.imaging_url, config.imaging_root, 
					    dirname, filename, filelink, MAX_PATH_LENGTH);

		}
	      fprintf (out,
		       "<tr><th align=\"right\">Field calibration and statistics</th>\n");
	      fprintf (out, "<td>%s</td>\n", filelink);
	      fprintf (out, "</tr>\n");

	      (void) snprintf (filename, MAX_PATH_LENGTH, "fpAtlas-%06d-%d-%04d.fit",
			run, camcol, field);
	      (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d", run,
			rerun, camcol);
	      fprintf (out, "<tr><th align=\"right\">Atlas images</th>\n");
	      (void) checked_link (config.imaging_url, config.imaging_root, 
				   dirname, filename, filelink, MAX_PATH_LENGTH);
	      fprintf (out, "<td>%s</td>\n", filelink);
	      fprintf (out, "</tr>\n");

	      (void) snprintf (filename, MAX_PATH_LENGTH, "psField-%06d-%d-%04d.fit",
			run, camcol, field);
	      (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d", run,
			rerun, camcol);
	      fprintf (out,
		       "<tr><th align=\"right\">Prelimary calib. and final PSF fit</th>\n");
	      (void) checked_link (config.imaging_url, config.imaging_root, 
				   dirname, filename, filelink, MAX_PATH_LENGTH);
	      fprintf (out, "<td>%s</td>\n", filelink);
	      fprintf (out, "</tr>\n");

	      (void) snprintf (filename, MAX_PATH_LENGTH, "fpObjc-%06d-%d-%04d.fit",
			run, camcol, field);
	      (void) snprintf (dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d", run,
			rerun, camcol);
	      fprintf (out,
		       "<tr><th align=\"right\">Uncalibrated object catalog</th>\n");
	      (void) checked_link (config.imaging_url, config.imaging_root, 
				   dirname, filename, filelink, MAX_PATH_LENGTH);
	      fprintf (out, "<td>%s</td>\n", filelink);
	      fprintf (out, "</tr>\n");
	      fprintf (out, "</tbody>\n</table>\n");
	      fprintf (out, "</td>");

	      fprintf (out, "</tr>");
	    }
	}
    }

  fprintf (out, "</tbody>\n");
  fprintf (out, "</table>\n");
  fprintf (out, "</div>\n");

  fprintf (out, "</body>\n");
  fprintf (out, "</html>");
}
