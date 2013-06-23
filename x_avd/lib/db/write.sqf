#define SELF "x_avd\lib\db\write.sqf"
#include "include\avd.h"

if(!isServer) exitWith {
    DLOG("Saving is only for servers, exiting.");
};

private ["_wobject", "_wkey", "_wvalue"];
_wobject = _this select 0;
_wkey = str(_this select 1);
_wvalue = _this select 2;
_wkey = [_wkey, """", ""] call CBA_fnc_replace;


DLOG("Saving " + str(_wobject) + ": " + _wkey + " => " + str(_wvalue));
if([DB, _wobject, _wkey, _wvalue] call iniDB_write) then {
    DLOG("Object saved, adding to index.");
    true
} else {
    DLOG("Could not save object");
    false
};
false