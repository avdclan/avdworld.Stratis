if(! local player) exitWith {};
if(! hasInterface) exitWith {};

#define SELF "x_avd\player\setup.sqf"
#include "include\avd.h"

DLOG("Setting up player.");

//player addMPEventHandler["MPKilled", ]

ccp("x_avd\player\actions\init.sqf");
setViewDistance 1500;