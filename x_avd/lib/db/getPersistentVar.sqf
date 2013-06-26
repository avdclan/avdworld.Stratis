#define SELF "x_avd\lib\db\getPersistentVar.sqf"
#include "include\avd.h"

private ["_obj", "_key", "_hash", "_default", "_ret"];
_obj = PARAM(0, nil);
if(isNil "_obj") exitWith {};
_key = PARAM(1, nil);
if(isNil "_key") exitWith {};

_default = PARAM(2, nil);
_hash = _obj getVariable "avd_persistent_vars";
if(isNil "_hash") exitWith {
  _default;  
};

_ret = [_hash, _key] call CBA_fnc_hashHasKey;
if(! _ret) exitWith { _default; };
[_hash, _key] call CBA_fnc_hashGet;
