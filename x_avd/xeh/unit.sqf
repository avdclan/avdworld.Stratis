//waitUntil { time > 0 }; // wtf.

#define SELF "x_avd\xeh\unit.sqf"
//#define NODEBUG
#include "include\avd.h"
//DLOG("Unit CREATE: " + str(_this));
["avd_unit_create", _this] call CBA_fnc_globalEvent;
