waitUntil { !isNull player };
if(! local player) exitWith {};
if(! hasInterface) exitWith {};
//waitUntil { ! player };

#define SELF "x_avd\player\setup.sqf"
#include "include\avd.h"
private ["_var"];
DLOG("varCheck");
_var = (player getVariable "avd_setup");
if(! isNil "_var") exitWith { DLOG("EXIT!!"); };
player setVariable ["avd_setup", true, true];

DLOG("Setting up player.");

call AVD_fnc_player_init;

cutText["Welcome " + str(name player), "PLAIN DOWN"];
[format["AVD World %1",worldName], "by Rush & Ahab", AVD_META_VERSION] spawn BIS_fnc_infoText;