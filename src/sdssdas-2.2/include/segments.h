/*! @file segments.h
 * @brief Defines structures used hold a list of imaging segments
 * @author Eric H. Neilsen, Jr.
 */

#define TSV_LINE_LENGTH 2048 /*!< the max length of a line to be loaded */

/*! Holds segment info
 */
typedef struct
{
  int run; /*!< the run number */
  int rerun; /*!< the rerun number */
  int camcol; /*!< the camera column */
  int field; /*!< the first field in the segment */
  int nfields; /*!< the number of fields in the segment */
} segment;

bool read_segment (FILE *in, segment /*@out@*/ *s);
