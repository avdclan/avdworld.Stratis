#define SELF "x_avd\player\modules\fooddrink\functions.sqf"
#include "include\avd.h"
#include "include\arrays.h"

AVD_fnc_fds_canDrink = {
  private ["_unit", "_tmp"];
  _unit = _this select 0;
  
  //if(surfaceIsWater getPos _unit) exitWith { true; };
  
  _tmp = magazines _unit;
  _ret = false;
  {
      if(_x in _tmp) exitWith {
          _ret = true;
      };
  } foreach DRINK_CLASSES;
  _ret;
};

AVD_fnc_fds_getDrinkValue = {
  333.5;  
};

AVD_fnc_fds_drink = {
  private ["_unit", "_tmp", "_drink", "_val"];
  if(isNil "_this") then {
    _this = [player];  
  };
  _unit = _this select 0;
  _drink = if(count(_this) > 1) then { _this select 1; } else { ""; };
  if(_drink == "") then {
  	_tmp = magazines _unit;
  	
  	{
    	  if(_x in _tmp) exitWith {
        	_drink = _x;  
      	  };
  	} foreach DRINK_CLASSES;
  };
  
  _val = [_drink] call AVD_fnc_fds_getDrinkValue;
  private "_curVal";
  _curVal = _unit getVariable "avd_fds_drinkVal";
  _unit removeMagazine _drink;
  private "_newVal";
  _newVal = _curVal + _val;
  if(_newVal > 1000) then { _newVal = 1000; };
  _unit setVariable["avd_fds_drinkVal", _newVal, true];
};

AVD_fnc_fds_canEat = {
  private ["_unit", "_tmp"];
  _unit = _this select 0;
  
  //if(surfaceIsWater getPos _unit) exitWith { true; };
  
  _tmp = magazines _unit;
  _ret = false;
  {
      if(_x in _tmp) exitWith {
          _ret = true;
      };
  } foreach FOOD_CLASSES;
  _ret;
};

AVD_fnc_fds_getFoodValue = {
  333.5;  
};

AVD_fnc_fds_food = {
  private ["_unit", "_tmp", "_food", "_val"];
  if(isNil "_this") then {
    _this = [player];  
  };
  _unit = _this select 0;
  _food = if(count(_this) > 1) then { _this select 1; } else { ""; };
  if(_food == "") then {
  	_tmp = magazines _unit;
  	
  	{
    	  if(_x in _tmp) exitWith {
        	_food = _x;  
      	  };
  	} foreach FOOD_CLASSES;
  };
  
  _val = [_food] call AVD_fnc_fds_getFoodValue;
  private "_curVal";
  _curVal = _unit getVariable "avd_fds_foodVal";
  _unit removeMagazine _food;
  private "_newVal";
  _newVal = _curVal + _val;
  if(_newVal > 1000) then { _newVal = 1000; };
  _unit setVariable["avd_fds_foodVal", _newVal, true];
};

