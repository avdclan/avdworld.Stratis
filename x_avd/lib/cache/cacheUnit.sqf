#define SELF "x_avd\lib\cache\cacheUnit.sqf"
//#define NODEBUG
#include "include\avd.h"
//if(isDedicated) exitWith {};

private["_unit", "_c"];;
_unit = _this select 0;
DLOG(str(_this));

//if(local _unit) exitWith { DLOG("WON'T CACHE, UNIT IS LOCAL!"); };
if(isPlayer _unit) exitWith { DLOG("Not caching player!"); };

if(!local _unit) then {
  DLOG("Sending cache request to owner.");
  [{
     if(! local(_this select 0)) exitWith {};
     
     _this call AVD_fnc_cache_cacheUnit;
  }, _this] call AVD_fnc_remote_execute;   
};
        
                    	

private ["_vec", "_l", "_marker", "_cachable", "_obj"];
_vec = vehicle _unit;
_l = [_unit];
if(_vec != _unit) then { 
	//[format["Got vehicle %1", _vec], "cacheUnit"] call AVD_fnc_log;
	_l = _l + [_vec];
};
{
    
    //[format["Caching %1", _x], "cacheUnit"] call AVD_fnc_log;
     _cachable = [_x] call AVD_fnc_cache_isCachable;
     DLOG(str(_x) + " is cachable: " + str(_cachable));
     if(_cachable) then {
         DLOG("Caching unit " + str(_x));
        //[format["Caching unit %1 (%2)", _this, typeOf _this], "debug"] call AVD_fnc_log;

       	        // unplug cache object attached to the unit.
        // if trigger is attach to unit it will also stop simulating
        //detach _obj;	
        //sleep 0.01;
       
        //_x enableSimulation false;
        _x disableAI "MOVE";
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x disableAI "ANIM";
        _x disableAI "FSM";
        _x hideObject true;
        _x setVariable ["avd_cache_isCached", true, true];
   	 };
} foreach _l;