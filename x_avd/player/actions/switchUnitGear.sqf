#define SELF "x_avd\lib\player\actions\arrest.sqf"
#include "include\avd.h"

private ["_target", "_caller", "_id", "_args", "_ctarget"];
_target = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_args = _this select 3;
_ctarget = player;
[cursorTarget, player, true] call AVD_fnc_switchUnitGear; 