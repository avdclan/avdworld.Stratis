#define SELF "x_avd\player\actions\debug.sqf"
#include "include\avd.h"
#include "include\arrays.h"
/*{
    if(side _x == east) then {
      deleteVehicle _x;  
    };
} foreach allUnits;
*/
private ["_target", "_str", "_curHouse, _numPos", "_unit"];
_target = cursorTarget;
_target setFuelCargo 0.5;
if(isNull _target) then { _target = player; };
_curHouse = nearestBuilding player;	
_numPos = 0;
for[{_i = 0},{_i < 50},{_i = _i + 1}] do {
	_pos1 = _curHouse buildingPos _i;
	_result1 = [_pos1,[0,0,0]] call BIS_fnc_areEqual;  // result = true
    if(!_result1) then {
      _numPos = _numPos + 1;  
    };
};

_str = format["Object info for %1:\nClass: %2\nAnimation %3\nAlive: %4\nPos: %5\nDamage: %6\nFuel: %7\nLocked: %8\nSide: %9\nFaction: %10\n----\nNearest Building: %11\nBuilding class: %12\nPositions in Building: %13\n-----\nOwner: %14 (player: %15)", _target, typeOf _target, animationState _target, alive _target, getPosASL _target, damage _target, fuel _target, locked _target, side _target, faction _target, _curHouse, typeOf _curHouse, _numPos, owner _target, owner player];
cutText[_str, "PLAIN", 3];
DLOG(_str);




_ci = [_target] call AVD_fnc_im_canIdentify;
DLOG("Identify: " + str(_ci));

if(!_ci) then {
_target addMagazine ITEM_PASSPORT;
_ci = [_target] call AVD_fnc_im_canIdentify;
DLOG("Identify: " + str(_ci));
};

if(_ci) then {
    _name = name _target;
    _natio = side _target;
    _company = faction _target;
    _age = _target getVariable "avd_identity_age";
  DLOG("Name: " + str(_name));
  DLOG("Age: " + str(_age));
  DLOG("Nationality: " + str(_natio));
  DLOG("Company: " + str(_company));
  
  
};


/*
{
    DLOG("Having house: " + str(_x) + " type: " + str(typeof _x));
} foreach (nearestObjects [player, ["House"], 20]);

DLOG("Sides: " + str(resistance));
*/	
/*
[] spawn {
_pos = getPos player;
_foo = [_pos select 0, 1000, 50];
deleteVehicle HOUSE;
HOUSE = "Land_MilOffices_V1_F" createVehicle _foo;
HOUSE setPosASL _foo;
                       

sleep 5;
_i = 2;
{
 _b = HOUSE buildingPos _i;
_x setPosASL _b;
_i = _i + 1;
sleep 1;
} foreach playableUnits;
};
*/