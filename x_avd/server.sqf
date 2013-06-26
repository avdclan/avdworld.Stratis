#define SELF "x_avd\server.sqf"
#include "include\avd.h"
#include "include\component.h"
if(!isServer) exitWith {
    DLOG("Won't run on non-server.");
};
if(! isNil "AVD_WORLD_SERVER_INIT") exitWith {
  DLOG("AvD World Server already initialized.");  
};
AVD_WORLD_SERVER_INIT = true;
AVD_WORLD_SERVER_LOADED = false;
publicVariable "AVD_WORLD_SERVER_LOADED";
publicVariable "AVD_WORLD_SERVER_INIT";

COMPF("server\events");
DLOG("Initializing AvD World Server...");

LOAD_COMPONENT("void");


//tmp
call compile preprocessFileLineNumbers "scripts\safetyHouse.sqf";
call compile preprocessFileLineNumbers "scripts\pythosBase.sqf";
call compile preprocessFileLineNumbers "scripts\airfieldBase.sqf";

//tmp

//LOAD_COMPONENT("spawn");


/*
LOAD_COMPONENT("civilian");

LOAD_COMPONENT("red");

LOAD_COMPONENT("spawn");
*/


AVD_WORLD_SERVER_LOADED = true;
publicVariable "AVD_WORLD_SERVER_INIT";
publicVariable "AVD_WORLD_SERVER_LOADED";
DLOG("AvD World Server initialized.");