/*! @file brittle_fits.c
 * @brief routines to support very simpleminded, brittle reading of fits tables
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "brittle_fits.h"

/*! Read past a header in a fits file
 *
 * @param fp the file pointer to the fits file
 * @return true if there was an error
 */
bool
fits_pass_hdr (FILE * fp)
{
  char hcard[81];		/* the contend of the header card read */
  int card_index;		/* the index of the header card read */
  size_t bytes_read = 0;		/* bytes read by fread */
  bool hpassed = false;		/* true if we have encountered the end marker */

  hcard[80] = '\0';
  while (!hpassed)
    {
      for (card_index = 0; card_index < 36; card_index++)
	{
	  bytes_read = fread (hcard, 1, 80, fp);
	  if (bytes_read != 80)
	    return false;
	  hpassed = strncmp (hcard, "END     ", 8) == 0 ? true : hpassed;
	}
    }
  return true;
}

/*! Read a fits header value with an integer value
 *
 * @param fp the file pointer to the fits header
 * @param ptr the pointer to the address into which to put the int
 * @param keyword the string with the keyword to read
 * @return true if there was an error
 */
bool
fits_hdr_int (FILE * fp,	/* file from which to read the header */
	      int /*@out@*/ *ptr,		/* pointer to memory for the value */
	      char *keyword	/* header keyword to load */
  )
{
  char hcard[81];		/* read line */
  size_t bytes_read;		/* bytes read */
  char kw[9];			/* Keyword padded out to 8 characters */
  char *c;			/* pointer to an element of kw */
  bool ended = false;		/* we have passed the end of the header */
  char in_keyword[9];		/* keyword encountered in file */
  char assignment[3];		/* assignment character */
  char comment[71];		/* comment in header */
  int values_read;		/* values scanned from hcard */

  *ptr = 0;

  /* make sure the keyword is a full 8 chars, padding if necessary */
  kw[8] = '\0';
  (void) strncpy (kw, keyword, 8);
  for (c = kw + strlen (kw); c <= kw + 8; c++)
    *c = ' ';

  /* read until we have our value, or reach the end of the header */
  while (!ended)
    {
      bytes_read = fread (hcard, 1, 80, fp);
      if (bytes_read != 80)
	return true;
      if (strncmp (hcard, kw, 8) == 0)
	{
	  values_read = sscanf (hcard, "%8s%1s%i%s",
				in_keyword, assignment, ptr, comment);
	  if (values_read >= 3)
	    return false;
	}
      ended = strncmp (hcard, "END     ", 8) == 0;
    }
  return true;
}

/*! Read a fits header value with an double value
 *
 * @param fp the file pointer to the fits header
 * @param ptr the pointer to the address into which to put the int
 * @param keyword the string with the keyword to read
 * @return true if there was an error
 */
bool
fits_hdr_dbl (FILE * fp,	/* file from which to read the header */
	      double /*@out@*/ *ptr,		/* pointer to memory for the value */
	      char *keyword	/* header keyword to load */
  )
{
  char hcard[81];		/* read line */
  size_t bytes_read;		/* bytes read */
  char kw[9];			/* Keyword padded out to 8 characters */
  char *c;			/* pointer to an element of kw */
  bool ended = false;		/* we have passed the end of the header */
  char in_keyword[9];		/* keyword encountered in file */
  char assignment[3];		/* assignment character */
  char comment[71];		/* comment in header */
  int values_read;		/* values scanned from hcard */

  *ptr = 0.0;

  /* make sure the keyword is a full 8 chars, padding if necessary */
  kw[8] = '\0';
  (void) strncpy (kw, keyword, 8);
  for (c = kw + strlen (kw); c <= kw + 8; c++)
    *c = ' ';

  /* read until we have our value, or reach the end of the header */
  while (!ended)
    {
      bytes_read = fread (hcard, 1, 80, fp);
      if (bytes_read != 80)
	return true;
      if (strncmp (hcard, kw, 8) == 0)
	{
	  values_read = sscanf (hcard, "%8s%1s%lg%s",
				in_keyword, assignment, ptr, comment);
	  if (values_read >= 3)
	    return false;
	}
      ended = strncmp (hcard, "END     ", 8) == 0;
    }
  
  return true;
}

/*! Swap bytes to toggle between little and big endian
 * 
 * @param *in the data to swap
 * @param size the size of the data to swap
 */
static void
swap_bytes (void *in, size_t s)
{
  char *swapped;		/* Buffer for swapped bytes */
  char *outbyte;		/* Pointer to next byte to be written */
  char *inbyte;			/* Pointer to next byte to be read */

  swapped = malloc (s);
  inbyte = (char *) in + s;
  
  /* This memory fiddling really upsets splint; tell it not to worry */
  /*@-nullderef -nullpass -compdef*/
  for (outbyte = swapped; outbyte < swapped + s; outbyte++)
    {
      inbyte--;
      *outbyte = *inbyte;
    }
  memcpy (in, swapped, s);
  /*@=nullderef =nullpass =compdef*/

  free (swapped);
}

/*! Read a data value from a file
 *
 * @param fp the file from which to read the datum
 * @param ptr the address into which to read the datum
 * @param s the number of bytes to read
 * @return true if there was an error in the read
 */
bool 
fits_read_cell (FILE *fp,	/* file pointer from which to read */
		void /*@out@*/ *ptr,	/* address into which to read */
		size_t s	/* number of bytes to read */
		)
{
  size_t bytes_read;		/* number of bytes actually read */
  long endian_test = 1;
  bool little_endian;
  little_endian = (char) (*(char *) &endian_test) == (char) 1;
  bytes_read = fread (ptr, s, 1, fp);
  if (bytes_read != 1)
    return true;
  if (little_endian)
    swap_bytes (ptr, s);
  return false;
}

/*! close the file and return an error code
 *
 * @param fp the file pointer to close
 * @param code the error code to return
 */
int 
fits_error(FILE *fp, /* the file pointer to close */
	   int code /* the error code */
	   )
{
  (void) fclose(fp);
  return code;
}
