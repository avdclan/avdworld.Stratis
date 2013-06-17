#define SELF "x_avd\lib\cache\activateUnit.sqf"
#include "include\avd.h"
//DLOG(str(_this));
private["_unit"];
_unit = _this select 0;
//[format["Activating unit %1 from cache.", _unit], "debug"] call AVD_fnc_log;
if(isPlayer _unit) exitWith {};

    private ["_vec", "_l"];
    //if(local _this) exitWith { [format["Local units are not caching %1", _unit], "debug"] call AVD_fnc_log; };
    _l = [_unit];
    _vec = vehicle _unit;
    if(_vec != _unit) then { _l = _l + [_vec]; };
	
    
    { 
        _x enableSimulation true;
    	//_obj = _x getVariable "avd_cache_object";
    	//_obj attachTo [_x, [0, 0, 0]];
    	//[format["Unit %1 woke up from cache.", _x], "debug"] call AVD_fnc_log;
    	_x setVariable["avd_cache_isCached", false, false];
    	//_obj setVariable["avd_cache_isCached", false, false];
    } foreach _l;
    
    
