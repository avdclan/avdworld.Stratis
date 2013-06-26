#define SELF "x_avd\lib\db\setPersistentVar.sqf"
#include "include\avd.h"

private ["_obj", "_key", "_value", "_broadcast", "_hash"];
_obj = PARAM(0, nil);
if(isNil "_obj") exitWith {};
_key = PARAM(1, nil);
if(isNil "_key") exitWith {};
_value = PARAM(2, objNull);
_broadcast = PARAM(3, true);

_hash = _obj getVariable "avd_persistent_vars";
if(isNil "_hash") then {
  _hash = [] call CBA_fnc_hashCreate;  
};
[_hash, _key, _value] call CBA_fnc_hashSet;
_obj setVariable ["avd_persistent_vars", _hash, _broadcast];
