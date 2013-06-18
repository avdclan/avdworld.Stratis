#define SELF "x_avd\client.sqf"
#include "include\avd.h"
DLOG("Loading client.");
startLoadingScreen["Waiting for AVD Server to initialize... "];
DLOG("Waiting for AVD World Server to initialize...");
waitUntil {
  !isNil "AVD_WORLD_SERVER_INIT" and AVD_WORLD_SERVER_INIT  
};
progressLoadingScreen 0.1;
DLOG("Server is ready.");

[str ("Welcome to AVD World " + AVD_META_VERSION) ,  str(date select 1) + "." + str(date select 2) + "." + str(date select 0), str("You're on " + worldName)] spawn BIS_fnc_infoText;

call compile preprocessFileLineNumbers "x_avd\player\setup.sqf";

endLoadingScreen;
