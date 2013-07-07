#define SELF "x_avd\components\void\load\treasures.sqf"
#define PATH "x_avd\components\void\load"
//#define NODEBUG
#include "include\avd.h"
#include "include\db.h"
#include "include\arrays.h"

private ["_treasures"];

_treasures = DB_LOAD_ARRAY("treasures", "index");
DLOG("Got treasures: " + str(_treasures));
AVD_TREASURES = [];
publicVariable "AVD_TREASURES";
{
    _f = format["treasure-%1", _x];
    _id = DB_LOAD(_f, "id");
    _holder = DB_LOAD(_f, "holder");
    _posASL = DB_LOAD_ARRAY(_f, "posASL");
    _weapons = DB_LOAD_ARRAY(_f, "weaponCargo");
    _magazines = DB_LOAD_ARRAY(_f, "magazineCargo");
    _wreck = DB_LOAD(_f, "wreck");
    
    DLOG("Loaded data for treasure " + str(_id) + ", type: " + str(_holder) + ", posASL: " + str(_posASL) + ", weapons: " + str(_weapons) + ", magazines: " + str(_magazines));
    _varName = format["treasure_%1", _id];
    
    DLOG("Creating wreck " + str(_wreck));
    _wreck = _wreck createVehicle [0, 0, 100];
    DLOG("Creating wreck " + str(_wreck));
    _wreck setPosATL _posASL;
    DLOG("Creating wreck " + str(_wreck));
    
    _vec = _holder createVehicle _posASL;
    //_vec allowDamage false;
    //clearWeaponCargoGlobal _vec;
   // clearMagazineCargoGlobal _vec;
    
	for "_i" from 0 to count(_weapons)-1 do {
     if(!(count(_weapons select 0) > 0)) exitWith {};
      _vec addWeaponCargoGlobal [(_weapons select 0) select _i,(_weapons select 1) select _i];  
    };
	if(!(count(_magazines select 0) > 0)) exitWith {};
	for "_i" from 0 to count(_magazines)-1 do {
      _vec addMagazineCargoGlobal [(_magazines select 0) select _i,(_magazines select 1) select _i];  
    };
        
    
    [_vec, _varName] call AVD_fnc_setVehicleVarName;
    AVD_TREASURES = AVD_TREASURES + [_vec];

    DLOG("Created " + str(_vec));
} foreach _treasures;
publicVariable "AVD_TREASURES";