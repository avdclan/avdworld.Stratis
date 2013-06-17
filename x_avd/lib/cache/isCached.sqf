#define SELF "x_avd\lib\cache\isCached.sqf"
#include "include\avd.h"
private ["_unit", "_var", "_c"];
_unit = _this select 0;
_var = _unit getVariable "avd_cache_isCached";
_c = [_unit] call AVD_fnc_cache_isCachable;
if(isNil "_c" or !_c) exitWith { false; };
//if(_var == objNull) exitWith { false; };
_str = format["Unit %1 (%3)) has cache: %2", _unit, _var, typeOf _unit];
//DLOG(_str);
if(isNil "_var") then {
    false;
} else {
    _var;
};
