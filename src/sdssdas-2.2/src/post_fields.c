/*! @file post_fields.c
 * @brief Generate a table of field parameters from multipart/form-data
 *
 * Read data from a multipart/form-data message and produce a 
 * tab separated value (tsv) table listing the fields specified
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
#include "segmentlist_table.h"
#include "seglist_overlap.h"

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
  static bool cone_cas_format = false;   /* use the CAS IQS column format */
  static bool prox_cas_format = false;   /* use the CAS IQS column format */
  int run = 0; /* run read */
  int rerun = 0; /* rerun read */
  int camcol = 0; /* camcol read */
  int field  = 0; /* field read */
  int nfields = 1; /* nfields read */
  int elements = 0; /* elements supplied by the user */
  int obj = 0; /* the object number (ignored) */
  double ra = 0.0; /* the ra (ignored)*/
  double dec = 0.0; /* the dec (ignored)*/

  if (lines_encountered == 0) 
    {
      fprintf(output,"#run\trerun\tcamcol\tfield\tnfields\n");
    }

  lines_encountered++;

  /* ignore CAS generated column headings */
  if (lines_encountered == 1 && strcmp(line,"run,rerun,camcol,field") == 0)
    {
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"run,rerun,camcol,field,nfields") == 0)
    {
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"run,rerun,camCol,field,obj,filter") == 0)
    {
      cone_cas_format = true;
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"run,rerun,camCol,field,obj") == 0)
    {
      cone_cas_format = true;
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"ra,dec,run,rerun,camCol,field,obj,filter") == 0)
    {
      prox_cas_format = true;
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"ra,dec,run,rerun,camCol,field,obj") == 0)
    {
      prox_cas_format = true;
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

  if (cone_cas_format)
    {
      nfields = 1;
      elements = sscanf(line, "%d,%d,%d,%d,%d", 
			&run, &rerun, &camcol, &field, &obj);
    }
  else if (prox_cas_format)
    {
      nfields = 1;
      elements = sscanf(line, "%f,%f,%d,%d,%d,%d,%d", 
			&ra, &dec, &run, &rerun, &camcol, &field, &obj);
    }
  else
    {
      elements = sscanf(line, "%d%d%d%d%d", 
			&run, &rerun, &camcol, &field, &nfields);
    }

  /* if input is not white space separated, try commas */
  if (elements < 2) 
    {
      elements = sscanf(line, "%d,%d,%d,%d,%d", 
			&run, &rerun, &camcol, &field, &nfields);
    }
  
  if (elements < 5) nfields = 1;
  if (elements < 4) 
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

  fprintf(output,"%d\t%d\t%d\t%d\t%d\n",
	  run, rerun, camcol, field, nfields);

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
  int run = 0; /* run read */
  int camcol = 0; /* camcol read */
  int field  = 0; /* field read */
  int nfields = 1; /* nfields read */
  int elements = 0; /* elements supplied by the user */

  if (lines_encountered == 0) 
    {
      fprintf(output,"#run\trerun\tcamcol\tfield\tnfields\n");
    }

  lines_encountered++;

  /* ignore CAS generated column headings */
  if (lines_encountered == 1 && strcmp(line,"run,camcol,field") == 0)
    {
      return false;
    }
  if (lines_encountered == 1 && strcmp(line,"run,camcol,field,nfields") == 0)
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
		    &run, &camcol, &field, &nfields);
  /* if input is not white space separated, try commas */
  if (elements < 2) 
    {
      elements = sscanf(line, "%d,%d,%d,%d", 
			&run, &camcol, &field, &nfields);
    }
  
  if (elements < 4) nfields = 1;
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


  fprintf(output,"%d\t0\t%d\t%d\t%d\n",
	  run, camcol, field, nfields);

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
  char unsorted_contents_fn[MAX_LINE_LENGTH]; /* file name for file with unsorted contents */
  char contents_fn[MAX_LINE_LENGTH]; /* file name for file with sorted contents */
  char full_contents_fn[MAX_LINE_LENGTH]; /* file name for file with sorted contents, including non-overlaps */
  char dataset_fn[MAX_LINE_LENGTH]; /* file name for file definig the data set */
  int fn_length; /* length of most recently constructed file name */
  FILE *unsorted_contents; /* the file with the unsorted contents */
  FILE *contents; /* the file with the sorted contents */
  FILE *full_contents; /* the file with the sorted contents, including non-overlaps */
  FILE *dataset_file; /* the file defining the data set */
  int fclose_return; /* return value of fclose (0 if okay) */
  int dataset = 0;     /* the data set from which to select data */

  printf ("Content-Type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf ("<html>\n");
  printf ("<head><title>User Posted Field List</title></head>\n");
  printf ("<body>\n");
  fflush(stdout);

  fp = stdin;

  read_config(&config, DAS_CONFIG_FILE);
  lines_processed = process_post (fp, 
				  print_line, print_line_rerun, 
				  config, list_id, &dataset);

  /* Make sure we have a valid data set */
  switch (dataset)
    {
    case 10:
    case 20:
    case 30:
    case 40:
    case 50:
    case 60:
    case 70:
    case 11:
    case 21:
    case 31:
    case 41:
    case 51:
    case 61:
    case 71:
    case 72:
    case 73:
    case 74:
    case 75:
    case 99:
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
  fn_length = snprintf(full_contents_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/full_contents.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);
  fn_length = snprintf(contents_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/contents.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);

  unsorted_contents = fopen(unsorted_contents_fn, "r");
  if (unsorted_contents == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for reading\n", 
	      unsorted_contents_fn);
      exit(EXIT_FAILURE);
    }

  full_contents = fopen(full_contents_fn, "w");
  if (full_contents == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for writing\n", full_contents_fn);
      exit(EXIT_FAILURE);
    }

  merge_segments(unsorted_contents, full_contents);

  fclose_return = fclose(unsorted_contents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", 
	      unsorted_contents_fn);
      exit(EXIT_FAILURE);
    }

  (void) fflush(full_contents);
  fclose_return = fclose(full_contents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", full_contents_fn);
      exit(EXIT_FAILURE);
    }

  fprintf(stderr,"dataset is %d\n", dataset);

  /* Create the sorted TSV list containing only data from the specified set */
  if (dataset == 0)
    link(full_contents_fn, contents_fn);
  else 
    {
      fn_length = snprintf(dataset_fn, MAX_LINE_LENGTH,
			   "%s/dr-%d.tsv",
			   config.drdefs_root, dataset);
      assert(fn_length < MAX_LINE_LENGTH);      
      dataset_file = fopen(dataset_fn, "r");
      fn_length = snprintf(contents_fn, MAX_LINE_LENGTH,
			   "%s/userlist-%s/contents.tsv",
			   config.scratch_root, list_id);
      assert(fn_length < MAX_LINE_LENGTH);      
      contents = fopen(contents_fn, "w");

      full_contents = fopen(full_contents_fn, "r");
      if (full_contents == NULL) 
	{
	  fprintf(stderr,"SDSSDAS could not open %s for reading\n", 
		  full_contents_fn);
	  exit(EXIT_FAILURE);
	}
      if (contents == NULL) 
	{
	  fprintf(stderr,"SDSSDAS could not open %s for writing\n",
		  contents_fn);
	  exit(EXIT_FAILURE);
	}
      if (dataset_file == NULL) 
	{
	  fprintf(stderr,"SDSSDAS could not open %s for reading\n",
		  dataset_fn);
	  exit(EXIT_FAILURE);
	}

      seglist_overlap(full_contents, dataset_file, contents);

      fclose_return = fclose(full_contents);
      if (fclose_return != 0) 
	{
	  fprintf(stderr,"SDSSDAS error closing %s\n", full_contents_fn);
	  exit(EXIT_FAILURE);
	}
      fclose_return = fclose(contents);
      if (fclose_return != 0) 
	{
	  fprintf(stderr,"SDSSDAS error closing %s\n", contents_fn);
	  exit(EXIT_FAILURE);
	}
      (void) fflush(dataset_file);
      fclose_return = fclose(dataset_file);
      if (fclose_return != 0) 
	{
	  fprintf(stderr,"SDSSDAS error closing %s\n", dataset_fn);
	  exit(EXIT_FAILURE);
	}
    }

  printf ("<h1>User defined fields list</h1>\n" );

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
  printf ("<p class=\"left\">You can use <a href=\"%s/dl_request_form?list=%s\">", config.cgi_url, list_id);
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
  segmentlist_table(contents, stdout, list_id, config);
  fclose_return = fclose(contents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", contents_fn);
      exit(EXIT_FAILURE);
    }
  
  printf ("</body>\n");
  printf ("</html>\n");
  exit(EXIT_SUCCESS);
}
