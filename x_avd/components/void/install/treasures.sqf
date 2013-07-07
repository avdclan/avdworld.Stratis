#define SELF "x_avd\components\void\install\treasures.sqf"
#include "include\avd.h"
#include "include\arrays.h"
#include "include\db.h"
DLOG("Installing Treasures");

AVDUMMY = (createGroup sideLogic) createUnit ["LOGIC", [0, 0, 0], [], 0, ""];

AVD_fnc_getRandomWaterPos = {
  private ["_min", "_max", "_minDepth", "_maxDepth", "_tmp"];
  _min = PARAM(0, 1000);
  _max = PARAM(1, 5000);
  _minDepth = PARAM(2, 30);
  _maxDepth = PARAM(3, 100);
  
  _minDepth = _minDepth * -1;
  _maxDepth = _maxDepth * -1;
  _posAsl = nil;
  
  waitUntil {
        
	  _tmp = [[0,0,0], 100000] call CBA_fnc_randPos;
	  
	  waitUntil {
	    _tmp = [[0,0,0], 100000] call CBA_fnc_randPos;
	    surfaceIsWater _tmp;  
	  };
	  AVDUMMY setPosATL _tmp;
	  _posAsl = getPosASL AVDUMMY; 
	  _depth = _posAsl select 2;
	  _depth <= _minDepth and _depth >= _maxDepth
  };
  _posAsl;
};

private ["_count", "_list"];

_count = 10;

_list = [];

for "_i" from 0 to _count-1 do {
  _id = call AVD_fnc_getIndex;
  _pos = [1000, 5000] call AVD_fnc_getRandomWaterPos;
  DLOG("Got rand pos: " + str(_pos));
  _tHolder = TREASURE_HOLDER createVehicle [_pos select 0, _pos select 1, 100];
  clearWeaponCargoGlobal _tHolder;
  clearMagazineCargoGlobal _tHolder;
  //_tHolder allowDamage false;
  _tHolder setPosASL _pos;
  _tholder addMagazineCargoGlobal ["ARP_Objects_blackbox_m", (floor(random 3) + 1)];
  // code to add the actual treasure
  _fstr = format["treasure-%1", _id];
  DB_WRITE(_fstr, "id",_id);
  DB_WRITE(_fstr, "holder", TREASURE_HOLDER);
  DB_WRITE(_fstr, "posASL", _pos);
  _weapons = [[],[]];
  _magazines = [["ARP_Objects_blackbox_m"], [(floor(random 3) + 1)]];
  DB_WRITE(_fstr, "weaponCargo", _weapons);
  DB_WRITE(_fstr, "magazineCargo", _magazines);
  _w = [SHIP_WRECKS] call CBA_fnc_shuffle;
  DB_WRITE(_fstr, "wreck", (_w select 0));
  _list = _list + [_id];
};
DB_WRITE("treasures", "index", _list);