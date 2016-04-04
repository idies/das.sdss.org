/*! @file coord_xform.c
 * @brief Routines which convert to and from survey-specific coodinate systems
 *
 * This code was taken from astrotools
 * 
 *  There are five coordinate systems:
 *
 *   Equatorial -- ra, dec
 *   Galactic -- galactic longitude, galactic latitude
 *   Great Circle -- mu, nu (with node and inclination also specified)
 *   Survey -- survey longitude, survey latitude (lambda, eta)
 *   Azelpa -- azimuth, elevation, and position angle of the telescope
 *
 * The functions here convert Equatorial coordinates to and from 
 * Galactic, Great Circle, and Survey coordinates; also between Survey
 * and Azelpa.
 *
 * Survey coordinates are (lambda, eta).  Lines of constant lambda are
 * parallels, and lines of constant eta are meridians which go through
 * the survey pole.  The center of a great circle scan will be a line
 * of constant eta.
 *
 * Great circle coordinates (mu, nu) are defined so that the line down the
 * center of a stripe (which is a meridian in survey coordinates) is the
 * parallel nu=0.  So, lines of constant mu are meridians and lines of
 * constant nu are parallels.  Great circle coordinates are specific to a
 * survey stripe.
 *
 * To convert to and from Great Circle coordinates, you must input the
 * node and inclination of the reference great circle.  For "normal" drift
 * scan great circles, use <code>node=at_surveyCenterRa - 90</code>degrees,
 * and <code>inc=survey latitude + at_surveyCenterDec</code>.
 *
 * The survey latitudes for SDSS stripes are <code> +/- n*at_stripeSeparation
 *
 * The limits on these coordinates are:
 *
 *  0 <= (ra, glong, mu) < 360.0
 *  -180.0 <= lambda < 180.0
 *  -90 <= (dec, glat, nu, eta) < 90.0
 *
 * The survey center is defined with the external const double values
 *
 *  at_surveyCenterRa = 185.0
 *  at_surveyCenterDec = 32.5
 *
 * This (ra,dec) transforms to:
 * galactic:  gLong=172.79876542 gLat=81.32406952
 * great circle: (with node=95.0, inclination=32.5) mu=185.0 nu=0.0
 * survey: lambda=0.0 eta=0.0
 */

#include <math.h>
#include <float.h>
#include <string.h>
#include <assert.h>

#include "file_readable.h"
#include "coord_xform.h"
#include "brittle_fits.h"

/* Stop splint from complaining about exported functions that are only
 * used locally. We want to be able to export them conveniently 
 */
/*@-exportlocal */



/*! Set the angle within the specified bounds
 *
 * @param angle pointer with angle to bound in degrees
 * @param min inclusive minimum value
 * @param max exclusive maximum value 
 */
static void
atBound (double *angle,		/* MODIFIED -- the angle to bound in degrees */
	 double min,		/* IN -- inclusive minimum value */
	 double max		/* IN -- exclusive maximum value */
  )
{
  while (*angle - min < DBL_EPSILON)
    {
      *angle += 360.0;
    }
  while (*angle - max >= DBL_EPSILON)
    {
      *angle -= 360.0;
    }
  return;
}

/*! Set the two angles within legal bounds
 *
 * @param theta pointer to the -90 to 90 angle
 * @param phi pointer to the 0 to 360 angle
 */
static void
atBound2 (double *theta,	/* MODIFIED -- the -90 to 90 angle */
	  double *phi		/* MODIFIED -- the 0 to 360 angle */
  )
{
  atBound (theta, -180.0, 180.0);
  if (fabs (*theta) - 90.0 > DBL_EPSILON)
    {
      *theta = 180.0 - *theta;
      *phi += 180;
    }
  atBound (theta, -180.0, 180.0);
  atBound (phi, 0.0, 360.0);
  if (fabs (fabs (*theta) - 90) <= DBL_EPSILON)
    *phi = 0.;
  return;
}

/*! Converts Equatorial coordinates to Great Circle coordinates.
 *
 * @param ra in degrees
 * @param dec in degrees
 * @param pointer to location for mu in degrees
 * @param pointer to location for nu in degrees
 * @param node in degrees
 * @param inclination in degrees
 */
