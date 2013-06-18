if(!isServer) exitWith {};
#define SELF "x_avd\components\civilian\init.sqf"
#include "include\avd.h"

DLOG("Loading civilians... ");
ccpf("x_avd\components\civilian\events.sqf");
private ["_villages",
		"_cities",
        "_capitals",
        "_locals"];
        
_villages = nearestLocations [[0,0,0], ["NameVillage"], 100000]; 
_cities = nearestLocations [[0,0,0], ["NameCity"], 100000];
_capitals = nearestLocations [[0,0,0], ["NameCityCapital"], 100000];
_locals = nearestLocations [[0,0,0], ["NameLocal"], 100000];

/*
{ 
	//_side = [_SIDES] call CBA_fnc_shuffle;
	[_x, [150, 150], [5, 10], false, civilian] call AVD_fnc_createTriggerLocation;
} foreach _villages; 
*/

{ 
	if(text _x in AVD_LOCATION_EXCLUDE) exitWith { DLOG("Excluding location " + str(text _x)); };
	//_side = [_SIDES] call CBA_fnc_shuffle;
    DLOG("Creating Trigger Location for cities: " + str(_x));
	[_x, [250, 250], [5, 10], false, civilian] call AVD_fnc_createTriggerLocation;
} foreach _cities; 

{ 
	//_side = [_SIDES] call CBA_fnc_shuffle;
    DLOG("Creating Trigger Location for capitals: " + str(_x));
	[_x, [500, 500], [5, 10], false, civilian] call AVD_fnc_createTriggerLocation;
} foreach _capitals; 
/*
{ 
	//_side = [_SIDES] call CBA_fnc_shuffle;
    DLOG("Creating Trigger Location for village: " + str(_x));
	[_x, [100, 100], [5, 10], false, civilian] call AVD_fnc_createTriggerLocation;
} foreach _locals;
*/
DLOG("Civilians initialized.");