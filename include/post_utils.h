/*! @file post_utils.h
 * @brief Defines structures used to parse multipart/form-data into tsv specs.
 * @author Eric H. Neilsen, Jr.
 */

#define MAX_FIELD_LENGTH 1024 /*!< buffer size for individual read lines */
#define MAX_LINE_LENGTH 1024 /*!< buffer size for individual read lines */
#define MAX_LINES_READ 10000 /*!< max number of lines to read from a single submission */

/*! Data we want from the header of a part of the multipart form submission 
 */
typedef struct
{
  char disposition[MAX_FIELD_LENGTH]; /*!< Value of disposition field in part header */
  char name[MAX_FIELD_LENGTH]; /*!< Value of name field in part header */
  char filename[MAX_FIELD_LENGTH]; /*!< Value of filename field in part header, if present */
  char type[MAX_FIELD_LENGTH]; /*!< type field in part header */
} part_header;

int
process_post (FILE *fp, 
	      bool (*process_func)(char *, das_config config, FILE *, char *), 
	      bool (*process_func_rerun)(char *, das_config config, FILE *, char *), 
	      das_config config, 
	      char /*@out@*/ *list_id, int *dataset);

bool
cgi_protect (char *line);

/*! A duplicate of the POSIX declaration, placed here to appease splint. */
char *
mkdtemp (char *__template);