void
atEqToGC (double ra,		/* IN -- ra in degrees */
	  double dec,		/* IN -- dec in degrees */
	  double /*@out@ */ *amu,	/* OUT -- mu in degrees */
	  double /*@out@ */ *anu,	/* OUT -- nu in degrees */
	  double anode,		/* IN -- node in degrees */
	  double ainc		/* IN -- inclination in degrees */
  )
{
  double x1, y1, z1, x2, y2, z2;
  /* Convert to radians */
  ra = ra * at_deg2Rad;
  dec = dec * at_deg2Rad;
  anode = anode * at_deg2Rad;
  ainc = ainc * at_deg2Rad;
  /* Rotation */
  x1 = cos (ra - anode) * cos (dec);
  y1 = sin (ra - anode) * cos (dec);
  z1 = sin (dec);
  x2 = x1;
  y2 = y1 * cos (ainc) + z1 * sin (ainc);
  z2 = -y1 * sin (ainc) + z1 * cos (ainc);

  *amu = atan2 (y2, x2) + anode;
  *anu = asin (z2);
  /* Convert back to degrees */
  *amu = *amu * at_rad2Deg;
  *anu = *anu * at_rad2Deg;
  atBound2 (anu, amu);
  return;
}

/*! Converts Great Circle to Equatorial coordinates.
 * 
 * @param mu in degrees
 * @param nu in degrees
 * @param pointer to location for ra in degrees
 * @param pointer to location for dec in degrees
 * @param node in degrees
 * @param inclination in degrees
 */
void
atGCToEq (double amu,		/* IN -- mu in degrees */
	  double anu,		/* IN -- nu in degrees */
	  double /*@out@ */ *ra,	/* OUT -- ra in degrees */
	  double /*@out@ */ *dec,	/* OUT -- dec in degrees */
	  double anode,		/* IN -- node in degrees */
	  double ainc		/* IN -- inclination in degrees */
  )
{
  double x1, y1, z1, x2, y2, z2;
  /* Convert to radians */

  amu = amu * at_deg2Rad;
  anu = anu * at_deg2Rad;
  anode = anode * at_deg2Rad;
  ainc = ainc * at_deg2Rad;
  /* Rotation */
  x2 = cos (amu - anode) * cos (anu);
  y2 = sin (amu - anode) * cos (anu);
  z2 = sin (anu);
  x1 = x2;
  y1 = y2 * cos (ainc) - z2 * sin (ainc);
  z1 = y2 * sin (ainc) + z2 * cos (ainc);

  *ra = atan2 (y1, x1) + anode;
  *dec = asin (z1);
  /* Convert back to degrees */
  *ra = *ra * at_rad2Deg;
  *dec = *dec * at_rad2Deg;
  atBound2 (dec, ra);
  return;
}

/*! Convert x, y to xp, yp
 *
 * @param trans astrometric transform structure
 * @param row row
 * @param col column
 * @param x pointer to undistorted row
 * @param y pointer to undistorted column
 */
static void
pixToXY (trans trans,		/* transform struct */
	 double row,		/* row */
	 double col,		/* column */
	 double /*@out@ */ *x,	/* pointer to mu */
	 double /*@out@ */ *y	/* pointer to nu */
  )
{
  *x = row + trans.dRow0 + trans.dRow1 * col + trans.dRow2 * col * col +
    trans.dRow3 * col * col * col + trans.ccRow;

  *y = col + trans.dCol0 + trans.dCol1 * col + trans.dCol2 * col * col +
    trans.dCol3 * col * col * col + trans.ccCol;

  return;
}

/*! Convert x, y to mu, nu
 *
 * @param trans astrometric transform structure
 * @param x undistorted row
 * @param y undistorted column
 * @param mu pointer to mu coordinate
 * @param nu pointer to nu coordinate
 */
void
xyToGC (trans trans,		/* transform struct */
	double x,		/* row */
	double y,		/* column */
	double /*@out@ */ *mu,	/* pointer to mu */
	double /*@out@ */ *nu	/* pointer to nu */
  )
{

  *mu = trans.a + trans.b * x + trans.c * y;
  *nu = trans.d + trans.e * x + trans.f * y;
  return;
}

/*! Convert x, y to mu, nu
 *
 * @param trans astrometric transform structure
 * @param row row
 * @param col column
 * @param mu pointer to mu coordinate
 * @param nu pointer to nu coordinate
 */
void
pixToGC (trans trans,		/* transform struct */
	 double row,		/* row */
	 double col,		/* column */
	 double /*@out@ */ *mu,	/* pointer to mu */
	 double /*@out@ */ *nu	/* pointer to nu */
  )
{
  double x;			/* x prime from astrom xform eqns */
  double y;			/* y prime from astrom xform eqns */

  pixToXY (trans, row, col, &x, &y);
  xyToGC (trans, x, y, mu, nu);

  return;
}

