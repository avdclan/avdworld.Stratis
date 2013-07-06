#define SELF "x_avd\components\red\init.sqf"
#include "include\avd.h"

DLOG("Loading reds... ");
[{
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
	DLOG("Loading village : " + str(text _x) + " -> " + str(AVD_LOCATION_EXCLUDE));
	if(!((text _x) in AVD_LOCATION_EXCLUDE)) then {
		_res = [east, position _x, 250, true] call AVD_fnc_military_createOutpost;
        _cGroup = _res select 1;
        _cars = floor(random 2) + 3;
        [position _x, 2, 10000, false, true, false, 0, [_cars, 5], 0.1, _cGroup, ""] execVM "militarize.sqf";
    };
    

} foreach _villages; 


{ 
	
	if(((text _x) in AVD_LOCATION_EXCLUDE)) then {
		_res = [east, position _x, 250, true] call AVD_fnc_military_createOutpost;
        _cGroup = _res select 1;
		_cars = floor(random 2) + 3;
     	[position _x, 2, 10000, false, true, false, 0, [_cars, 5], 0.1, _cGroup, ""] execVM "militarize.sqf";
    };
} foreach _cities; 

{ 
	
} foreach _capitals; 

{ 
	
} foreach _locals;

AVD_COMPONENT_RED_INIT = true;
publicVariable "AVD_COMPONENT_RED_INIT";
}, [], AVD_D_CLIENT_EAST] call AVD_fnc_remote_execute;

waitUntil { !isNil "AVD_COMPONENT_RED_INIT" };
/*
[{
		[] spawn {
        private ["_index"];
        waitUntil { time > (5 * 60) };
			for[{_i = 0}, { _i < 100}, { _i = _i + 1 }] do {
            	_index = call AVD_fnc_getIndex;
				[[0, 0, 0], 2, 10000, true, false, false, [2, 2], 0, random 0.2, nil, nil, _index] execVM "militarize.sqf";
        		sleep 1;
    		};
		};
}, [], AVD_D_CLIENT_EAST] call AVD_fnc_remote_execute;*/
DLOG("Reds initialized.");