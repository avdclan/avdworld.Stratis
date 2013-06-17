private ["_trigger", "_caller", "_var", "_list", "_ret"];
_trigger = _this select 0;
_caller = _this select 1;
_list = _trigger getVariable "avd_trigger_caller_list";
if(isNil "_list") then {
    _list = [];
  _ret = false; 
} else {
	_ret = (_caller in _list);
};
_ret;