/*! @file segment_table.h
 * @brief Declares function to generate table of fields in a segment
 * @author Eric H. Neilsen, Jr.
 */

void
segment_table (FILE *in, FILE *out, 
	       int run, int rerun, int camcol, int zoom, das_config config);
