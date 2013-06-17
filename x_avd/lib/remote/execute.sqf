#define SELF "x_avd\lib\remote\execute.sqf"
#include "include\avd.h"

private ["_code", "_arguments"];
_code = _this select 0;
_arguments = if(count(_this) == 2) then { _this select 1; } else { []; };
//DLOG(str(_arguments) + " remote " + str(_code));
[[_arguments, _code],"BIS_fnc_spawn",true,true] spawn BIS_fnc_MP;
