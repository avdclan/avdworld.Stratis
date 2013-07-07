if(!isServer) exitWith {};
#define SELF "x_avd\components\void\install\civilian.sqf"
#define NODEBUG
#include "include\avd.h"
#include "include\arrays.h"
#include "include\db.h"
DLOG("Installing civilians.");
AVD_fnc_void_scanHouses = {
 private ["_location", "_radius", "_group", "_hash", "_houses", "_families", "_hash", "_arr"];
  _arr = [];
  // scan houses
  _houses = nearestObjects [[0, 0, 0], ["House"], 100000];
  _valid = []; 
  
  {
      if(typeOf _x in CIVILIAN_HOUSES) then {
      _pos = _x buildingPos 0;
      
      	_res = [_pos, [0, 0, 0]] call BIS_fnc_areEqual;
	      if(!_res) then {
    	    _valid = _valid + [_x];
       
	      };
      };
  } foreach _houses;
  
  _chouses = floor(count(_valid) / 2);
  DLOG(str(_chouses) + " all");
  _c = 0;
  _families = [];
  waitUntil {
      _mem = (floor(random 10) + floor(random 10));
      _n = _c + _mem;
      if(_n > _chouses) then { _mem = _chouses - _c; };
      DLOG(str(_c) + "/" + str(_n) + "/" + str(_mem) + ": Familie with " + str(_mem) + "/" + str(_chouses - _c) + " members.");
      if(_mem > 0) then {
          _families = _families + [_mem];
      };
      _c = _c + _mem;
      !(_c <= _chouses) or _mem == 0;
  };
  
  
  
  _lindex = 0;
  _cindex = 0;
  _hindex = 0;
  _classes = [civilian, "man"] call AVD_fnc_lists_get;
  {
      // generate family
      _group = createGroup civilian;
      
      for "_i" from 0 to _x-1 do {
        _class = nil;	
        DLOG("Waiting");
        waitUntil {
        _class = [_classes] call CBA_fnc_shuffle;
        _class = _class select 0;
        ! (_class in EXCLUDE)
        };
        DLOG("Got class");
        // house is
        _house = _valid select _hindex;
        _hindex = _hindex + 1;
        _hash = [] call CBA_fnc_hashCreate;
        _age = floor((((random 0.3) + 0.2) * 100));
    	
   		 _brave = random 1;
    	DLOG("Creation");
        _mem = _group createUnit[_class, _house buildingPos 1, [], 0, "NONE"];
        _mem disableAI "MOVE";
        DLOG("Created " + str(name _mem) + " living in " + str(_house));
        [_hash, "class", _class] call CBA_fnc_hashSet;
        [_hash, "name", name _mem] call CBA_fnc_hashSet;
        _spl = [name _mem, " "] call CBA_fnc_split;
        [_hash, "firstname", _spl select 0] call CBA_fnc_hashSet;
        [_hash, "lastname", _spl select 1] call CBA_fnc_hashSet;
        [_hash, "age", _age] call CBA_fnc_hashSet;
        [_hash, "brave", _mem skill "courage"] call CBA_fnc_hashSet;
        [_hash, "var_prefix", "avd_d_civilian"] call CBA_fnc_hashSet;
        [_hash, "members", floor(random 3)] call CBA_fnc_hashSet;
        
        _distr = nil;
        _city = nearestLocation[getPos _mem, "NameCity"];
        _village = nearestLocation[getPos _mem, "NameVillage"];
        _capital = nearestLocation[getPos _mem, "NameCityCapital"];
        _distr = _capital;
        
        if((_mem distance position _city) < (_mem distance position _distr)) then {
          _distr = _city;  
        };
        if((_mem distance position _village) < (_mem distance position _distr)) then {
          _distr = _village;  
        };
        
        DLOG("Capital is " + str(_capital) + " district: " + str(_distr));
        _capital = text _capital;
        _distr = text _distr;
        [_hash, "capital", _capital] call CBA_fnc_hashSet;
        [_hash, "district", _distr] call CBA_fnc_hashSet;
        [_hash, "house_type", typeOf _house] call CBA_fnc_hashSet;
        [_hash, "house_posATL", getPosATL _house] call CBA_fnc_hashSet;
		
        _id = DB_WRITE_HASH("civilian", _hash);
        DLOG("Saved with id " + str(_id));
        deleteVehicle _mem;
        
      };
      deleteGroup _group;
      
  } foreach _families;
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

call AVD_fnc_void_scanHouses;