if(!isServer) exitWith {};
#define SELF "x_avd\components\void\install\civilian.sqf"
#include "include\avd.h"

DLOG("Installing civilians.");
AVD_fnc_void_scanCity = {
 private ["_location", "_radius", "_group"];
  _location = PARAM(0, {[]});
  _radius = PARAM(1, 250);
  _group = PARAM(2, nil);
  if(isNil "_group") then {
  	_group = createGroup sideLogic;  
  };
  _logic = _group createUnit["LOGIC", position _x, [], 0, "NONE"];
  makePersistent(_logic);
  DLOG("Group: " + str(group _logic) + ", obj: " + str(_logic));
  _name = text _x;
  setPVAR(_logic, "name", _name);
  setPVAR(_logic, "location", position _x);
  
  // scan houses
  _houses = nearestObjects [_logic, ["House"], _radius];
  _valid = [];
  _chouses = count(_houses);
  _counter = 0;
  _stat1 = 0;
  _stat2 = 0;
  _had = [];
  {
    // scan building positions, maxpos 50.
    _h = _x;  
    _posses = [];
	for "_i" from 0 to 50 do {
    	_pos = _h buildingPos _i;
        _ret = [_pos, [0,0,0]] call BIS_fnc_areEqual;
        if(!_ret) then {
        	_posses = _posses + [_pos];
        }; 
    };
    if(count(_posses) > 0 and !(typeOf _x in _had)) then {
    	DLOG("House " + str(_x) + " has " + str(count(_posses)) + " positions.");
        _had = _had + [typeOf _x];
    };
    
  } foreach _houses;
  DLOG("Valid houses: " + str(_valid));
  
  {
      _pos = getPos _x;
  } foreach _valid;
  
  _logic;
};
        
AVD_fnc_void_scanLocations = {
    private ["_villages",
		"_cities",
        "_capitals",
        "_locals"];
    _group = createGroup sideLogic; 
	_villages = nearestLocations [[0,0,0], ["NameVillage"], 100000]; 
	_cities = nearestLocations [[0,0,0], ["NameCity"], 100000];
	_capitals = nearestLocations [[0,0,0], ["NameCityCapital"], 100000];
	//_locals = nearestLocations [[0,0,0], ["NameLocal"], 100000];
    if(isNil "_group") then {
    	_group = createGroup sideLogic;  
  	};
  	{
    	_logic = [_x, 200, _group] call AVD_fnc_void_scanCity;
    } foreach _villages;
    {
    	_logic = [_x, 500, _group] call AVD_fnc_void_scanCity;
    } foreach _cities;
    {
    	_logic = [_x, 1000, _group] call AVD_fnc_void_scanCity;
    } foreach _capitals;
    
    //[_locals, 0] call AVD_fnc_void_scanCity; 
   	
};

//call AVD_fnc_void_scanLocations;