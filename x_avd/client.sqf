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



call compile preprocessFileLineNumbers "x_avd\player\setup.sqf";

endLoadingScreen;
