#define SELF "x_avd\lib\cache\cacheUnit.sqf"
#include "include\avd.h"


private["_unit", "_c"];;
_unit = _this select 0;
if(isPlayer _unit) exitWith {};
    private ["_vec", "_l", "_marker", "_cachable", "_obj"];
    _vec = vehicle _unit;
    _l = [_unit];
    if(_vec != _unit) then { 
    	//[format["Got vehicle %1", _vec], "cacheUnit"] call AVD_fnc_log;
    	_l = _l + [_vec];
    };
	{
       // DLOG("Working on " + str(_x));
        //[format["Caching %1", _x], "cacheUnit"] call AVD_fnc_log;
        if((! local _x) or (isServer and !isDedicated)) then {
         _marker = _x getVariable "avd_tracking_marker";
         _cachable = [_x] call AVD_fnc_cache_isCachable;
         if(_cachable) then {
            //[format["Caching unit %1 (%2)", _this, typeOf _this], "debug"] call AVD_fnc_log;
	        if(! isNil "_marker") then {
	          _marker setMarkerColorLocal "ColorWhite";  
	        };
	        // unplug cache object attached to the unit.
	        // if trigger is attach to unit it will also stop simulating
	        _obj = _x getVariable "avd_cache_object";
	        //detach _obj;
            //sleep 0.01;
	        //_x enableSimulation false;
	        _x setVariable ["avd_cache_isCached", true, false];
	        _obj setVariable ["avd_cache_isCached", true, false];
       };
       };
    } foreach _l;