/*! Convert mu, nu to x, y
 * 
 * @param trans astrometric transform structure
 * @param mu coordinate
 * @param nu coordinate
 * @param x pointer to undistorted row
 * @param y pointer to undistorted column
 */
void
gcToXY (trans trans,		/* transform struct */
	double mu,		/* mu */
	double nu,		/* nu */
	double /*@out@ */ *x,	/* pointer to x */
	double /*@out@ */ *y	/* pointer to y */
  )
{
  double a, b, c, d, e, f;
  double tmu, tnu; /* test mu and nu values */

  a = trans.a;
  b = trans.b;
  c = trans.c;
  d = trans.d;
  e = trans.e;
  f = trans.f;

  *y = (mu * e + b * d - e * a - b * nu) / (c * e - b * f);
  *x = (nu - d - (f * (*y))) / e;

  /* test that we get the correct answer */
  xyToGC(trans, *x, *y, &tmu, &tnu);
  assert(fabs(mu-tmu) - 1.0e-10 < DBL_EPSILON);
  assert(fabs(nu-tnu) - 1.0e-10 < DBL_EPSILON);

  return;
}

/*! convert xp, yp to row, col
 *
 * @param trans astrometric transform structure
 * @param x undistorted row
 * @param y undistorted column
 * @param row pointer to row
 * @param col pointer to column
 */
static void
xyToPix (trans trans,		/* transform struct */
	 double x,		/* x */
	 double y,		/* y */
	 double /*@out@ */ *row,	/* pointer to row */
	 double /*@out@ */ *col	/* pointer to column */
  )
{
  double cols[INTERP_ORDER];	/* col values of sample points */
  double ys[INTERP_ORDER];	/* y values of sample points */
  int i, j, k;			/* the index of the sample point being calculated */
  double rows, xs;		/* placeholder */
  double factor;		/* the factor for the current term in the interp. */
  double tx, ty;                /* test values */

  /* Start by getting y */

  /* Use Lagrange's interpolation method */

  /* calculate sample points */
  rows = x;
  for (i = 0; i < INTERP_ORDER; i++)
    {
      cols[i] = (double) (i * Y_SIZE / (INTERP_ORDER - 1));
      pixToXY (trans, rows, cols[i], &xs, &(ys[i]));
    }

  /* Interpolate using Lagrange's method; 
   *  see Bevington, 2nd ed., p 222
   *  or Lanczos, p396
   */
  *col = 0.0;
  for (k = 0; k < INTERP_ORDER; k++)
    {
      factor = 1.0;
      for (j = 0; j < INTERP_ORDER; j++)
	if (k != j)
	  factor *= (y - ys[j]) / (ys[k] - ys[j]);
      *col += factor * cols[k];
    }

  /* Now, get x */
  *row = x - (trans.dRow0 + trans.dRow1 * *col + trans.dRow2 * *col * *col +
	      trans.dRow3 * *col * *col * *col + trans.ccRow);

  /* Test our answer */
  pixToXY (trans, *row, *col, &tx, &ty);
  assert(fabs(x-tx) - 0.001 < DBL_EPSILON);
  assert(fabs(y-ty) - 0.001 < DBL_EPSILON);

  return;
}


/*! Convert mu, nu to x, y 
 *
 * @param trans astrometric transform structure
 * @param mu coordinate
 * @param nu coordinate
 * @param row pointer to row
 * @param col pointer to column
 */
void
gcToPix (trans trans,		/* transform struct */
	 double mu,		/* mu */
	 double nu,		/* nu */
	 double /*@out@ */ *row,	/* pointer to row */
	 double /*@out@ */ *col	/* pointer to column */
  )
{
  double x, y;			/* x and y coordinates */
  double tmu, tnu;              /* test mu and nu */

  gcToXY (trans, mu, nu, &x, &y);
  xyToPix (trans, x, y, row, col);

  /* test our result */
  pixToGC (trans, *row, *col, &tmu, &tnu);
  assert(fabs(mu-tmu) - 1.0e-8 < DBL_EPSILON);
  assert(fabs(nu-tnu) - 1.0e-8 < DBL_EPSILON);

  return;
}


