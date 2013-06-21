#define SELF "x_avd\player\modules\fooddrink\actions\food.sqf"
#include "include\avd.h"

DLOG("Eating " + str(_this));
[player] call AVD_fnc_fds_food;