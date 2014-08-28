/** @file imlist.c
 * @brief CGI program to list the segments in an uploaded spectroscopic data list
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "das_config.h"
#include "post_utils.h"
#include "spectro_post.h"


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

  int plate = 0; /* plate number read */
  int mjd = 0; /* mjd read */
  int rerun = 0; /* rerun read */
  int fiber = 0; /* fiber read */
  int nfibers = 0; /* fibers printed */

  char *read_check;		/* a pointer to the read string returned by fgets */
  char line[SP_TSV_LINE_LENGTH];	/* a buffer of the line input */
  int cols_read; /* the columns read from a scanned line */

  char url[MAX_URLBASE_LENGTH]; /* url of page giving a fiber overview */

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
  printf ("<head><title>User Posted Fiber List</title></head>\n");
  printf ("<body>\n");

  printf ("<h1>User defined fiber list</h1>\n" );

  /* Print list summary */
  printf ("<h2>List summary</h2>\n");
  printf ("<table class=\"list-summary\">\n");
  printf ("<tr><th>List serial number</th><td>%s</td></tr>\n", list_id);
  printf ("</table>\n");
  

  /* Download choices */
  printf ("<h2>Download selection</h2>\n");
  printf ("<p>You can use <a href=\"%s/spdl_request_form?list=%s\">", config.cgi_url, list_id);
  printf ("this form</a> to generate lists of files that can be used by wget or rsync for\n");
  printf ("mass retrieval of data. It allows selection of specific filters, \n");
  printf ("types of files for download, and download method.</p>");

  /* Print a table of uploaded segments */
  printf ("<h2>Contents of the list</h2>\n");
  contents = fopen(contents_fn, "r");
  if (contents == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for reading\n", contents_fn);
      exit(EXIT_FAILURE);
    }

  printf ("<table class=\"fiber-list\">\n");
  printf ("<thead>\n");
  printf ("<tr class=\"top\">\n");
  printf ("<th>link</th>\n");
  printf ("<th>plate</th>\n");
  printf ("<th>MJD</th>\n");
  printf ("<th>rerun</th>\n");
  printf ("<th>fiber</th>\n");
  printf ("</tr>\n");
  printf ("</thead>\n");
  nfibers = 0;
  do
    {
      read_check = fgets (line, SP_TSV_LINE_LENGTH, contents);
      cols_read = (read_check == line && (line[0] != '#')) ? 
	sscanf(line, "%d%d%d%d", &plate, &mjd, &rerun, &fiber) : 0;
      if (cols_read == 4)
	{
	  nfibers++;
	  if (nfibers <= MAX_TABLE_LENGTH)
	    {
	      printf("<tr class=\"fiber\">\n");
	      (void) snprintf(url, MAX_URLBASE_LENGTH,
			      "%s/fiber?PLATE=%d&MJD=%d&RERUN=%d&FIBER=%d",
			      config.cgi_url, plate, mjd, rerun, fiber);	      
	      printf("<td><a href=\"%s\">%s</a></td>",url,url);
	      printf("<td class=\"plate\">%d</td>",plate);
	      printf("<td class=\"mjd\">%d</td>",mjd);
	      printf("<td class=\"rerun\">%d</td>",rerun);
	      printf("<td class=\"fiber\">%d</td>",fiber);
	      printf("</tr>\n");
	    }
	}
    }
  while(read_check == line); 
  printf ("</table>\n");

  fclose_return = fclose(contents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", contents_fn);
      exit(EXIT_FAILURE);
    }
  
  if (nfibers > MAX_TABLE_LENGTH)
    printf("<p>plus %d more fibers.</p>\n",nfibers-MAX_TABLE_LENGTH);

  printf ("</body>\n");
  printf ("</html>\n");

  exit (EXIT_SUCCESS);

}
