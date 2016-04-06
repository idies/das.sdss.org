/** @file download-list.c
 * @brief CGI program to generate a list of files for mass download
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include "das_config.h"
#include "segments.h"

/*! Generate a line for an download list
 * 
 * @param prefix the prefix for the line of output
 * @param dir_format the format string for the directroy
 * @param file_format the format string for the file format
 * @param s the struct defining the segment
 * @param field the field number
 * @param ts_format true if the file format contains the rerun
 */
static void
list_entry(char *prefix, char *dir_format, char *file_format, 
	   segment s, int field, bool ts_format)
{
  char filename[MAX_PATH_LENGTH];	/* the current file name */
  char dirname[MAX_PATH_LENGTH];	/* the current directory name */
  
  (void) snprintf(dirname, MAX_PATH_LENGTH, dir_format, 
		  s.run, s.rerun, s.camcol);
  if (ts_format)
    (void) snprintf(filename, MAX_PATH_LENGTH, file_format, 
		    s.run, s.camcol, s.rerun, field);
  else
    (void) snprintf(filename, MAX_PATH_LENGTH, file_format, 
		    s.run, s.camcol, field);

  printf("%s/%s/%s\n", prefix, dirname, filename);
}

/*! cgi program to generate lists for mass download 
 *
 * For example, this program might create a simple list of URLs for 
 * download using wget.
 */
