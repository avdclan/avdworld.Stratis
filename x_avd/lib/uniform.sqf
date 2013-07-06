#define SELF "x_avd\lib\uniform.sqf"
//#define NODEBUG
#include "include\avd.h"

AVD_fnc_isUniform = {
    private ["_className", "_ret"];
    _className = _this select 0;
    _ret = [_className] call AVD_fnc_getWeaponType;
    if(_ret == "uniform") exitWith { true; };
    false;
};
AVD_fnc_isUniformType = {
  private ["_weapon", "_type", "_ret"];
  _weapon = _this select 0;
  _type = _this select 1;
  
  _ret = [_weapon] call AVD_fnc_getWeaponType;
    
  if(_ret == _type) exitWith { true; };
  false;  
};

AVD_fnc_getUniformType = {
  private ["_className", "_unit", "_var", "_cfg", "_type", "_ret", "_result"];
  _className = _this select 0;
  _ret = "";
  
  _cfg = configFile >> "cfgWeapons" >> _className;
  if(isClass _cfg) then {
  	_result = [_className, "_"] call CBA_fnc_split;
  	_type = _result select 0; 
    switch(_type) do {
        case "U": {
          _ret = "uniform";  
        };
        case "V": {
          _ret = "vest";  
        };
        
        case "H": {
            _ret = "headgear";
        };
    };  
  };
  
  _ret;
};


AVD_fnc_getDummyUnit = {
    private ["_side", "_dummy"];
    _dummy = (createGroup civilian) createUnit["C_man_1", [0, 0, 0], [], 0, ""];
    removeAllWeapons _dummy;
    removeAllItems _dummy;
    removeBackpack _dummy;
    removeGoggles _dummy;
    removeUniform _dummy;
    removeHeadgear _dummy;
    removeVest _dummy;
    _dummy;
};
