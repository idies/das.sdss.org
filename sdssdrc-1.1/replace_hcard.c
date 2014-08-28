/*! \brief Replace a FITS header card
 *
 * Author: Eric H. Neilsen, Jr.
 * Date: $Date: 2008/10/10 13:44:47 $
 * Version: $Name:  $
 * Revision: $Revision: 1.1.1.1 $
 *
 * This program reads a file from standard input and changes header keywords
 * in a fits file accordingly. Each line to be changed corresponds to three
 * lines in the standard input: the file name, the expected line of the keyword 
 * to be changed, and the line to change the keyword to.
 * 
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <signal.h>
#include <unistd.h>

int
main (int argc, const char **argv)
{
  int verbose = 1;         /**< true if user has requested verbose */

  char in_buffer[9];       /**< Buffer for keyword to read */
  char out_hcard[81];      /**< Buffer for header data card */
  char in_hcard[81];       /**< Buffer for old value of header data card */
  char keyword[9];         /**< Keyword to replate */
  FILE *ffile;             /**< File handle of the fits file */
  char ffile_name[101];   /**< The file name of the fits file */
  char offile_name[101];   /**< The file name of the open fits file */
  long int index;          /**< The header card index to try first */
  int i;                   /**< An index */
  int kw_index=-1;    /**< The index of the hcard to replace*/
  errno = 0;

  FILE *infile;             /**< the input file */

  if (argc != 2) {
    printf("Usage: replace_hcard replacement_file.lis\n");
  }

  infile = fopen(argv[1],"r");
  if (infile == NULL) {
    fprintf(stderr,"File %s not found\n",argv[1]);
    return 1;
  }

  offile_name[0]='\0';

  while(1) {
    fgets(ffile_name, 100, infile);
    if (feof(infile)) break;
    if (strlen(ffile_name) == 0) break;
    ffile_name[strlen(ffile_name)-1]='\0';
    fscanf(infile, "%li\n", &index);
    if (feof(infile)) break;
    fgets(out_hcard, 81, infile);
    if (feof(infile)) break;
    out_hcard[strlen(out_hcard)-1]='\0';
    strncpy(keyword, out_hcard, 8);

    if (access(ffile_name,W_OK)) 
      {
	printf("CANNOT_WRITE\t%s\n",ffile_name);
      } 
    else 
      {
	/* Pad the keyword to the necessary length */
	for(i=strlen(keyword); i<9; i++) keyword[i]=' ';
	keyword[8]='\0';
      
	if (verbose) printf("CHANGING\t%s\t%s\n",ffile_name,keyword);
	
	/* Pad the replacement to 80 characters */
	for(i=strlen(out_hcard); i<81; i++) out_hcard[i]=' ';
	out_hcard[80]='\0';
	
	/* If this is a new file, close the old and open the new */
	if (strcmp(offile_name,ffile_name)) {
	  if (strlen(offile_name)>0) 
	    {
	      fflush(ffile);
	      fclose(ffile);
	    }
	  errno=0;
	  ffile=fopen(ffile_name,"r+");
	  if (ffile == NULL)
	    {
	      fprintf(stderr,"CANNOT_OPEN\t%s\t%d\n",ffile_name,errno);
	      /* Look in /usr/include/asm/errno.h for meaning of error codes */
	      errno=0;
	      continue;
	    }
	  strncpy(offile_name,ffile_name,100);
	} 
	
	/* Find the position in of the header card in the file */
	
	/* Start by looking at the suggested index */
	fseek(ffile, 80L*index, SEEK_SET);
	fgets(in_buffer, 9, ffile);
	in_buffer[8]='\0';
	
	/* If the desired keword is not at the suggested index, search from the beginning */
	if (strcmp(in_buffer, keyword)) 
	  {
	    index=0;
	    while(!(fseek(ffile, 80L*index, SEEK_SET))) {
	      fgets(in_buffer, 9, ffile);
	      in_buffer[8]='\0';
	      if (!strcmp(in_buffer, keyword)) {
		kw_index = index;
		break;
	      }
	      index++;
	    }
	  } 
	else 
	  {
	    kw_index = index;
	  }
	
	/* If the keyword wasn't found, exit without doing anything */
	if (kw_index < 0) {
	  printf("Keyword %s not found in file %s\n",keyword, ffile_name);
	  return(65);
	} 
	
	if (verbose) printf("KEYWORD_INDEX\t%d\n", kw_index);
	
	fseek(ffile, 80L*kw_index, SEEK_SET);
	fputs(out_hcard,ffile);
      } 
    
  } 
  

  if (strlen(offile_name)>0) {
    fflush(ffile);
    fclose(ffile);
  }
  fclose(infile);
  return(0);

}
