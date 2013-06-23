#define SELF "x_avd\components\spawn\init.sqf"
#include "include\avd.h"
#include "include\arrays.h"
#include "include\params.h"
if(!isServer) exitWith {};
if(isNil "AVD_SPAWN_BOXES") then {
	AVD_SPAWN_BOXES = []; 
	publicVariable "AVD_SPAWN_BOXES";
          
};
private ["_houses", "_rate"];
DLOG("Loading spawn...");
_houses = [];
// collecting houses.
_cfgVehicles = configFile >> "cfgVehicles";
_foo = [];
_stime = time;
_rate = missionParam("d_spawn_house_rate");
DLOG("Spawn rate: " + str(_rate));
if(_rate == -1) then {
  _rate = random 1;  
};
DLOG("Spawn rate: " + str(_rate));
DLOG("DELETING OLD SPAWN");
{
  deleteVehicle _x; 
  AVD_SPAWN_BOXES = AVD_SPAWN_BOXES - [_x];
} foreach AVD_SPAWN_BOXES;

DLOG("Starting algo at " + str(time));
for "_i" from 0 to (count _cfgVehicles)-1 do {
    _vec = _cfgVehicles select _i;
     if(isClass _vec) then {
    _cName = configName(_vec);
   
	    _val = getNumber(_cfgVehicles >> _cName >> "numberOfDoors");
	    if(!isNil "_val" and _val >= 1) then {
	      _foo = _foo + [[_cName, _val]];  
	    };    
    };
};
_houses = [];
_o = 0;
{
    _class = _x select 0;
    _doors = _x select 1;
    _objs = nearestObjects [[0, 0, 0], [_class], 100000];
    
    {
        
       if(random 1 < _rate) then {
       //[_x, format["%1 (%2 / %3 / %4)", typeOf _x, _doors, count(_positions), count(_exits)], 0] call AVD_fnc_trackingMarker;
        _houses = _houses + [_x];
       };
       _o = _o + 1;
    } foreach _objs;
   
} foreach _foo;
_p = (100 / _o) * count(_houses);
DLOG("Got " + str(count(_houses)) + "/" + str(_o) + " (" + str(_p) + "%) houses to place spawn in.");
_houses = [_houses] call CBA_fnc_shuffle;
{
	_id = call AVD_fnc_getIndex;
	["SPAWN_LOCATIONS", _id, [_x]] call AVD_fnc_queue_add;
	sleep 0.01;
} foreach _houses;
DLOG("Algo took: " + str(time - _stime));
