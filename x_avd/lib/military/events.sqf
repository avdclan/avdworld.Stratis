#define SELF "x_avd\lib\military\events.sqf"
#include "include\avd.h"


["avd_outpost_cleared", {
    private ["_logic", "_side", "_newSide", "_args"];
    _logic = _this select 0;
    _args = _this select 1;
    _side = _logic getVariable "avd_outpost_side";
    _newSide = east;
    if(_side == east) then {
      _newSide = west;  
    };
    deleteVehicle _logic;    
    [_newSide, _args select 1, _args select 2, _args select 3] spawn AVD_fnc_military_createOutpost;
    
    
    
    
}] call CBA_fnc_addEventHandler;
