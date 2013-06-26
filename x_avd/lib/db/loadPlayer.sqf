#define SELF "x_avd\lib\db\loadPlayer.sqf"
#include "include\avd.h"
#include "include\db.h"

if(!isServer) exitWith {
  DLOG("Retrieving data from server.");
  [{
      if(!isServer) exitWith {};
      DLOG("Remote loadPlayer call from: " + str(_this));
      _this call AVD_fnc_db_loadPlayer;
  }, _this] call AVD_fnc_remote_execute;  
};

private ["_player", "_db", "_ret"];
_player = PARAM(0, nil);

if(isNil "_player") exitWith { DLOG("Won't load nil player."); };

_db = format["avdworld\player_%1", getPlayerUID _player];
_ret = _db call inidb_exists;
if(! _ret) then {
    // create player
    DLOG("Player does not exist, creating.");
    [_player] call compile preprocessFileLineNumbers "x_avd\player\gear.sqf";
    
   
} else {
    removeAllWeapons _player;
	removeAllItems _player;
	removeBackpack _player;
	removeGoggles _player;
	removeHeadgear _player;
	removeUniform _player; 
	removeVest _player;
    
	 private ["_uid", "_name", "_world", "_alive", "_damage", "_dir", "_posATL", "_posASL", "_weapons", "_primaryWeapon", "_magazines", "_items", "_headgear", "_vest", "_uniform", "_backpack", "_backpackItems", "_onWater", "_animation", "_pvars"];
     _uid = DB_LOAD_FROM(_db, "player", "uid");
     _name = DB_LOAD_FROM(_db, "player", "name");
     _world = DB_LOAD_FROM(_db, "player", "world");
     _alive = DB_LOAD_FROM(_db, "player", "alive");
     _alive = call compile _alive;
     _damage = DB_LOAD_NUMBER_FROM(_db, "player", "damage");
     _dir = DB_LOAD_NUMBER_FROM(_db, "player", "dir");
     _posATL = DB_LOAD_ARRAY_FROM(_db, "player", "posATL");
     _posASL = DB_LOAD_ARRAY_FROM(_db, "player", "posASL");
	 _weapons = DB_LOAD_ARRAY_FROM(_db, "player", "weapons");
     _weapons = UNPACK(_weapons);
     _primaryWeapon = DB_LOAD_FROM(_db, "player", "primaryWeapon");
     if(!isNil "_primaryWeapon") then {
       _weapons = _weapons - [_primaryWeapon];  
     };
     _primaryWeaponMagazines = DB_LOAD_ARRAY_FROM(_db, "player", "primaryWeaponMagazines");
     _primaryWeaponMagazines = UNPACK(_primaryWeaponMagazines);
     _primaryWeaponItems = DB_LOAD_ARRAY_FROM(_db, "player", "primaryWeaponItems");
     _primaryWeaponItems = UNPACK(_primaryWeaponItems);
     _magazines = DB_LOAD_ARRAY_FROM(_db, "player", "magazines");
     _magazines = UNPACK(_magazines);
     _items = DB_LOAD_ARRAY_FROM(_db, "player", "items");
     _items = UNPACK(_items);
     _headgear = DB_LOAD_FROM(_db, "player", "headgear");
     _vest = DB_LOAD_FROM(_db, "player", "vest");
     _uniform = DB_LOAD_FROM(_db, "player", "uniform");
     _backpack = DB_LOAD_FROM(_db, "player", "backpack");
     _backpackItems = DB_LOAD_ARRAY_FROM(_db, "player", "backpackItems");
     _backpackItems = UNPACK(_backpackItems);
     _backpackMagazines = [];
     _backpackWeapons = [];
     if(count(_backpackItems) > 0) then {
       for "_m" to count(_magazines)-1 do {
         _elem = _magazines select _m;
         if(_elem in _backpackItems) then {
           _magazines set [_m, objNull];
           _backpackMagazines = _backpackMagazines + [_elem];  
           _backpackItems = _backpackItems - [_elem];
         };  
       };  
       _tmp = [];
       {
           if(typeName _x == "STRING") then {
             _tmp = _tmp + [_x];  
           };
       } foreach _magazines;
       _magazines = _tmp;
       
       for "_w" to count(_weapons)-1 do {
         _elem = _weapons select _w;
         if(_elem in _backpackItems) then {
           _weapons set [_w, nil];
           _backpackWeapons = _backpackWeapons + [_elem];
           _backpackItems = _backpackItems - [_elem];  
         };  
       };  
       _tmp = [];
       {
           if(typeName _x == "STRING") then {
             _tmp = _tmp + [_x];  
           };
       } foreach _weapons;
       _weapons = _tmp;  
     };
     
     _onWater = DB_LOAD_FROM(_db, "player", "onWater");
     _onWater = call compile _onWater;
     _animation = DB_LOAD_FROM(_db, "player", "animation");
     _pvars = DB_LOAD_FROM(_db, "player", "persistentVars");
     _pvars = [_pvars, "any", "nil"] call CBA_fnc_replace;
     
     DLOG("Restoring player " + str(_player) + ", dir " + str(_dir) + ", vest: " + str(_vest) + " and so on..");
     
     if(_world != worldName) then {
       DLOG("");
       DLOG("");
       DLOG("WORLD HAS CHANGED, UNSURE ABOUT CERTAIN THINGS. PLEASE IMPLEMENT!");
       DLOG("");
       DLOG("");  
     };

	 if(!_alive) then {
       // bad.  
     };     
     
     _player setDir _dir;
     sleep 0.05;
     DLOG("Restoring damage: " + str(_damage));
     _player setDamage _damage;
     if(!isNil "_vest") then {
     	DLOG("Restoring vest: " + str(_vest));
        _player addVest _vest;
        sleep 0.05;
     };
     
	 if(!isNil "_headgear") then {
     	DLOG("Restoring headgear: " + str(_headgear));
     	_player addHeadgear _headgear;
        sleep 0.05;
     };
     
     if(!isNil "_uniform") then {
         DLOG("Restoring uniform " + str(_uniform));
     	_player addUniform _uniform;
        sleep 0.05;
     };
     
     if(!isNil "_backpack") then {
         DLOG("Restoring backpack " + str(_backpack));
     	_player addBackpack _backpack;
        sleep 0.05;
     };
     
     if(_onWater) then {
         DLOG("Restoring posASL " + str(_posASL));
         _player setPosASL _posASL;
         sleep 0.05;
     } else {
         DLOG("Restoring posATL " + str(_posATL));
       	_player setPosATL _posATL;
        sleep 0.05;  
     };
     if(!isNil "_primaryWeapon") then {
         DLOG("Restoring primaryWeapon " + str(_primaryWeapon));
       _player addWeapon _primaryWeapon;
       sleep 0.05;  
     };
     if(count(_primaryWeaponItems) > 0) then {
       {
           DLOG("Restoring primaryWeaponItem " + str(_x));
           if(_x != "") then {
       			_player addPrimaryWeaponItem _x;
       	   };
       sleep 0.05;
       } foreach _primaryWeaponItems;  
     };
     if(count(_weapons) > 0) then {
       {
           DLOG("Restoring weapon " + str(_x));
           _player addWeapon _x;
           sleep 0.05;
       } foreach _weapons;
     };
          if(count(_primaryWeaponMagazines) > 0) then {
       {
           DLOG("Restoring primaryWeaponMagazine " + str(_x));
       _player addMagazine _x;
       sleep 0.05;
       } foreach _primaryWeaponMagazines;  
     };
     /*
      * makes the game crash because primaryWeaponMagazine is an array.
      * 
      * if(!isNil "_primaryWeaponMagazine") then {
       _player addMagazine _primaryWeaponMagazine;
       sleep 0.05;  
     };*/
         
     if(count(_magazines) > 0) then {
       {
           DLOG("Restoring magazine " + str(_x));
           _player addMagazine _x;
           sleep 0.05;
       } foreach _magazines;
     };
     if(count(_items) > 0) then {
       {
           DLOG("Restoring item " + str(_x));
           _player addItem _x;
           sleep 0.05;
       } foreach _magazines;
     };
     
     if(!isNil "_primaryWeapon") then {
         
     };

     {
         DLOG("Restoring backpack magazine " + str(_x));
         (unitBackpack player) addMagazineCargoGlobal [_x, 1];
         sleep 0.05;
     } foreach _backpackMagazines;
     {
         DLOG("Restoring backpack weapon " + str(_x));
         (unitBackpack player) addWeaponCargoGlobal [_x, 1];
         sleep 0.05;
     } foreach _backpackWeapons;
     
     if(!isNil "_animation") then {
         DLOG("Restoring animation" + str(_animation));
       _player playMoveNow _animation;  
     };
     
     
};


_player setVariable ["avd_player_loaded", true, true];
[{
    AVD_PLAYER_LOADED = true;
},[], _player] call AVD_fnc_remote_execute;

