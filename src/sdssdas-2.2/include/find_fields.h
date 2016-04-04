/*! @file segment_defs.h
 * @brief header defining and handling the structure that defines segment limits
 */

#define NROWS 1489
#define NCOLS 2048

typedef struct
{
  short run;                    /* the run number */
  short rerun;                  /* the rerun number */
  short camcol;                 /* the camera column */
  double node;                  /* the node of the great circle covered by this run */
  double incl;                  /* the incl of the great circle covered by this run */
  short field0;                 /* field number of the first field in the segment */
  short nFields;                /* number of fields in the segment */
  int muMin, muMax;             /* range of mu, in arcseconds */
  int nuMin, nuMax;             /* range of nu, in arcseconds */
} segment_def;

typedef struct field_node /*@owned@*/ /*@null@*/ *field_node_pointer;

typedef struct
{
  double ra;                    /* the RA in decimal degrees */
  double dec;                   /* the dec in decimal degrees */
  short run;                    /* the run number */
  short rerun;                  /* the rerun number */
  short camcol;                 /* the camera column */
  short field;                  /* field number of the first field in the segment */
  double row;                   /* the row of the coordinate in the field */
  double col;                   /* the column of the coordinate in the field */
  field_node_pointer next;      /* pointer to the next node in the linked list */
} field_node;

typedef struct coord_node *coord_node_pointer;

typedef struct
{
  double ra;                    /* the RA in decimal degrees */
  double dec;                   /* the dec in decimal degrees */
  coord_node_pointer /*@dependent@*/ *next;     /* pointer to the next node in the linked list */
} coord_node;

int
load_segment_defs(const char *filename,  /* file pointer to the fits file */
		  segment_def  /*@out@*/ /*@dependent@*/ **s0, /* pointer to the defs */
		  int *n /* number of segments */
		  );

void
free_field_list (field_node_pointer *f0 /* pointer to the start of the list to free */
		 );

int
matching_fields (double ra,	/* the ra in decimal degrees */
		 double dec,	/* the dec in decimal degs */
		 segment_def  /*@null@*/ *s0,	/* start of array segment defs */
		 int n,	          /* the number of segments */
		 field_node_pointer *f0p  /* start of linked list of fields to be returned */
		 );
