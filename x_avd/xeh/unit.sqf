#define SELF "x_avd\xeh\unit.sqf"
#include "include\avd.h"
//DLOG("Creating unit: " + str(_this));
if(!isServer) exitWith {};
private ["_unit", "_varName"];
_unit = _this select 0;

if(isPlayer _unit) exitWith { 
	//[format["Not running on player %1", _unit], "XEH-unit"] call AVD_fnc_log;
	["avd_player_create", [_unit]] call CBA_fnc_globalEvent; 
};
_varName = vehicleVarName _unit;

if(_varName == "") then {
  _varName = call AVD_fnc_getValidVarName;
  [_unit, _varName] call AVD_fnc_setVehicleVarName;
};
//[format["XEH: Unit is beeing created: %1", _this], "XEH"] call AVD_fnc_log;
//_unit addEventHandler ["killed", { _this call compile preprocessFile "x_avd\events\unit\killed.sqf"; }]; 
//_unit addEventHandler ["hit", { _this call compile preprocessFile "x_avd\events\unit\hit.sqf"; }];

[_unit] spawn {
    _unit = _this select 0;
   	[_unit, format["%2_%1", typeOf _unit, _unit]] call AVD_fnc_trackingMarker;
	["avd_unit_creation", [_unit]] call CBA_fnc_globalEvent;
	["avd_unit_create", [_unit]] call CBA_fnc_globalEvent;
};