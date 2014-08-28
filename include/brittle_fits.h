/*! @file brittle_fits.h
 * @brief Declares functions for reading fits files
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdbool.h>

bool fits_pass_hdr (FILE *fp);

bool 
fits_read_cell(FILE *fp, /* file pointer from which to read */
	       void /*@out@*/ *ptr, /* address into which to read */
	       size_t s /* number of bytes to read */
	       );

bool
fits_hdr_int(FILE *fp, /* file from which to read the header */
	     int /*@out@*/ *ptr,  /* pointer to memory for the value */
	     char *keyword /* header keyword to load */
	     );

bool
fits_hdr_dbl(FILE *fp, /* file from which to read the header */
	     double /*@out@*/ *ptr,  /* pointer to memory for the value */
	     char *keyword /* header keyword to load */
	     );

int 
fits_error(FILE *fp, /* the file pointer to close */
	   int code /* the error code */
	   );
