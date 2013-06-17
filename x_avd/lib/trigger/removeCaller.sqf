private ["_trigger", "_caller", "_var", "_list", "_trg", "_parent"];
_trigger = _this select 0;
if(! local _trigger) exitWith {};

_caller = _this select 1;
_parent = _trigger getVariable "avd_trigger_parent";
_list = _parent getVariable "avd_trigger_caller_list";
if(isNil "_list") then {
  _list = [];  
};

if(! (_caller in _list)) exitWith { false; };
//[format["Removing %1 from %2 (parent: %3 (%5), trigger: %4 (%6))", _caller, _list, _parent, _trigger, triggerArea _parent, triggerArea _trigger], "debug"] call AVD_fnc_log;
_list = _list - [_caller];
_parent setVariable["avd_trigger_caller_list", _list, true];
_trigget setVariable["avd_trigger_parent", _parent, true];
true;

