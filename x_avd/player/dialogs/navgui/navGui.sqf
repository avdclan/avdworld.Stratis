#define SELF "x_avd\player\dialogs\navgui\navGui.sqf"
#include "include\avd.h"

private ["_unit", "_pos", "_dir", "_targetPos", "_vectorTo", "_vectorDir", "_dist"];
_unit = PARAM(0, nil);
_targetPos = PARAM(1, nil);
waitUntil {

	_pos = getPos _unit;
	_dir = getDir _unit;
	_vectorTo = [_unit, _targetPos] call BIS_fnc_dirTo;
	_vectorDir = _vectorTo; //_vectorTo + 360;
	_dist = _unit distance _targetPos;

	((uiNameSpace getVariable "navGui")displayCtrl 11020) ctrlSetText  format ["%1, %2, %3",(round (_pos select 0)), (round (_pos select 1)), (round (_pos select 2))];
	((uiNameSpace getVariable "navGui")displayCtrl 11021) ctrlSetText format ["%1",_dir];
	((uiNameSpace getVariable "navGui")displayCtrl 11022) ctrlSetText format ["%1",_vectorDir];
	((uiNameSpace getVariable "navGui")displayCtrl 11023) ctrlSetText format ["%1",_dist];
	navGuiOpen == 0;
};