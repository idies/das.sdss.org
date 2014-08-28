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
#include "spectro_post.h"

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

  bool spPlate, spSpec, spPlotGif, spPlotPs, spAtlas, spObj, spDiag1d, spZbest, 
    spZline, spZall, ssTar, sspp; /* include this file type? */
  bool wget, rsync, tar;        /* the download method to use */

  char prefix[MAX_PATH_LENGTH];	/* the initial element of the download string */

  int old_plate = 0;
  int old_mjd = 0;
  int old_rerun = 0;

  int plate = 0; /* plate number read */
  int mjd = 0; /* mjd read */
  int rerun = 0; /* rerun read */
  int fiber = 0; /* fiber read */

  char line[SP_TSV_LINE_LENGTH];	/* a buffer of the line input */
  char *read_check;		/* a pointer to the read string returned by fgets */
  int cols_read; /* the columns read from a scanned line */
  
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

  spPlate = strstr(query, "type=spPlate") != NULL;
  spSpec = strstr(query, "type=spSpec") != NULL;
  spPlotGif = strstr(query, "type=spPlotGif") != NULL;
  spPlotPs = strstr(query, "type=spPlotPs") != NULL;
  spAtlas = strstr(query, "type=spAtlas") != NULL;
  spObj = strstr(query, "type=spObj") != NULL;
  spDiag1d = strstr(query, "type=spDiag1d") != NULL;
  spZbest = strstr(query, "type=spZbest") != NULL;
  spZline = strstr(query, "type=spZline") != NULL;
  spZall = strstr(query, "type=spZall") != NULL;
  ssTar = strstr(query, "type=ssTar") != NULL;
  sspp = strstr(query, "type=sspp") != NULL;

  wget = strstr(query, "dlmethod=wget") != NULL;
  rsync = strstr(query, "dlmethod=rsync") != NULL;
  tar = strstr(query, "dlmethod=tar") != NULL;
  
  /* If no file type is selected, return results for spPlate */
  if (!(spPlate || spSpec || spPlotGif || spPlotPs 
	|| spAtlas || spObj || spDiag1d || spZbest 
	|| spZall || ssTar || sspp ))
    {
      spPlate = true;
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
		       config.spectro_url);
    }
  else if (rsync) 
    {
      (void) snprintf (prefix, MAX_PATH_LENGTH, "/spectro"); 
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

  do
    {
      read_check = fgets (line, SP_TSV_LINE_LENGTH, contents);
      cols_read = (read_check == line && (line[0] != '#')) ? 
	sscanf(line, "%d%d%d%d", &plate, &mjd, &rerun, &fiber) : 0;
      if (cols_read == 4)
	{
	  /* Do the once per plate files */
	  if (!(plate == old_plate && mjd == old_mjd && rerun == old_rerun))
	    {
	      if (spPlate)
		printf("%s/2d_%d/%d/spPlate-%04d-%05d.fits\n",
		       prefix, rerun, plate, plate, mjd);
	      if (spObj)
		printf("%s/ss_%d/%04d/spObj-%04d-%05d-%02d.fit\n",
		       prefix, rerun, plate, plate, mjd, rerun);
	      if (spDiag1d)
		printf("%s/ss_%d/%04d/spDiag1d-%05d-%04d.par\n",
		       prefix, rerun, plate, plate, mjd);
	      if (spZbest)
		printf("%s/2d_%d/%04d/spZbest-%04d-%05d.fits\n",
		       prefix, rerun, plate, plate,mjd);
	      if (spZline)
		printf("%s/2d_%d/%04d/spZline-%04d-%05d.fits\n",
		       prefix, rerun, plate, plate,mjd);
	      if (spZall)
		printf("%s/2d_%d/%04d/spZall-%04d-%05d.fits\n",
		       prefix, rerun, plate, plate,mjd);
	      if (ssTar)
		printf("%s/ss_tar_%d/%04d.tar.gz\n",
		       prefix, rerun, plate);
	      if (sspp)
		printf("%s/sspp_%d/%04d-%05d.tgz\n",
		       prefix, rerun, plate, mjd);
	    }

	  /* Now on to those for each fiber */
	  if (spSpec)
	    printf("%s/1d_%d/%04d/1d/spSpec-%05d-%04d-%03d.fit\n",
		   prefix, rerun, plate, mjd, plate, fiber);
	  if (spPlotGif)
	    printf("%s/1d_%d/%04d/gif/spPlot-%05d-%04d-%03d.gif\n",
		   prefix, rerun, plate, mjd,plate,fiber);
	  if (spPlotPs)
	    printf("%s/1d_%d/%04d/gif/spPlot-%05d-%04d-%03d.ps.gz\n",
		   prefix, rerun, plate, mjd,plate,fiber);
	  if (spAtlas)
	    printf("%s/ss_%d/%04d/spAtlas/spAtlas-%04d-%05d-%d.fit\n",
		   prefix, rerun, plate, plate, mjd, fiber);
	}
      old_plate = plate;
      old_mjd = mjd;
      old_rerun = rerun;
    }
  while(read_check == line); 
  
  /* close the contents list */
  fclose_return = fclose (contents);
  if (fclose_return != 0)
    {
      fprintf (stderr, "SDSSDAS error closing %s\n", contents_fn);
      exit (EXIT_FAILURE);
    }

  exit (EXIT_SUCCESS);

}
