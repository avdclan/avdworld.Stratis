#define SELF "x_avd\events.sqf"
#include "include\avd.h"

["avd_network_opc", {
    [{
    private ["_player"];
    _player = _this select 0;
    //execVM "x_avd\player\setup.sqf";
    }, _this, (_this select 0), false] call AVD_fnc_remote_execute;
    
}] call CBA_fnc_addEventHandler;

["avd_unit_create", {
    private ["_unit"];
    _unit = _this select 0;
    if(! local _unit) exitWith {};
    
    _unit addEventHandler ["killed", { ["avd_unit_killed", _this] call CBA_fnc_globalEvent; }]; 
	_unit addEventHandler ["hit", { ["avd_unit_hit", _this] call CBA_fnc_globalEvent; }];
    
}] call CBA_fnc_addEventHandler;

["avd_unit_killed", {
  //  DLOG("KILLED: " + str(_this));
}] call CBA_fnc_addEventHandler;
["avd_unit_hit", {
  //  DLOG("HIT: " + str(_this));
}] call CBA_fnc_addEventHandler;

