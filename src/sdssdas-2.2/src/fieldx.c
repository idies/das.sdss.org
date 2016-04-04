/** @file fieldx.c
 * @brief CGI program generate xml describing a field
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "das_config.h"

static
void print_row(char *type, das_config config, char filter, 
	      char *directory, char *filename) {
  if (filter == '\0') 
    printf("  <datafile type=\"%s\">\n",type);
  else 
    printf("  <datafile type=\"%s\" filter=\"%c\">\n",type,filter);

  printf("    <dirname url=\"%s/%s\">%s</dirname>\n",config.imaging_url,directory,directory);
  printf("    <filename url=\"%s/%s/%s\">%s</filename>\n",config.imaging_url,directory,filename,filename);
  printf("  </datafile>\n");
}

int main(void)
{
  char *query;
  int run, rerun, camcol, field, zoom;
  char *filter="ugriz";
  char filename[MAX_PATH_LENGTH];
  char dirname[MAX_PATH_LENGTH];
  int i;
  int read_params;
  int zooms[]={0,5,10,15,20,25,30};
  int nzooms=7;
  das_config config;		/* the DAS configuration */

  read_config(&config, DAS_CONFIG_FILE);

  query = getenv("QUERY_STRING");
  assert(query != NULL);
  
  read_params=sscanf(query,"RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&ZOOM=%d",
		     &run, &rerun, &camcol, &field, &zoom);
  if (read_params < 5) {
    zoom=15;
  }

  printf("Content-type:text/xml\n\n");
  printf("<?xml version=\"1.0\"?>\n");
  printf("<?xml-stylesheet type=\"text/xsl\" href=\"../fieldx.xsl\"?>\n");
  printf("<field run=\"%d\" rerun=\"%d\" camcol=\"%d\" number=\"%d\">\n",
	 run, rerun, camcol, field);

  for(i=0;i<nzooms;i++) {
    printf("<zoom zoom=\"%d\" url=\"%s/%d/%d/Zoom/%d/fpC-%06d-%d-%d-%04d-z%02d.jpeg\"/>\n",
	   zooms[i],config.imaging_url,run,rerun,camcol,run,camcol,rerun,field,zooms[i]);
  }

  (void) snprintf(filename, MAX_PATH_LENGTH, "tsObj-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",run,rerun,camcol);
  print_row("tsObj",config,'\0',dirname,filename);

  (void) snprintf(filename, MAX_PATH_LENGTH, "tsField-%06d-%d-%d-%04d.fit",run,camcol,rerun,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/calibChunks/%d",run,rerun,camcol);
  print_row("tsField",config,'\0',dirname,filename);

  for(i=0;i<5;i++) {
    (void) snprintf(filename, MAX_PATH_LENGTH, "fpC-%06d-%c%d-%04d.fit.gz",run,filter[i],camcol,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/corr/%d",run,rerun,camcol);
    print_row("fpC",config,filter[i],dirname,filename);
  }
      
  for(i=0;i<5;i++) {
    (void) snprintf(filename, MAX_PATH_LENGTH, "fpBIN-%06d-%c%d-%04d.fit",run,filter[i],camcol,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
    print_row("fpBIN",config,filter[i],dirname,filename);
  }
  
  for(i=0;i<5;i++) {
    (void) snprintf(filename, MAX_PATH_LENGTH, "fpM-%06d-%c%d-%04d.fit",run,filter[i],camcol,field);
    (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
    print_row("fpM",config,filter[i],dirname,filename);
  }

  (void) snprintf(filename, MAX_PATH_LENGTH, "fpAtlas-%06d-%d-%04d.fit",run,camcol,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
  print_row("fpAtlas",config,'\0',dirname,filename);
    
  (void) snprintf(filename, MAX_PATH_LENGTH, "psField-%06d-%d-%04d.fit",run,camcol,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
  print_row("psField",config,'\0',dirname,filename);

  (void) snprintf(filename, MAX_PATH_LENGTH, "fpObjc-%06d-%d-%04d.fit",run,camcol,field);
  (void) snprintf(dirname, MAX_PATH_LENGTH, "%d/%d/objcs/%d",run,rerun,camcol);
  print_row("fpObjc",config,'\0',dirname,filename);

  printf("</field>");
  exit (EXIT_SUCCESS);
}
