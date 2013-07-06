if(!isServer) exitWith {};
#define SELF "x_avd\components\spawn\events.sqf"
//#define NODEBUG

#include "include\avd.h"
#include "include\arrays.h"

AVD_fnc_spawn_mkSpawn = {
  DLOG(_this);
  private ["_holder", "_num", "_items", "_shfl"];
  _holder = PARAM(0, nil);
  _num = PARAM(1, 2);
  _items = PARAM(2, {[]});
  _shfl = [_items] call CBA_fnc_shuffle;
  for "_n " from 1 to _num do {
      {
          _rand = random 1;
          _class = _x select 0;
          _p = _x select 1;
          if(_rand < _p) then {
            _wtype = [_class] call AVD_fnc_getWeaponType;
            switch(_wtype) do {
                case "magazine": { 
            		_holder addMagazineCargoGlobal [_class, 1];
                };
                case "weapon": {
                    _holder addWeaponCargoGlobal [_class, 1];
                };
                default {
                  	_holder addWeaponCargoGlobal [_class, 1];  
                };
            };  
          };
      } foreach _shfl;
   };     
};

["avd_cron", {
   private ["_args", "_queue", "_hash", "_pos", "_result", "_holder", "_num", "_shfl", "_ret", "_spos"];
   for "_i" from 0 to 10 do {
	   _queue = ["SPAWN_LOCATIONS"] call AVD_fnc_queue_next;
	   if(isNil "_queue") exitWith { DLOG("Queue empty."); };
       _ret = [_queue, "args"] call CBA_fnc_hashHasKey;
       if(!_ret) exitWith { DLOG("No args."); nil; };
	   _args = [_queue, "args"] call CBA_fnc_hashGet;
	   DLOG("_args: " + str(_args));
	   _elem = _args select 0;
	   _pos = _elem buildingPos 1;
	   _result = [_pos,[0,0,0]] call BIS_fnc_areEqual;
	   if(_result) then {
	     _pos = getPosATL _elem;  
	   };   
		//_elem enableSimulation false;
	    _holder = SPAWN_HOLDER createVehicle [0, 0, 100];
	    _holder allowDamage false;
	   	clearWeaponCargoGlobal _holder;
		clearMagazineCargoGlobal _holder;
	    //_holder disableCollisionWith _elem;
	    
	    //_elem disableCollisionWith _holder;
        _spos = [_pos select 0, _pos select 1, ((_pos select 2) + 2)];
	    _holder setPosATL _spos;

	   // add min 2, max 5 food items.
       _num = floor(random 3) + 2;        
       [_holder, _num, FOOD_SPAWN] call AVD_fnc_spawn_mkSpawn;

	   // add min 2, max 5 drink items.
	   _num = floor(random 3) + 2;
	   [_holder, _num, DRINK_SPAWN] call AVD_fnc_spawn_mkSpawn;

	   // add min 2, max 5 drink items.
	   _num = floor(random 3) + 2;
	   [_holder, _num, NORMAL_SPAWN] call AVD_fnc_spawn_mkSpawn;

       [_holder, 1, RARE_SPAWN] call AVD_fnc_spawn_mkSpawn;

       
	   
	   //player setPos _pos;
	   AVD_SPAWN_BOXES = AVD_SPAWN_BOXES + [_holder];
	   publicVariable "AVD_SPAWN_BOXES";
	   [_elem] call AVD_fnc_trackingMarker;
   };
   
}] call CBA_fnc_addEventHandler;