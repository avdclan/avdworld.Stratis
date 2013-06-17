private ["_trigger", "_caller", "_var", "_list", "_trg", "_attached", "_dim", "_events", "_callEvents", "_eargs"];
_trigger = _this select 0;
if(! local _trigger) exitWith {};
_caller = _this select 1;
_attached = _this select 2;
if(isNUll _attached) exitWith {};
_events = _this select 3;
_list = _trigger getVariable "avd_trigger_caller_list";


if(isNil "_list") then {
  _list = [];  
};

if(_caller in _list) exitWith { false; };
//[format["Adding %1 (%3) to %2 (%4) radius %5", _caller, _attached, typeOf _caller, typeOf _attached, triggerArea _trigger], "debug"] call AVD_fnc_log;

_dim = triggerArea _trigger;
_trg = createTrigger ["EmptyDetector", getPos _caller];
_trg setVariable["avd_trigger_tmp_caller", _caller, true];
_trg setVariable["avd_trigger_parent", _trigger, true];
_trg setTriggerArea _dim;
_trg setTriggerActivation["ANY", "PRESENT", false];
 _eargs = format["[%1, %2, thislist, thistrigger, %3]", _attached, _caller, _events];
  _callEvents = "";
  
  {
      _callEvents = format["%1 ['%2_deactivated', %3] call CBA_fnc_globalEvent;", _callEVents, _x, _eargs];
  } foreach _events;
_onact = format["[thistrigger, %1] call AVD_fnc_trigger_removeCaller;", _caller];
_onact = format["%1 %2", _onact, _callEvents];
//[format["onact: %1", _onact], "addCaller"] call AVD_fnc_log;
_trg setTriggerStatements[format["!(%1 in thislist)", _caller], _onact, "deleteVehicle thistrigger;"]; 
_trg attachTo[_attached, [0,0,0]];
_list = _list + [_caller];
_trigger setVariable["avd_trigger_caller_list", _list, true];
_unit setVariable["avd_trigger_current", _trigger, true];
true;
