#define SELF "x_avd\events.sqf"
#include "include\avd.h"

["avd_network_opc", {
    [{
    private ["_player"];
    _player = _this select 0;
    execVM "x_avd\player\setup.sqf";
    }, _this, (_this select 0), false] call AVD_fnc_remote_execute;
    
}] call CBA_fnc_addEventHandler;