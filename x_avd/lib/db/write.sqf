#define SELF "x_avd\lib\db\write.sqf"
#define NODEBUG
#include "include\avd.h"

if(!isServer) exitWith {
    DLOG("Saving is only for servers, exiting.");
};

private ["_wobject", "_wkey", "_wvalue"];
_wobject = _this select 0;
_wkey = str(_this select 1);
_wvalue = _this select 2;
_wdb = PARAM(3, AVD_DB);
_wkey = [_wkey, """", ""] call CBA_fnc_replace;
switch(typeName _wvalue) do {
  case "STRING": {
	  if(_wvalue == "") then {
	    _wvalue = "nil";  
	  };  
  };
};
DLOG("Saving " + str(_wobject) + ": " + _wkey + " => " + str(_wvalue));
if([_wdb, _wobject, _wkey, _wvalue] call iniDB_write) then {
    //DLOG("Object saved, adding to index.");
    true
} else {
    //DLOG("Could not save object");
    false
};
false