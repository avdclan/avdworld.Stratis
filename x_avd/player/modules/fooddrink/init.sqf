#define SELF "x_avd\player\modules\fooddrink\init.sqf"
#define PATH "x_avd\player\modules\fooddrink"
#include "include\avd.h"
#include "include\arrays.h"

DLOG("Initializing Food & Drink System");
private ["_unit", "_foodVal", "_drinkVal"];
  
_unit = PARAM(0, player);
_foodVal = PARAM(1, 1000);
_drinkVal = PARAM(2, 1000);

setPVAR(_unit, "avd_fds_foodVal", _foodVal);
setPVAR(_unit, "avd_fds_drinkVal", _drinkVal);

COMP("functions");
COMP("actions");


if(!isNil "AVD_TIMER") then {
    AVD_FDS_TIMER = nil;
};

AVD_FDS_TIMER = [_unit, _foodVal, _drinkVal] spawn {
    private ["_unit", "_foodVal", "_drinkVal", "_curVal", "_time"];
    _unit = _this select 0;
    _foodVal = _this select 1;
    _drinkVal = _this select 2;
    waitUntil {
      
      _factor = 0.025;
      _anim = animationState _unit;
      _drinkVal = [_unit, "avd_fds_drinkVal"] call AVD_fnc_db_getPersistentVar;
      _foodVal = [_unit, "avd_fds_foodVal"] call AVD_fnc_db_getPersistentVar;
      {
          _anims = _x select 0;
          if(_anim in _anims) exitWith {
              _factor = _x select 1;
          };
      } foreach CONSUME_LISTS;
      _drinkVal =  _drinkVal - (_factor * 5);
      _foodVal =  _foodVal - _factor;
	  setPVAR(_unit, "avd_fds_foodVal", _foodVal);
	  setPVAR(_unit, "avd_fds_drinkVal", _drinkVal);
     // DLOG("ANIM: " + str(_anim) + ", factor: " + str(_factor) + ", curVal: " + str(_drinkVal));
      hintSilent parseText format["Food: %1 (%3)<br />Drink: %2 (%4)<br />", _foodVal, _drinkVal, _factor, (_factor * 5)];  
      if(_drinkVal <= 0 or _foodVal <= 0) then {
        _unit setDamage 1;  
      };
      sleep 1;
      !(alive _unit)
      
      
      
    };
}