if(! local player) exitWith {};
if(! hasInterface) exitWith {};
//waitUntil { ! player };

#define SELF "x_avd\player\init.sqf"
#include "include\avd.h"
private ["_var"];
DLOG("varCheck");
_var = (player getVariable "avd_player_init");
if(! isNil "_var") exitWith { DLOG("EXIT!!"); };
player setVariable ["avd_player_init", true, true];

DLOG("Initializing player.");

DLOG("Adding events");
player addMPEventHandler ["mpkilled", { _this call compile preprocessFile "x_avd\player\events\killed.sqf";}];
player addMPEventHandler ["mprespawn", { _this call compile preprocessFile "x_avd\player\events\respawn.sqf";}];

//player addMPEventHandler["MPKilled", ]
DLOG("Adding actions.");
ccp("x_avd\player\actions\init.sqf");

ccp("x_avd\player\init_include.sqf");

DLOG("Setting view distance");
setViewDistance 1500;
