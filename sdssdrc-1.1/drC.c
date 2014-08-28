/*! \brief sent to stdout a frame file from an fpC file by adding header keywords
 *
 * Author: Eric H. Neilsen, Jr.
 * Date: $Date: 2008/11/07 19:19:11 $
 * Version: $Name:  $
 * Revision: $Revision: 1.5 $
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <sysexits.h>
#include <alloca.h>
#include <math.h>
#include <unistd.h>
#include "config.h"
#include "fitsio.h"
#include "md5.h"

static const char bin2hex[] = { '0', '1', '2', '3',
				'4', '5', '6', '7',
				'8', '9', 'a', 'b',
				'c', 'd', 'e', 'f' };

void manage_fitserror(int status);
void add_double_keyword_from_table(fitsfile *table, fitsfile *image, char *column, char *keyword, char *comment, int filter);
void add_long_keyword_from_table(fitsfile *table, fitsfile *image, char *column, char *keyword, char *comment, int filter);
void copy_string_key(fitsfile *origin, fitsfile *destination, char *keyword);
double mag2counts(fitsfile *fits, double mag);
double counts2mag(fitsfile *fits, double counts);
double sky_counts(fitsfile *fits);
double zeropoint(fitsfile *fits);

int
main (int argc, const char **argv)
{
  const char in_dir[] = IMDATADIR;     /**< the base directory of the tree with the fpC files */
  char *query;             /**< points to the cgi string */
  int read_params;         /**< parames read from cgi string */
  int run;                 /**< the run number */
  int rerun;               /**< the rerun */
  int camcol;              /**< the camera column */
  char filter;             /**< the filter (u, g, r, i, z) */
  int field;               /**< the field number */
  int filter_index;        /**< the filter index */

  char *fpC_name;          /**< the fully qualified name of the fpC file */
  char fpC_base[39];       /**< the base name of the fpC file */
  FILE *fpC_file;          /**< file handle for fpC file used to read raw */
  char md5bin[16];         /**< binary representation of fpC file md5sum */
  char md5hex[33];         /**< hex representation of the fpC file md5sum (plus a byte for a string terminator)*/
  int byte_index;          /**< index of the byte being converted to hex*/

  char *tsField_name;      /**< the name of the tsField file */
  char *outFile_name;      /**< the name of the output file */

  fitsfile *fpC;            /**< the fpC fits file */
  fitsfile *tsField;        /**< the tsField file */
  fitsfile *outFile;        /**< the newly created fits file */
  int fits_status = 0;      /**< status data from cfitsio */
  long n_fields = 0;        /**< the number of fields listed tsField */
  char comment[80];         /**< Comment from read fits keyword */
  double datum;
  double b;                 /**< photo softening parameter */
  double flux0, flux20, zp; /**< photometric calib values */
  double sky;               /**< sky level */
  double exptime=53.905;    /**< the exposure time */
  char sexptime[80];        /**< the exposure time expressed as a string */
  sexptime[0]='\0';

  /* Process user supplied options and arguments */
  query = getenv("QUERY_STRING");
  if (query == NULL) 
    exit(EX_NOINPUT);
  
  read_params=sscanf(query,"RUN=%d&RERUN=%d&CAMCOL=%d&FIELD=%d&FILTER=%c",
		     &run, &rerun, &camcol, &field, &filter);
  if (read_params != 5) 
    exit(EX_DATAERR);

  sprintf(fpC_base,"fpC-%06d-%c%1d-%04d.fit.gz",run, filter, camcol, field);
  fpC_name = alloca(strlen(in_dir)+(int)log10(run)+(int)log10(rerun)+38);
  sprintf(fpC_name,"%s/%d/%d/corr/%1d/%s",in_dir, run, rerun, camcol, fpC_base);

  tsField_name = alloca(strlen(in_dir)+(int)log10(run)+2*(int)log10(rerun)+47);
  sprintf(tsField_name,"%s/%d/%d/dr/%1d/drField-%06d-%1d-%d-%04d.fit",
	  in_dir, run, rerun, camcol, run, camcol, rerun, field);
  if (access(tsField_name, R_OK) != 0) {
    sprintf(tsField_name,"%s/%d/%d/calibChunks/%1d/tsField-%06d-%1d-%d-%04d.fit",
	    in_dir, run, rerun, camcol, run, camcol, rerun, field);
  }  

  outFile_name = alloca(16);
  sprintf(outFile_name,"-");
  
  /* Get the filter index */
  switch(filter) 
    {
    case 'u': filter_index=1; break;
    case 'g': filter_index=2; break;
    case 'r': filter_index=3; break;
    case 'i': filter_index=4; break;
    case 'z': filter_index=5; break;
    default: exit(EX_DATAERR);  
    }

  fpC_file = fopen(fpC_name,"r");
  __md5_stream(fpC_file,md5bin);
  fclose(fpC_file);
  for(byte_index=0;byte_index<16;byte_index++) {
    md5hex[byte_index*2]=bin2hex[(md5bin[byte_index]>>4)&0xf];
    md5hex[byte_index*2+1]=bin2hex[md5bin[byte_index]&0xf];
  }
  md5hex[32]='\0';

  fits_open_file(&fpC, fpC_name, READONLY, &fits_status);
  manage_fitserror(fits_status);
 
  printf("Content-Disposition: attachment; filename=drC-%06d-%c%1d-%04d.fits\nContent-type:image/fits\n\n",run, filter, camcol, field);

  fits_create_file(&outFile, outFile_name, &fits_status);
  manage_fitserror(fits_status);

  fits_copy_hdu(fpC, outFile, 0, &fits_status);
  manage_fitserror(fits_status);

  fits_close_file(fpC, &fits_status);
  manage_fitserror(fits_status);

  fits_open_file(&tsField, tsField_name, READONLY, &fits_status);
  manage_fitserror(fits_status);
  fits_movabs_hdu(tsField, 2, NULL, &fits_status);
  manage_fitserror(fits_status);
  fits_get_num_rows(tsField, &n_fields, &fits_status);
  manage_fitserror(fits_status);
  if (n_fields != 1)
    exit(EX_DATAERR);

  /* Rename previously existing keywords */
  fits_read_key(outFile, TDOUBLE, "FLUX0", &datum, comment, &fits_status);
  if (fits_status != KEY_NO_EXIST) {
    fits_modify_name(outFile, "FLUX0", "PFLUX0", &fits_status);
    manage_fitserror(fits_status);
    fits_modify_comment(outFile, "PFLUX0", "Preliminary value; use FLUX0 instead", &fits_status);
    manage_fitserror(fits_status);
  }
  fits_read_key(outFile, TDOUBLE, "FLUX20", &datum, comment, &fits_status);
  if (fits_status != KEY_NO_EXIST) {
    fits_modify_name(outFile, "FLUX20", "PFLUX20", &fits_status);
    manage_fitserror(fits_status);
    fits_modify_comment(outFile, "PFLUX20", "Preliminary value; use FLUX20 instead", &fits_status);
    manage_fitserror(fits_status);
  }
  fits_read_key(outFile, TDOUBLE, "SKY", &datum, comment, &fits_status);
  if (fits_status != KEY_NO_EXIST) {
    fits_modify_name(outFile, "SKY", "PSKY", &fits_status);
    manage_fitserror(fits_status);
    fits_modify_comment(outFile, "PSKY", "Preliminary value; use SKY instead", &fits_status);
    manage_fitserror(fits_status);
  }
  fits_status=0;

  /* Try and get the correct exposure time. Some processing of SDSS data get the */
  /* EXPTIME keyword in the drC formatted incorrectly. Try the different ways it */
  /* might be. */
  fits_read_key(outFile, TDOUBLE, "EXPTIME", &datum, comment, &fits_status);
  if (fits_status == 0) {
    exptime = datum;
  } else {
    fits_status = 0;
    fits_read_card(outFile, "EXPTIME", sexptime, &fits_status);
    if (fits_status == 0) {
      fits_status=0;
      if (sscanf(sexptime,"EXPTIME = '%lf'",&exptime)!=1) {
	sscanf(sexptime,"EXPTIME ='%lf'",&exptime); 
      }
    }
  }
  fits_modify_name(outFile, "EXPTIME", "SEXPTIME", &fits_status);
  if (fits_status != KEY_NO_EXIST) {
    manage_fitserror(fits_status);
  }
  fits_status=0;
  
  /* Add comment marking start of new keywords */
  datum=0;
  fits_write_key(outFile, TDOUBLE, "FPC_END", &datum, "Header section found in fpC files ends here", &fits_status);
  manage_fitserror(fits_status);

  /* name and MD5 checksum of base fpC file */
  fits_write_key(outFile, TSTRING, "FPC_NAME", fpC_base, "Name of the original fpC file", &fits_status);
  manage_fitserror(fits_status);
  fits_write_key(outFile, TSTRING, "FPC_MD5", md5hex, "MD5 hash of the original fpC file", &fits_status);
  manage_fitserror(fits_status);
  
  /* write the exposure time with the correct type if necessary */
  if (exptime > 0) {
    fits_write_key(outFile, TDOUBLE, "EXPTIME", &exptime, "Exposure time (seconds)", &fits_status);
    manage_fitserror(fits_status);
  }

  /* photometric keywords */
  fits_write_comment(outFile,"Photometric transformation",&fits_status);
  fits_write_comment(outFile,tsField_name,&fits_status);
  fits_write_comment(outFile,"See Lupton et al. (1999AJ....118.1406L)",&fits_status);
  fits_write_comment(outFile,"See Stoughton et al. (2002AJ....123..485S) section 4.4.5.1",&fits_status);
  fits_write_comment(outFile,"f/f0 = counts/exptime * 10^(0.4*(aa + kk * airmass))",&fits_status);
  fits_write_comment(outFile,"Pogson mag = -2.5 * log10(f/f0)",&fits_status);
  fits_write_comment(outFile,"asinh mag = -(2.5/ln(10))*[asinh((f/f0)/2b)+ln(b)]",&fits_status);
  manage_fitserror(fits_status);
  add_double_keyword_from_table(tsField, outFile, "aa", "pht_aa", "Photometric aa parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "aaErr", "phtaaErr", "Photometric aa error parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "kk", "pht_kk", "Photometric kk parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "kkErr", "phtkkErr", "Photometric kk error parameter", filter_index);
  switch(filter) 
    {
    case 'u': 
      b=1.4e-10;
      break;
    case 'g': 
      b=9.0e-11;
      break;
    case 'r': 
      b=1.2e-10;
      break;
    case 'i': 
      b=1.8e-10;
      break;
    case 'z': 
      b=7.4e-10;
      break;
    default: exit(EX_DATAERR);
    }
  fits_write_key(outFile, TDOUBLE, "pht_b", &b, "Softening parameter b", &fits_status);; 
  add_double_keyword_from_table(tsField, outFile, "airmass", "airmass", "Airmass", filter_index);

  flux0=mag2counts(outFile,0);
  fits_write_key(outFile, TDOUBLE, "FLUX0", &flux0, "Number of DN in 0th mag object", &fits_status);; 
  manage_fitserror(fits_status);
  flux20=mag2counts(outFile,20);
  fits_write_key(outFile, TDOUBLE, "FLUX20", &flux20, "Number of DN in 20th mag object", &fits_status);; 
  manage_fitserror(fits_status);
  zp=zeropoint(outFile);
  fits_write_key(outFile, TDOUBLE, "ZP", &zp, "Phot. zero point m=-2.5log(DN)+ZP", &fits_status);; 
  manage_fitserror(fits_status);
  
  /* sky level */
  fits_write_comment(outFile,"A maggie is a linear unit of flux",&fits_status);
  fits_write_comment(outFile,"counts = maggies*FLUX0",&fits_status);
  add_double_keyword_from_table(tsField, outFile, "sky", "sky_flux", "average sky value (maggie/arcsec^2)", filter_index);
  /* On some older files, the returned value is in luptitudes rather than maggies.*/
  /* Check and convert if necessary */
  fits_read_key(outFile, TDOUBLE, "SKY_FLUX", &sky, comment, &fits_status);
  manage_fitserror(fits_status);
  if (sky > 1.0) sky = pow(10.0,-0.4*sky);
  fits_update_key(outFile, TDOUBLE, "SKY_FLUX", &sky, comment, &fits_status);
  manage_fitserror(fits_status);
  /* Calculate the value in data numbers */
  sky=sky_counts(outFile);
  fits_write_key(outFile, TDOUBLE, "SKY", &sky, "sky level (DN/pixel)", &fits_status);; 
  manage_fitserror(fits_status);

  /* astrometric keywords */
  fits_write_comment(outFile,"astrometric transformation",&fits_status);
  fits_write_comment(outFile,"See Pier et al. (2003AJ....125.1559P)",&fits_status);
  fits_write_comment(outFile,"See Stoughton et al. (2002AJ....123..485S) section 3.2.2",&fits_status);
  fits_write_comment(outFile,"   r'-i' < riCut:",&fits_status);
  fits_write_comment(outFile,"       rowm =row+dRow0+dRow1*col+dRow2*(col^2)+dRow3*(col^3)+csRow*color",&fits_status);
  fits_write_comment(outFile,"       colm =col+dCol0+dCol1*col+dCol2*(col^2)+dCol3*(col^3)+csCol*color",&fits_status);
  fits_write_comment(outFile,"     Which color to use depends on the filter as follows:",&fits_status);
  fits_write_comment(outFile,"       u: u-g    g: g-r    r,i,z: r-i",&fits_status);
  fits_write_comment(outFile,"   r'-i' >= riCut",&fits_status);
  fits_write_comment(outFile,"       rowm = row+dRow0+dRow1*col+dRow2*(col^2)+dRow3*(col^3)+ccRow",&fits_status);
  fits_write_comment(outFile,"       colm = col+dCol0+dCol1*col+dCol2*(col^2)+dCol3*(col^3)+ccCol",&fits_status);
  fits_write_comment(outFile,"   mu = a + b * rowm + c * colm",&fits_status);
  fits_write_comment(outFile,"   nu = d + e * rowm + f * colm",&fits_status);
  fits_write_comment(outFile,"tan(ra-NODE)=[sin(mu-NODE)cos(nu)cos(INCL)-sin(nu)sin(INCL)]/",&fits_status);
  fits_write_comment(outFile,"             [cos(mu-NODE)cos(nu)]",&fits_status);
  fits_write_comment(outFile,"sin(dec)=sin(mu-NODE)cos(nu)sin(INCL)+sin(nu)cos(INCL)",&fits_status);
  add_double_keyword_from_table(tsField, outFile, "a", "ast_a", "Astrometric a parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "b", "ast_b", "Astrometric b parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "c", "ast_c", "Astrometric c parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "d", "ast_d", "Astrometric d parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "e", "ast_e", "Astrometric e parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "f", "ast_f", "Astrometric f parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dRow0", "astdrow0", "Astrometric dRow0 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dRow1", "astdrow1", "Astrometric dRow1 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dRow2", "astdrow2", "Astrometric dRow2 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dRow3", "astdrow3", "Astrometric dRow3 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dCol0", "astdcol0", "Astrometric dCol0 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dCol1", "astdcol1", "Astrometric dCol1 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dCol2", "astdcol2", "Astrometric dCol2 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dCol3", "astdcol3", "Astrometric dCol3 parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "csCol", "astcscol", "Astrometric csCol parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "csRow", "astcsrow", "Astrometric csRow parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "ccCol", "astcccol", "Astrometric ccCol parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "ccRow", "astccrow", "Astrometric ccRow parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "riCut", "astricut", "Astrometric riCut parameter", filter_index);
  add_double_keyword_from_table(tsField, outFile, "muErr", "astmuerr", "Astrometric muErr parameter (asec)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "nuErr", "astnuerr", "Astrometric nuErr parameter (asec)", filter_index);

  add_double_keyword_from_table(tsField, outFile, "mjd", "mjd",
				"MJD(TAI) when row 0 was read", filter_index);
  add_long_keyword_from_table(tsField, outFile, "numStars", "numStars",
			      "Number of matching secondary stars in field", filter_index);
  add_double_keyword_from_table(tsField, outFile, "rowOffset", "rowOfset",
				"Offset to add to transformed row coors (pix)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "colOffset", "colOfset",
				"Offset to add to transformed col coords (pix)", filter_index);
  add_long_keyword_from_table(tsField, outFile, "saturation_level", "satlevel",
				"Saturation level", filter_index);
  add_double_keyword_from_table(tsField, outFile, "neff_psf", "neff_psf",
				"Effective area of the PSF (pixels)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "sky_psp", "sky_psp",
				"Sky from the point spread function", filter_index);
  add_double_keyword_from_table(tsField, outFile, "sky_frames", "sky_frms",
				"Global sky value in the corrected frame", filter_index);
  add_double_keyword_from_table(tsField, outFile, "sky_frames_sub", "skyfrmss",
				"Global sky value after object subtraction", filter_index);
  add_double_keyword_from_table(tsField, outFile, "sigPix", "sigPix",
				"Clipped sigma of pixel values in corrected frame", filter_index);
  add_double_keyword_from_table(tsField, outFile, "deV_ap_correction",
				"deVapcor", "De Vaucouleurs aperture correction", filter_index);
  add_double_keyword_from_table(tsField, outFile, "deV_ap_correctionErr", "deVapcre",
				"De Vaucouleurs aperture correction error", filter_index);
  add_double_keyword_from_table(tsField, outFile, "exp_ap_correction", "exapcor", 
				"Exponential aperture correction", filter_index);
  add_double_keyword_from_table(tsField, outFile, "exp_ap_correctionErr", "exapcore", 
				"Exponential aperture correction error", filter_index);
  add_double_keyword_from_table(tsField, outFile, "deV_model_ap_correction", "deVmap", 
				"De Vaucouleurs model aperture correction", filter_index);
  add_double_keyword_from_table(tsField, outFile, "deV_model_ap_correctionErr", "deVmape", 
				"De Vaucouleurs model aperture correction error", filter_index);
  add_double_keyword_from_table(tsField, outFile, "exp_model_ap_correction", "exmapcor", 
				"Exponential model aperture correction", filter_index);
  add_double_keyword_from_table(tsField, outFile, "exp_model_ap_correctionErr", "exmapcre", 
				"Exponential model aperture correction error", filter_index);
  add_long_keyword_from_table(tsField, outFile, "nCR", "nCR", 
			      "Number of cosmic rays detected on the frame", filter_index);
  add_long_keyword_from_table(tsField, outFile, "nBrightObj", "nBtObj", 
			      "Number of bright objects detected", filter_index);
  add_long_keyword_from_table(tsField, outFile, "nFaintObj", "nFtObj", 
				"Number of faint objects detected", filter_index);
  add_double_keyword_from_table(tsField, outFile, "median_fiberColor", "medfibCr", 
				"Median fiber colors of objects", filter_index);
  add_double_keyword_from_table(tsField, outFile, "median_psfColor", "medpsfCr", 
				"Median PSF colors of objects", filter_index);
  add_double_keyword_from_table(tsField, outFile, "q", "q", 
				"Mean Stokes Q parameter on the frame", filter_index);
  add_double_keyword_from_table(tsField, outFile, "u", "u", 
				"Mean Stokes U parameter on the frame", filter_index);
  add_long_keyword_from_table(tsField, outFile, "status", "PFITTYPE", 
			      "Type of PSF fit for each filter in the field", filter_index);
  add_double_keyword_from_table(tsField, outFile, "skySig", "skySig", 
				"Sigma of distribution of sky values", filter_index);
  add_double_keyword_from_table(tsField, outFile, "skyErr", "skyErr", 
				"The error of average sky value in the frame ", filter_index);
  add_double_keyword_from_table(tsField, outFile, "skySlope", "skySlope", 
				"The slope in the sky value along the columns", filter_index);
  add_double_keyword_from_table(tsField, outFile, "lbias", "lbias", 
				"Left-hand bias level", filter_index);
  add_double_keyword_from_table(tsField, outFile, "rbias", "rbias", 
				"Right-hand bias level", filter_index);
  add_long_keyword_from_table(tsField, outFile, "psf_nstar", "psfnstar", 
			      "Number of stars used in psf measurement", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_ap_correctionErr", "psfapcre", 
				"Photometric error due to imperfect PSF model", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_sigma1", "psf_s1", 
				"Inner gaussian sigma for composite fit (asec)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_sigma2", "psf_s2", 
				"Outer gaussian sigma for composite fit (asec)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_b", "psf_b", 
				"Ratio of inner to outer PSF at origin", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_p0", "psf_p0", 
				"The value of the power law at the origin", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_beta", "psf_beta", 
				"Slope of power law", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_sigmap", "psfsgmap", 
				"Width parameter for power law", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_width", "psfwid", 
				"Effective PSF width in 2-Gaussian fit (asec)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_psfCounts", "psfcts", 
				"Flux via fit to the PSF (counts)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_sigma1_2G", "psfs12G", 
				"PSF inner sigma in 2-Gaussian fit (pix)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_sigma2_2G", "psfs22G", 
				"PSF outer sigma in 2-Gaussian fit (pix)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psf_b_2G", "psf_b_2G", 
				"Ratio of gaussian 2 to gaussian 1 at origin ", filter_index);
  add_double_keyword_from_table(tsField, outFile, "psfCounts", "psfcts", 
				"PSF counts", filter_index);
  add_double_keyword_from_table(tsField, outFile, "gain", "gain", 
				"Gain averaged over all amplifiers (e/DN)", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dark_variance", "dark_var", 
				"combined variance from dark cur. and read noise", filter_index);
  add_double_keyword_from_table(tsField, outFile, "dark_variance", "rdnoise", 
				"combined variance from dark cur. and read noise", filter_index);

  fits_movabs_hdu(tsField, 1, NULL, &fits_status);
  manage_fitserror(fits_status);
  copy_string_key(tsField, outFile, "PHOTO_ID");
  copy_string_key(tsField, outFile, "PHOT_VER");
  copy_string_key(tsField, outFile, "TASTR_ID");
  copy_string_key(tsField, outFile, "TAST_VER");
  copy_string_key(tsField, outFile, "TFCAL_ID");
  copy_string_key(tsField, outFile, "TFCA_VER");
  copy_string_key(tsField, outFile, "EASTR_ID");
  copy_string_key(tsField, outFile, "EAST_VER");
  copy_string_key(tsField, outFile, "EFCAL_ID");
  copy_string_key(tsField, outFile, "EFCA_VER");

  fits_close_file(tsField, &fits_status);
  manage_fitserror(fits_status);

  fits_write_chksum(outFile, &fits_status);
  manage_fitserror(fits_status);
  
  fits_close_file(outFile, &fits_status);
  manage_fitserror(fits_status);
}

void
add_double_keyword_from_table(fitsfile *table, fitsfile *image, char *column, char *keyword, char *comment, int filter)
{
  double datum;             /**< the array of values from the table */
  int col_index;            /**< the columnt index */
  int fits_status = 0;      /**< status data from cfitsio */
  
  fits_get_colnum(table, 0, column, &col_index, &fits_status);
  manage_fitserror(fits_status);
  fits_read_col(table, TDOUBLE, col_index, 1, (long)filter, 1, NULL, &datum, NULL, &fits_status);
  manage_fitserror(fits_status);
  fits_write_key(image, TDOUBLE, keyword, &datum, comment, &fits_status);
  manage_fitserror(fits_status);
}

void
add_long_keyword_from_table(fitsfile *table, fitsfile *image, char *column, char *keyword, char *comment, int filter)
{
  long datum;             /**< the array of values from the table */
  int col_index;            /**< the columnt index */
  int fits_status = 0;      /**< status data from cfitsio */
  
  fits_get_colnum(table, 0, column, &col_index, &fits_status);
  manage_fitserror(fits_status);
  fits_read_col(table, TLONG, col_index, 1, (long)filter, 1, NULL, &datum, NULL, &fits_status);
  manage_fitserror(fits_status);
  fits_write_key(image, TLONG, keyword, &datum, comment, &fits_status);
  manage_fitserror(fits_status);
}

void
manage_fitserror(int status)
{
  if (status)
    {
      fits_report_error(stderr, status); 
      exit(status);
    }
  return;
}

double 
mag2counts(fitsfile *fits, double mag)
{
  double counts;
  double ff0;
  double aa, kk, airmass, b, exptime;
  char comment[80];         /**< Comment from read fits keyword */
  int fits_status = 0;      /**< status data from cfitsio */

  fits_read_key(fits, TDOUBLE, "pht_aa", &aa, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "pht_kk", &kk, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "airmass", &airmass, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "pht_b", &b, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "exptime", &exptime, comment, &fits_status);
  manage_fitserror(fits_status);

  ff0=2.0*b*sinh( (-1.0*log(10.0)*mag/2.5)-log(b) );
  counts = exptime*ff0*pow(10.0,-0.4*(aa+kk*airmass));
  return counts;
}

double
sky_counts(fitsfile *fits)
{
  double cd2_1, cd2_2;
  double sky_maggie;
  double sky_counts;
  double pscale;
  double flux0;
  char comment[80];         /**< Comment from read fits keyword */
  int fits_status = 0;      /**< status data from cfitsio */

  fits_read_key(fits, TDOUBLE, "CD2_1", &cd2_1, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "CD2_2", &cd2_2, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "SKY_FLUX", &sky_maggie, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "FLUX0", &flux0, comment, &fits_status);
  manage_fitserror(fits_status);

  pscale = 3600.0*sqrt(cd2_1*cd2_1+cd2_2*cd2_2);

  sky_counts=pscale*pscale*flux0*sky_maggie;
  return sky_counts;
}

double
zeropoint(fitsfile *fits) 
{
  double zp;
  double aa, kk, airmass, exptime;
  char comment[80];         /**< Comment from read fits keyword */
  int fits_status = 0;      /**< status data from cfitsio */

  fits_read_key(fits, TDOUBLE, "pht_aa", &aa, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "pht_kk", &kk, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "airmass", &airmass, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_read_key(fits, TDOUBLE, "exptime", &exptime, comment, &fits_status);
  manage_fitserror(fits_status);

  zp = -1*(aa+kk*airmass)+(2.5/log(10))*log(exptime);

  return zp;

}

void
copy_string_key(fitsfile *origin, fitsfile *destination, char *keyword)
{
  char value[80];
  char comment[80];
  int fits_status = 0;      /**< status data from cfitsio */

  fits_read_key(origin, TSTRING, keyword, value, comment, &fits_status);
  manage_fitserror(fits_status);
  fits_write_key(destination, TSTRING, keyword, value, comment, &fits_status);
  manage_fitserror(fits_status);
  return;
}
