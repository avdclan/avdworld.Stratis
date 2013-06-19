#define SELF "x_avd\lib\uniform.sqf"
#include "include\avd.h"

AVD_fnc_isUniform = {
    private ["_className", "_ret"];
    _className = _this select 0;
    _ret = [_className] call AVD_fnc_getWeaponType;
    if(_ret == "uniform") exitWith { true; };
    false;
};
AVD_fnc_isWeaponType = {
  private ["_weapon", "_type", "_ret"];
  _weapon = _this select 0;
  _type = _this select 1;
  
  _ret = [_weapon] call AVD_fnc_getWeaponType;
    
  if(_ret == _type) exitWith { true; };
  false;  
};
AVD_fnc_getWeaponType = {
  private ["_className", "_unit", "_var"];
  _className = _this select 0;
    
  // unless allowedSlots is same on either backpack, vest or uniform,
  // we have to do this dirty shit.
  _unit = call AVD_fnc_getDummyUnit;
  
  // performing uniform check.
  DLOG("CHECKING IF IT'S UNIFORM.");
  _unit addUniform _className;
  if(uniform _unit == _className) exitWith { deleteVehicle _unit; "uniform"; };
  
  // performing vest check.
  DLOG("CHECKING IF IT'S VEST.");
  _unit addVest _className;
  if(vest _unit == _className) exitWith { deleteVehicle _unit; "vest"; };
  
  // performing vest check.
  DLOG("CHECKING IF IT'S HEADGEAR.");
  _unit addHeadgear _className;
  if(headgear _unit == _className) exitWith { deleteVehicle _unit; "headgear"; };
  deleteVehicle _unit;
  false;
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
}
