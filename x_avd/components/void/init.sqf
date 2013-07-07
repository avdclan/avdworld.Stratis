if(!isServer) exitWith {};

AVD_VOID_LOADED = false;
#define SELF "x_avd\components\void\init.sqf"
#define PATH "x_avd\components\void"

#include "include\avd.h"
waitUntil { time > 2 };
DLOG("Initializing V.O.I.D.");

// check if void was already initialized in the past
private "_ret";
//AVD_DB call iniDB_delete;
_ret = AVD_DB call iniDB_exists;
//_ret = false;
if(! _ret) then {
    COMPF("install");
};

DLOG("Loading data...");
COMPF("load\world");


AVD_VOID_LOADED = true;
publicVariable "AVD_VOID_LOADED";
true;