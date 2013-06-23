#define SELF "x_avd\lib\db\load.sqf"
#include "include\avd.h"
#include "include\db.h"

if(!isServer) exitWith {
    DLOG("Loading is only for servers, exiting.");
};

private ["_object", "_keys", "_ret"];
_object = PARAM(0, nil);
_keys = PARAM(1, { [] });
_ret = [];
//DLOG("Loading " + str(_object) + ", keys: " + str(_keys));
{
    _key = [_x, """", ""] call CBA_fnc_replace;
    _r = [AVD_DB, _object, _key] call iniDB_read;
    DLOG("Got " + str(_r) + " for " + str(_key));
	_ret = _ret + [_r];
} foreach _keys;
_ret;
