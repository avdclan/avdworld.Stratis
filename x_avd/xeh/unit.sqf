//waitUntil { time > 0 }; // wtf.

#define SELF "x_avd\xeh\unit.sqf"
//#define NODEBUG
#include "include\avd.h"
//DLOG("Unit CREATE: " + str(_this));
_unit = _this select 0;
_unit setVariable ["avd_xeh_init", true, true];
_unit addEventHandler ["killed", { ["avd_unit_killed", _this] call CBA_fnc_globalEvent; }]; 
_unit addEventHandler ["hit", { ["avd_unit_hit", _this] call CBA_fnc_globalEvent; }];
["avd_unit_create", _this] call CBA_fnc_globalEvent;
