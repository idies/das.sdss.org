/** @file imlist.c
 * @brief CGI program to list the segments in an uploaded imaging list
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

/*! cgi progam to generate a web page describing an upleaded list
 */
int
main (void)
{
  char *query;			/* the user (web server) supplied query */
  das_config config;		/* the DAS configuration */
  int read_params;		/* number of parameters read from user */

  char contents_fn[MAX_PATH_LENGTH];	/* file name for file with sorted contents */
  int fn_length;		/* length of most recently constructed file name */
  FILE *contents;		/* the file with the sorted contents */
  char list_id[7];		/* the list ID */

  int fclose_return;            /* return value from fclose, checked for errors */

  read_config(&config, DAS_CONFIG_FILE);

  /* read and parse get query */
  query = getenv ("QUERY_STRING");
  if (query == NULL)
    {
      exit(EXIT_FAILURE);
    }
  read_params = sscanf (query,
			"list=%6[0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]", 
			list_id); 

  if (read_params < 1)
    {
      exit (EXIT_FAILURE);
    }

  /* open the contents list */
  fn_length = snprintf(contents_fn, MAX_PATH_LENGTH,
		       "%s/userlist-%s/contents.tsv",
		       config.scratch_root, list_id);
  assert (fn_length < MAX_PATH_LENGTH);
  contents = fopen (contents_fn, "r");
  if (contents == NULL)
    {
      fprintf (stderr, "SDSSDAS could not open %s for reading\n",
	       contents_fn);
      exit (EXIT_FAILURE);
    }

  printf ("Content-Type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf ("<html>\n");
  printf ("<head><title>User Posted Field List</title></head>\n");
  printf ("<body>\n");

  printf ("<h1>User defined fields list</h1>\n" );

  /* Print list summary */
  printf ("<h2>List summary</h2>\n");
  printf ("<div class=\"list-summary\">\n");
  printf ("<table class=\"list-summary\">\n");
  printf ("<tr><th>List serial number</th><td>%s</td></tr>\n", list_id);
  printf ("</table>\n");
  printf ("</div>\n");
  
  /* Download choices */
  printf ("<h2>Download selection</h2>\n");
  printf ("<p>You can use <a href=\"%s/dl_request_form?list=%s\">", config.cgi_url, list_id);
  printf ("this form</a> to generate lists of files that can be used by wget or rsync for\n");
  printf ("mass retrieval of data. It allows selection of specific filters, \n");
  printf ("types of files for download, and download method.</p>");

  /* Print a table of uploaded segments */
  printf ("<h2>Contents of the list</h2>\n");
  segmentlist_table(contents, stdout, list_id, config);
  printf ("</body>\n");
  printf ("</html>\n");

  /* close the contents list */
  fclose_return = fclose (contents);
  if (fclose_return != 0)
    {
      fprintf (stderr, "SDSSDAS error closing %s\n", contents_fn);
      exit (EXIT_FAILURE);
    }

  exit (EXIT_SUCCESS);

}
