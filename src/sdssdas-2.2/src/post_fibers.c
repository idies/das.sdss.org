/*! @file post_fibers.c
 * @brief Generate a table of fiber parameters from multipart/form-data
 *
 * Read data from a multipart/form-data message and produce a 
 * tab separated value (tsv) table listing the fibers specified
 * in the message.
 *  
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "das_config.h"
#include "post_utils.h"
#include "spectro_post.h"

/*! Process a line of input
 * 
 * @param line an input string
 * @param config the structure holding the DAS configuration
 * @param output the file to which the result of the line will be written
 * @param list_id the serial number of the output file
 * @return true if the line was processed successfully
 */
static bool
print_line_rerun (char *line, das_config /*@unused@*/ config, FILE *output, char /*@unused@*/ *list_id)
{
  static int lines_encountered = 0; /* number of lines encountered */
  int plate = 0; /* plate number read */
  int mjd = 0; /* mjd read */
  int rerun = 0; /* rerun read */
  int fiber = 0; /* fiber read */
  int elements = 0; /* elements supplied by the user */

  if (lines_encountered == 0) 
    {
      fprintf(output,"#plate\tMJD\trerun\tfiber\n");
    }

  lines_encountered++;
  /* ignore CAS generated column headings */
  if (lines_encountered == 1 && strcmp(line,"plate,mjd,rerun") == 0)
    {
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"plate,mjd,rerun,fiberID") == 0)
    {
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"plate,mjd,rerun,fiberid") == 0)
    {
      return false;
    }

  /* get rid of extra white space */
  while (strlen (line) > 0
	 && (line[strlen (line) - 1] == ' '
	     || line[strlen (line) - 1] == '\t'))
    {
      line[strlen (line) - 1] = '\0';
    }

  /* if the line has nothing in it, ignore it */
  if (strlen(line) == 0)
    return true;

  elements = sscanf(line, "%d%d%d%d", 
		    &plate, &mjd, &rerun, &fiber);
  /* if input is not white space separated, try commas */
  if (elements < 3) 
    {
      elements = sscanf(line, "%d,%d,%d,%d", 
		    &plate, &mjd, &rerun, &fiber);
    }

  if (elements < 3) 
    {
      if (line[0] != '#' && strlen(line) > 0)
	{
	  printf("<em>Error parsing line %d; line was:</em><br>\n",
		 lines_encountered); 
	  (void) cgi_protect(line);
	  printf("<pre>%s</pre><br>\n", line); 
	}
      return false;
    }

  if (elements == 3)
    {
      for (fiber = 1; fiber<641; fiber++)
	{
	  fprintf(output,"%d\t%d\t%d\t%d\n",
		  plate, mjd, rerun, fiber);
	}     
    }
  else 
    {
      fprintf(output,"%d\t%d\t%d\t%d\n",
	      plate, mjd, rerun, fiber);
    }

  return true;
}

/*! Process a line of input
 * 
 * @param line an input string
 * @param config the structure holding the DAS configuration
 * @param output the file to which the result of the line will be written
 * @param list_id the serial number of the output file
 * @return true if the line was processed successfully
 */
static bool
print_line (char *line, das_config /*@unused@*/ config, FILE *output, char /*@unused@*/ *list_id)
{
  static int lines_encountered = 0; /* number of lines encountered */
  int plate = 0; /* plate number read */
  int mjd = 0; /* mjd read */
  int fiber = 0; /* fiber read */
  int elements = 0; /* elements supplied by the user */

  if (lines_encountered == 0) 
    {
      fprintf(output,"#plate\tMJD\tfiber\n");
    }

  lines_encountered++;
  /* ignore CAS generated column headings */
  if (lines_encountered == 1 && strcmp(line,"plate,mjd") == 0)
    {
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"plate,mjd,fiberID") == 0)
    {
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"plate,mjd,fiberid") == 0)
    {
      return false;
    }

  /* get rid of extra white space */
  while (strlen (line) > 0
	 && (line[strlen (line) - 1] == ' '
	     || line[strlen (line) - 1] == '\t'))
    {
      line[strlen (line) - 1] = '\0';
    }

  /* if the line has nothing in it, ignore it */
  if (strlen(line) == 0)
    return true;

  elements = sscanf(line, "%d%d%d", 
		    &plate, &mjd, &fiber);
  /* if input is not white space separated, try commas */
  if (elements < 2) 
    {
      elements = sscanf(line, "%d,%d,%d", 
		    &plate, &mjd, &fiber);
    }

  if (elements < 2) 
    {
      if (line[0] != '#' && strlen(line) > 0)
	{
	  printf("<em>Error parsing line %d; line was:</em><br>\n",
		 lines_encountered); 
	  (void) cgi_protect(line);
	  printf("<pre>%s</pre><br>\n", line); 
	}
      return false;
    }

  if (elements == 2)
    {
      for (fiber = 1; fiber<641; fiber++)
	{
	  fprintf(output,"%d\t%d\t%d\n",
		  plate, mjd, fiber);
	}     
    }
  else 
    {
      fprintf(output,"%d\t%d\t%d\n",
	      plate, mjd, fiber);
    }

  return true;

}

