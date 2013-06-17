#define SELF "x_avd\onPlayerDisconnected.sqf"
#include "include\avd.h"

private [
	"_id", 
    "_name", 
    "_n",
    "_str"];

_id = _this select 0;
_name = _this select 1;
["avd_network_opd_classic", [_id, _name]] call CBA_fnc_globalEvent;
{
    _n = name _x;
    if(_name == _n) exitWith {
        _str = format["Player %1 disconnected.", _x];
        DLOG(_str);
      ["avd_network_opd", [_x]] call CBA_fnc_globalEvent;  
    };
  
} foreach playableUnits;