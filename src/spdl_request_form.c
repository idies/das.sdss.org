/*! @file spdl_request_form.c
 * @brief Generate an html form for requesting a downlead list of spectro data
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "das_config.h"

/*! Generate a form for requesting a downlead list of spectro data
 */
int
main (void)
{
  char *query;			/* the user (web server) supplied query */
  das_config config;		/* the DAS configuration */
  int read_params;		/* number of parameters read from user */
  char list_id[7];              /* user list id */

  read_config(&config, DAS_CONFIG_FILE);

  printf ("Content-Type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf ("<html>\n");
  (void) fflush(stdout);

  /* read and parse get query */
  query = getenv ("QUERY_STRING");
  if (query == NULL)
    {
      printf ("<head><title>Download list form generation error</title></head>\n");
      printf ("<body>\n");
      printf ("<h1>Error generating download</h1>\n");
      printf ("<p>You must specify what files to download.</p>");
      printf ("</body>\n");
      printf ("</html>");
      exit(EXIT_SUCCESS);
    }

  read_params = sscanf (query, 
			"list=%6[0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]", 
			list_id);
  if (read_params < 1)
    {
      printf ("<head><title>Download list form generation error</title></head>\n");
      printf ("<body>\n");
      printf ("<h1>Error generating form</h1>\n");
      printf ("<p>You must supply a list ID.</p>");
      printf ("</body>\n");
      printf ("</html>");
      (void) fflush(stdout);
      exit (EXIT_SUCCESS);
    }
  
  /* Download choices */
  printf ("<head><title>Request a list of spectroscopic data files for download</title></head>\n");
  printf ("<body>\n");
  printf ("<h2>Download selection</h2>\n");
  printf ("<form class=\"file-download\" method=\"get\" action=\"%s/spdownload_list\">\n", config.cgi_url);
  printf ("<p>Data set serial number:"); 
  printf ("<input type=\"text\" maxlength=\"6\" size=\"6\" name=\"list\" value=\"%s\"/></p>\n", list_id);
  printf ("<h3>File types</h3>\n");
  printf ("<table class=\"file-types\">\n");
  printf ("<thead>\n");
  printf ("<tr class=\"top\">\n");
  printf ("<th></th>\n");
  printf ("<th>Description</th>\n");
  printf ("</tr>\n");
  printf ("</thead>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spSpec\" checked=\"checked\"/>spSpec</th>\n");
  printf ("<td>The extracted, calibrated spectrum from one fiber, with 1d parameters</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spPlate\"/>spPlate</th>\n");
  printf ("<td>The extracted, calibrated spectra for a plate</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spPlotGif\"/>spPlotGif</th>\n");
  printf ("<td>GIF file of a plot of the spectrum</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spPlotPs\"/>spPlotPs</th>\n");
  printf ("<td>Postscript file with a plot of the spectrum</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spAtlas\"/>spAtlas</th>\n");
  printf ("<td>Cutout image for the spectroscopic target</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spObj\"/>spObj</th>\n");
  printf ("<td>Catalog of targeted objects</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spDiag1d\"/>spDiag1d</th>\n");
  printf ("<td>A spectroscopic processing log file with diagnostics</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spZbest\"/>spZbest</th>\n");
  printf ("<td>Best fit spectroscopic classifications and redshifts</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spZline\"/>spZline</th>\n");
  printf ("<td>Line fits</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"spZall\"/>spZall</th>\n");
  printf ("<td>All fit spectroscopic classifications and redshifts</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"ssTar\"/>ssTar</th>\n");
  printf ("<td>A tar file with the spPlate file and all spSpec files for a plate</td>\n");
  printf ("</tr>\n");

  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"sspp\"/>sspp</th>\n");
  printf ("<td>A tar file with the output of the SEGUE Stellar Parameter Pipeline</td>\n");
  printf ("</tr>\n");

  printf ("</table>\n");

  if (true) {
    printf ("<h3>Download method</h3>\n");
    printf ("<table class=\"dlmethod\">\n");
    printf ("<thead>\n");
    printf ("<tr class=\"top\">\n");
    printf ("<th></th>\n");
    printf ("<th>Description</th>\n");
    printf ("</tr>\n");
    printf ("</thead>\n");
    printf ("<tr><th><input type=\"radio\" name=\"dlmethod\" value=\"wget\" checked=\"checked\">wget</input></th>\n");
    printf ("<td>Download a list of URL (which can be used as an input to wget for mass download).</td>\n");
    printf ("<tr><th><input type=\"radio\" name=\"dlmethod\" value=\"rsync\">rsync</input></th>\n");
    printf ("<td>Download a list of file names (which can be used as an input to rsync for mass download).</td>\n");
    if (false) {
      printf ("<tr><th><input type=\"radio\" name=\"dlmethod\" value=\"tar\">tar</input></th>\n");
      printf ("<td><font color=\"red\">TODO</font> Download tar file of selected files.</td>\n");
    }
    printf ("</table>\n");
  }

  printf ("<p>\n");
  printf ("<input type=\"submit\" value=\"request\"/>\n");
  printf ("</p>\n");
  
  printf ("</body>\n");
  printf ("</html>\n");
  exit(EXIT_SUCCESS);
}
