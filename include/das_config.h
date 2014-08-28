/*! @file das_config.h
 * @brief Defines structures used hold DAS configuration information
 * @author Eric H. Neilsen, Jr.
 */

#include <stdbool.h>

#define MAX_PATH_LENGTH 2048 /*!< the maximum fully qualified file name length */
#define MAX_URLBASE_LENGTH 2048 /*!< the maximum length of the base url*/
#define MAX_HOST_LENGTH 2048 /*!< the maximum length of a host name*/
#define MAX_CONFIG_LINE_LENGTH 2048 /*!< the maximum length of a line in the config file*/

/*! Data read from the configuration file 
 */
typedef struct
{
  char imaging_root[MAX_PATH_LENGTH]; /*!< root directory for imaging data */
  char spectro_root[MAX_PATH_LENGTH]; /*!< root directory for spectroscopic data */
  char scratch_root[MAX_PATH_LENGTH]; /*!< root directory for scratch data */
  char drdefs_root[MAX_PATH_LENGTH]; /*!< root directory with the data release defs */
  char astlimits_fname[MAX_PATH_LENGTH]; /*!< name of file with astremetric limits to stripes */
  char imaging_url[MAX_URLBASE_LENGTH]; /*!< URL of base directory of imaging data */
  char spectro_url[MAX_URLBASE_LENGTH]; /*!< URL of base directory of spectroscopic data */
  char scratch_url[MAX_URLBASE_LENGTH]; /*!< URL of base directory of scratch files */
  char cgi_url[MAX_URLBASE_LENGTH]; /*!< URL of base directory of cgi programs */
  char rsync_host[MAX_HOST_LENGTH]; /*!< Host name of the rsync server */
  char cas_navi_url[MAX_URLBASE_LENGTH]; /*!< Base URL of CAS navigator tool */
  char cas_obj_url[MAX_URLBASE_LENGTH]; /*!< Base URL of CAS explorer tool */
  bool offer_drC; /*!< offer drC files */
} das_config;

void
read_config (das_config /*@out@*/ *config, const char *config_file);

