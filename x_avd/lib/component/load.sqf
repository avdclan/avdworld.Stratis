#define SELF "x_avd\lib\component\load.sqf"
#include "include\avd.h"

if(!isServer) exitWith {
    DLOG("Components can only be loaded on the server.");
};

private ["_component", "_ret"];
_component = _this select 0;

DLOG("Loading component " + _component);
_ret = call compileFinal preprocessFile format["x_avd\components\%1\init.sqf", _component];
DLOG("Component " + str(_component) + " loaded.");
if(isNil "_ret") then {
  _ret = [];  
};
_ret;