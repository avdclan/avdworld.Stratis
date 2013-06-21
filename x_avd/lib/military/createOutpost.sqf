#define SELF "x_avd\lib\military\createOutpost.sqf"
//#define NODEBUG
#include "include\avd.h"
#include "include\arrays.h"
private ["_side", "_position", "_radius", "_marker", "_trigger", "_enemies", "_cargoHouses", "_towers", "_houses", "_hqs", "_numPat", "_airportTowers", "_logic", "_varName", "_flag", "_captureAble"];
_side = _this select 0;
_position = _this select 1;
_radius = _this select 2;
_captureAble = if(count(_this) > 3) then { _this select 3; } else { false; };
_numSide = if(_side == west) then { 1; } else { 2; };

_logic = (createGroup sideLogic) createUnit["LOGIC", _position, [], 0, ""];
_flag = FLAG_EAST createVehicle getPosATL _logic;
_flag attachTo [_logic, [0, 0, 0]];
_logic enableSimulation false;
_logic setVariable["avd_outpost_side", _side, true];
_logic setVariable["avd_outpost_radius", _radius, true];
_varName = call AVD_fnc_getValidVarName;
[_logic, _varName] call AVD_fnc_setVehicleVarName;
_numPatrol = random ((_radius / 50) / 2); 
// find all cargo hosues.
//DLOG("Finding all cargo places...");
_houses = nearestObjects [_position, ["House"], _radius];
_cargoHouses = [];
_towers = [];
_hqs = [];
_airportTowers = [];

DLOG("Got all houses: " + str(_houses));
{
    if(x_isCargoHouse(_x)) then {
        DLOG("Having cargo house: " + str(_x) + "(" + str(typeOf _x) + ")");
        _cargoHouses = _cargoHouses + [_x];
    };
    if(x_isTower(_x)) then {
        DLOG("Having tower: " + str(_x) + "(" + str(typeOf _x) + ")");
        _towers = _towers + [_x];
    };
    if(x_isHQHouse(_x)) then {
        DLOG("Having HQ house: " + str(_x) + "(" + str(typeOf _x) + ")");
        _hqs = _hqs + [_x];
    };
    
    if(typeOf _x in AIRPORT_TOWERS) then {
        DLOG("Having Airport Tower: " + str(_x) + "(" + str(typeOf _x) + ")");
        _airportTowers = _airportTowers + [_x];
    };
} foreach _houses;

// fill hq
{
    _index = call AVD_fnc_getIndex;
    [_x, _numSide, false, 2, random 50, 1, random 0.5, nil, nil, _index] execVM "fillHouse.sqf";
    _index = call AVD_fnc_getIndex;
    [_x, _numSide, true, 1, random 25, 1, random 0.5, nil, nil, _index] execVM "fillHouse.sqf";
} foreach _hqs;

// fill towers
{
    _index = call AVD_fnc_getIndex;
    [_x, _numSide, false, 2, random 25, 1, random 0.5, nil, nil, _index] execVM "fillHouse.sqf";
} foreach _towers;
{
    _index = call AVD_fnc_getIndex;
    [_x, _numSide, false, 2, random 100 + 50, 1, random 0.5, nil, nil, _index] execVM "fillHouse.sqf";
} foreach _airportTowers;

DLOG("Spawning " + str(_numPatrol) + " patrol groups.");
for[{ _i = 0; }, { _i <= _numPatrol }, { _i = _i + 1; }] do {
    _index = call AVD_fnc_getIndex;
	[_position, _numSide, (_radius * 1.5), true, false, false, [2, 2], 0, random 0.5, nil, nil, _index] execVM "militarize.sqf";
};

if(_captureAble) then {
    sleep 5;
    _trigger = createTrigger["EmptyDetector", _position];
    _varName = call AVD_fnc_getValidVarName;
    [_trigger, _varName] call AVD_fnc_setVehicleVarName;
    _trigger setTriggerArea[_radius, _radius, 0, false];
    _trigger setTriggerActivation[str(_side), "NOT PRESENT", false];
    _trigger setTriggerStatements["this", "[""avd_outpost_cleared"", [" + vehicleVarName _logic + ", " + str(_this) + "]] call CBA_fnc_localEvent; deleteVehicle thisTrigger;", ""];
};
_logic;