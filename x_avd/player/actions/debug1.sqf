#define SELF "x_avd\player\actions\debug1.sqf"
#include "include\avd.h"
#include "include\arrays.h"
//_outpost = [east, getPos player, 500, true] call compile preprocessFile "x_avd\lib\military\createOutpost.sqf";
//DLOG("Having outpost: " + str(_outpost));
//_objs =  nearestObjects [getPos player, [], 500];
/*
{
    if(typeOf _x != "") then {
		DLOG("Having object " + str(_x) + " type: " + str(typeOf _x));
    };
} forEach _objs;
*/
//execVM "x_avd\components\spawn\init.sqf";
/*
call compile preprocessFile "x_avd\lib\uniform.sqf";
// ammo
// hit, thrust, typicalSpeed, cost
_cfgAmmos = configFile >> "cfgAmmo";
_ammos = [];
for "_i" from 0 to (count _cfgAmmos)-1 do {
	_ammo = _cfgAmmos select _i;
    if(isClass _ammo) then {
      _cName = configName(_ammo);
      _dName = getText(_ammo >> "cost");
	  _ammos = _ammos + [_ammo];
       DLOG("ACName: " + str(_cName) + ", AdName: " + str(_dName));  
    };
};

_cfgMagazines = configFile >> "cfgMagazines";
_mags = [];
for "_i" from 0 to (count _cfgMagazines)-1 do {
	_mag = _cfgMagazines select _i;
    if(isClass _mag) then {
      _cName = configName(_mag);
      _dName = getText(_mag >> "ammo");
	  _mags = _mags + [_mag];
       DLOG("MCName: " + str(_cName) + ", MdName: " + str(_dName));  
    };
};

// mag
// ammo, count, initSpeed, descriptionShort, displayName

// weapons
// magazines[], htMin, htMin, maxRange, maxLeadSpeed, reloadTime,
_cfgWeapons = configFile >> "cfgWeapons";
_weapons = [];
_stats = [];
for "_i" from 0 to (count _cfgWeapons)-1 do {
	_weapon = _cfgWeapons select _i;
    _mags = getArray(_weapon >> "magazines");
    
    if(isClass _weapon and count(_mags) >= 1) then {
        DLOG("Mags: " + str(_mags));
      _cName = configName(_weapon);
      _dName = getNumber(_weapon >> "reloadTime");
      _htMax = getNumber(_weapon >> "htMax");
      _htMin = getNumber(_weapon >> "htMin");
      if(!(_htMax in _stats)) then { _stats = _stats + [_htMax]; };
	  _weapons = _weapons + [_weapon];
       DLOG("WCName: " + str(_cName) + ", WdName: " + str(_dName) + ", htMax: " + str(_htMax) + ", htMin: " + str(_htMin));  
    };
};

// CfgFactionClasses
// CfgInventory >> Objects
//				>> SlotTypes

// vehicles >> linkedItems, magazines, weapons
                                                */
//["<t size='2'>Hello World</t>",getPos player,15,0] spawn bis_fnc_3Dcredits; 
    
//player addWeaponCargo ["ARP_Objects_waterbottle_m", 1];
/*
detach player;
player attachTo [cursorTarget, [-0.3, 0.2, 0]];
[47, [true, false, false], { detach player; player setVariable["avd_arrested", false, true]; }] call CBA_fnc_addKeyHandler;
cursorTarget spawn {
  waitUntil {
      _var = player getVariable "avd_arrested";
      if(!isNil "_var" and !_var) exitWith {};
      player playMoveNow animationState _this;
      sleep 0.5;
      false;
  }  
};
*/
/*["avd_task_success", {
    DLOG("Task completed: " + str(_this));
}] call CBA_fnc_addEventHandler;
*/
//call compile preprocessFile "x_avd\lib\tasks.sqf";
//[player, ["Test Task", "Das ist ein Test Task!!!", "HIER IST DER TEST"], getPos player] call AVD_fnc_tasks_create;

//["ScoreAdded",["Disabled the nuke without triggering an alarm.",5]] call bis_fnc_showNotification;
/*_pos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
if(isNil "d_spawn_house_rate") then {
	DLOG("Nil..");    
} else {
  	DLOG(d_spawn_house_rate);  
};

DLOG(str(AVD_MAP_LOCATIONS_LAND));
*/



