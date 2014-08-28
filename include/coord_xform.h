/*! @file coord_xform.h
 * @brief header for routines which convert to and from survey-specific coodinate systems
 */

/* Stop splint from complaining about exported functions that are only
 * used locally. We want to be able to export them conveniently 
 */
/*@-exportlocal */



#define at_deg2Rad 0.0174532925199432955
#define at_rad2Deg 57.2957795130823229
#define INTERP_ORDER 4
#define Y_SIZE 2048

typedef struct
{
  double a, b, c, d, e, f;	/* affine transformation terms */
  double dRow0, dRow1, dRow2, dRow3;	/* row optical distortion terms */
  double dCol0, dCol1, dCol2, dCol3;	/* column optical distortion terms */
  double csRow, csCol;		/* Slope in DCR correction for blue objects */
  double ccRow, ccCol;		/* DCR constant terms (used when r'-i' >= riCut) */
} trans;

void atEqToGC (double ra,	/* IN -- ra in degrees */
	       double dec,	/* IN -- dec in degrees */
	       double /*@out@ */ *amu,	/* OUT -- mu in degrees */
	       double /*@out@ */ *anu,	/* OUT -- nu in degrees */
	       double anode,	/* IN -- node in degrees */
	       double ainc	/* IN -- inclination in degrees */
	       );

void atGCToEq (double amu,	/* IN -- mu in degrees */
	       double anu,	/* IN -- nu in degrees */
	       double /*@out@ */ *ra,	/* OUT -- ra in degrees */
	       double /*@out@ */ *dec,	/* OUT -- dec in degrees */
	       double anode,	/* IN -- node in degrees */
	       double ainc	/* IN -- inclination in degrees */
	       );

int read_trans (const char *filename,	/* the name of the tsObj file to read */
		trans /*@out@ */  * trans,	/* the structure in to which to read the trans file */
		double /*@out@ */ *node,	/* node */
		double /*@out@ */ *incl	/* inclination */
		);

void pixToGC (trans trans,	/* transform struct */
	      double row,	/* row */
	      double col,	/* column */
	      double /*@out@ */ *mu,	/* pointer to mu */
	      double /*@out@ */ *nu	/* pointer to nu */
	      );

void gcToXY (trans trans,		/* transform struct */
	     double mu,		/* mu */
	     double nu,		/* nu */
	     double /*@out@ */ *x,	/* pointer to x */
	     double /*@out@ */ *y	/* pointer to y */
	     );

void gcToPix (trans trans,	/* transform struct */
	      double mu,	/* mu */
	      double nu,	/* nu */
	      double /*@out@ */ *col,	/* pointer to row */
	      double /*@out@ */ *row	/* pointer to column */
	      );

void pixToEq (double row,	/* IN -- ROW */
	      double col,	/* IN -- COL */
	      trans t,	/* transform */
	      double node,	/* IN -- node in degrees */
	      double incl,	/* IN -- inclination in degrees */
	      double /*@out@ */ *ra,	/* OUT -- ra in degrees */
	      double /*@out@ */ *dec	/* OUT -- dec in degrees */
	      );

void eqToPix (double ra,	/* IN -- ra in degrees */
	      double dec,	/* IN -- dec in degrees */
	      trans t,	/* transform */
	      double node,	/* IN -- node in degrees */
	      double incl,	/* IN -- inclination in degrees */
	      double /*@out@ */ *row,	/* OUT -- row */
	      double /*@out@ */ *col	/* OUT -- col */
	      );

/*@=exportlocal */
