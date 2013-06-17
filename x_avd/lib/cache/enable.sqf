 #define SELF "x_\avd\lib\cache\enable.sqf"
 #include "include\avd.h"
 
 private ["_unit", "_res"];
// DLOG(_this);
 _unit = _this select 0; 
 if(isPlayer _unit) exitWith {};
 if(isNull _unit) exitWith {};
 _res = _unit getVariable "avd_cache_enabled";
 if(! isNil "_res") exitWith {};
 _unit setVariable ["avd_cache_enabled", false, true];
 
AVD_fnc_cache_createTriggerZone = {
    private ["_unit", "_rad", "_name", "_group", "_logic", "_cond", "_act", "_deact", "_trg", "_trgs", "_unit", "_area", "_varName"];
    _unit = _this select 0;
  	_rad = _this select 1;	
  	_name = _this select 2;
    if(isNull _unit) exitWith {};
    if(! local _unit) exitWith {};
    
    if(vehicleVarName _unit == "") then {
      _varName = call AVD_fnc_getValidVarName;
      [_unit, _varName] call AVD_fnc_setVehicleVarName;
    };
    
   //DLOG("Enabling cache for unit " + str(_unit) + " (" + str(netId _unit) + ")");
    _logic = _this select 3;
    _trgs = _logic getVariable "avd_zone_triggers";
    if(isNil "_trgs") then {
        _trgs = [];
    };
    _area = [_rad select 0, _rad select 1, 0, false];
    _trgs = _trgs + [_name];
  //  [format["Making %1 (%2) cachable - zone: %3", _unit, _logic, _name], "enableCache"] call AVD_fnc_log;
  	_trg = [
    	_unit, 
        _area, 
        ["ANY", "PRESENT", true],
        [format["avd_unit_zone_%1", _name], "avd_unit_zone"]
    ] call AVD_fnc_trigger_createMultiTrigger;
    _trg attachTo[_logic, [0,0,0]];
    _trg = [
    	_unit, 
       _area, 
        ["ANY", "EAST D", true],
        ["avd_unit_zone"]
    ] call AVD_fnc_trigger_createMultiTrigger;
    _trg attachTo[_logic, [0,0,0]];
    
    
    
  /*
	_trg = createTrigger["EmptyDetector", getPos _unit];
	_trg setTriggerArea[_rad select 0, _rad select 1, 0, false];
	_trg setTriggerActivation["ANY", "PRESENT", true];
	_cond = "isPlayer (thislist select 0)";
	_act = format["thisTrigger setVariable['avd_trigger_enter_caller_%1', (thislist select 0), true]; ['avd_unit_zone_enter_%1', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent; ['avd_unit_zone_enter', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_deact = format["['avd_unit_zone_leave_%1', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_enter_caller_%1'), thislist]] call CBA_fnc_globalEvent; ['avd_unit_zone_leave', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_enter_caller_%1'), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_trg setTriggerStatements[_cond, _act, _deact];
	_trg setTriggerTimeout[0, 0, 0, true];
    _trg attachTo[_logic, [0, 0, 0]];

    if(isNil "_trgs") then {
        _trgs = [];
    };
    _trgs = _trgs + [_name];
    
    _trg = createTrigger["EmptyDetector", getPos _unit];
	_trg setTriggerArea[_rad select 0, _rad select 1, 0, false];
	_trg setTriggerActivation["ANY", "EAST D", true];
	_cond = "this";
	_act = format["thisTrigger setVariable['avd_trigger_detect_caller_%1', (thislist select 0), true]; ['avd_unit_detect_enter_%1', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_enter', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_deact = format["['avd_unit_detect_leave_%1', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_leave', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_trg setTriggerStatements[_cond, _act, _deact];
	_trg setTriggerTimeout[0, 0, 0, true];
    _trg attachTo[_logic, [0, 0, 0]];
    if(isNil "_trgs") then {
        _trgs = [];
    };
    _trgs = _trgs + [_name];
    
    _trg = createTrigger["EmptyDetector", getPos _unit];
	_trg setTriggerArea[_rad select 0, _rad select 1, 0, false];
	_trg setTriggerActivation["ANY", "WEST D", true];
	_cond = "this";
	_act = format["thisTrigger setVariable['avd_trigger_detect_caller_%1', (thislist select 0), true]; ['avd_unit_detect_enter_%1', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_enter', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_deact = format["['avd_unit_detect_leave_%1', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_leave', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_trg setTriggerStatements[_cond, _act, _deact];
	_trg setTriggerTimeout[0, 0, 0, true];
    _trg attachTo[_logic, [0, 0, 0]];
    if(isNil "_trgs") then {
        _trgs = [];
    };
    _trgs = _trgs + [_name];
    
    _trg = createTrigger["EmptyDetector", getPos _unit];
	_trg setTriggerArea[_rad select 0, _rad select 1, 0, false];
	_trg setTriggerActivation["ANY", "GUER D", true];
	_cond = "this";
	_act = format["thisTrigger setVariable['avd_trigger_detect_caller_%1', (thislist select 0), true]; ['avd_unit_detect_enter_%1', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_enter', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_deact = format["['avd_unit_detect_leave_%1', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_leave', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_trg setTriggerStatements[_cond, _act, _deact];
	_trg setTriggerTimeout[0, 0, 0, true];
    _trg attachTo[_logic, [0, 0, 0]];
    if(isNil "_trgs") then {
        _trgs = [];
    };
    _trgs = _trgs + [_name];
    
    _trg = createTrigger["EmptyDetector", getPos _unit];
	_trg setTriggerArea[_rad select 0, _rad select 1, 0, false];
	_trg setTriggerActivation["ANY", "CIV D", true];
	_cond = "this";
	_act = format["thisTrigger setVariable['avd_trigger_detect_caller_%1', (thislist select 0), true]; ['avd_unit_detect_enter_%1', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_enter', [""%1"", %2, %3, (thislist select 0), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_deact = format["['avd_unit_detect_leave_%1', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent; ['avd_unit_detect_leave', [""%1"", %2, %3, (thisTrigger getVariable 'avd_trigger_detect_caller_%1'), thislist]] call CBA_fnc_globalEvent;", _name, _unit, _rad];
	_trg setTriggerStatements[_cond, _act, _deact];
	_trg setTriggerTimeout[0, 0, 0, true];
    _trg attachTo[_logic, [0, 0, 0]];
    if(isNil "_trgs") then {
        _trgs = [];
    };
    _trgs = _trgs + [_name];
    */
    
    
    _logic setVariable ["avd_zone_triggers", _trgs, true];
    _logic setVariable [format["avd_zone_%1_trigger", _name], _trg, true];
    
};
//[format["Making %1 cachable.", _unit], "enableCache"] call AVD_fnc_log;
private ["_lc", "_lg"];
//_lg = call AVD_fnc_getLogicGroup;
//_lc = _lg createUnit["LOGIC", getPos _unit, [],  0, ""];
//[_lc] joinSilent grpNull;
//_lc enableSimulation false;
_lc = _unit;
_unit setVariable ["avd_cache_object", _lc, true];
[_unit, [2, 2], "black", _lc] call AVD_fnc_cache_createTriggerZone;
[_unit, [5, 5], "purple", _lc] call AVD_fnc_cache_createTriggerZone;
[_unit, [50, 50], "red", _lc] call AVD_fnc_cache_createTriggerZone;
[_unit, [250, 250], "yellow", _lc] call AVD_fnc_cache_createTriggerZone;
[_unit, [1000, 1000], "blue", _lc] call AVD_fnc_cache_createTriggerZone;
[_unit, [2000, 2000], "green", _lc] call AVD_fnc_cache_createTriggerZone;
[_unit, [5000, 5000], "white", _lc] call AVD_fnc_cache_createTriggerZone;
_unit setVariable ["avd_cache_enabled", true, true];
_unit setVariable ["avd_cache_isCachable", true, true];

[_unit] call AVD_fnc_cache_cacheUnit;
//_lc attachTo [_unit, [0,0,0]];