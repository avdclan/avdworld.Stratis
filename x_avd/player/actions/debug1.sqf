#define SELF "x_avd\player\actions\debug1.sqf"
#include "include\avd.h"
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
    
player addWeaponCargo ["ARP_Objects_waterbottle_m", 1];

