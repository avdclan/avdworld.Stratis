#define SELF "x_avd\components\civilian\events.sqf"
#include "include\avd.h"
#define __quiet true

["avd_location_create", {
	//DLOG("Location create: " + str(_this));
    //DLOG("Location radius: " + str((_this select 0) getVariable "avd_location_radius"));
    [-2, {
        DLOG(str(playableUnits));
        if(! local AVD_D_CLIENT_CIV) exitWith {
            _str = format["I am not %1 (%2), I am %3 (%4)", AVD_D_CLIENT_CIV, owner AVD_D_CLIENT_CIV, player, owner player];
            DLOG(_str);
        };
        private ["_logic", "_side", "_name", "_marker", "_size", "_houses", "_chouses", "_counter"];
    	_logic = _this select 0;
    	// populate location with civilians
     	_side = _logic getVariable "avd_side";
      _name = _logic getVariable "avd_name";
      _marker = _logic getVariable "avd_marker";
      _size = getMarkerSize _marker;
      // getting all houses
      _houses = nearestObjects [_logic, ["House"], _size select 0];
      //[format["Got these houses for %1: %2", _name, _houses], "debug"] call AVD_fnc_log;
      _chouses = count(_houses);
      //[format["Got %2 houses for %1", _name, _chouses], "debug"] call AVD_fnc_log;
      _counter = 0;
      {
          
        _pos1 = _x buildingPos 5;
        _pos2 = _x buildingPos 10;
        
        _result1 = [_pos1,[0,0,0]] call BIS_fnc_areEqual;  // result = true
        _result2 = [_pos2,[0,0,0]] call BIS_fnc_areEqual;  // result = true
        _maxPos = 50;
       
        if( !_result1 && _result2 ) then {
                _exit = _x buildingExit 0;
                _result = [_exit,[0,0,0]] call BIS_fnc_areEqual;  // result = true
                if( ! _result) then {
	        		_counter = _counter + 1;
          			_className = [civilian] call AVD_fnc_getRandomUnitClass;
                    _grp = createGroup _side;
                    _houseHolder = _grp createUnit[_className, _pos1, [], 0, "CAN_COLLIDE"];
                    _rand = random 100;
                    if(_rand < 40) then {
                        _sides = [east, west, resistance];
                        _shfl = [_sides] call CBA_fnc_shuffle;
                        _nullGrp = createGroup (_shfl select 0);
                        [_houseHolder] joinSilent _nullGrp;
                    };
                   _houseHolder setVariable["avd_location_logic", _logic, true];
                   //[_logic, [_houseHolder]] call AVD_fnc_addCachingUnit;
                   [_houseHolder] call AVD_fnc_cache_enable;                  
                };
        };
      } foreach _houses;
      
      // place normal civs.
     _index = call AVD_fnc_getIndex;
     _min = (_size select 0) / 20;
     _rand = _min / 2;
     _count = [_min, _rand];
     [_logic, 0, (_size select 0), true, true, false, _count, 0, 0.1, nil, "", _index] execVM "militarize.sqf";
     _index spawn {
         private ["_index", "_grp"];
         _index = _this;
         //DLOG("Waiting for LVgroup" + str(_index) + " to become ready....");
         waitUntil {! isNil format["LVgroup%1", _index] };
        // DLOG("LVgroup" + str(_index) + " is ready.");
         _grp = nil; 
         call compile format[" _grp = LVgroup%1;", _index];
         {
             //DLOG("Runing cache-enable for " + str(_x));
             [_x] call AVD_fnc_cache_enable;
         } foreach units _grp;
         _grp setBehaviour "CARELESS";
         _grp setSpeedMode "LIMITED";
     };
     }, _this] call CBA_fnc_globalExecute;    
}] call CBA_fnc_addEventHandler;

["avd_unit_zone_activated", {
    private ["_unit", "_caller", "_res"];
    _unit = _this select 0;
    _caller = _this select 1;
	
    if(isPlayer _caller) then {
    //  DLOG("zone activated: " + str(_this));  
    };
    
	if(! local _unit) exitWith {};
    
    [-2, {
    	private ["_unit", "_caller", "_res"];
        _unit = _this select 0;
        _caller = _this select 1;
        //DLOG("Running everywhere");
        if(! local _caller) exitWith {};
        //DLOG("Running locally");
        _res = [_unit] call CBA_fnc_cache_isCached;
        //DLOG("Is cached: " + str(_res));
        if(! _res) exitWith {};
        //DLOG("Distance: " + str((_unit distance _caller)) + ", viewDistance: " + str(viewDistance));
        if((_unit distance _caller) > viewDistance) exitWith {};
       // DLOG("Alright, activating.");
        [_unit] call AVD_fnc_cache_activateUnit;
                        
    }, _this] call CBA_fnc_globalExecute;    
 
}] call CBA_fnc_addEventHandler;
["avd_unit_zone_deactivated", {
    private ["_unit", "_caller", "_res"];
    _unit = _this select 0;
    _caller = _this select 1;
    if(isPlayer _caller) then {
      //DLOG("zone deactivated: " + str(_this));  
    };
	if(! local _unit) exitWith {};
    
    [-2, {
    	private ["_unit", "_caller", "_res"];
        _unit = _this select 0;
        _caller = _this select 1;
       // DLOG("Running everywhere");
        if(! local _caller) exitWith {};
        //DLOG("Running locally");
        _res = [_unit] call CBA_fnc_cache_isCached;
        //DLOG("Is cached: " + str(_res));
        if(_res) exitWith {};
        
       // DLOG("Distance: " + str((_unit distance _caller)) + ", viewDistance: " + str(viewDistance));
        if((_unit distance _caller) <= viewDistance) exitWith {};
       // DLOG("Alright, caching.");
        [_unit] call AVD_fnc_cache_cacheUnit;
                        
    }, _this] call CBA_fnc_globalExecute;      
 
}] call CBA_fnc_addEventHandler;