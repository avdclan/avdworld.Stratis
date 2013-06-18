#define SELF "x_avd\player\actions\debug.sqf"
#include "include\avd.h"

private ["_target", "_str", "_curHouse, _numPos", "_unit"];
_target = cursorTarget;
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

{
    DLOG("Having house: " + str(_x) + " type: " + str(typeof _x));
} foreach (nearestObjects [player, ["House"], 20])
