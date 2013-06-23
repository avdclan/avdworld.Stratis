if(!isServer) exitWith {};

#define SELF "x_avd\lib\precompile.sqf"
#include "include\avd.h"
#include "include\world.h"
#include "include\params.h"

private ["_time"];
_time = time;
DLOG("Precompiling.");



DLOG("Mapping Map.");
AVD_MAP_LOCATIONS_LAND = [];
AVD_MAP_LOCATIONS_WATER = [];

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
[[0, 0], missionParam("d_world_mapPointScala")] call AVD_fnc_precompile_mapMap;

// set config params

for "_i" from (0) to ((count paramsArray) - 1) do
{
	_str = configName((missionConfigFile/"Params") select _i);
    _val = paramsArray select _i;
    _code = format["AVD_PARAM_%1 = %2;", _str, _val];
    DLOG("Setting Param: " + str(_code));
    call compile _code;
};


DLOG("Precompiling took " + str(time - _time) + " seconds.");