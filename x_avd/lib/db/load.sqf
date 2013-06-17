#define SELF "x_avd\lib\db\load.sqf"
#include "include\avd.h"

if(!isServer) exitWith {
    DLOG("Loading is only for servers, exiting.");
};

private ["_object", "_keys", "_ret"];
_object = _this select 0;
_keys = _this select 1;
_ret = [];
DLOG("Loading " + str(_object) + ", keys: " + str(_keys));
{
    _r = [DB, _object, _x] call iniDB_read;
    DLOG("Got " + str(_r) + " for " + str(_x));
	_ret = _ret + [_r];
} foreach _keys;
_ret;
