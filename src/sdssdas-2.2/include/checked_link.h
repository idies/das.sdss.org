/*! @file checked_link.h
 * @author Eric H. Neilsen, Jr.
 */

bool
checked_link (char *url_base, char *dir_base, 
	      char *dir, char *filename,
	      char /*@out@*/ *result, size_t result_len);

