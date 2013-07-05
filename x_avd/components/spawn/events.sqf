#define SELF "x_avd\components\spawn\events.sqf"
//#define NODEBUG

#include "include\avd.h"
#include "include\arrays.h"



    if(true) exitWith {};
    
    
    
[] spawn {   
   private ["_args", "_queue", "_hash", "_pos", "_result", "_holder", "_num", "_shfl"];
   waitUntil { 
   _queue = ["SPAWN_LOCATIONS"] call AVD_fnc_queue_next;
   if(isNil "_queue") exitWith {};
   _args = [_queue, "args"] call CBA_fnc_hashGet;
   DLOG("_args: " + str(_args));
   _elem = _args select 0;
   _pos = _elem buildingPos 1;
   _result = [_pos,[0,0,0]] call BIS_fnc_areEqual;
   if(_result) then {
     _pos = getPosATL _elem;  
   };   
	//_elem enableSimulation false;
    _holder = SPAWN_HOLDER createVehicle _pos;
    _holder allowDamage false;
   	clearWeaponCargoGlobal _holder;
	clearMagazineCargoGlobal _holder;
    //_holder disableCollisionWith _elem;
    
    //_elem disableCollisionWith _holder;
    _holder setPosATL _pos;
    
   
   // add min 2, max 5 food items.
   _num = floor(random 3) + 2;
   _shfl = [FOOD_SPAWN] call CBA_fnc_shuffle;
   for[{_i = 0}, {_i < _num}, { _i = _i + 1 }] do {
      {
          _rand = random 1;
          _class = _x select 0;
          _p = _x select 1;
          if(_rand < _p) then {
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
          if(_rand < _p) then {
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
          if(_rand < _p) then {
             DLOG("Adding " + str(_class) + " to holder " + str(_holder));
            _holder addWeaponCargoGlobal [_class, 1];  
          };
      } foreach _shfl;
   };
   
   //player setPos _pos;
   AVD_SPAWN_BOXES = AVD_SPAWN_BOXES + [_holder];
   publicVariable "AVD_SPAWN_BOXES";
   [_elem] call AVD_fnc_trackingMarker;
   sleep 0.5;
   false;
   };
};