/*! Read a multipart/form-data submission and write a tsv table of parameters
 */
int
main (void)
{
  FILE *fp;			/* file pointer from which to read input */
  int lines_processed;          /* the number of lines processed */
  das_config config;            /* the DAS configuration */
  char list_id[7];              /* user list id */
  char unsorted_contents_fn[MAX_LINE_LENGTH]; /* file name for file defining the data set */
  char contents_fn[MAX_LINE_LENGTH]; /* file name for file defining the data set */
  int fn_length; /* length of most recently constructed file name */
  FILE *unsorted_contents; /* the file with the unsorted contents */
  FILE *contents; /* the file with the unsorted contents */
  int fclose_return; /* return value of fclose (0 if okay) */
  int dataset = 0;     /* the data set from which to select data */
  char dataset_fn[MAX_LINE_LENGTH]; /* file name for file definig the data set */
  FILE *dataset_file; /* the file defining the data set */
  int rerun[NUM_PLATES]; /* an array holding the rerun numbers for the data set */
  int read_rerun = 0; /* the rerun read from the line examined */
  int plate = 0; /* the plate if the line being examined */
  int mjd = 0; /* the mjd of the line being examined */
  int fiber = 0; /* the fiber of the line being examined */
  char line[SP_TSV_LINE_LENGTH];	/* a buffer of the line input */
  char *read_check;		/* a pointer to the read string returned by fgets */
  int cols_read; /* the columns read from a scanned line */
  int nfibers = 0; /* the number of fibers encountered */
  char url[MAX_URLBASE_LENGTH]; /* url of page giving a fiber overview */

  printf ("Content-Type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf ("<html>\n");
  printf ("<head><title>User Posted Fiber List</title></head>\n");
  printf ("<body>\n");
  (void) fflush(stdout);

  fp = stdin;

  read_config(&config, DAS_CONFIG_FILE);
  lines_processed = process_post (fp, 
				  print_line, print_line_rerun, 
				  config, list_id, &dataset);

  /* Make sure we have a valid data set */
  switch (dataset)
    {
    case 7:
    case 6:
    case 5:
    case 0:
      break;
    default:
      dataset = 0;
    }

  /* Create the sorted TSV list */

  fn_length = snprintf(unsorted_contents_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/orig_contents.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);
  fn_length = snprintf(contents_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/contents.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);

  /* Create the TSV list containing only data from the specified set */
  if (dataset == 0)
    (void) link(unsorted_contents_fn, contents_fn);
  else 
    {
      for(plate=0; plate<NUM_PLATES; plate++)
	rerun[plate]=-1;

      /* Read the reference file */
      fn_length = snprintf(dataset_fn, MAX_LINE_LENGTH,
			   "%s/spdr-%d.tsv",
			   config.drdefs_root, dataset);
      assert(fn_length < MAX_LINE_LENGTH);      
      dataset_file = fopen(dataset_fn, "r");
      if (dataset_file == NULL) 
	{
	  fprintf(stderr,"SDSSDAS could not open %s for reading\n", 
		  dataset_fn);
	  exit(EXIT_FAILURE);
	}      
      do
	{
	  read_check = fgets (line, SP_TSV_LINE_LENGTH, dataset_file);
	  cols_read = (read_check == line && (line[0] != '#')) ? 
	    sscanf(line, "%d%d%d", &plate, &mjd, &read_rerun) : 0;
	  if (cols_read == 3)
	    rerun[plate]=read_rerun;
	}
      while(read_check == line); 
      fclose_return = fclose(dataset_file);
      if (fclose_return != 0) 
	{
	  fprintf(stderr,"SDSSDAS error closing %s\n", dataset_fn);
	  exit(EXIT_FAILURE);
	}

      /* Go through the supplied lines */
      unsorted_contents = fopen(unsorted_contents_fn, "r");
      if (unsorted_contents == NULL) 
	{
	  fprintf(stderr,"SDSSDAS could not open %s for reading\n", 
		  unsorted_contents_fn);
	  exit(EXIT_FAILURE);
	}
      contents = fopen(contents_fn, "w");
      if (contents == NULL) 
	{
	  fprintf(stderr,"SDSSDAS could not open %s for writing\n", 
		  contents_fn);
	  exit(EXIT_FAILURE);
	}
      fprintf(contents,"#plate\tMJD\trerun\tfiber\n");
      do
	{
	  read_check = fgets (line, SP_TSV_LINE_LENGTH, unsorted_contents);
	  cols_read = (read_check == line && (line[0] != '#')) ? 
	    sscanf(line, "%d%d%d", &plate, &mjd, &fiber) : 0;
	  if ((cols_read == 3) && (rerun[plate] > -1))
	    {
	      fprintf(contents,"%d\t%d\t%d\t%d\n", plate, mjd, rerun[plate], fiber);
	    }
	}
      while(read_check == line); 
      fclose_return = fclose(contents);
      if (fclose_return != 0) 
	{
	  fprintf(stderr,"SDSSDAS error closing %s\n", contents_fn);
	  exit(EXIT_FAILURE);
	}
      (void) fflush(contents);

      fclose_return = fclose(unsorted_contents);
      if (fclose_return != 0) 
	{
	  fprintf(stderr,"SDSSDAS error closing %s\n", 
		  unsorted_contents_fn);
	  exit(EXIT_FAILURE);
	}
    }

  printf ("<h1>User defined fiber list</h1>\n" );

  /* Print list summary */
  printf ("<h2>List summary</h2>\n");
  printf ("<div class=\"list-summary\">\n");
  printf ("<table class=\"list-summary\">\n");
  printf ("<tr><th>List serial number</th><td>%s</td></tr>\n", list_id);
  printf ("<tr><th>Input lines processed</th><td>%d</td></tr>\n", lines_processed);
  printf ("</table>\n");
  printf ("</div>\n");
  

  /* Download choices */
  printf ("<h2>Download selection</h2>\n");
  printf ("<p class=\"left\">You can use <a href=\"%s/spdl_request_form?list=%s\">", config.cgi_url, list_id);
  printf ("this form</a> to generate lists of files that can be used by wget for\n");
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

  printf ("<div class=\"fiber-list\">\n");
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
	sscanf(line, "%d%d%d%d", &plate, &mjd, &read_rerun, &fiber) : 0;
      if (cols_read == 4)
	{
	  nfibers++;
	  if (nfibers <= MAX_TABLE_LENGTH)
	    {
	      printf("<tr class=\"fiber\">\n");
	      (void) snprintf(url, MAX_URLBASE_LENGTH,
			      "%s/fiber?PLATE=%d&MJD=%d&RERUN=%d&FIBER=%d",
			      config.cgi_url, plate, mjd, read_rerun, fiber);	      
	      printf("<td><a href=\"%s\">%s</a></td>",url,url);
	      printf("<td class=\"plate\">%d</td>",plate);
	      printf("<td class=\"mjd\">%d</td>",mjd);
	      printf("<td class=\"rerun\">%d</td>",read_rerun);
	      printf("<td class=\"fiber\">%d</td>",fiber);
	      printf("</tr>\n");
	    }
	}
    }
  while(read_check == line); 
  printf ("</table>\n");
  printf ("</div>\n");

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
  exit(EXIT_SUCCESS);
}
