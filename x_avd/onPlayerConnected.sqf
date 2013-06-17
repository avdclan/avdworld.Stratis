#define SELF "x_avd\onPlayerConnected.sqf"
#include "include\avd.h"

private [
	"_id", 
    "_name", 
    "_n",
    "_str"];

_id = _this select 0;
_name = _this select 1;
["avd_network_opc_classic", [_id, _name]] call CBA_fnc_globalEvent;
{
    _n = name _x;
    if(_name == _n) exitWith {
        //DLOG(_n + " is " + _name + ", calling event for " + _x);
        _str = format["Player %1 connected.", _x];
        DLOG(_str);
      ["avd_network_opc", [_x]] call CBA_fnc_globalEvent;  
    };
  
} foreach playableUnits;
