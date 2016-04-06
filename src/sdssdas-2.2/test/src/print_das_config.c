/*! @file print_das_config.c
 * @brief Read and parse a DAS config file and print the results
 *
 * @author Eric H. Neilsen, Jr.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "das_config.h"

int
main (int argc, const char *argv[])
{
  const char *config_file = "das.conf";	/*!< the configuration file to read */
  das_config config = { "", "", "", "", "", "", "" };	/*!< the configuration read */

  switch (argc)
    {
    case 1:
      break;
    case 2:
      config_file = argv[1];
      break;
    default:
      printf ("Incorrect number of args (1 required, %d supplied)\n", argc);
      exit (EXIT_FAILURE);
    }

  read_config (&config, config_file);

  printf ("Imaging_root\t%s\n", config.imaging_root);
  printf ("Spectro_root\t%s\n", config.spectro_root);
  printf ("Scratch_root\t%s\n", config.scratch_root);
  printf ("Drdefs_root\t%s\n", config.drdefs_root);
  printf ("Astlimits_fname\t%s\n", config.astlimits_fname);
  printf ("Imaging_url\t%s\n", config.imaging_url);
  printf ("Spectro_url\t%s\n", config.spectro_url);
  printf ("Scratch_url\t%s\n", config.scratch_url);
  printf ("Cgi_url\t%s\n", config.cgi_url);
  printf ("CAS_navi_url\t%s\n", config.cas_navi_url);
  printf ("CAS_obj_url\t%s\n", config.cas_obj_url);
  printf ("Rsync_host\t%s\n", config.rsync_host);
  if (config.offer_drC) {
    printf ("offer_drC\tTrue\n");
  } else {
    printf ("offer_drC\tFalse\n");
  }

  exit (EXIT_SUCCESS);

}
