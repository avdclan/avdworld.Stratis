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
		[east, position _x, 250, true] spawn AVD_fnc_military_createOutpost;
    };
    

} foreach _villages; 


{ 
	
	if(((text _x) in AVD_LOCATION_EXCLUDE)) then {
		[east, position _x, 250, true] spawn AVD_fnc_military_createOutpost;
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

DLOG("Reds initialized.");