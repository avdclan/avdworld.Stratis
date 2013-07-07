#include "include\avd.h"
private ["_unit", "_foodVar", "_drinkVar", "_side"];

_unit = _this select 0;

waitUntil {

_side = side _unit;
_drinkVar = [_unit, "avd_fds_drinkVal"] call AVD_fnc_db_getPersistentVar;
_foodVar = [_unit, "avd_fds_foodVal"] call AVD_fnc_db_getPersistentVar;

	switch(_side) do {
			case West: {
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetText "B";
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetTextColor [0, 0, 1, 1];
			};
			case East: {
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetText "R";
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetTextColor [1, 0, 0, 1];
			};
			case Resistance: {
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetText "G";
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetTextColor [0, 1, 0, 1];
			};
			case Civilian: {
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetText "C";
				((uiNameSpace getVariable "infoBar")displayCtrl 10033) ctrlSetTextColor [1, 1, 1, 1];
			};
	};

((uiNameSpace getVariable "infoBar")displayCtrl 10031) ctrlSetText  format ["%1", floor(_foodVar)];
((uiNameSpace getVariable "infoBar")displayCtrl 10032) ctrlSetText format ["%1", floor(_drinkVar)];
infoBarOpen == 0;
};