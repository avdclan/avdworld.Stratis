
#define SELF "x_avd\server.sqf"

#include "include\avd.h"
#include "include\component.h"
if(!isServer) exitWith {
    DLOG("Won't run on non-server.");
};
if(! isNil "AVD_WORLD_SERVER_INIT" and AVD_WORLD_SERVER_INIT) exitWith {
  DLOG("AvD World Server already initialized.");  
};
waitUntil { !isNil "AVD_lib_init" };
AVD_WORLD_SERVER_INIT = true;
COMP("server\events");
DLOG("Initializing AvD World Server...");

DLOG("Initializing iniDB.");
call compile preProcessFile "\iniDB\init.sqf";


//tmp
call compile preprocessFile "scripts\pythosBase.sqf";
call compile preprocessFile "scripts\airfieldBase.sqf";

//tmp

//LOAD_COMPONENT("spawn");

LOAD_COMPONENT("civilian");
LOAD_COMPONENT("red");
execVM "x_avd\components\spawn\init.sqf";

publicVariable "AVD_WORLD_SERVER_INIT";
DLOG("AvD World Server initialized.");