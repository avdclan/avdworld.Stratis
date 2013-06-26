#define SELF "x_avd\lib\db\load.sqf"
#include "include\avd.h"
#include "include\db.h"

if(!isServer) exitWith {
    DLOG("Loading is only for servers, exiting.");
};

private ["_object", "_dkey", "_ret", "_dtype", "_db"];

_object = PARAM(0, nil);
_dkey = PARAM(1, nil);
_dtype = PARAM(2, "STRING");
_db = PARAM(3, AVD_DB);
_ret = [];
_dkey = [_dkey, """", ""] call CBA_fnc_replace;
//DLOG("Trying to load " + str(_dkey) + " from " + str(_db) + " object: " + str(_object));
_ret = [_db, _object, _dkey, _dtype] call iniDB_read;  
//DLOG("Got " + str(_ret) + " for " + str(_key));
_ret;
    
