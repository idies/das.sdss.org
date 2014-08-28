/*! @file segment_defs.c
 * @brief Tools for linked lists of segments
 *
 * @author Eric H. Neilsen, Jr.
 */

/******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "brittle_fits.h"
#include "das_config.h"
#include "coord_xform.h"
#include "find_fields.h"

/*! Allocate an array to hold segment defs, and read the contents from fits
 *
 * @param segment_limits a pointer to the memory into which to write the defs
 * @param filename the name of the file from which to load the defs
 * @param nsegments pointer to the number of segments
 */
int
load_segment_defs (const char *filename,	/* file pointer to the fits file */
		   segment_def /*@out@*/ /*@dependent@*/ **s0,	/* pointer to the defs */
		   int *n	/* number of segments */
  )
{
  FILE *fp;			/* file pointer to the fits file */
  segment_def /*@dependent@*/ *s;		/* pointer to segment def being read */

  short run, rerun, camcol, field0, nFields;
  double node, incl;
  int muMin, muMax, nuMin, nuMax;

  int i;                        /* the index of the current segment */

  /* make sure types match fits sizes */
  assert(sizeof(short)==2);
  assert(sizeof(int)==4);
  assert(sizeof(double)==8);

  /* initializations to make splint happy */
  *n = 0;
  *s0 = NULL;

  fp = fopen (filename, "r");
  assert (fp != NULL);

  if (!fp)
    return fits_error (fp, 1);
  (void) fits_pass_hdr(fp);
  if (fits_hdr_int (fp, n, "NAXIS2"))
    return fits_error (fp, 2);

  s = malloc (*n * sizeof (segment_def));
  if (s == NULL)
    return fits_error (fp, 4);
  *s0 = s;

  /* go to the beginning of the data */
  rewind(fp);
  (void) fits_pass_hdr(fp);
  (void) fits_pass_hdr(fp);
  for (i=0; i<*n; i++)
    {
      s = &((*s0)[i]);
      if (fits_read_cell (fp, &run, sizeof(run)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &rerun, sizeof(rerun)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &camcol, sizeof(camcol)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &node, sizeof(node)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &incl, sizeof(incl)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &field0, sizeof(field0)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &nFields, sizeof(nFields)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &muMin, sizeof(muMin)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &muMax, sizeof(muMax)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &nuMin, sizeof(nuMin)))
	return fits_error (fp, 8);
      if (fits_read_cell (fp, &nuMax, sizeof(nuMax)))
	return fits_error (fp, 8);
      s->run = run;
      s->rerun = rerun;
      s->camcol = camcol;
      s->node = node;
      s->incl = incl;
      s->field0 = field0;
      s->nFields = nFields;
      s->muMin = muMin;
      s->muMax = muMax;
      s->nuMin = nuMin;
      s->nuMax = nuMax;
    }

  (void) fclose (fp);

  return 0;

}

void
free_field_list (field_node_pointer *f0p /* pointer to the start of the list to free */
		)
{
  field_node /*@dependent@*/ *f = NULL;
  field_node *last = NULL;

  /* this idiotic method of deallocating the stack placates splint */
  if (*f0p != NULL)
    {
      f = (field_node *) *f0p;
      while(f->next != NULL)
	{
	  while (((field_node *)f->next)->next != NULL)
	    f = (field_node *) f->next;
	  last = (field_node *)(f->next);
	  assert(last->next == NULL);
	  free(last);
	  f->next = NULL;
	  f = (field_node *) *f0p;
	}
      assert(((field_node *) *f0p)->next == NULL);
      free(*f0p);
      *f0p = NULL;
    }
  *f0p = NULL;
}

/*! return a list of estimated fields for a given set a coordinates
 * 
 * @param ra the RA
 * @param dec the dec
 * @param s0 the array of segment definitions
 * @param n the number of segments in the array
 * @param f0p a pointer to a pointer to the first node in the linked list of returns
 * @return the number of matches
 */
