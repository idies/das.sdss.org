/** @file field.c
 * @brief CGI program show data on a field
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "das_config.h"

static
void print_row(char *type, das_config config,
	      char *directory, char *filename) {
  printf("<tr>\n");
  printf("    <th>%s</th>\n",type);
  printf("    <td><a href=\"%s/%s\">%s</a></td>",config.spectro_url,directory,directory);
  printf("    <td><a href=\"%s/%s/%s\">%s</a></td>",config.spectro_url,directory,filename,filename);
  printf("</tr>\n");
}

int main(void)
{
  char *query;
  int plate, mjd, rerun, fiber;
  char filename[MAX_PATH_LENGTH];
  char dirname[MAX_PATH_LENGTH];
  int read_params;
  das_config config;		/* the DAS configuration */

  read_config(&config, DAS_CONFIG_FILE);

  query = getenv("QUERY_STRING");
  assert(query != NULL);
  
  read_params=sscanf(query,"PLATE=%d&MJD=%d&RERUN=%d&FIBER=%d",
		     &plate, &mjd, &rerun, &fiber);
  if (read_params != 4) {
    fprintf (stderr, "Incorrect parameters supplied in cgi call");
    exit (EXIT_FAILURE);
  }

  printf("Content-type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf("<head><title>SDSS Plate %d, MJD %d, Rerun %d, Fiber %d</title></head>\n",
	 plate, mjd, rerun, fiber);
  printf("<body>\n");
  printf("<h1>SDSS Plate %d, MJD %d, Rerun %d, Fiber %d</h1>\n",
	 plate, mjd, rerun, fiber);
  
  printf("<div>\n");
  
  printf("<p class=\"center\">\n");
  printf("<img class=\"spectrum\" src=\"%s/1d_%d/%04d/gif/spPlot-%05d-%04d-%03d.gif\" alt=\"Spectrum\" />\n",
	 config.spectro_url,rerun,plate,mjd,plate,fiber);
  printf("</p>");
 
  printf("</div>\n");

  /* Get the link to the CAS */
  if (strlen(config.cas_obj_url)>7) 
    {
      printf("<a href=\"%s?plate=%d&mjd=%d&fiber=%d\">",
	     config.cas_obj_url,plate,mjd,fiber);
      printf("See the CAS Explorer page for more information on this object</a>\n");
    }

  printf("<div class=\"fiber-files\">\n");
  printf("<table class=\"fiber-files\">\n");
  printf("<thead>\n");
  printf("<tr>\n");
  printf("<th>File type</th>\n");
  printf("<th>Directory</th>\n");
  printf("<th>File name</th>\n");
  printf("</tr>\n");
  printf("</thead>\n");
  printf("<tbody>\n");

  /* 1d data directory */

  (void) snprintf(dirname, MAX_PATH_LENGTH, "1d_%d/%04d/1d",rerun,plate);

  (void) snprintf(filename, MAX_PATH_LENGTH, "spSpec-%05d-%04d-%03d.fit",mjd,plate,fiber);
  print_row("The extracted, calibrated spectrum for this fiber, with 1d parameters",config,dirname,filename);

  /* 1d plot directory */

  (void) snprintf(dirname, MAX_PATH_LENGTH, "1d_%d/%04d/gif",rerun,plate);

  (void) snprintf(filename, MAX_PATH_LENGTH, "spPlot-%05d-%04d-%03d.gif",mjd,plate,fiber);
  print_row("Plot of the extracted, calibrated spectrum for this fiber, in gif image",config,dirname,filename);

  (void) snprintf(filename, MAX_PATH_LENGTH, "spPlot-%05d-%04d-%03d.ps.gz",mjd,plate,fiber);
  print_row("Plot of the extracted, calibrated spectrum for this fiber, in gzipped postscript",config,dirname,filename);

  /* spAtlas directory */
  (void) snprintf(dirname, MAX_PATH_LENGTH, "ss_%d/%04d/spAtlas",rerun,plate);
  (void) snprintf(filename, MAX_PATH_LENGTH, "spAtlas-%04d-%05d-%d.fit",plate,mjd,fiber);
  print_row("Atlas image of this object",config,dirname,filename);

  /* ss directory */
  (void) snprintf(dirname, MAX_PATH_LENGTH, "ss_%d/%04d",rerun,plate);

  (void) snprintf(filename, MAX_PATH_LENGTH, "spObj-%04d-%05d-%02d.fit",plate,mjd,rerun);
  print_row("List of objects in the plate with imaging parameters",config,dirname,filename);

  (void) snprintf(filename, MAX_PATH_LENGTH, "spDiag1d-%05d-%04d.par",mjd,plate);
  print_row("Log file from the 1d data reduction",config,dirname,filename);

  /* 2d directory */

  (void) snprintf(dirname, MAX_PATH_LENGTH, "2d_%d/%04d",rerun,plate);

  (void) snprintf(filename, MAX_PATH_LENGTH, "spPlate-%04d-%05d.fits",plate,mjd);
  print_row("The extracted, calibrated spectra for a plate",config,dirname,filename);

  if (rerun >= 25) {
    (void) snprintf(filename, MAX_PATH_LENGTH, "spZbest-%04d-%05d.fits",plate,mjd);
    print_row("best fit spectroscopic classifications and redshifts",config,dirname,filename);

    (void) snprintf(filename, MAX_PATH_LENGTH, "spZline-%04d-%05d.fits",plate,mjd);
    print_row("line fits for the spectra",config,dirname,filename);

    (void) snprintf(filename, MAX_PATH_LENGTH, "spZall-%04d-%05d.fits",plate,mjd);
    print_row("all fit spectroscopic classifications and redshifts",config,dirname,filename);
  }

  /* Tar file */
  (void) snprintf(dirname, MAX_PATH_LENGTH, "ss_tar_%d",rerun);

  (void) snprintf(filename, MAX_PATH_LENGTH, "%04d.tar.gz",plate);
  print_row("Gzipped, tarred collection of spPlate and spSpec files for the plate",config,dirname,filename);

  /* sspp file */
  (void) snprintf(dirname, MAX_PATH_LENGTH, "sspp_%d",rerun);

  (void) snprintf(filename, MAX_PATH_LENGTH, "%04d-%05d.tgz",plate,mjd);
  print_row("A tar file with the output of the SEGUE Stellar Parameter Pipeline",config,dirname,filename);



  printf("</tbody>\n");
  printf("</table>\n");
  printf("</div>\n");

  printf("</body>\n");
  printf("</html>");
  exit (EXIT_SUCCESS);
}
