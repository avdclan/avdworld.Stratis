#define SELF "x_avd\player\dialogs\uniforms\changeUniform.sqf"
#include "include\avd.h"
private ["_data", "_index", "_current", "_side"];
_index = lbCurSel 1500;
_data = lbData [1500, _index];
_current = uniform player;
DLOG("Current: " + str(_current) + ", data: " + str(_data));


player removeWeapon _data;
player addUniform _data;
if(_current != "") then {
  player addWeaponCargoGlobal [_data, 1];  
};


_side = [_data] call AVD_fnc_getSideByClass;

DLOG("Got side: " + str(_side));

[player] joinSilent grpNull;
[player] joinSilent (createGroup _side);
closeDialog 0;