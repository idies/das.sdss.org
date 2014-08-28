/*! @file post_utils.c
 * @brief Process lines submitted from multipart/form-data
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "das_config.h"
#include "post_utils.h"
#include "mkdtemp.h"

/*! Change a string to protect against malicious CGI attacks
 * 
 * @param line buffer for the line (which must already be allocated)
 * @return true of the line was modified, false if it was not
 */
bool
cgi_protect (char *line)
{
  bool change_made = false;    	/* read the end of the file */
  size_t i;                        /* an index into the line */
  size_t length;                   /* the length of the input line */

  length = strlen(line);
      
  assert(length < MAX_LINE_LENGTH);

  if (length < 1) return false;

  for (i=0; i < length; i++) 
    {
      if (line[i] >= '0' && line[i] <= '9') continue;
      if (line[i] >= 'A' && line[i] <= 'Z') continue;
      if (line[i] >= 'a' && line[i] <= 'z') continue;
      if (line[i] == '-') continue;
      if (line[i] == '_') continue;
      if (line[i] == ' ') continue;
      if (line[i] == '\t') continue;
      if (line[i] == '#') continue;
      if (line[i] == '.') continue;
      if (line[i] == ',') continue;
      line[i] = '_';
      change_made = true;
    }

  return change_made;
}


/*! Read a line from multipart/form-data message, stripping the final CRLF
 * 
 * @param line buffer for the line (which must already be allocated)
 * @param line_size the maximum number of characters to read
 * @param fp the file pointer to read from
 * @param request a file where the record of the line will be written
 * @return true of the line was read successfilly, false of an EOF was reached
 */
static bool
get_line ( /*@out@ */ char *line, int line_size, FILE * fp, FILE * request)
{
  bool eof_encountered;		/* read the end of the file */
  char *returned_line = NULL;	/* pointer to read data */
  int io_error;    /* error code returned by attempt to record request */

  returned_line = fgets (line, line_size, fp);
  io_error = fputs(line, request);
  if (io_error == EOF) 
    {
      fprintf(stderr,"SDSSDAS post_utils error logging request\n");
    } 
  eof_encountered = (returned_line == NULL);

  /* Trim the CRLF from the end of the line */
  if (!eof_encountered)
    {
      if (line[strlen (line) - 1] == '\n')
	{
	  line[strlen (line) - 1] = '\0';
	}
      if (line[strlen (line) - 1] == '\r')
	{
	  line[strlen (line) - 1] = '\0';
	}
    }

  return eof_encountered;
}

/*! Read the header of a part of a multipart/form-data message 
 * 
 * @param h a pointer to the structure into which to read header parameters
 * @param fp the file pointer to read from
 * @param request a file on disk that holds a record of the submission
 */
static void
read_header ( /*@out@ */ part_header * h, FILE * fp, FILE * request)
{
  char line[MAX_LINE_LENGTH];	/* input buffer for one line */
  int values_read;		/* number of parameters read from line */
  bool eof_encountered;		/* read the end of the file */
  char hdr_format[MAX_LINE_LENGTH];	/* format of header line to read */
  int hdr_format_len;		/* length of header format string */

  eof_encountered = get_line (line, MAX_LINE_LENGTH, fp, request);
  if (eof_encountered) 
    {
      return;
    }

  hdr_format_len = snprintf (hdr_format, MAX_LINE_LENGTH,
			     "Content-Disposition: %%%d[^;]; name=\"%%%d[^\"]\"; filename=\"%%%d[^\"]\"",
			     MAX_LINE_LENGTH, MAX_LINE_LENGTH,
			     MAX_LINE_LENGTH);
  assert (hdr_format_len < MAX_LINE_LENGTH);

  values_read =
    sscanf (line, hdr_format, h->disposition, h->name, h->filename);

  assert (values_read == 2 || values_read == 3);

  switch (values_read)
    {
    case 2:
      h->filename[0] = '\0';
      h->type[0] = '\0';
      break;
    case 3:
      eof_encountered = get_line (line, MAX_LINE_LENGTH, fp, request);
      assert (!eof_encountered);
      hdr_format_len = snprintf (hdr_format, MAX_LINE_LENGTH,
				 "Content-Type: %%%ds", MAX_LINE_LENGTH);
      assert (hdr_format_len < MAX_LINE_LENGTH);
      values_read = sscanf (line, hdr_format, h->type);
      break;
    default:
      assert (false);
    }

  /* A blank line marks the end of the header, but the line read includes a CRLF */
  while (strlen (line) > 2)
    {
      eof_encountered = get_line (line, MAX_LINE_LENGTH, fp, request);
      assert (!eof_encountered);
    }

}

/*! Process a multipart/form-data submission, performing an op on each line
 *
 * @param fp the file pointer to read the submission from
 * @param process_func a pointer to the function used to processess each line, not including the rerun
 * @param process_func_rerun a pointer to the function used to processess each line, including the rerun
 * @param config the structure giving the DAS configuration
 * @param list_id a pointer to the string where the serial number of the list should be stored
 * @param dataset the dataset from which to take submitted fields
 * @return the number of lines processed
 */
