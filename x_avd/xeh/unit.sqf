waitUntil { time > 0 }; // wtf.

#define SELF "x_avd\xeh\unit.sqf"
//#define NODEBUG
#include "include\avd.h"
["avd_unit_create", [_unit]] call CBA_fnc_globalEvent;
