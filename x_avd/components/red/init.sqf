if(!isServer) exitWith {};
#define SELF "x_avd\components\red\init.sqf"
#include "include\avd.h"

DLOG("Loading reds... ");
//ccpf("x_avd\components\civilian\events.sqf");
private ["_villages",
		"_cities",
        "_capitals",
        "_locals"];
        
_villages = nearestLocations [[0,0,0], ["NameVillage"], 100000]; 
_cities = nearestLocations [[0,0,0], ["NameCity"], 100000];
_capitals = nearestLocations [[0,0,0], ["NameCityCapital"], 100000];
_locals = nearestLocations [[0,0,0], ["NameLocal"], 100000];

{ 
	//_side = [_SIDES] call CBA_fnc_shuffle;
    //DLOG("Creating Trigger Location for village: " + str(_x));
    //_group = [east, 8, "SEARCH", "CITY_SEARCH"] call AVD_fnc_group_spawn;
    _index = call AVD_fnc_getIndex;
    [position _x, 2, 150, true, true, false, [5, 2], [2, 1], 0.2, nil, "", _index] execVM "militarize.sqf";
    _index spawn {
      private ["_index", "_grp", "_group"];
      _index = _this;
      _grp = format["LVgroup%1", _index];
      _group = nil;
      waitUntil { ! isNil _grp };
      call compile format["_group = %1;", _grp];
      {
          [_x] call AVD_fnc_trackingMarker;
      } foreach units _group;
    };
	//[_x, [150, 150], [5, 10], false, civilian] call AVD_fnc_createTriggerLocation;
} foreach _villages; 


{ 
	//_side = [_SIDES] call CBA_fnc_shuffle;
    //DLOG("Creating Trigger Location for village: " + str(_x));
    //_group = [east, 15, "SEARCH", "CITY_SEARCH"] call AVD_fnc_group_spawn;
    _index = call AVD_fnc_getIndex;
    [position _x, 2, 350, true, true, false, [15, 6], [2, 1], 0.2, nil, "", _index] execVM "militarize.sqf";
    _index spawn {
      private ["_index", "_grp", "_group"];
      _index = _this;
      _grp = format["LVgroup%1", _index];
      _group = nil;
      waitUntil { ! isNil _grp };
      call compile format["_group = %1;", _grp];
      {
          [_x] call AVD_fnc_trackingMarker;
      } foreach units _group;
    };
	//[_x, [250, 250], [5, 10], false, civilian] call AVD_fnc_createTriggerLocation;
} foreach _cities; 

{ 
	//_side = [_SIDES] call CBA_fnc_shuffle;
    //DLOG("Creating Trigger Location for village: " + str(_x));
	//[_x, [500, 500], [5, 10], false, civilian] call AVD_fnc_createTriggerLocation;
    //_group = [east, 20, "SEARCH", "CITY_SEARCH"] call AVD_fnc_group_spawn;
    _index = call AVD_fnc_getIndex;
    [position _x, 2, 500, true, true, false, [15, 15], [3, 3], 0.2, nil, "", _index] execVM "militarize.sqf";
    _index spawn {
      private ["_index", "_grp", "_group"];
      _index = _this;
      _grp = format["LVgroup%1", _index];
      _group = nil;
      waitUntil { ! isNil _grp };
      call compile format["_group = %1;", _grp];
      {
          [_x] call AVD_fnc_trackingMarker;
      } foreach units _group;
    };
} foreach _capitals; 

{ 
	//_side = [_SIDES] call CBA_fnc_shuffle;
    //DLOG("Creating Trigger Location for village: " + str(_x));
    //_group = [east, 8, "SEARCH", "CITY_SEARCH"] call AVD_fnc_group_spawn;
    _index = call AVD_fnc_getIndex;
    [position _x, 2, 50, true, false, false, [2, 3], 0, 0.5, nil, "", _index] execVM "militarize.sqf";
    _index spawn {
      private ["_index", "_grp", "_group"];
      _index = _this;
      _grp = format["LVgroup%1", _index];
      _group = nil;
      waitUntil { ! isNil _grp };
      call compile format["_group = %1;", _grp];
      {
          [_x] call AVD_fnc_trackingMarker;
      } foreach units _group;
    };
	//[_x, [100, 100], [5, 10], false, east] call AVD_fnc_createTriggerLocation;
} foreach _locals;

DLOG("Reds initialized.");