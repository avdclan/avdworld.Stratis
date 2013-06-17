#define SELF "x_avd\xeh\init.sqf"
#include "include\avd.h"
// runs on EVERY unit created.
private ["_unit"];
_unit = _this select 0;
DLOG("Creating unit: " + str(_unit));