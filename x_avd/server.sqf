
#define SELF "x_avd\server.sqf"
#include "include\avd.h"
#include "include\component.h"
if(!isServer) exitWith {
    DLOG("Won't run on non-server.");
};
if(! isNil "AVD_WORLD_SERVER_INIT" and AVD_WORLD_SERVER_INIT) exitWith {
  DLOG("AvD World Server already initialized.");  
};
AVD_WORLD_SERVER_INIT = true;

DLOG("Initializing AvD World Server...");

DLOG("Initializing iniDB.");
call compile preProcessFile "\iniDB\init.sqf";


LOAD_COMPONENT("civilian");
LOAD_COMPONENT("red");


publicVariable "AVD_WORLD_SERVER_INIT";
DLOG("AvD World Server initialized.");