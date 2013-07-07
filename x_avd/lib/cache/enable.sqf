 #define SELF "x_\avd\lib\cache\enable.sqf"
 #include "include\avd.h"

 private ["_unit", "_res"];
// DLOG(_this);
 _unit = _this select 0; 
 if(isPlayer _unit) exitWith {};
 if(isNull _unit) exitWith {};
 _res = _unit getVariable "avd_cache_enabled";
 if(! isNil "_res") exitWith {};
 _unit setVariable ["avd_cache_enabled", false, true];

_unit setVariable ["avd_cache_enabled", true, true];
_unit setVariable ["avd_cache_isCachable", true, true];
//[_unit] execFSM "x_avd\fsm\caching.fsm";