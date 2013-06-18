#define SELF "x_avd\player\actions\debug1.sqf"
#include "include\avd.h"
_outpost = [east, getPos player, 500, true] call compile preprocessFile "x_avd\lib\military\createOutpost.sqf";
DLOG("Having outpost: " + str(_outpost));
_objs =  nearestObjects [getPos player, [], 500];
/*
{
    if(typeOf _x != "") then {
		DLOG("Having object " + str(_x) + " type: " + str(typeOf _x));
    };
} forEach _objs;
*/