private ["_unit", "_var"];
_unit = _this select 0;
if(_unit isKindOf "Animal") exitWith { false; };
_var = _unit getVariable "avd_cache_isCachable";
if(isNil "_var") exitWith { false; };
_var;  
