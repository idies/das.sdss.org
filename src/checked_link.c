/** @file checked_link.c
 * @brief generate a link if a file exists, text if it does not
 * @author Eric H. Neilsen, Jr.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "file_readable.h"
#include "das_config.h"
#include "checked_link.h"

/*! generate a link if a file exists, text if it does not
 * 
 * @param url_base the base url of the link to generate
 * @param dir_base the base dir in which to look for the file
 * @param dir the relative directory in which to look for the file
 * @param result the string into which to put the result
 * @param result_len the max characters for the result
 * @param filename the name of the file
 * @return true if the file exists
 */
bool
checked_link (char *url_base, char *dir_base, 
	      char *dir, char *filename,
	      char /*@out@*/ *result, size_t result_len)
{
  (void) snprintf(result, result_len,
		  "%s/%s/%s", dir_base, dir, filename);
  if (file_readable(result))
    {
      if (strlen(filename) == 0)
	{
	  (void) snprintf(result, result_len,
			  "<a href=\"%s/%s\">%s</a>", 
			  url_base, dir, dir);
	}
      else
	{
	  (void) snprintf(result, result_len,
			  "<a href=\"%s/%s/%s\">%s</a>", 
			  url_base, dir, filename, filename);
	}
      return true;
    }
  else 
    {
      if (strlen(filename) == 0)
	{
	  (void) snprintf(result, result_len,
			  "<span class=\"missing-file\">%s</span>", dir);
	}
      else
	{
	  (void) snprintf(result, result_len,
			  "<span class=\"missing-file\">%s</span>", filename);
	}
      return false;
    }

}