/*_pos = AVD_MAP_LOCATIONS_WATER select (floor(random (count(AVD_MAP_LOCATIONS_WATER)-1)));
for[{_i = 0}, { _i < 100}, { _i = _i + 1 }] do {
           	DLOG("creating group. at " + str(_pos));
			_grp = createGroup  west;
            _unit = _grp createUnit["I_Soldier_GL_F", _pos, [], 0, ""];
            _unit enableSimulation false; 
            _unit = _grp createUnit["I_Soldier_GL_F", _pos, [], 0, ""];
            _unit enableSimulation false;
            DLOG("Got group: " + str(_grp));
            
            
     		
};
*/

/*
["avd_cron", {
    private ["_time", "_offset", "_format", "_avgOffset", "_count", "_avg"];
	_avgOffset = missionNamespace getVariable"avd_cron_check_avgoffset";
    _count = missionNamespace getVariable "avd_cron_check_count";
    if(isNil "_avgOffset") then {
      _avgOffset = 0;  
    };
    if(isNil "_count") then {
      _count = 1;  
    };
    _offset = time % 60;
    _avg = _avgOffset + _offset;
    missionNamespace setVariable["avd_cron_check_avgoffset", _avg];
    missionNamespace setVariable["avd_cron_check_count", (_count + 1)];
    _format = format["offset: %1 (avg: %8), allGroups: %9, allUnits: %2, allDead: %3, vehicles: %4, players: %5, fps: %6, fpsmin: %7", _offset, count(allUnits), count(allDead), count(vehicles), count(playableUnits), diag_fps, diag_fpsmin, (_avg / _count), count(allGroups)];
    DLOG(_format);
}] call CBA_fnc_addEventHandler;
*/
//execVM "x_avd\lib\im\events.sqf";
//wh = "Library_WeaponHolder" createVehicle (getPos player); wh addItemCargo ["ItemMap", 5];
//wh addWeaponCargo ["V_BandollierB_cbr", 5];


/*_rand = [east, "car"] call AVD_fnc_lists_getRandom;
DLOG("Creating " + _rand);
_vec = _rand createVehicle getPos player;
DLOG("Got vec " + str(_vec) + "on pos " + str(getPos _vec));
*/
_object = getPlayerUID player;
_keys = ["posATL", "posASL", "alive", "uniform"];
_ret = [];
//DLOG("Loading " + str(_object) + ", keys: " + str(_keys));
{
    _key = [_x, """", ""] call CBA_fnc_replace;
    _r = [AVD_DB, _object, _key] call iniDB_read;
    DLOG("Got " + str(_r) + " for " + str(_key));
	_ret = _ret + [_r];
} foreach _keys;

/*
_ret = [getPlayerUID player, "account", "weapon", currentWeapon player] call iniDB_write;

diag_log format["Result #1: %1", _ret];

_ret = [getPlayerUID player, "account", "magazines", getMagazineCargo player] call iniDB_write;

diag_log format["Result #2: %1", _ret];

_ret = [getPlayerUID player, "account", "pos", position player] call iniDB_write;

diag_log format["Result #3: %1", _ret];

_ret = [getPlayerUID player, "account", "stupidity", 99.5] call iniDB_write;

diag_log format["Result #4: %1", _ret];

_testArray = ['hello', ['hello again']];
_testArrayStr = format["%1", _testArray];

_ret = [getPlayerUID player, "account", "arrayTest", _testArray] call iniDB_write;

diag_log format["Result #5: %1", _ret];

diag_log format["Test String: %1", _testArrayStr];

_crcTest = "SicSemperTyrannis" call iniDB_CRC32;
_md5Test = "SicSemperTyrannis" call iniDB_MD5;
_b64Test = _testArrayStr call iniDB_Base64Encode;

diag_log _crcTest;
diag_log _md5Test;
diag_log _b64Test;

_ret = [getPlayerUID player, "account", "arrayTest", "ARRAY"] call iniDB_read;

diag_log format["Read (arrayTest): %1 (%2)", _ret, typeName _ret];

_ret = [getPlayerUID player, "account", "stupidity", "NUMBER"] call iniDB_read;

diag_log format["Read (stupidity): %1 (%2)", _ret, typeName _ret];
*/

_objs = getPos player nearObjects 5;
DLOG("objs: " + str(_objs));