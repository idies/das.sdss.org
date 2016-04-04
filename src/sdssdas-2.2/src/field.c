/** @file fieldcas.c
 * @brief CGI program show data on a field
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "das_config.h"
#include "checked_link.h"
#include "file_readable.h"
#include "coord_xform.h"

static
void print_row(char *type, das_config config, char filter, 
	      char *directory, char *filename) {
  char filelink[MAX_PATH_LENGTH];	/* a link to a file (if it exists) */

  printf("<tr>\n");
  if (filter == '\0') {
    printf("  <th colspan=\"2\">%s</th>\n",type);
  } else if (filter == 'u') {
    printf("  <th rowspan=\"5\">%s</th><td>%c</td>\n",type,filter);
  } else {
    printf("    <td>%c</td>\n",filter);
  }

  (void) checked_link (config.imaging_url, config.imaging_root, 
		       directory, "", filelink, MAX_PATH_LENGTH);
  printf("    <td>%s</td>",filelink);

  (void) checked_link (config.imaging_url, config.imaging_root, 
		       directory, filename, filelink, MAX_PATH_LENGTH);
  printf("    <td>%s</a></td>",filelink);

  printf("</tr>\n");
}

int main(void)
{
  char *query;
  int run, rerun, camcol, field, zoom;
  char *filter="ugriz";
  char filename[MAX_PATH_LENGTH];
  char dirname[MAX_PATH_LENGTH];
  char filelink[MAX_PATH_LENGTH];	/* a link to a file (if it exists) */
  char tsField_fname[MAX_PATH_LENGTH];	/* the fully qualified name of the tsField */
  bool have_dr;                         /* drField and drObj files exist */
  bool have_fastrom;                         /* improved astrometry files exist */
  bool rerun_set;                       /* the rerun number was set by the query */
  int i;
  int read_params;
  int zooms[]={0,5,10,15,20,25,30};
  int nzooms=7;
  int zoom_rerun;
  char zoom_fn[MAX_PATH_LENGTH]; /* the location of the zoom image */
  das_config config;		/* the DAS configuration */

  trans trans[5];                   /* astrometric transformation */
  double node, incl, ra, dec;    /* astrometric parameters */

  read_config(&config, DAS_CONFIG_FILE);

  query = getenv("QUERY_STRING");
  assert(query != NULL);
  
  read_params=sscanf(query,"RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&ZOOM=%d",
		     &run, &rerun, &camcol, &field, &zoom);
  if (read_params < 5) {
    zoom=15;
  }

  rerun_set = read_params >= 4;
  if (!rerun_set) {
    read_params=sscanf(query,"run=%d&camcol=%d&field=%d",
		       &run, &camcol, &field);
    rerun = 40;
  } 

  if (read_params < 3)
    {
      printf("Content-type:text/html\n\n");
      printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
      printf("<head><title>Invalid field request</title></head>\n");
      printf("<body>\n");
      printf("<p>Invalid field request</p>\n");
      printf("</body>\n");
      printf("</html>");
      exit (EXIT_SUCCESS);
    }

  /* We might need to get the zoom from some other rerun; if we do not find 
     a zoom with the proveded rerun, go looking */
  zoom_rerun = rerun;
  (void) snprintf(zoom_fn, MAX_PATH_LENGTH, 
		  "%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg",
		  config.imaging_root, run, zoom_rerun, camcol, run, camcol,
		  zoom_rerun, field, zoom);
  /* If the zoom isn't available in the requested rerun, try and find
     a zoom from another rerun. */
  if (!file_readable(zoom_fn)) 
    {
      for (zoom_rerun = 49; zoom_rerun >= 0; zoom_rerun--) {
	(void) snprintf(zoom_fn, MAX_PATH_LENGTH, 
			"%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg",
			config.imaging_root, run, zoom_rerun, camcol, run, camcol,
			zoom_rerun, field, zoom);
	if (file_readable(zoom_fn)) break;
      }
    }
  if (!rerun_set) rerun = zoom_rerun;
  
  printf("Content-type:text/html\n\n");
  printf ("<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/sdssdas.css\"/>\n");
  printf("<head><title>SDSS Run %d, Rerun %d, Camcol %d, Field %d</title></head>\n",
	 run, rerun, camcol, field);
  printf("<body>\n");
  printf("<h1>SDSS Run %d, Rerun %d, Camcol %d, Field %d</h1>\n",
	 run, rerun, camcol, field);

  /* Get the link to the CAS */
  if (strlen(config.cas_navi_url)>7) 
    {
      (void) snprintf(tsField_fname, MAX_PATH_LENGTH, 
		      "%s/%d/%d/calibChunks/%d/tsField-%06d-%d-%d-%04d.fit",
		      config.imaging_root,run,rerun,camcol,run,camcol,rerun,field);
      if (!read_trans(tsField_fname, trans, &node, &incl))
	{
	  pixToEq(745,1024,trans[2],node,incl,&ra,&dec);
	  if (ra >= 0 && ra <= 360 && dec >= -90 && dec <= 90) 
	    {
	      printf("<a href=\"%s?ra=%f&dec=%f&opt=F&scale=3\">",
		     config.cas_navi_url,ra,dec);
	      printf("Coordinates of center: %8.4f, %8.4f</a>\n", ra, dec);
	    } 
	}
    }

  printf("<p class=\"center\">\n");
  printf("<a href=\"%s/field?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&ZOOM=%d\">previous</a>\n",
	 config.cgi_url,run,rerun,camcol,field-1,zoom);
  printf("<a href=\"%s/field?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&ZOOM=%d\">next</a>\n",
	 config.cgi_url,run,rerun,camcol,field+1,zoom);
  printf("</p>");

  
  printf("<div>\n");
  
  if (file_readable(zoom_fn))
    {
      printf("<p class=\"center\">\n");
      printf("<a class=\"zoom\" href=\"%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg\">\n",
	     config.imaging_url,run,zoom_rerun,camcol,run,camcol,zoom_rerun,field,0);
      printf("<img class=\"zoom\" src=\"%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg\" alt=\"Zoom%02d\" />\n",
	     config.imaging_url,run,zoom_rerun,camcol,run,camcol,zoom_rerun,field,zoom,zoom);
      printf("</a>\n");
      printf("</p>");
    }

  printf("<p class=\"center\">\n");
  for(i=0;i<nzooms;i++) {
    printf("<a href=\"%s/field?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&ZOOM=%d\">%d</a>\n",
	   config.cgi_url,run,rerun,camcol,field,zooms[i],zooms[i]);
  }
  printf("</p>\n");
  printf("</div>\n");


  /* print the table of files */
  printf("<div class=\"field-files\">\n");
  printf("<table class=\"field-files\">\n");
  printf("<thead>\n");
  printf("<tr>\n");
  printf("<th>File type</th>\n");
  printf("<th>Filter</th>\n");
  printf("<th>Directory</th>\n");
  printf("<th>File name</th>\n");
  printf("</tr>\n");
  printf("</thead>\n");
  printf("<tbody>\n");

  (void) snprintf(filename, MAX_PATH_LENGTH, "drObj-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/dr/%d",run,rerun,camcol);
  have_dr = checked_link (config.imaging_url, config.imaging_root, 
			  dirname, "", filelink, MAX_PATH_LENGTH);
  if (have_dr) {
    print_row("Calibrated object catalog (revised)",config,'\0',dirname,filename);
    (void) snprintf(filename, MAX_PATH_LENGTH, "drField-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/dr/%d",run,rerun,camcol);
    print_row("Field calibration and statistics (revised)",config,'\0',dirname,filename);
  } else {
    /* If we have drObj and drField, give tsObj and tsField later */
    (void) snprintf(filename, MAX_PATH_LENGTH, "tsObj-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",run,rerun,camcol);
    print_row("Calibrated object catalog",config,'\0',dirname,filename);
    
    (void) snprintf(filename, MAX_PATH_LENGTH, "tsField-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",run,rerun,camcol);
    print_row("Field calibration and statistics",config,'\0',dirname,filename);
  }

  if (config.offer_drC) {
    for(i=0;i<5;i++) {
      printf("<tr>\n");
      if (i == 0)
	printf("  <th rowspan=\"5\">Header-supplemented corrected frames</th>");
      printf("<td>%c</td>\n",filter[i]);
      printf("<td>dynamically generated</td>");
      printf("<td><a href=\"%s/drC?RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&FILTER=%c\">drC-%06d-%c%d-%04d.fits</a></td>",
	     config.cgi_url,run,rerun,camcol,field,filter[i],run,filter[i],camcol,field);
      printf("</tr>\n");
    }
  } else {
    for(i=0;i<5;i++) {
      (void) snprintf(filename, MAX_PATH_LENGTH, "fpC-%06d-%c%d-%04d.fit.gz",run,filter[i],camcol,field);
      (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/corr/%d",run,rerun,camcol);
      print_row("Original corrected frames",config,filter[i],dirname,filename);
    }
  } 
   
  (void) snprintf(filename, MAX_PATH_LENGTH, "fcPCalib-%06d-%d.fit",run,camcol);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/nfcalib",run,rerun);
  print_row("Photometric calibration",config,'\0',dirname,filename);
      
  (void) snprintf(filename, MAX_PATH_LENGTH, "asTrans-%06d.fit",run);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/fastrom",run,rerun);
  have_fastrom = checked_link (config.imaging_url, config.imaging_root, 
			  dirname, "", filelink, MAX_PATH_LENGTH);
  if (have_fastrom) {
    print_row("Astrometric calibration (revised)",config,'\0',dirname,filename);
  } else {
    (void) snprintf(filename, MAX_PATH_LENGTH, "asTrans-%06d.fit",run);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/astrom",run,rerun);
    print_row("Astrometric calibration",config,'\0',dirname,filename);
  }

  /* The coadd runs do not have fpBIN files */
  if (run < 100000) {
    for(i=0;i<5;i++) {
      (void) snprintf(filename, MAX_PATH_LENGTH, "fpBIN-%06d-%c%d-%04d.fit",run,filter[i],camcol,field);
      (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
      print_row("Binned frames",config,filter[i],dirname,filename);
    }
  }
  
  for(i=0;i<5;i++) {
    (void) snprintf(filename, MAX_PATH_LENGTH, "fpM-%06d-%c%d-%04d.fit",run,filter[i],camcol,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
    print_row("Masks",config,filter[i],dirname,filename);
  }

  (void) snprintf(filename, MAX_PATH_LENGTH, "fpAtlas-%06d-%d-%04d.fit",run,camcol,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
  print_row("Atlas images",config,'\0',dirname,filename);
    
  (void) snprintf(filename, MAX_PATH_LENGTH, "psField-%06d-%d-%04d.fit",run,camcol,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
  print_row("Prelimary calib. and final PSF fit",config,'\0',dirname,filename);

  if (config.offer_drC) {
    for(i=0;i<5;i++) {
      (void) snprintf(filename, MAX_PATH_LENGTH, "fpC-%06d-%c%d-%04d.fit.gz",run,filter[i],camcol,field);
      (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/corr/%d",run,rerun,camcol);
      print_row("Original corrected frames",config,filter[i],dirname,filename);
    }
  }
      
  if (have_dr) {
    /* If we do not have drObj and drField, we gave tsObj and tsField at the top */
    (void) snprintf(filename, MAX_PATH_LENGTH, "tsObj-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",run,rerun,camcol);
    print_row("Calibrated object catalog (original)",config,'\0',dirname,filename);
    
    (void) snprintf(filename, MAX_PATH_LENGTH, "tsField-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",run,rerun,camcol);
    print_row("Field calibration and statistics (original)",config,'\0',dirname,filename);
  }

  if (have_fastrom) {
    /* If we do not have fastrom, we gave the original astorm above  */
    (void) snprintf(filename, MAX_PATH_LENGTH, "asTrans-%06d.fit",run);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/astrom",run,rerun);
    print_row("Astrometric calibration (original)",config,'\0',dirname,filename);
  } 

  (void) snprintf(filename, MAX_PATH_LENGTH, "fpObjc-%06d-%d-%04d.fit",run,camcol,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
  print_row("Uncalibrated object catalog",config,'\0',dirname,filename);

  printf("</tbody>\n");
  printf("</table>\n");
  printf("</div>\n");

  printf("</body>\n");
  printf("</html>");
  exit (EXIT_SUCCESS);
}
