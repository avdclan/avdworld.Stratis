#define SELF "x_avd\components\civilian\events.sqf"
#define NODEBUG
#include "include\avd.h"

AVD_LOCATIONS_INITIALIZED = [];
["avd_location_create", {
	DLOG("Location create: " + str(_this) + " - target: " + str(AVD_D_CLIENT_CIV));
    //DLOG("Location radius: " + str((_this select 0) getVariable "avd_location_radius"));
//    remoteSpawn({ DLOG("test!");}, []);

		if(!isServer) exitWith {};
        private ["_council", "_logic", "_side", "_name", "_marker", "_size", "_houses", "_chouses", "_counter", "_cGroup"];
    	_logic = _this select 0;
        if(_logic in AVD_LOCATIONS_INITIALIZED) exitWith { DLOG(str(_logic) + " already initialized."); };
        AVD_LOCATIONS_INITIALIZED = AVD_LOCATIONS_INITIALIZED + [_logic];
    	// populate location with civilians
     	_side = _logic getVariable "avd_side";
        if(_side != civilian) exitWith { DLOG("WRONG SIDE: " + str(_side)); };
      _name = _logic getVariable "avd_name";
	  _className = [civilian] call AVD_fnc_getRandomUnitClass;
      _cGroup = createGroup _side;
      _council = _cGroup createUnit[_className, getPos _logic, [], 0, "NONE"];
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
                    _houseHolder = _cGroup createUnit[_className, _pos1, [], 0, "NONE"];
                    _houseHolder setPosATL _pos1;
                    _houseHolder disableAI "move";
                    _rand = random 1;
                    if(_rand < 0.4) then {
                        _houseHolder enableAI "move";
                        _sides = [east, west, resistance];
                        _shfl = [_sides] call CBA_fnc_shuffle;
                        _nullGrp = createGroup (_shfl select 0);
                        [_houseHolder] joinSilent _nullGrp;
                       	_houseHolder setCaptive true;
                        
                    };
                   _houseHolder setVariable["avd_location_logic", _logic, true];
                   //[_logic, [_houseHolder]] call AVD_fnc_addCachingUnit;
                   [_houseHolder] call AVD_fnc_cache_enable;                  
                };
        };
      } foreach _houses;
      
      // place normal civs.
     _index = call AVD_fnc_getIndex;
     _min = (_size select 0) / 60;
     _rand = _min / 2;
     _count = [_min, _rand];
     [_logic, 0, (_size select 0), true, true, false, _count, 0, 0.1, _cGroup, "", _index] execVM "militarize.sqf";
     _cars = floor(random 10) + 5;
     [_logic, 0, 10000, false, true, false, 0, [_cars, 5], 0.1, _cGroup, "", _index] execVM "militarize.sqf";
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

     
}] call CBA_fnc_addEventHandler;

["avd_unit_zone_activated", {
    private ["_unit", "_caller", "_res"];
    _unit = _this select 0;
    _caller = _this select 1;
	
    if(isPlayer _caller and hasInterface) then {
   		DLOG("zone activated: " + str(_this));  
    };
    
	if(! local _unit) exitWith {};
    
    [{
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
                        
    }, _this] call AVD_fnc_remote_execute;    
 
}] call CBA_fnc_addEventHandler;
["avd_unit_zone_deactivated", {
    private ["_unit", "_caller", "_res"];
    _unit = _this select 0;
    _caller = _this select 1;
    if(isPlayer _caller and hasInterface) then {
   		DLOG("zone deactivated: " + str(_this));  
    };
	if(! local _unit) exitWith {};
    
    [{
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
                        
    }, _this] call AVD_fnc_remote_execute;      
 
}] call CBA_fnc_addEventHandler;