int
main (void)
{
  char *query;			/* the user (web server) supplied query */
  das_config config;		/* the DAS configuration */
  int read_params;		/* number of parameters read from user */
  char list_id[7];		/* the list ID */

  char contents_fn[MAX_PATH_LENGTH];	/* file name for file with sorted contents */
  int fn_length;		/* length of most recently constructed file name */
  FILE *contents;		/* the file with the sorted contents */

  int fclose_return;            /* return value from fclose, checked for errors */

  bool u, g, r, i, z;           /* include this filter? */
  bool asTrans, fcPCalib, drC, corr, fpBIN, fpM, fpObjc, fpAtlas, tsField, tsObj, drField, drObj; /* include this file type? */
  bool wget, rsync, tar;        /* the download method to use */

  segment s;			/* the segment to add next */
  int field;			/* the field being shown */
  char prefix[MAX_PATH_LENGTH];	/* the initial element of the download string */
  
  read_config(&config, DAS_CONFIG_FILE);

  /* read and parse get query */
  query = getenv ("QUERY_STRING");
  if (query == NULL)
    {
      printf ("Content-type:text/html\n\n");
      printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
      printf ("<head><title>Download list generation error</title></head>\n");
      printf ("<body>\n");
      printf ("<h1>Error generating download</h1>\n");
      printf ("<p>You must specify what files to download.</p>");
      printf ("</body>\n");
      printf ("</html>");
      exit(EXIT_SUCCESS);
    }

  list_id[6] = '\0';
  read_params = sscanf (query, 
			"list=%6[0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]", 
			list_id);
  if (read_params < 1)
    {
      printf ("Content-type:text/html\n\n");
      printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
      printf ("<head><title>Download list generation error</title></head>\n");
      printf ("<body>\n");
      printf ("<h1>Error generating download</h1>\n");
      printf ("<p>You must supply a list ID.</p>");
      printf ("</body>\n");
      printf ("</html>");
      exit (EXIT_SUCCESS);
    }

  u = strstr(query, "filter=u") != NULL;
  g = strstr(query, "filter=g") != NULL;
  r = strstr(query, "filter=r") != NULL;
  i = strstr(query, "filter=i") != NULL;
  z = strstr(query, "filter=z") != NULL;
  asTrans = strstr(query, "type=asTrans") != NULL;
  fcPCalib = strstr(query, "type=fcPCalib") != NULL;
  corr = strstr(query, "type=corr") != NULL;
  drC = strstr(query, "type=drC") != NULL;
  fpBIN = strstr(query, "type=fpBIN") != NULL;
  fpM = strstr(query, "type=fpM") != NULL;
  fpObjc = strstr(query, "type=fpObjc") != NULL;
  fpAtlas = strstr(query, "type=fpAtlas") != NULL;
  tsField = strstr(query, "type=tsField") != NULL;
  tsObj = strstr(query, "type=tsObj") != NULL;
  drField = strstr(query, "type=drField") != NULL;
  drObj = strstr(query, "type=drObj") != NULL;
  wget = strstr(query, "dlmethod=wget") != NULL;
  rsync = strstr(query, "dlmethod=rsync") != NULL;
  tar = strstr(query, "dlmethod=tar") != NULL;

  /* If no filter is selected, return results for all */
  if (!(u || g || r || i || z))
    {
      u = true;
      g = true;
      r = true;
      i = true;
      z = true;
    }
  
  /* If no file type is selected, return results for all */
  if (!(asTrans || fcPCalib || corr || drC || fpBIN || fpM || fpObjc || fpAtlas || tsField || tsObj || drField || drObj))
    {
      asTrans = true;
      fcPCalib = true;
      corr = true;
      drC = true;
      fpBIN = true;
      fpM = true;
      fpObjc = true;
      fpAtlas = true;
      tsField = true;
      tsObj = true;
      drField = true;
      drObj = true;
    }

  /* If no download method is selected, return wget list */
  if (! (wget || rsync || tar) )
    {
      wget = true;
    }

  /* Make sure only one download method is selected */
  if ( (wget && rsync) || (wget && tar) || (tar && rsync) )
    {
      printf ("Content-type:text/html\n\n");
      printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
      printf ("<head><title>Download list generation error</title></head>\n");
      printf ("<body>\n");
      printf ("<h1>Error generating download</h1>\n");
      printf ("<p>Please choose only one download method.</p>");
      printf ("</body>\n");
      printf ("</html>");
      exit(EXIT_SUCCESS);
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

  if (wget) 
    {
      (void) snprintf (prefix, MAX_PATH_LENGTH, "%s", 
		       config.imaging_url);
    }
  else if (rsync) 
    {
      (void) snprintf (prefix, MAX_PATH_LENGTH, "/imaging"); 
    }
  else if (tar)
    {
      printf ("Content-type:text/html\n\n");
      printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
      printf ("<head><title>Download list generation error</title></head>\n");
      printf ("<body>\n");
      printf ("<h1>Error generating download</h1>\n");
      printf ("<p>Sorry, tar is not supported yet.</p>");
      printf ("</body>\n");
      printf ("</html>");
      exit(EXIT_SUCCESS);
    }
  else
    {
      printf ("Content-type:text/html\n\n");
      printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
      printf ("<head><title>Download list generation error</title></head>\n");
      printf ("<body>\n");
      printf ("<h1>Error generating download</h1>\n");
      printf ("<p>Invalid download method chosen.</p>");
      printf ("</body>\n");
      printf ("</html>");
      exit(EXIT_SUCCESS);
    }

  /* Print http header */
  if (rsync)
    printf ("Content-Disposition: attachment; filename=sdss-rsync-%s.lis\nContent-type:text/plain\n\n", list_id);
  else
    printf ("Content-Disposition: attachment; filename=sdss-wget-%s.lis\nContent-type:text/plain\n\n", list_id);

  while (read_segment (contents, &s))
    {
      if (asTrans)
	printf("%s/%d/%d/fastrom/asTrans-%06d.fit\n",
	       prefix, s.run, s.rerun, s.run);

      if (fcPCalib)
	printf("%s/%d/%d/nfcalib/fcPCalib-%06d-%d.fit\n",
	       prefix, s.run, s.rerun, s.run, s.camcol);

      for (field = s.field; field < s.field + s.nfields; field++)
	{

	  if (tsObj)
	    list_entry(prefix, "%d/%d/calibChunks/%d", "tsObj-%06d-%d-%d-%04d.fit", 
		       s, field, true);

	  if (tsField)
	    list_entry(prefix, "%d/%d/calibChunks/%d", "tsField-%06d-%d-%d-%04d.fit", 
		       s, field, true);

	  if (drObj)
	    list_entry(prefix, "%d/%d/dr/%d", "drObj-%06d-%d-%d-%04d.fit", 
		       s, field, true);

	  if (drField)
	    list_entry(prefix, "%d/%d/dr/%d", "drField-%06d-%d-%d-%04d.fit", 
		       s, field, true);

	  if (corr && u)
	    list_entry(prefix, "%d/%d/corr/%d", "fpC-%06d-u%d-%04d.fit.gz", 
		       s, field, false);
	  if (corr && g)
	    list_entry(prefix, "%d/%d/corr/%d", "fpC-%06d-g%d-%04d.fit.gz", 
		       s, field, false);
	  if (corr && r)
	    list_entry(prefix, "%d/%d/corr/%d", "fpC-%06d-r%d-%04d.fit.gz", 
		       s, field, false);
	  if (corr && i)
	    list_entry(prefix, "%d/%d/corr/%d", "fpC-%06d-i%d-%04d.fit.gz", 
		       s, field, false);
	  if (corr && z)
	    list_entry(prefix, "%d/%d/corr/%d", "fpC-%06d-z%d-%04d.fit.gz", 
		       s, field, false);

	  /* a cgi application generates drC files, so they are only available
	     if downloaded through apache, eg with wget */
	  if (wget) {
	    if (drC && u)
	      printf("%s/drC?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&FILTER=u\n",
		     config.cgi_url, s.run, s.rerun, s.camcol, field);
	    if (drC && g)
	      printf("%s/drC?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&FILTER=g\n",
		     config.cgi_url, s.run, s.rerun, s.camcol, field);
	    if (drC && r)
	      printf("%s/drC?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&FILTER=r\n",
		     config.cgi_url, s.run, s.rerun, s.camcol, field);
	    if (drC && i)
	      printf("%s/drC?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&FILTER=i\n",
		     config.cgi_url, s.run, s.rerun, s.camcol, field);
	    if (drC && z)
	      printf("%s/drC?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&FILTER=z\n",
		     config.cgi_url, s.run, s.rerun, s.camcol, field);
	  }

	  if (fpBIN && u)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpBIN-%06d-u%d-%04d.fit",
		       s, field, false);	    
	  if (fpBIN && g)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpBIN-%06d-g%d-%04d.fit",
		       s, field, false);
	  if (fpBIN && r)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpBIN-%06d-r%d-%04d.fit",
		       s, field, false);
	  if (fpBIN && i)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpBIN-%06d-i%d-%04d.fit",
		       s, field, false);
	  if (fpBIN && z)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpBIN-%06d-z%d-%04d.fit",
		       s, field, false);
	    
	  if (fpM && u)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpM-%06d-u%d-%04d.fit",
		       s, field, false);
	  if (fpM && g)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpM-%06d-g%d-%04d.fit",
		       s, field, false);
	  if (fpM && r)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpM-%06d-r%d-%04d.fit",
		       s, field, false);
	  if (fpM && i)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpM-%06d-i%d-%04d.fit",
		       s, field, false);
	  if (fpM && z)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpM-%06d-z%d-%04d.fit",
		       s, field, false);
	    
	  if (fpObjc)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpObjc-%06d-%d-%04d.fit",
		       s, field, false);
	    
	  if (fpAtlas)
	    list_entry(prefix, "%d/%d/objcs/%d", "fpAtlas-%06d-%d-%04d.fit",
		       s, field, false);

	}
    } 

  /* close the contents list */
  fclose_return = fclose (contents);
  if (fclose_return != 0)
    {
      fprintf (stderr, "SDSSDAS error closing %s\n", contents_fn);
      exit (EXIT_FAILURE);
    }

  exit (EXIT_SUCCESS);

}
