#define SELF "x_avd\lib\db\savePlayer.sqf"
#define NODEBUG
#include "include\avd.h"
#include "include\db.h"

private ["_player", "_db", "_hash", "_save", "_var"];
_player = PARAM(0, player);
_hash = PARAM(1, nil);
_save = PARAM(2, false);
_var = 	_player getVariable "avd_player_loaded";
if(isNil "_var") exitwith { DLOG("Won't save player data. avd_player_loaded is nil or false."); };

_db = format["avdworld\player_%1", getPlayerUID _player];

if(_save and isServer) then {
	DLOG("Saving data for player " + str(_player) + ": " + str(_hash));
    private "_f";
    _dumpHash = {
    	DB_WRITE_TO(_db, "player", _key, _value);
	};

	[_hash, _dumpHash] call CBA_fnc_hashEachPair;
            		
} else {
    private ["_hash", "_vars"];
    // compile player hash
    _hash = [] call CBA_fnc_hashCreate;
    
    [_hash, "uid", getPlayerUID _player] call CBA_fnc_hashSet;
    [_hash, "name", name _player] call CBA_fnc_hashSet;
    [_hash, "world", worldName] call CBA_fnc_hashSet;
    [_hash, "alive", alive _player] call CBA_fnc_hashSet;
    [_hash, "damage", damage _player] call CBA_fnc_hashSet;
    [_hash, "dir", getDir _player] call CBA_fnc_hashSet;
    [_hash, "posATL", getPosATL _player] call CBA_fnc_hashSet;
    [_hash, "posASL", getPosASL _player] call CBA_fnc_hashSet;
    [_hash, "side", side _player] call CBA_fnc_hashSet;
   	/*
    [_hash, "weapons", PACK(weapons _player)] call CBA_fnc_hashSet;
    [_hash, "primaryWeapon", primaryWeapon _player] call CBA_fnc_hashSet;
    [_hash, "primaryWeaponItems", PACK(primaryWeaponItems _player)] call CBA_fnc_hashSet;
    [_hash, "primaryWeaponMagazines", PACK(primaryWeaponMagazine _player)] call CBA_fnc_hashSet;
    [_hash, "magazines", PACK(magazines _player)] call CBA_fnc_hashSet;
    [_hash, "items", PACK(items _player)] call CBA_fnc_hashSet;
    [_hash, "headgear", headgear _player] call CBA_fnc_hashSet;
    [_hash, "vest", vest _player] call CBA_fnc_hashSet;
    [_hash, "vestItems", PACK(vestItems _player)] call CBA_fnc_hashSet;
    [_hash, "uniform", uniform _player] call CBA_fnc_hashSet;
    [_hash, "uniformItems", PACK(uniformItems _player)] call CBA_fnc_hashSet;
    [_hash, "backpack", backpack  _player] call CBA_fnc_hashSet;
    [_hash, "backpackItems", PACK(backpackItems _player)] call CBA_fnc_hashSet;
   	*/
    
    //_l = [_player, ["ammo"]] call AEROSON_fnc_getLoadout;
    _l = [_player] call AEROSON_fnc_getLoadout;
    _cc = 0;
    {
        DLOG(str(_cc) + ": " + str(_x));
        _cc = _cc + 1;
    } foreach _l;
    APACK(_l, 8);
	APACK(_l, 10);
	APACK(_l, 12);
	[_hash, "loadout", _l] call CBA_fnc_hashSet;

    
    [_hash, "onWater", surfaceIsWater getPos _player] call CBA_fnc_hashSet;
    [_hash, "animation", animationState _player] call CBA_fnc_hashSet;
    
    _vars = _player getVariable "avd_persistent_vars";
    _vars = str(_vars);
    _vars = [_vars, ",]", ",objNull]"] call CBA_fnc_replace;
    [_hash, "persistentVars", _vars] call CBA_fnc_hashSet;
    DLOG("Sending local data to server.");
    [{
        if(!isServer) exitWith {};
        DLOG("Calling savePlayer on server with " + str(_this));
        _this call AVD_fnc_db_savePlayer;
    }, [_player,_hash, true]] call AVD_fnc_remote_execute;
    
    
};