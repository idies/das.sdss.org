/*! @file das_config.c
 * @brief Parse the DAS configuration file
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "das_config.h"

/*! Copy the input value to the output value only if the input and output keywords match
 *
 * Intended to copy the value field of a configuration file
 * into a string holding the content if and only if the keyword
 * in the configuration file matches the provided keyword.
 * 
 * @param in_value pointer to string with input value
 * @param in_keyword pointer to string with input keyword
 * @param out_value pointer to string with output value
 * @param out_keyword pointer to string with output keyword
 * 
 * @return true if value string was copied
 */
static bool
kwcpy (char /*@unique@ */ *in_value, char *in_keyword,
       char *out_value, char *out_keyword)
{
  if (strcmp (in_keyword, out_keyword) == 0)
    {
      strncpy (out_value, in_value, MAX_CONFIG_LINE_LENGTH);
      return true;
    }
  return false;
}

/*! Read the das configuration file into a das configuration struct
 *
 * @param config a pointer to the das config struct to be filled in
 * @param config_file the string holding the file name
 * @return the number of bad lines encountered
 */
void
read_config (das_config /*@out@*/ *config, const char *config_file)
{
  FILE *fp;			/*! pointer to config file descriptor */
  char line[MAX_CONFIG_LINE_LENGTH];	/*! buffer for line read */
  char kw[MAX_CONFIG_LINE_LENGTH];	/*! keyword read for a line */
  char value[MAX_CONFIG_LINE_LENGTH];	/*! value read for a line */
  char drC_str[MAX_CONFIG_LINE_LENGTH];	/*! value read for a line */
  int elements_read;		/*! number of elements read from a line */
  int line_index = 0;		/*! line number of most recently read line */
  bool valid_keyword;		/*! the line contains a valid keyword */

  /* Initialize config to default values */
  strncpy(config->imaging_root, "/srv/das/imaging", MAX_PATH_LENGTH);
  strncpy(config->spectro_root, "/srv/das/spectro", MAX_PATH_LENGTH);
  strncpy(config->scratch_root, "/srv/das/webscratch", MAX_PATH_LENGTH);
  strncpy(config->drdefs_root, "/srv/das/contents/tsv", MAX_PATH_LENGTH);
  strncpy(config->astlimits_fname, "/srv/das/contents/fits/astlimits.fits", MAX_PATH_LENGTH);
  strncpy(config->imaging_url, "http://das.sdss.org/imaging", MAX_URLBASE_LENGTH);
  strncpy(config->spectro_url, "http://das.sdss.org/spectro", MAX_URLBASE_LENGTH);
  strncpy(config->scratch_url, "http://das.sdss.org/webscratch", MAX_URLBASE_LENGTH);
  strncpy(config->cgi_url, "http://das.sdss.org/www/cgi-bin", MAX_URLBASE_LENGTH);
  strncpy(config->rsync_host, "rsync.sdss.org", MAX_HOST_LENGTH);
  strncpy(config->cas_navi_url, "NONE", MAX_URLBASE_LENGTH);
  strncpy(config->cas_obj_url, "NONE", MAX_URLBASE_LENGTH);
  strncpy(drC_str, "no", MAX_CONFIG_LINE_LENGTH);

  fp = fopen (config_file, "r");
  if (fp == NULL)
    {
      fprintf (stderr, "Cannot read configuration file %s\n",
	       config_file);
    }
  else 
    {
      while (fgets (line, MAX_CONFIG_LINE_LENGTH, fp) != NULL)
	{
	  line_index++;
	  
	  /*  get rid of trailing whitespace so that all lines that are
	   *  entirely whitespace have zero length 
	   */
	  while (strlen (line) > 0
		 && (line[strlen (line) - 1] == ' '
		     || line[strlen (line) - 1] == '\t'))
	    {
	      line[strlen (line) - 1] = '\0';
	    }
	  /* only process the line if it has non-zero length or is not a comment */
	  if (strlen (line) > 0 && line[0] != '#')
	    {
	      elements_read = sscanf (line, "%s%s", kw, value);
	      if (kw[strlen(kw)-1]==':' || kw[strlen(kw)-1]=='=')
		{
		  kw[strlen(kw)-1]='\0';
		}
	      if (elements_read == 2)
		{
		  valid_keyword =
		    kwcpy (value, kw, config->imaging_root, "imaging_root")
		    || kwcpy (value, kw, config->spectro_root, "spectro_root")
		    || kwcpy (value, kw, config->scratch_root, "scratch_root")
		    || kwcpy (value, kw, config->drdefs_root, "drdefs_root")
		    || kwcpy (value, kw, config->astlimits_fname, "astlimits_fname")
		    || kwcpy (value, kw, config->imaging_url, "imaging_url")
		    || kwcpy (value, kw, config->spectro_url, "spectro_url")
		    || kwcpy (value, kw, config->scratch_url, "scratch_url")
		    || kwcpy (value, kw, config->cgi_url, "cgi_url")
		    || kwcpy (value, kw, config->cas_navi_url, "cas_navi_url")
		    || kwcpy (value, kw, config->cas_obj_url, "cas_obj_url")
		    || kwcpy (value, kw, drC_str, "offer_drC")
		    || kwcpy (value, kw, config->rsync_host, "rsync_host");
		  if (!valid_keyword)
		    {
		      fprintf (stderr, "Bad keyword %s in line %d of %s\n",
			       kw, line_index, config_file);
		    }
		}
	      else
		{
		  fprintf (stderr, "Could not parse line %d of %s\n",
			   line_index, config_file);
		}
	    }
	}
      (void) fclose(fp);
    }
  config->offer_drC = ( strcmp (drC_str, "yes") == 0 ) ||
    ( strcmp (drC_str, "YES") == 0 ) ||
    ( strcmp (drC_str, "Yes") == 0 ) ||
    ( strcmp (drC_str, "1") == 0 ) ||
    ( strcmp (drC_str, "true") == 0 ) ||
    ( strcmp (drC_str, "TRUE") == 0 ) ||
    ( strcmp (drC_str, "True") == 0 ) ;

}
