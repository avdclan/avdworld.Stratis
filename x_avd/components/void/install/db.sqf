#define SELF "x_avd\components\void\install\db.sqf"
#include "include\avd.h"
#include "include\db.h"

DLOG("Installing database... ");
DB_WRITE("avdworld", "install_time", REAL_TIME);
DB_WRITE("avdworld", "install_version", AVD_VERSION);
DB_WRITE("avdworld", "install_world", worldName);