int
matching_fields (double ra,	/* the ra in decimal degrees */
		 double dec,	/* the dec in decimal degs */
		 segment_def /*@null@*/ *s0,	/* start of array segment defs */
		 int n,	        /* the number of segments */
		 field_node_pointer *f0p	/* start of linked list of fields to be returned */
  )
{
  int nFields = 0;	       	/* the number of matching fields */
  double dmu, dnu;		/* the mu and nu coordinates of in the run considered in decimal degrees */
  int mu, nu;			/* the mu and nu coordinates of in the run considered in arcsecords */
  trans trans[5];		/* the astrometry transform for the field in question */
  double node, incl;		/* the node and inclination of the segment in question */
  das_config config;		/* the DAS configuration */
  char filename[MAX_PATH_LENGTH];	/* the name of the tsField file */
  char dirname[MAX_PATH_LENGTH];	/* the directory where the tsField file can be found */
  segment_def *s;               /* the current segment */
  int error_code = 0;           /* an error code */
  int i;                        /* the index of the current segment */

  field_node f;	/* current field being checked */
  field_node_pointer *next_node = NULL; /* pointer to pointer to next field */

  free_field_list(f0p);
  next_node = f0p;

  if (s0 == NULL)
    {
      assert(n == 0);
      return 0;
    }

  read_config (&config, DAS_CONFIG_FILE);

  for (i=0; i<n; i++)
    {
      s = &(s0[i]);

      atEqToGC (ra, dec, &dmu, &dnu, s->node, s->incl);
      nu = (int) (3600.0 * dnu);
      mu = (int) (3600.0 * dmu);

      /* If the run passes mu=360, check mu>360 as well */
      /* 1296000 = 60*60*360 */
      if (s->muMin < 1296000 && s->muMax > 1296000 && mu < (s->muMax % 1296000))
	{
	  mu += 1296000;
	  /* When a run goes past mu=360 deg, the "a" values in the 
	     astrometric transform keep rising past 360, so we need
	     to use mu values over 360 */
	  dmu += 360;
	}

      if (nu > s->nuMin && nu < s->nuMax && mu > s->muMin && mu < s->muMax)
	{
	  (void) snprintf (dirname, MAX_PATH_LENGTH, "%s/%d/%d/calibChunks/%d",
			   config.imaging_root, s->run, s->rerun, s->camcol);

	  f.next = NULL;
	  f.ra = ra;
	  f.dec = dec;
	  f.run = s->run;
	  f.rerun = s->rerun;
	  f.camcol = s->camcol;
	  f.field = s->field0 +
	    (short)(((mu - s->muMin) * s->nFields) / (s->muMax - s->muMin));

	  (void) snprintf (filename, MAX_PATH_LENGTH,
			   "%s/tsField-%06d-%d-%d-%04d.fit", dirname, s->run,
			   s->camcol, s->rerun, f.field);
	  error_code = read_trans (filename, trans, &node, &incl);
	  if (error_code == 0)
	    {
	      gcToXY (trans[2], dmu, dnu, &(f.row), &(f.col));
	      while ((int)f.row < 0 && f.field > s->field0 && error_code == 0)
		{
		  f.field--;
		  (void) snprintf (filename, MAX_PATH_LENGTH,
				   "%s/tsField-%06d-%d-%d-%04d.fit", dirname, s->run,
				   s->camcol, s->rerun, f.field);
		  error_code = read_trans (filename, trans, &node, &incl);
		  if (error_code == 0)
		    gcToXY (trans[2], dmu, dnu, &(f.row), &(f.col));
		}
	      while ((int)f.row > NROWS && f.field < s->field0 + s->nFields && error_code == 0)
		{
		  f.field++;
		  (void) snprintf (filename, MAX_PATH_LENGTH,
				   "%s/tsField-%06d-%d-%d-%04d.fit", dirname, s->run,
				   s->camcol, s->rerun, f.field);
		  error_code = read_trans (filename, trans, &node, &incl);
		  if (error_code == 0)
		    gcToXY (trans[2], dmu, dnu, &(f.row), &(f.col));
		}
	      
	      if ((int)f.row <= NROWS + 1 && (int)f.row > 0 && (int)f.col > 0
		  && (int)f.col < NCOLS + 1 && error_code == 0)
		{
		  *next_node = malloc(sizeof(field_node));
		  assert(*next_node != NULL);
		  memcpy(*next_node, &f, sizeof(field_node));
		  next_node = &(((field_node *)(*next_node))->next);
		  nFields++;
		}
	    }
	}
    }
  
  return nFields;
}
