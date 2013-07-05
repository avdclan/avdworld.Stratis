#define SELF "x_avd\xeh\init.sqf"
#include "include\avd.h"
// runs on EVERY unit created.
private ["_unit", "_side", "_downer", "_cowner"];
_unit = _this select 0;
if(isPlayer _unit) exitWith { DLOG("Skipping player."); };
_side = side _unit;
_cowner = owner _unit;
DLOG("Creating unit " + str(_unit) + ", side: " + str(_side) + ", owner: " + str(_cowner));
switch (_side) do {
  case EAST: {
      _downer = owner AVD_D_CLIENT_EAST;
  };
  case WEST: {
      _downer = owner AVD_D_CLIENT_WEST;
  };
  case RESISTANCE: {
      _downer = owner AVD_D_CLIENT_GUER;
  };
  default {
      _downer = owner AVD_D_CLIENT_CIV;
  };  
};


if(_cowner != _downer) then {
  DLOG("Moving ownership for unit " + str(_unit) + " from " + str(_cowner) + " to " + str(_downer));  
};