/*! Read the trans structure from a tsField file 
 * 
 * @param filename the name of the tsField file
 * @param trans the pointer to the array of trans structures to fill out
 * @param node the node of the great circle
 * @param incl the incl of the great circle
 * @return 0 if and only if successful
 */
int
read_trans (const char *filename,	/* the name of the tsField file to read */
	    trans /*@out@ */  *trans,	/* the structure in to which to read the trans file */
	    double /*@out@ */ *node,	/* node */
	    double /*@out@ */ *incl	/* inclination */
  )
{
  FILE *fp;			/* file pointer to the fits file */
  int error_code = 0;		/* error code to return */
  int filter;			/* filter being read */
  long field, quality;		/* cols that must be read past */

  /* initializations to make splint happy */
  *node = 0;
  *incl = 0;

  if (!file_readable((char *)filename))
    {
      return 64;
    }

  fp = fopen (filename, "r");
  assert (fp != NULL);

  /*@+boolint */
  if (fits_hdr_dbl (fp, node, "NODE"))
    error_code = error_code || 16;
  if (fits_hdr_dbl (fp, incl, "INCL"))
    error_code = error_code || 32;
  rewind (fp);
  if (!fits_pass_hdr (fp))
    error_code = error_code || 2;
  if (!fits_pass_hdr (fp))
    error_code = error_code || 4;
  if (fits_read_cell (fp, &field, 4))
    error_code = error_code || 8;
  if (fits_read_cell (fp, &quality, 4))
    error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell (fp, &(trans[filter].a), sizeof (trans[filter].a)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell (fp, &(trans[filter].b), sizeof (trans[filter].b)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell (fp, &(trans[filter].c), sizeof (trans[filter].c)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell (fp, &(trans[filter].d), sizeof (trans[filter].d)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell (fp, &(trans[filter].e), sizeof (trans[filter].e)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell (fp, &(trans[filter].f), sizeof (trans[filter].f)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dRow0), sizeof (trans[filter].dRow0)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dRow1), sizeof (trans[filter].dRow1)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dRow2), sizeof (trans[filter].dRow2)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dRow3), sizeof (trans[filter].dRow3)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dCol0), sizeof (trans[filter].dCol0)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dCol1), sizeof (trans[filter].dCol1)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dCol2), sizeof (trans[filter].dCol2)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].dCol3), sizeof (trans[filter].dCol3)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].csRow), sizeof (trans[filter].csRow)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].csCol), sizeof (trans[filter].csCol)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].ccRow), sizeof (trans[filter].ccRow)))
      error_code = error_code || 8;
  for (filter = 0; filter < 5; filter++)
    if (fits_read_cell
	(fp, &(trans[filter].ccCol), sizeof (trans[filter].ccCol)))
      error_code = error_code || 8;
  /*@=boolint */
  (void) fclose (fp);
  
  return error_code;
}

/*! Converts row, column to Equatorial coordinates.
 * 
 * @param row row
 * @param col column
 * @param trans astrometric transform structure
 * @param node in degrees
 * @param inclination in degrees
 * @param ra in degrees
 * @param dec in degrees
 */
void
pixToEq (double row,		/* IN -- row */
	 double col,		/* IN -- col */
	 trans t,		/* transform */
	 double node,		/* IN -- node in degrees */
	 double incl,		/* IN -- inclination in degrees */
	 double /*@out@ */ *ra,	/* OUT -- ra in degrees */
	 double /*@out@ */ *dec	/* OUT -- dec in degrees */
  )
{
  double mu, nu;		/* mu and nu coordinates */
  pixToGC (t, row, col, &mu, &nu);
  atGCToEq (mu, nu, ra, dec, node, incl);
}

/*! Converts Equatorial coordinates to row, column
 * 
 * @param ra in degrees
 * @param dec in degrees
 * @param trans astrometric transform structure
 * @param node in degrees
 * @param inclination in degrees
 * @param row row
 * @param col column
 */
void
eqToPix (double ra,		/* IN -- ra in degrees */
	 double dec,		/* IN -- dec in degrees */
	 trans t,		/* transform */
	 double node,		/* IN -- node in degrees */
	 double incl,		/* IN -- inclination in degrees */
	 double /*@out@ */ *row,	/* OUT -- row */
	 double /*@out@ */ *col	/* OUT -- col */
  )
{
  double mu, nu;		/* mu and nu coordinates */

  atEqToGC (ra, dec, &mu, &nu, node, incl);
  gcToPix (t, mu, nu, row, col); 

}

/*@=exportlocal */
