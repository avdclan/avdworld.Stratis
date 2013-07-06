#define SELF "x_avd\lib\common.sqf"
#include "include\avd.h"

AVD_fnc_getValidVarName = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getValidVarName.sqf";
AVD_fnc_getIndex = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getIndex.sqf";
AVD_fnc_setVehicleVarName = compileFinal preprocessFileLineNumbers "x_avd\lib\common\setVehicleVarName.sqf";
AVD_fnc_getRandomUnitClass = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getRandomUnitClass.sqf";
AVD_fnc_trackingMarker = compileFinal preprocessFileLineNumbers "x_avd\lib\common\trackingMarker.sqf";
AVD_fnc_say = compileFinal preprocessFileLineNumbers "x_avd\lib\common\say.sqf";
AVD_fnc_getMissionParam = compileFinal preprocessFileLineNumbers "x_avd\lib\common\getMissionParam.sqf";

AVD_fnc_player_init = compileFinal preprocessFileLineNumbers "x_avd\player\init.sqf";



AVD_fnc_getSideByClass = {
    private ["_class", "_elem", "_ret"];
    _class = PARAM(0, nil);
    _ret = civilian;
    
    _elem = configFile >> "cfgVehicles" >> _class;


    if(isClass _elem) then {
        DLOG("ELEM: " + configName(_elem));
        _s = getNumber(_elem >> "side");
         switch(_s) do {
	        case 0: {
	          _ret = EAST;  
	        };
	        case 1: {
	          _ret = WEST;  
	        };  
	        case 2: {
	          _ret = RESISTANCE;  
	        };
	        default {
	          _ret = CIVILIAN;  
	        };
      	};
    };
    
    _ret;
};

AVD_fnc_getWeaponType = {
  	private ["_class", "_elem", "_ret"];
  
    _class = PARAM(0, nil);
    if(isNil "_class") exitWith { DLOG("no class"); };
    
    // cfgAmmo, cfgMagazines, cfgWeapons
    _elem = configFile >> "cfgWeapons" >> _class;
    if(isClass _elem) exitWith { DLOG("is weapon."); "weapon"; };
    _elem = configFile >> "cfgMagazines" >> _class;
    if(isClass _elem) exitWith { DLOG("is mag."); "magazine"; };
    _elem = configFile >> "cfgAmmo" >> _class;
    if(isClass _elem) exitWith { DLOG("is ammo."); "ammo"; };
    nil;  
};