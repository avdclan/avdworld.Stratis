#define SELF "x_avd\player\modules\fooddrink\actions\drink.sqf"
#include "include\avd.h"

DLOG("Drinking " + str(_this));
[player] call AVD_fnc_fds_drink;