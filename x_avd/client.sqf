#define SELF "x_avd\client.sqf"
#include "include\avd.h"
waitUntil { !isNull player };


DLOG("Loading client.");
//startLoadingScreen["Waiting for AVD Server to initialize... "];
DLOG("Waiting for AVD World Server to initialize...");
progressLoadingScreen 0.1;
/*
waitUntil { !isNil "AVD_VOID_LOADED" };
waitUntil { AVD_VOID_LOADED };
                                */
DLOG("Server is ready.");1

/*waitUntil { !isNil "AVD_SAFETY_HOUSE" };
player setPosASL (AVD_SAFETY_HOUSE buildingPos 2);
*/
//[str ("Welcome to AVD World " + AVD_META_VERSION) ,  str(date select 1) + "." + str(date select 2) + "." + str(date select 0), str("You're on " + worldName)] spawn BIS_fnc_infoText;
progressLoadingScreen 0.2;
call compileFinal preprocessFileLineNumbers "x_avd\player\setup.sqf";
