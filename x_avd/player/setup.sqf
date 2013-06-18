if(! local player) exitWith {};
if(! hasInterface) exitWith {};

#define SELF "x_avd\player\setup.sqf"
#include "include\avd.h"
private "_var";
_var = (player getVariable "avd_setup");
if(! isNil "_var") exitWith {};
player setVariable ["avd_setup", true, true];

DLOG("Setting up player.");


//player addMPEventHandler["MPKilled", ]
DLOG("Adding actions.");
ccp("x_avd\player\actions\init.sqf");

DLOG("Setting view distance");
setViewDistance 1500;
cutText["Welcome " + str(name player), "PLAIN DOWN"];
[format["AVD World %1",worldName], "by Rush & Ahab", AVD_META_VERSION] spawn BIS_fnc_infoText;