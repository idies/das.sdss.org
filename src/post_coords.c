/*! @file post_coords.c
 * @brief Generate a table of fiber parameters from multipart/form-data
 *
 * Read data from a multipart/form-data message and produce a 
 * tab separated value (tsv) table listing the coords specified
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
#include "foot_post.h"
#include "find_fields.h"
#include "merge_segments.h"

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
  double ra = 0.0; /* RA in decimal degrees */
  double dec = 0.0; /* Dec in decimal degrees */
  int elements = 0; /* elements supplied by the user */

  if (lines_encountered == 0) 
    {
      fprintf(output,"#ra\tdec\n");
    }

  lines_encountered++;
  /* ignore CAS generated column headings */
  if (lines_encountered == 1 && strcmp(line,"ra,dec") == 0)
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

  elements = sscanf(line, "%lf%lf", &ra, &dec);

  /* if input is not white space separated, try commas */
  if (elements < 2) 
    elements = sscanf(line, "%lf,%lf", &ra, &dec);

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
    fprintf(output, "%f\t%f\n", ra, dec);

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
  char coord_field_fn[MAX_LINE_LENGTH]; /* file name for file with the coords and fields  */
  char contents_fn[MAX_LINE_LENGTH]; /* file name for file with the field data only  */
  char rdcontents_fn[MAX_LINE_LENGTH]; /* file name for file with the field data only, duplicates removed  */
  int fn_length; /* length of most recently constructed file name */
  FILE *unsorted_contents; /* the file with the unsorted contents */
  FILE *coord_field; /* the file with the unsorted contents */
  FILE *contents; /* the file with the contents */
  FILE *rdcontents; /* the file with the contents sorted with duplicates removed */
  int fclose_return; /* return value of fclose (0 if okay) */
  int dataset = 0;     /* the data set from which to select data */
  char dataset_fn[MAX_LINE_LENGTH]; /* file name for file definig the data set */
  FILE *dataset_file; /* the file defining the data set */
  char line[FT_TSV_LINE_LENGTH];	/* a buffer of the line input */
  char *read_check;		/* a pointer to the read string returned by fgets */
  int cols_read; /* the columns read from a scanned line */
  int ncoords = 0; /* the number of coords encountered */
  char url[MAX_URLBASE_LENGTH]; /* url of page giving a fiber overview */
  int return_code = 0; /* return code from segment loading */
  segment_def *seg_defs = NULL; /* segment definition structure */
  int num_segs = 0; /* number of segment defs in the structure */
  field_node_pointer f0 = NULL; /* pointer to the list of field nodes */
  field_node /*@dependent@*/ *f = NULL; /* pointer to the current field node */
  double ra, dec; /* ra and dec provided */

  printf ("Content-Type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf ("<html>\n");
  printf ("<head><title>User Posted Coordinate List</title></head>\n");
  printf ("<body>\n");
  (void) fflush(stdout);

  fp = stdin;

  read_config(&config, DAS_CONFIG_FILE);
  lines_processed = process_post (fp, 
				  print_line, print_line, 
				  config, list_id, &dataset);

  /* Create a TSV with the coordinates and fields */

  fn_length = snprintf(unsorted_contents_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/orig_contents.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);
  fn_length = snprintf(coord_field_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/coord_field.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);
  fn_length = snprintf(contents_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/unsorted_contents.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);      
  fn_length = snprintf(rdcontents_fn, MAX_LINE_LENGTH,
		       "%s/userlist-%s/contents.tsv",
		       config.scratch_root, list_id);
  assert(fn_length < MAX_LINE_LENGTH);      

  /* Create the TSV list containing only data from the specified set */

  unsorted_contents = fopen(unsorted_contents_fn, "r");
  if (unsorted_contents == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for reading\n", 
	      unsorted_contents_fn);
      exit(EXIT_FAILURE);
    }
  coord_field = fopen(coord_field_fn, "w");
  if (coord_field == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for writing\n", 
	      coord_field_fn);
      exit(EXIT_FAILURE);
    }
  contents = fopen(contents_fn, "w");
  if (coord_field == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for writing\n", 
	      contents_fn);
      exit(EXIT_FAILURE);
    }


  /* read the reference file */
  fn_length = snprintf(dataset_fn, MAX_LINE_LENGTH,
		       "%s", config.astlimits_fname);
  assert(fn_length < MAX_LINE_LENGTH);      
  return_code = load_segment_defs(dataset_fn, &seg_defs, &num_segs);

  /* write the files with the fields */
  fprintf(coord_field,"#ra\tdec\trun\trerun\tcamcol\tfield\trow\tcol\n");
  fprintf(contents,"#run\trerun\tcamcol\tfield0\tnFields\n");
  do
    {
      read_check = fgets (line, FT_TSV_LINE_LENGTH, unsorted_contents);
      ra = 0.0;
      dec = 0.0;
      cols_read = (read_check == line && (line[0] != '#')) ? 
	sscanf(line, "%lf%lf", &ra, &dec) : 0;
      if (cols_read == 2)
	{
	  (void) matching_fields(ra, dec, seg_defs, num_segs, &f0);
	  for(f = (field_node *)f0; f != NULL; f = (field_node *)f->next)
	    {
	      fprintf(coord_field,"%f\t%f\t%d\t%d\t%d\t%d\t%f\t%f\n",
		     ra, dec, f->run, f->rerun, f->camcol, f->field,
		     f->row, f->col); 	  
	      fprintf(contents,"%d\t%d\t%d\t%d\t1\n",
		     f->run, f->rerun, f->camcol, f->field); 	  
	    }
	  free_field_list(&f0);
	}
    }
  while(read_check == line); 
  
  /* Free the structure loaded from the reference file */
  free(seg_defs);

  fclose_return = fclose(contents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", contents_fn);
      exit(EXIT_FAILURE);
    }
  (void) fflush(contents);
  
  fclose_return = fclose(coord_field);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", coord_field_fn);
      exit(EXIT_FAILURE);
    }
  (void) fflush(coord_field);
  
  fclose_return = fclose(unsorted_contents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", 
	      unsorted_contents_fn);
      exit(EXIT_FAILURE);
    }

  /* Sort the resultant fields */
  contents = fopen(contents_fn, "r");
  if (contents == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for reading\n", contents_fn);
      exit(EXIT_FAILURE);
    }
  rdcontents = fopen(rdcontents_fn, "w");
  if (rdcontents == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for reading\n", rdcontents_fn);
      exit(EXIT_FAILURE);
    }
  merge_segments(contents, rdcontents);
  fclose_return = fclose(rdcontents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", rdcontents_fn);
      exit(EXIT_FAILURE);
    }
  fclose_return = fclose(contents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", contents_fn);
      exit(EXIT_FAILURE);
    }
  


  printf ("<h1>Fields containing specified coordinates</h1>\n" );

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
  printf ("this form</a> to generate lists of files that can be used by wget or rsync for\n");
  printf ("mass retrieval of data. It allows selection of specific filters, \n");
  printf ("types of files for download, and download method.</p>");

  /* Print a table of uploaded segments */
  printf ("<h2>Contents of the list</h2>\n");
  rdcontents = fopen(rdcontents_fn, "r");
  if (rdcontents == NULL) 
    {
      fprintf(stderr,"SDSSDAS could not open %s for reading\n", contents_fn);
      exit(EXIT_FAILURE);
    }
  segmentlist_table(rdcontents, stdout, list_id, config);
  fclose_return = fclose(rdcontents);
  if (fclose_return != 0) 
    {
      fprintf(stderr,"SDSSDAS error closing %s\n", rdcontents_fn);
      exit(EXIT_FAILURE);
    }
  
  printf ("</body>\n");
  printf ("</html>\n");

  exit(EXIT_SUCCESS);
}
