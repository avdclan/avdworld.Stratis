#define SELF "x_avd\lib\remote\execute.sqf"
#include "include\avd.h"

private ["_code", "_arguments", "_target", "_persistent"];
_code = _this select 0;
_arguments = if(count(_this) >= 2) then { _this select 1; } else { []; };
_target = if(count(_this) >= 3) then { _this select 2; } else { true; };
_persistent = if(count(_this) >= 4) then { _this select 3; } else { false; };
//DLOG(str(_arguments) + " remote " + str(_code));
[[_arguments, _code],"BIS_fnc_spawn",_target,_persistent] spawn BIS_fnc_MP;
