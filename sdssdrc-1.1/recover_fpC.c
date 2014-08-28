/*! \brief Generate a frame file from an fpC file by adding header keywords
 *
 * Author: Eric H. Neilsen, Jr.
 * Date: $Date: 2008/10/10 13:44:47 $
 * Version: $Name:  $
 * Revision: $Revision: 1.1.1.1 $
 * 
 */

#include <popt.h>
#include <stdio.h>
#include <stdlib.h>
#include <sysexits.h>
#include <alloca.h>
#include <math.h>
#include <assert.h>
#include "fitsio.h"

void manage_fitserror(int status);
int
main (int argc, const char **argv)
{
  int poptReturnCode;      /**< return code from poptGetNextOpt */
  poptContext optCon;      /**< popt context for options processing */
  int verbose = 0;         /**< true if user has requested verbose */

  const char * in_name;    /**< the name of the file to read */
  const char * out_name;   /**< the name of the file to write */

  fitsfile *in;            /**< the recovered fpC fits file */
  fitsfile *out;           /**< the input file */
  int fits_status = 0;     /**< status data from cfitsio */
  char comment[80];        /**< Comment from read fits keyword */
  char hcard[81];          /**< A fits header card */
  char simple[81];         /**< A fits header card */
  double datum;            /**< A dummy */
  int keynum=0;            /**< The key number from the header */
  int out_keynum=0;
  int last_key;            /**< The first key to delete */
  int created_out_keys;
  int num_keys;            /**< The number of keys in the header */
  long naxes[2];
  char *endkey;
  char **skey;
  int char_counter=0;

  FILE *in_plain, *out_plain;

  endkey=alloca(8*sizeof(char));
  strcpy(endkey,"FPC_END");
  skey=&endkey;
  naxes[0]=2048;
  naxes[1]=1489;

  /* Options specification for popt options processing */
  struct poptOption optionsTable[] = {
    {"verbose", 'v', POPT_ARG_NONE,
     &verbose, 0,
     "print extra information",NULL
    },
    POPT_AUTOHELP
    { NULL, '\0', POPT_ARG_NONE, NULL, 0, NULL, NULL}
  };

  /* Process user supplied options and arguments */
  optCon = poptGetContext("recover_fpC", argc, argv, optionsTable, 0);
  poptSetOtherOptionHelp(optCon,"<in_name> <out_name>");

  if ((poptReturnCode = poptGetNextOpt(optCon)) < -1) {
    /* report option processing error */
    fprintf(stderr, "%s: %s\n",
            poptBadOption(optCon, POPT_BADOPTION_NOALIAS),
            poptStrerror(poptReturnCode));
    return EX_USAGE;
  }

  in_name = poptGetArg(optCon);
  out_name = poptGetArg(optCon);

  fits_open_file(&in, in_name, READONLY, &fits_status);
  manage_fitserror(fits_status);
 
  /* Create a new fits file of the correct type and data size */
  fits_create_file(&out, out_name, &fits_status);
  manage_fitserror(fits_status);
  fits_create_img(out, SHORT_IMG, 2, naxes, &fits_status);
  manage_fitserror(fits_status);
  fits_get_hdrpos(out, &created_out_keys, &out_keynum, &fits_status);
  manage_fitserror(fits_status);

  /* Determine where in the header the fpC keywords end and the new ones begin */
  fits_read_record(in, 1, hcard, &fits_status);
  manage_fitserror(fits_status);
  fits_find_nextkey(in, skey, 1, NULL, 0, hcard, &fits_status);
  manage_fitserror(fits_status);
  fits_get_hdrpos(in, &num_keys, &last_key, &fits_status);
  manage_fitserror(fits_status);

  /* Make sure there is enough room in the header */
  fits_read_record(out, 1, hcard, &fits_status);
  manage_fitserror(fits_status);
  fits_write_record(out, hcard, &fits_status);
  manage_fitserror(fits_status);
  for (keynum=created_out_keys; keynum < last_key-1 ; keynum++) {
    fits_write_comment(out, "This comment should get overwritten", &fits_status);
    manage_fitserror(fits_status);
  }

  /* Copy the data */
  fits_copy_data(in, out, &fits_status);
  manage_fitserror(fits_status);

  /* Get rid of the keywords we need to replace */
  for (keynum=2; keynum < last_key+1; keynum++) {
    fits_delete_record(out,2,&fits_status);
    manage_fitserror(fits_status);
  }

  /* Copy keys from input fits */
  for (keynum=2; keynum < last_key-1 ; keynum++) {
    fits_read_record(in, keynum, hcard, &fits_status);
    manage_fitserror(fits_status);

    fits_write_record(out, hcard, &fits_status);
    manage_fitserror(fits_status);
  } 

  /* Rename previously existing keywords */
  fits_read_key(out, TDOUBLE, "PFLUX0", &datum, comment, &fits_status);
  if (fits_status != KEY_NO_EXIST) {
    fits_modify_comment(out, "PFLUX0", "Number of DN in 0th mag object", &fits_status);
    manage_fitserror(fits_status);
    fits_modify_name(out, "PFLUX0", "FLUX0", &fits_status);
    manage_fitserror(fits_status);
  }
  fits_read_key(out, TDOUBLE, "PFLUX20", &datum, comment, &fits_status);
  if (fits_status != KEY_NO_EXIST) {
    fits_modify_comment(out, "PFLUX20", "Number of DN in 20th mag object", &fits_status);
    manage_fitserror(fits_status);
    fits_modify_name(out, "PFLUX20", "FLUX20", &fits_status);
    manage_fitserror(fits_status);
  }
  fits_read_key(out, TDOUBLE, "PSKY", &datum, comment, &fits_status);
  if (fits_status != KEY_NO_EXIST) {
    fits_modify_comment(out, "PSKY", "Approx. sky level (DN)", &fits_status);
    manage_fitserror(fits_status);
    fits_modify_name(out, "PSKY", "SKY", &fits_status);
    manage_fitserror(fits_status);
  }

  /* Close the output fits file */
  fits_close_file(out, &fits_status);
  manage_fitserror(fits_status);


  /*  This fits library requires a comment in the SIMPLE field not required
   *  by the standard, and not present in the original fpC files. Go back
   *  and get rid of this comment 
   */

  fits_read_record(in, 1, simple, &fits_status);
  manage_fitserror(fits_status);
  for (char_counter=strlen(simple); char_counter<80; char_counter++) {
    simple[char_counter]=' ';
  }
  simple[80]='\0';

  out_plain=fopen(out_name, "r+");
  fputs(simple,out_plain);
  fclose(out_plain);

  fits_close_file(in, &fits_status);
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

