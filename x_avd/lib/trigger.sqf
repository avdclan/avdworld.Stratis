#define SELF "x_avd\lib\trigger.sqf"
#include "include\avd.h"

AVD_LOCATION_LOGIC_GROUP = createGroup sideLogic;

AVD_fnc_trigger_addCaller = compileFinal preprocessFileLineNumbers "x_avd\lib\trigger\addCaller.sqf";
AVD_fnc_trigger_removeCaller = compileFinal preprocessFileLineNumbers "x_avd\lib\trigger\removeCaller.sqf";
AVD_fnc_trigger_isCalling = compileFinal preprocessFileLineNumbers "x_avd\lib\trigger\isCalling.sqf";

AVD_fnc_trigger_createMultiTrigger = {
    //DLOG("Creating multitrigger: " + str(_this));
     private ["_object", "_area", "_activation", "_name", "_condition", "_trg", "_ondeact", "_onact", "_eargs", "_events", "_callEvents"];
     _object = _this select 0;
     //DLOG("Object: " + str(_object));
   
     if(isNil "_object" or isNull _object) exitWith {};
     if(! local _object) exitwith {};
   //[format["Adding multi trigger to %1", _object], "multiTrigger"] call AVD_fnc_log;
   _area = _this select 1;
   _activation = _this select 2;
   _events = _this select 3;
   if(isNil "_events") then {
     _events = ["avd_location"];  
   };
   _condition = "_res = [thistrigger, (thislist select 0)] call AVD_fnc_trigger_isCalling; (!_res and !isNull (thislist select 0) and isPlayer (thislist select 0))";
   
   _trg = createTrigger["EmptyDetector", getPos _object];	
   _trg setTriggerArea _area;
   _trg setTriggerActivation _activation;
  _eargs = format["[%1, (thislist select 0), thislist, thistrigger, %2]", _object, _events];
  //DLOG("_eargs: " + str(_eargs));
  _callEvents = "";
  
  {
      //[format["Adding event %1_activated to %2", _x, _trg], "trigger"] call AVD_fnc_log;
      
      _callEvents = format["%1 ['%2_activated', %3] call CBA_fnc_globalEvent;", _callEVents, _x, _eargs];
  } foreach _events;	
  _onact = "";
   _onact = format["%1 [thistrigger, (thislist select 0), %2, %3] call AVD_fnc_trigger_addCaller;", _onact, _object, _events];
   _ondeact = "";
   _onact = format["%1 %2", _onact, _callEvents];
   //[format["On act: %1", _onact], "createMultiTrigger"] call AVD_fnc_log;
   _trg setTriggerStatements[_condition, _onact, _ondeact];
   _trg setTriggerTimeout[0, 0, 0, true];
   _trg setVariable ["avd_trigger_attached", _object, true];
   _trg attachTo[_object, [0, 0, 0]];
   _trg;                      
 };
 
 
AVD_fnc_createTriggerLocation = {
     if(!isServer) exitWith {};
     //[format["Creating triggerLocation: %1", _this], "createTriggerLocation"] call AVD_fnc_log;
     
     private ["_loc", "_rad", "_logicGroups", "_vecs", "_logic", "_pos", "_logicCenter", "_logicGroup", "_var", "_name", "_trg", "_marker", "_markerName"];
   	_loc = _this select 0;
   	_rad = _this select 1;
    _logicGroups = _this select 2;
    _vecs = _this select 3;
    _side = _this select 4;
    _pos = position _loc;
    _name = text _loc;
    
    
	private ["_x", "_y"];
    _x = _rad select 0;
    _y = _rad select 1;
    _markerName = "marker_" + str(_name);
    _marker = createMarker[_markerName, _pos];
	_marker setMarkerShape "ELLIPSE";
	//_marker setMarkerType "mil_dot";
	_marker setMarkerSize [_x, _y];
    _marker setMarkerColor "ColorBlack";
    
        
	_logic = AVD_LOCATION_LOGIC_GROUP createUnit ["LOGIC", _pos, [], 0, ""];
    _var = "location_trigger" call AVD_fnc_getValidVarName;
    DLOG(str(_logic) + " becomes varname " + str(_var));
    _logic setVehicleVarName _var;
    DLOG("varname is " + str(vehicleVarName _logic));
    
    //_logic enableSimulation false;
    //_trg = createTrigger["EmptyDetector", position _loc];
    _trg = [
    	_logic, 
        [_x, _y, 0, false], 
        ["ANY", "PRESENT", true]
    ] call AVD_fnc_trigger_createMultiTrigger;
    
    _logic setVariable ["avd_side", _side, true];
    _logic setVariable ["avd_location_side", _side, true];
    _logic setVariable ["avd_location_trigger", _trg, true];
    _logic setVariable ["avd_marker", _marker, true];
    _logic setVariable ["avd_name", _name, true];
    _logic setVariable ["avd_location_radius", _rad, true];

    //AVD_LOCATIONS = AVD_LOCATIONS + [_logic];
    //publicVariable "AVD_LOCATIONS";
    //[format["Firing avd_location_create event for %1", _logic], "createTriggerLocation"] call AVD_fnc_log;
    ["avd_location_create", [_logic]] call CBA_fnc_globalEvent;
    //[format["Fired avd_location_create event for %1", _logic], "createTriggerLocation"] call AVD_fnc_log;
        
};