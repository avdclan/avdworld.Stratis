#define SELF "x_avd\player\modules\fooddrink\init.sqf"
#define PATH "x_avd\player\modules\fooddrink"
#include "include\avd.h"
#include "consume.h"

DLOG("Initializing Food & Drink System");
private ["_unit", "_foodVal", "_drinkVal"];
if(isNil "_this") then {
  _this = [];  
};
_unit = if(count(_this) > 0) then { _this select 0; } else { player; };
_foodVal = if(count(_this) > 1) then { _this select 1; } else { 1000; };
_drinkVal = if(count(_this) > 2) then { _this select 2; } else { 1000; };

pVAR(_unit, "avd_fds_foodVal", _foodVal);
pVAR(_unit, "avd_fds_drinkVal", _drinkVal);

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
      
      {
          _anims = _x select 0;
          if(_anim in _anims) exitWith {
              _factor = _x select 1;
          };
      } foreach CONSUME_LISTS;
      _drinkVal =  _drinkVal - (_factor * 5);
      _foodVal =  _foodVal - _factor;
	  VAR(_unit, "avd_fds_drinkVal", _drinkVal);      
	  VAR(_unit, "avd_fds_foodVal", _foodVal);
     // DLOG("ANIM: " + str(_anim) + ", factor: " + str(_factor) + ", curVal: " + str(_drinkVal));
      hintSilent parseText format["Food: %1 (%3)<br />Drink: %2 (%4)<br />", _foodVal, _drinkVal, _factor, (_factor * 5)];  
      sleep 1;
      !(alive _unit)
      
      
      
    };
}