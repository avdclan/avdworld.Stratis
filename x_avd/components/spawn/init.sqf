#define SELF "x_avd\components\spawn\init.sqf"
#include "include\avd.h"
#include "include\arrays.h"
if(!isServer) exitWith {};
private ["_houses"];
DLOG("Loading spawn...");
_houses = [];
// collecting houses.
_cfgVehicles = configFile >> "cfgVehicles";
_foo = [];
_stime = time;
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
        
       if(random 1 < 0.5) then {
       //[_x, format["%1 (%2 / %3 / %4)", typeOf _x, _doors, count(_positions), count(_exits)], 0] call AVD_fnc_trackingMarker;
        _houses = _houses + [_x];
       };
       _o = _o + 1;
    } foreach _objs;
   
} foreach _foo;
_p = (100 / _o) * count(_houses);
DLOG("Got " + str(count(_houses)) + "/" + str(_o) + " (" + str(_p) + "%) houses to place spawn in.");
{
   
} foreach _houses;
DLOG("Algo took: " + str(time - _stime));
