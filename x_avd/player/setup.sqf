waitUntil { !isNull player };
if(! local player) exitWith {};
if(! hasInterface) exitWith {};


//waitUntil { ! player };
progressLoadingScreen 0.3;

#define SELF "x_avd\player\setup.sqf"
#define PATH "x_avd\player"
#include "include\avd.h"
private ["_var"];
DLOG("Waiting for lib...");
waitUntil { !isNil "AVD_lib_init" };
waitUntil { AVD_lib_init };

DLOG("varCheck");
_var = (player getVariable "avd_setup");
if(! isNil "_var") exitWith { DLOG("EXIT!!"); };
player setVariable ["avd_setup", true, true];
if(vehicleVarName player == "") then {
     _varName = format["player_%1", getPlayerUID player];
    [player, _varName] call AVD_fnc_setVehicleVarName;
};

DLOG("Loading data for player...");

[player] call AVD_fnc_db_loadPlayer;

DLOG("Waiting for player data.");
waitUntil { !isNil "AVD_PLAYER_LOADED" };
DLOG("Got player data");

progressLoadingScreen 0.4;
DLOG("Setting up player.");

call AVD_fnc_player_init;
progressLoadingScreen 0.5;

progressLoadingScreen 1;
endLoadingScreen;
sleep 0.5;
cutText["Welcome " + str(name player), "PLAIN DOWN"];
[format["AVD World %1",worldName], "by Rush & Ahab", AVD_META_VERSION] spawn BIS_fnc_infoText;

