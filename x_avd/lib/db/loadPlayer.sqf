#define SELF "x_avd\lib\db\loadPlayer.sqf"
#include "include\avd.h"
#include "include\db.h"
DLOG("With " + str(_this));
if(!isServer) exitWith {
  DLOG("Retrieving data from server.");
  [{
      if(!isServer) exitWith {};
      DLOG("Remote loadPlayer call from: " + str(_this));
      _this spawn AVD_fnc_db_loadPlayer;
      DLOG("Sent.");
  }, _this] call AVD_fnc_remote_execute;  
};

private ["_player", "_db", "_ret"];
_player = PARAM(0, nil);

if(isNil "_player") exitWith { DLOG("Won't load nil player."); };

_db = format["avdworld\player_%1", getPlayerUID _player];
_ret = _db call inidb_exists;
if(! _ret) then {
    // create player
    DLOG("Player '" + str(_player) + "' does not exist, creating.");
    [{
      	DLOG("THIS IS " + str(player) + " WITH THIS: " + str(_this));
        private "_player";
        if(! local (_this select 0)) exitWith {};
        _player = player;
        removeAllWeapons _player;
		removeAllItems _player;
		removeBackpack _player;
		removeGoggles _player;
		removeHeadgear _player;
		removeUniform _player; 
		removeVest _player;  
        _tmp = nil;
	  
		  waitUntil {
		    _tmp = [[4000,4000,0], 10000] call CBA_fnc_randPos;
		    !surfaceIsWater _tmp;  
		  };
		  _player setPos _tmp;
    	[player] call compile preprocessFileLineNumbers "x_avd\player\gear.sqf";
    }, [_player]] call AVD_fnc_remote_execute;
   
} else {  
	 private ["_uid", "_name", "_world", "_alive", "_damage", "_dir", "_posATL", "_posASL", "_weapons", "_primaryWeapon", "_magazines", "_items", "_headgear", "_vest", "_uniform", "_backpack", "_backpackItems", "_onWater", "_animation", "_pvars"];
     _uid = DB_LOAD_FROM(_db, "player", "uid");
     _name = DB_LOAD_FROM(_db, "player", "name");
     _world = DB_LOAD_FROM(_db, "player", "world");
     _alive = DB_LOAD_FROM(_db, "player", "alive");
     _alive = call compile _alive;
     _side = DB_LOAD_FROM(_db, "player", "side");
     switch(_side) do {
       case "WEST": { _side = WEST; };
       case "EAST": { _side = EAST; };
       case "GUER": { _side = RESISTANCE; };
       default { _side = civilian; };  
     };
     
     _damage = DB_LOAD_NUMBER_FROM(_db, "player", "damage");
     _dir = DB_LOAD_NUMBER_FROM(_db, "player", "dir");
     _posATL = DB_LOAD_ARRAY_FROM(_db, "player", "posATL");
     _posASL = DB_LOAD_ARRAY_FROM(_db, "player", "posASL");
     _loadOut = DB_LOAD_ARRAY_FROM(_db, "player", "loadout");
     AUNPACK(_loadOut, 8);
	 AUNPACK(_loadOut, 10);
	 AUNPACK(_loadOut, 12);
     DLOG("Loaded loadout: " + str(_loadOut));
     _onWater = DB_LOAD_FROM(_db, "player", "onWater");
     _onWater = call compile _onWater;
     _animation = DB_LOAD_FROM(_db, "player", "animation");
     _pvars = DB_LOAD_FROM(_db, "player", "persistentVars");
     _pvars = [_pvars, "any", "nil"] call CBA_fnc_replace;
     
     
     private "_pHash";
     _pHash = [] call CBA_fnc_hashCreate;
     
     [_pHash, "uid", _uid] call CBA_fnc_hashSet;
     
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
	
     [{
        private ["_player", "_loadOut"];
        _player = _this select 0;
        if(! local _player) exitWith {};
        _loadOut = _this select 1;
        
     	//[_player, _loadOut, ["ammo"]] call AEROSON_fnc_setLoadout;
        [_player, _loadOut] call AEROSON_fnc_setLoadout;
     }, [_player, _loadOut]] call AVD_fnc_remote_execute;
     
	 if(_onWater) then {
         DLOG("Restoring posASL " + str(_posASL));
         _player setPosASL _posASL;
         sleep 0.05;
     } else {
         DLOG("Restoring posATL " + str(_posATL));
       	_player setPosATL _posATL;
        sleep 0.05;  
     };
     if(!isNil "_animation") then {
         DLOG("Restoring animation" + str(_animation));
       _player playMoveNow _animation;  
     };
     
     
     if(side _player != _side) then {
     	[_player] joinSilent (createGroup _side);
     };
     
     
};


_player setVariable ["avd_player_loaded", true, true];
[{
    if(! local _this) exitWith {};
    AVD_PLAYER_LOADED = true;
},_player] call AVD_fnc_remote_execute;

