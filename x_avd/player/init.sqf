waitUntil { !isNull player };
if(! local player) exitWith {};
if(! hasInterface) exitWith {};


#define SELF "x_avd\player\init.sqf"
#define PATH "x_avd\player"
#include "include\avd.h"
#include "include\params.h"
#include "player.h"


private ["_var"];
DLOG("varCheck");
_var = (player getVariable "avd_player_init");
if(! isNil "_var") exitWith { DLOG("EXIT!!"); };
player setVariable ["avd_player_init", true, true];
private "_varName";
_varName = format["player_%1", getPlayerUID player];
DLOG("Setting varname:" + str(_varName));
[player, _varName] call AVD_fnc_setVehicleVarName;

DLOG("Adding events");
player addMPEventHandler ["mpkilled", { _this call compile preprocessFileLineNumbers "x_avd\player\events\killed.sqf";}];
player addMPEventHandler ["mprespawn", { _this call compile preprocessFileLineNumbers "x_avd\player\events\respawn.sqf";}];

DLOG("Initializing player.");
SPWN("gear");

if(missionParam("d_cache_unit_enable") == 1) then {
  	DLOG("Enabling experimental unit caching.");
    [player] execFSM "x_avd\player\fsm\caching.fsm";  
};

//player addMPEventHandler["MPKilled", ]
DLOG("Adding actions.");
ccp("x_avd\player\actions\init.sqf");

ccp("x_avd\player\init_include.sqf");

DLOG("Setting view distance");
setViewDistance 1500;
endLoadingScreen;
