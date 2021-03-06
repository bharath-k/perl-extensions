/*
 * Author: Bharath Kumaran
 * Licensing: GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
 * Description: example header file.
 */

/*
 * A simple structure that just has a char * named stringEntry.
 * The entire objective of this project is to simplify how this structure is
 * presented to target languages.
 */

struct myservice {
	char *stringEntry;
};

typedef struct myservice MYService;

/*
 * Returns a MYService structure.
 */
MYService *get_service();

/*
 * Returns a MYService array.
 */
MYService **get_service_array();

/*
 * Fill up a servicePointer with a MYService instance.
* If fail is not 0, an error code is returned.
 */
int fillup_service(int fail, MYService **servicePointer);

/*
 * Fill up an array of servicePointer with a couple of MYService instances.
* If fail is not 0, an error code is returned.
 */
int fillup_service_array(int fail, MYService ***serviceArrayPointer);
