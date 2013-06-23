#define SELF "x_avd\lib\road.sqf"
#include "include\avd.h"

AVD_fnc_getNearestRoad = {
     private ["_list", "_dist", "_obj", "_last", "_object", "_radius"];
     _object = _this select 0;
     _radius = _this select 1;
	_list = _object nearRoads _radius;
	_dist = 999999;
	_obj = nil;
	_last = nil;
	{
	    _d = _x distance _object;
	    if(_d < _dist) then {
	      _dist = _d;
	      _last = _obj;
	      _obj = _x;  
	    };
	
	    
	} foreach _list;
	
	_dir = [_obj, _last] call BIS_fnc_DirTo;
	[_obj, _last];
	
};
AVD_fnc_getDistantRoad = {
    DLOG(_this);
     private ["_list", "_dist", "_obj", "_last", "_object", "_radius"];
     _object = _this select 0;
     _radius = _this select 1;
	_list = _object nearRoads _radius;
    //DLOG(str(_list));
	_dist = 0;
	_obj = nil;
	_last = nil;
	{
	    _d = _x distance _object;
	    if(_d > _dist) then {
	      _dist = _d;
	      _last = _obj;
	      _obj = _x;  
	    };
	
	    
	} foreach _list;
	
	//_dir = [_obj, _last] call BIS_fnc_DirTo;
	[_obj, _last];
	
};