int
process_post (FILE *fp, bool (*process_func)(char *, das_config config, FILE *, char *),
	      bool (*process_func_rerun)(char *, das_config config, FILE *, char *),
	      das_config config, char /*@out@*/ *list_id, int *dataset)
{
  char line[MAX_LINE_LENGTH];	/* input buffer for one line */
  char boundary[MAX_LINE_LENGTH];	/* boundary marker between input parts */
  char userlist_dir[MAX_LINE_LENGTH]; /* userlist directory name */
  char request_fname[MAX_LINE_LENGTH]; /* file name for request */
  FILE *request; /* a file recording the request */
  char output_fname[MAX_LINE_LENGTH]; /* file name for table output */
  FILE *output; /* a file recording the table output */
  mode_t umask_mode; /* the umask before it is reset for opening the request record */
  int name_length; /* the length of a recently generated file or directory name */
  bool eof_encountered = 0;	/* read the end of the file */
  part_header h;		/* header of the part being processed */
  bool file_processed = false;	/* true if we have processed a file */
  int data_lines_read = 0;		/* number of data lines processed so far */
  int lines_read = 0;	        /* number of file lines processed so far */
  bool found_boundary = false;	/* true if we have read a boundary line */
  bool line_ok;                 /* true if line was processed ok */

  strncpy(list_id, "      ", 6);

  /* generate the output directory and open the log file */
  name_length = snprintf(userlist_dir, MAX_LINE_LENGTH,
		  "%s/userlist-XXXXXX", config.scratch_root);
  if (name_length > MAX_LINE_LENGTH-2) 
    {
      fprintf(stderr,"SDSSDAS User directory name too long");
    }
  if (mkdtemp(userlist_dir) == NULL ) 
    {
      fprintf(stderr,"SDSSDAS cannot create request record.\n");
      return 0;
    }

  /* derive the list id from the dir name */
  strncpy(list_id, &userlist_dir[strlen(userlist_dir)-6], 6);
  list_id[6] = '\0';

  /* Open a log of the request */
  name_length = snprintf(request_fname, MAX_LINE_LENGTH,
			 "%s/request.post", userlist_dir);
  if (name_length > MAX_LINE_LENGTH-2) 
    {
      fprintf(stderr,"SDSSDAS request record name too long");
    }
  umask_mode = (mode_t) umask(S_IRGRP|S_IWGRP|S_IXGRP|S_IROTH|S_IWOTH|S_IXOTH);
  request = fopen(request_fname,"w");
  (void) umask(umask_mode);

  /* if we can't open request, get rid of the output*/
  if (request == NULL) 
    {
      request = fopen("/dev/null","w+");
      if (request == NULL) exit(EXIT_FAILURE);
    }

  /* Open the output file */
  name_length = snprintf(output_fname, MAX_LINE_LENGTH,
			 "%s/orig_contents.tsv", userlist_dir);
  if (name_length > MAX_LINE_LENGTH-2) 
    {
      fprintf(stderr,"SDSSDAS table name too long");
    }
  umask_mode = (mode_t) umask(S_IWGRP|S_IXGRP|S_IWOTH|S_IXOTH);
  output = fopen(output_fname,"w");
  (void) umask(umask_mode);

  /* if we can't open an output file, exit without processing */
  if (output == NULL) 
    {
      return 0;
    }

  /* the first line seen will be the boundary */
  eof_encountered = get_line (boundary, MAX_LINE_LENGTH, fp, request);
  assert (!eof_encountered);
  assert (strlen (boundary) > 2);
  assert (strlen (boundary) < MAX_LINE_LENGTH - 1);  

  /* process each part as we encounter it */
  do
    {
      read_header (&h, fp, request);
      /* If we have processed a file, do not process the form */
      if (strcmp (h.name, "dataset") == 0)
	{
	  found_boundary = 0;
	  lines_read = 0;
	  while (!eof_encountered
		 && !found_boundary && lines_read < MAX_LINES_READ)
	    {
	      lines_read++;
	      eof_encountered = get_line (line, MAX_LINE_LENGTH, fp, request);
	      found_boundary =
		strncmp (boundary, line, strlen (boundary)) == 0;
	      if (!eof_encountered && !found_boundary)
		(void) sscanf(line,"%d",dataset);
	    }
	}
      else if (strcmp (h.name, "inputFile") == 0 ||
	  (strcmp (h.name, "csvIn") == 0 && !file_processed))
	{
	  found_boundary = 0;
	  lines_read = 0;
	  while (!eof_encountered
		 && !found_boundary && lines_read < MAX_LINES_READ)
	    {
	      lines_read++;
	      eof_encountered = get_line (line, MAX_LINE_LENGTH, fp, request);
	      found_boundary =
		strncmp (boundary, line, strlen (boundary)) == 0;
	      if (!found_boundary)
		{
		  if (*dataset == 0)
		    line_ok = process_func_rerun (line, config, output, list_id);
		  else
		    line_ok = process_func (line, config, output, list_id);

		  if (line_ok) 
		    data_lines_read++;
		}
	    }

	  /* If the file name was set, we just finished processing a file */
	  file_processed = strlen (h.filename) > 0;
	}
      else
	{
	  found_boundary = 0;
	  lines_read = 0;
	  while (!eof_encountered
		 && !found_boundary && lines_read < MAX_LINES_READ)
	    {
	      lines_read++;
	      eof_encountered = get_line (line, MAX_LINE_LENGTH, fp, request);
	      found_boundary =
		strncmp (boundary, line, strlen (boundary)) == 0;
	    }
	}
    }
  while (!eof_encountered);

  (void) fflush(request);
  (void) fclose(request);
  (void) fflush(output);
  (void) fclose(output);

  return data_lines_read;
}

