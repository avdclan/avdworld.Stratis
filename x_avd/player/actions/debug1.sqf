#define SELF "x_avd\player\actions\debug1.sqf"
#include "include\avd.h"
[east, getPos player, 500] execVM "x_avd\lib\military\createOutpost.sqf";

_objs =  nearestObjects [getPos player, [], 500];

{
    if(typeOf _x != "") then {
		DLOG("Having object " + str(_x) + " type: " + str(typeOf _x));
    };
} forEach _objs;