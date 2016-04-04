/*! @file segment_list.h
 * @brief Defines structures used hold a list of imaging segments
 * @author Eric H. Neilsen, Jr.
 */

/*! A node in a doubly linked list of segments
 */
typedef struct segment_link *segment_link_pointer;

/*! A link in a linked list of segments
 */
typedef struct
{
  segment segment; /*!< The data held by this link */
  segment_link_pointer /*@null@*/ /*@owned@*/ next; /*!< a pointer to the next segment in the list */
  segment_link_pointer /*@null@*/ /*@dependent@*/ previous; /*!< a pointer to the p segment in the list */
} segment_link;

/*! Segment list ends
 */
typedef struct 
{
  segment_link /*@null@*/ /*@owned@*/ *first; /*!< a pointer to the first element in the list */
  segment_link /*@null@*/ /*@dependent@*/ *last; /*!< a pointer to the last element in the list */
} slist_ends;

void free_segment_link(segment_link /*@owned@*/ /*@null@*/ *s);

void link_segment(segment_link /*@null@*/ /*@dependent@*/ *previous,
		  slist_ends /*@partial@*/ *ends,
		  segment s);

void print_segments (segment_link /*@null@*/ *first, FILE *out);
