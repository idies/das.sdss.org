/** @file segments.c
 * @brief CGI program show data on a segment
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "das_config.h"
#include "segments.h"
#include "segment_table.h"

/*! cgi progam to generate a web page describing a segment
 */
int
main (void)
{
  char *query;			/* the user (web server) supplied query */
  int run;			/* the run of the segment to list */
  int rerun;			/* the rerun of the segment to list */
  int camcol;			/* the camcol of the segment to list */
  int zoom;			/* the requested zoom level */
  das_config config;		/* the DAS configuration */
  int read_params;		/* number of parameters read from user */
  char list_id[7];		/* the list ID */

  char contents_fn[MAX_PATH_LENGTH];	/* file name for file with sorted contents */
  int fn_length;		/* length of most recently constructed file name */
  FILE *contents;		/* the file with the sorted contents */

  int fclose_return;            /* return value from fclose, checked for errors */

  int field = 11;               /* the field from which to try to get the stripe */
  char xxField_fname[MAX_PATH_LENGTH];	/* the fully qualified name of the tsField */
  FILE *xxField = NULL;         /* file pointer to the tsFiled file */
  int stripe = -99;             /* the strip */
  char strip = 'Z';             /* the stripe */
  int hcard_index = 0;          /* how many lines we have read from the header */
  char hcard[81];               /* the header line read */
  size_t bytes_read;            /* bytes read for header card */
  int values_read;              /* values read from headre card */

  read_config(&config, DAS_CONFIG_FILE);

  /* read and parse get query */
  query = getenv ("QUERY_STRING");
  if (query == NULL)
    {
      exit(EXIT_FAILURE);
    }
  list_id[6] = '\0';
  read_params = sscanf (query, 
			"LIST=%6[0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]&RUN=%d&RERUN=%d&CAMCOL=%d&ZOOM=%d",
			list_id, &run, &rerun, &camcol, &zoom);
  if (read_params < 4)
    {
      exit (EXIT_FAILURE);
    }
  if (read_params < 5)
    {
      zoom = 30;
    }

  /* open the contents list */
  fn_length = snprintf (contents_fn, MAX_PATH_LENGTH,
			"%s/userlist-%s/contents.tsv",
			config.scratch_root, list_id);
  assert (fn_length < MAX_PATH_LENGTH);
  contents = fopen (contents_fn, "r");
  if (contents == NULL)
    {
      fprintf (stderr, "SDSSDAS could not open %s for writing\n",
	       contents_fn);
      exit (EXIT_FAILURE);
    }

  /* Print html header */
  printf ("Content-type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf ("<head><title>SDSS Run %d, Rerun %d, Camcol %d</title></head>\n",
	  run, rerun, camcol);
  printf ("<body>\n");
  printf ("<h1>SDSS Run %d, Rerun %d, Camcol %d", run, rerun, camcol);

  /* Try to get the strip and stripe */
  for (field = 11; field < 800; field++) 
    {
      (void) snprintf(xxField_fname, MAX_PATH_LENGTH, 
		      "%s/%d/%d/dr/%d/drField-%06d-%d-%d-%04d.fit",
		      config.imaging_root,run,rerun,camcol,run,camcol,rerun,field);  
      xxField = fopen(xxField_fname, "r");
      if (xxField == NULL) 
	{
	  (void) snprintf(xxField_fname, MAX_PATH_LENGTH, 
			  "%s/%d/%d/calibChunks/%d/tsField-%06d-%d-%d-%04d.fit",
			  config.imaging_root,run,rerun,camcol,run,camcol,rerun,field);  
	  xxField = fopen(xxField_fname, "r");
	}
      if (xxField != NULL)
	{
	  for (hcard_index = 0; hcard_index < 35; hcard_index++)
	    {
	      bytes_read = fread (hcard, 1, 80, xxField);
	      values_read = sscanf(hcard, "STRIPE  = %d", &stripe);
	      values_read = sscanf(hcard, "STRIP   = '%c", &strip);
	      if (stripe != -99 && strip != 'Z') 
		{
		  printf(" (%d%c)", stripe, strip);
		  break;
		}
	    }
	  fclose(xxField);
	  if (stripe != -99 && strip != 'Z') break;
	}
    }


  printf ("</h1>\n");

  /* actually print the table */
  segment_table (contents, stdout, run, rerun, camcol, zoom, config);

  /* Print html close */
  printf ("</body>\n");
  printf ("</html>");

  /* close the contents list */
  fclose_return = fclose (contents);
  if (fclose_return != 0)
    {
      fprintf (stderr, "SDSSDAS error closing %s\n", contents_fn);
      exit (EXIT_FAILURE);
    }

  exit (EXIT_SUCCESS);

}
