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
   _pos = _x buildingPos 1;
   _result = [_pos,[0,0,0]] call BIS_fnc_areEqual;
   if(_result) then {
     _pos = getPosATL _x;  
   };   
   _holder = "Box_NATO_Wps_F" createVehicle _pos;
   clearWeaponCargoGlobal _holder;
   clearMagazineCargoGlobal _holder;
   
   
   // add min 2, max 5 food items.
   _num = floor(random 3) + 2;
   _shfl = [FOOD_SPAWN] call CBA_fnc_shuffle;
   for[{_i = 0}, {_i < _num}, { _i = _i + 1 }] do {
      {
          _rand = random 1;
          _class = _x select 0;
          _p = _x select 1;
          if(_p < _rand) then {
            _holder addMagazineCargoGlobal [_class, 1];  
          };
      } foreach _shfl;
   };
   
   // add min 2, max 5 drink items.
   _num = floor(random 3) + 2;
   _shfl = [DRINK_SPAWN] call CBA_fnc_shuffle;
   for[{_i = 0}, {_i < _num}, { _i = _i + 1 }] do {
      {
          _rand = random 1;
          _class = _x select 0;
          _p = _x select 1;
          if(_p < _rand) then {
             DLOG("Adding " + str(_class) + " to holder " + str(_holder));
            _holder addMagazineCargoGlobal [_class, 1];  
          };
      } foreach _shfl;
   };
   
   
   // add min 2, max 5 drink items.
   _num = floor(random 3) + 2;
   _shfl = [NORMAL_SPAWN] call CBA_fnc_shuffle;
   for[{_i = 0}, {_i < _num}, { _i = _i + 1 }] do {
      {
          _rand = random 1;
          _class = _x select 0;
          _p = _x select 1;
          if(_p < _rand) then {
             DLOG("Adding " + str(_class) + " to holder " + str(_holder));
            _holder addWeaponCargoGlobal [_class, 1];  
          };
      } foreach _shfl;
   };
   
   player setPos _pos;
   [_x] call AVD_fnc_trackingMarker;
   sleep 60;
} foreach _houses;
DLOG("Algo took: " + str(time - _stime));
