	#define SELF "x_avd\lib\common.sqf"
#define NODEBUG
#include "include\avd.h"

AVD_fnc_getValidVarName = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getValidVarName.sqf";
AVD_fnc_getIndex = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getIndex.sqf";
AVD_fnc_setVehicleVarName = compileFinal preprocessFileLineNumbers "x_avd\lib\common\setVehicleVarName.sqf";
AVD_fnc_getRandomUnitClass = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getRandomUnitClass.sqf";
AVD_fnc_trackingMarker = compileFinal preprocessFileLineNumbers "x_avd\lib\common\trackingMarker.sqf";
AVD_fnc_say = compileFinal preprocessFileLineNumbers "x_avd\lib\common\say.sqf";
AVD_fnc_getMissionParam = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getMissionParam.sqf";

AVD_fnc_player_init = compileFinal preprocessFileLineNumbers "x_avd\player\init.sqf";


AVD_fnc_getConfig = {
  private ["_class", "_elem", "_ret"];
  _class = PARAM(0, nil);
  _ret = nil;
  { 
  	_elem = configFile >> _x >> _class;
  	if(isClass _elem) exitWith { _ret = _elem; };
  } foreach ["cfgWeapons", "cfgVehicles", "cfgMagazines"];
  _ret;  
};

AVD_fnc_getSideByClass = {
    private ["_class", "_elem", "_ret"];
    _class = PARAM(0, nil);
    _ret = civilian;
    
    _elem = [_class] call AVD_fnc_getConfig;


    if(isClass _elem) then {
        _s = getNumber(_elem >> "side");
        _ret = [_s] call AVD_fnc_getSideFromNumber;
    };
    
    _ret;
};

AVD_fnc_getWeaponType = {
  	private ["_class", "_elem", "_ret"];
  
    _class = PARAM(0, nil);
    if(isNil "_class") exitWith { DLOG("no class"); };
    
    // cfgAmmo, cfgMagazines, cfgWeapons
    _elem = configFile >> "cfgWeapons" >> _class;
    if(isClass _elem) exitWith { "weapon"; };
    _elem = configFile >> "cfgMagazines" >> _class;
    if(isClass _elem) exitWith { "magazine"; };
    _elem = configFile >> "cfgAmmo" >> _class;
    if(isClass _elem) exitWith { "ammo"; };
    nil;  
};

AVD_fnc_getSideFromNumber = {
  private ["_num", "_side"];
  
     _num = PARAM(0, 0);
     _side = civilian;
      switch(_num) do {
        case 0: {
          _side = EAST;  
        };
        case 1: {
          _side = WEST;  
        };  
        case 2: {
          _side = RESISTANCE;  
        };
        default {
          _side = CIVILIAN;  
        };
      };  
      _side;
};