/*! @file dl_request_form.c
 * @brief Generate an html form for requesting a downlead list of imaging data
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "das_config.h"

/*! Generate a form for requesting a downlead list of imaging data
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
  printf ("<head><title>Request a list of imaging data files for download</title></head>\n");
  printf ("<body>\n");
  printf ("<h2>Download selection</h2>\n");
  printf ("<form class=\"file-download\" method=\"get\" action=\"%s/download-list\">\n", config.cgi_url);
  printf ("<p>Data set serial number:"); 
  printf ("<input type=\"text\" maxlength=\"6\" size=\"6\" name=\"list\" value=\"%s\"/></p>\n", list_id);
  printf ("<h3>Filters</h3>\n");
  printf ("<input type=\"checkbox\" name=\"filter\" value=\"u\" checked=\"checked\">u</input>\n");
  printf ("<input type=\"checkbox\" name=\"filter\" value=\"g\" checked=\"checked\">g</input>\n");
  printf ("<input type=\"checkbox\" name=\"filter\" value=\"r\" checked=\"checked\">r</input>\n");
  printf ("<input type=\"checkbox\" name=\"filter\" value=\"i\" checked=\"checked\">i</input>\n");
  printf ("<input type=\"checkbox\" name=\"filter\" value=\"z\" checked=\"checked\">z</input>\n");
  printf ("<h3>File types</h3>\n");
  printf ("<table class=\"file-types\">\n");
  printf ("<thead>\n");
  printf ("<tr class=\"top\">\n");
  printf ("<th></th>\n");
  printf ("<th>Description</th>\n");
  printf ("</tr>\n");
  printf ("</thead>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"drObj\" checked=\"checked\"/>drObj</th>\n");
  printf ("<td>Calibrated catalog for a field.</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"drField\" checked=\"checked\"/>drField</th>\n");
  printf ("<td>A table listing the properties of each field in the run, \n");
  printf ("    including astrometric and photometric calibration, data quality and processing flags,");
  printf ("    and object statistics.</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"corr\" checked=\"checked\"/>corr</th>\n");
  printf ("<td>The corrected image frame, having been bias subtracted, flat-fielded, and purged of bright stars.</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"fpBIN\"/>fpBIN</th>\n");
  printf ("<td>A 4x4 binned version of the corrected image after sky-subtraction.</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"fpM\"/>fpM</th>\n");
  printf ("<td>Contains the frame masks for a single frame.");
  printf ("    (These can be read using the readAtlasImages utility.)</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"fpAtlas\"/>fpAtlas</th>\n");
  printf ("<td>Contains the atlas images for all objects detected in a single field.\n");
  printf ("    (These can be read using the readAtlasImages utility.)</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"asTrans\"/>asTrans</th>\n");
  printf ("<td>The astrometric calibration.</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"fpObjc\"/>fpObjc</th>\n");
  printf ("<td>Object lists put out by the frames pipeline.</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"tsObj\" />tsObj</th>\n");
  printf ("<td>Calibrated catalog for a field.</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"drC\" />drC</th>\n");
  printf ("<td>The corrected image frame, having been bias subtracted, flat-fielded, purged of bright stars, and header updated with the latest calibrations (not available through rsync).</td>\n");
  printf ("</tr>\n");
  printf ("<tr>\n");
  printf ("<th><input type=\"checkbox\" name=\"type\" value=\"tsField\"/>tsField</th>\n");
  printf ("<td>A table listing the properties of each field in the run, \n");
  printf ("    including astrometric and photometric calibration, data quality and processing flags,");
  printf ("    and object statistics.</td>\n");
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
    printf ("<td>Download a list of URLs (which can be used as an input to wget for mass download).</td>\n");
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
