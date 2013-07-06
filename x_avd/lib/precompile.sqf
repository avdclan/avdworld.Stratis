if(!isServer) exitWith {};
#define NODEBUG
#define SELF "x_avd\lib\precompile.sqf"
#include "include\avd.h"
#include "include\world.h"
#include "include\params.h"
#include "include\arrays.h"

private ["_time"];
_time = time;
DLOG("Precompiling.");



DLOG("Mapping Map.");
AVD_MAP_LOCATIONS_LAND = [];
AVD_MAP_LOCATIONS_WATER = [];
publicVariable "AVD_MAP_LOCATIONS_LAND";
publicVariable "AVD_MAP_LOCATIONS_WATER";

AVD_LISTS = [] call CBA_fnc_hashCreate;
publicVariable "AVD_LISTS";
AVD_fnc_precompile_mapMap = {
    private ["_basePos", "_curPos", "_scala", "_radius", "_fields"];
    _basePos = PARAM(0, nil);
    _scala = PARAM(1, 500);
    _radius = PARAM(2, 1000);
    _fields = PARAM(3, 7);
    _curPos = _basePos;
    _land = true;
    for "_Y" from 0 to (_fields) do {
        
    	for "_X" from 0 to (_fields) do {
            _basePos = [(_X * _radius), (_Y * _radius)];
		    for "_n" from 0 to (_radius / _scala) do {
		        //DLOG("x " + str(_n));
			    for "_i" from 0 to (_radius / _scala) do {
		            //DLOG("y " + str(_i));
			        _curPos = [((_basePos select 0) + (_n * _scala)), ((_basePos select 1) + (_i * _scala))];
			        //DLOG("Scanning " + str(_curPos));
			        if(surfaceIsWater _curPos) then {
							                
			       		AVD_MAP_LOCATIONS_WATER = AVD_MAP_LOCATIONS_WATER + [_curPos];    
			        } else {
                        AVD_MAP_LOCATIONS_LAND = AVD_MAP_LOCATIONS_LAND + [_curPos];
                    };
			    };
		    };
		};
    };
    publicVariable "AVD_MAP_LOCATIONS_LAND";
    publicVariable "AVD_MAP_LOCATIONS_WATER";
};


//[[0, 0], missionParam("d_world_mapPointScala")] call AVD_fnc_precompile_mapMap;

// set config params

for "_i" from (0) to ((count paramsArray) - 1) do
{
	_str = configName((missionConfigFile/"Params") select _i);
    _val = paramsArray select _i;
    _code = format["AVD_PARAM_%1 = %2; publicVariable ""AVD_PARAM_%1"";", _str, _val];
    DLOG("Setting Param: " + str(_code));
    call compile _code;
};


AVD_fnc_lists_add = {
  private ["_side", "_type", "_val", "_hash", "_list", "_ret"];
  _side = PARAM(0, civilian);
  _type = PARAM(1, nil);
  _val = PARAM(2, nil);
  _type = toLower _type;
  _side = str(_side);
  _ret = [AVD_LISTS, _side] call CBA_fnc_hashHasKey;
  if(_ret) then {
    _hash = [AVD_LISTS, _side] call CBA_fnc_hashGet;  
  } else {
    _hash = [] call CBA_fnc_hashCreate;
  };
  _ret = [_hash, _type] call CBA_fnc_hashHasKey;
  if(_ret) then {
    _list = [_hash, _type] call CBA_fnc_hashGet;  
  } else {
    _list = [];
  };
  
  _list = _list + [_val];
  [_hash, _type, _list] call CBA_fnc_hashSet;
  [AVD_LISTS, _side, _hash] call CBA_fnc_hashSet;
  publicVariable "AVD_LISTS";
  DLOG("added " + str(_val) + " to list " + str(_type) + " for " + str(_side));
  true;   
};
AVD_fnc_lists_getRandom = {
    private ["_side", "_type", "_hash", "_list", "_random", "_ret"];
    _side = PARAM(0, civilian);
    _type = PARAM(1, "");
    _random = PARAM(2, false);
    
    _hash = [AVD_LISTS, str(_side)] call CBA_fnc_hashGet;
    _list = [_hash, _type] call CBA_fnc_hashGet;
    
    _ret = _list select (floor(random(count(_list)-1)));
    _ret;
};
AVD_fnc_lists_get = {
    private ["_side", "_type", "_hash", "_list", "_random", "_ret"];
    _side = PARAM(0, civilian);
    _type = PARAM(1, "");
    _type = toLower _type;
    _random = PARAM(2, false);
    DLOG("Looking for " + str(_side) + ", type: " + str(_type));
    _hash = [AVD_LISTS, str(_side)] call CBA_fnc_hashGet;
    _list = [_hash, _type] call CBA_fnc_hashGet;
	_list;
};
// compile vehicles list
_cfgVehicles = configFile >> "cfgVehicles";
_mags = [];
for "_i" from 0 to (count _cfgVehicles)-1 do {
	_c = _cfgVehicles select _i;
    
    if(isClass _c) then {
      _cName = configName(_c);
      if(_cName in EXCLUDE) exitWith {};
      _numSide = getNumber(_c >> "side");
      _fuelCap = getNumber(_c >> "fuelCapacity");
      if(_numSide == 4) exitWith {};
      
      _side = civilian;
      switch(_numSide) do {
        case 0: {
          _side = EAST;  
        };
        case 1: {
          _side = WEST;  
        };  
        case 2: {
          _side = RESISTANCE;  
        };
        default {
          _side = CIVILIAN;  
        };
      };
      _hasDriver = getNumber(_c >> "hasDriver");
	  if(_hasDriver == 1 and _fuelCap == 0 and !(_cName isKindOf "Man")) exitWith {}; // ignore erstmal.
      // cars:

      switch(true) do {
        case (_cName isKindOf "Animal"): {
            [_side, "Animal", _cName] call AVD_fnc_lists_add;  
        };
        case (_cName isKindOf "Man"): {
            [_side, "Man", _cName] call AVD_fnc_lists_add;
        };
        case (_cName isKindOf "Tank"): {
            [_side, "Tank", _cName] call AVD_fnc_lists_add;
        };
        case (_cName isKindOf "Air"): {
            [_side, "Air", _cName] call AVD_fnc_lists_add;
        };
        case (_cName isKindOf "Truck"): {
            [_side, "Truck", _cName] call AVD_fnc_lists_add;
        };
        case (_cName isKindOf "Car"): {
            [_side, "Car", _cName] call AVD_fnc_lists_add;
        };  
      };      
      
	  
    };
};
publicVariable "AVD_LISTS";



DLOG("Precompiling took " + str(time - _time) + " seconds.");