#define SELF "x_avd\player\modules\fooddrink\functions.sqf"
#include "include\avd.h"
#include "consume.h"

AVD_fnc_fds_canDrink = {
  private ["_unit", "_tmp"];
  _unit = _this select 0;
  _tmp = weapons _unit;
  _tmp = _tmp + magazines _unit;
  _tmp = _tmp + items _unit;
  
  {
      if(_x in _tmp) then {
          true;
      };
  } foreach DRINK_CLASSES;
  false;
};