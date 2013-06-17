#define SELF "x_avd\lib\waypoint\add.sqf"
#include "include\avd.h"

/**
 * 
 */
 private ["_group", "_pos", "_radius", "_index", "_cond", "_statement", "_sargs", "_func", "_funcName", "_ix", "_wp", "_cargs", "_res"];
 _group = _this select 0;
 _pos = _this select 1;
  _cond = if(count(_this) > 2) then { _this select 2; } else { ""; };
  _cargs = if(count(_this) > 3) then { _this select 3; } else { []; };
 _statement = if(count(_this) > 4) then { _this select 4; } else { {}; };
 _sargs = if(count(_this) > 5) then { _this select 5; } else { []; };
 _radius = if(count(_this) > 6) then { _this select 6; } else { 50; };
 _index = if(count(_this) > 7) then { _this select 7; } else {  count(waypoints _group); };

 
 _ix = call AVD_fnc_getIndex;
 _funcName = format["wp_func_%1", _ix];
 DLOG("Creating waypoint for " + str(_group) + ", pos: " + str(_pos) + ", radius: " + str(_radius) + ", index: " + str(_index) + ", cond: " + str(_cond) + ", statement: " + str(_statement) + ", sargs: " + str(_sargs));
   
 
 _func = format["%1 = %2; [%3, this, thislist, %4] call %1;", _funcName, _cond, _radius, _cargs];
 _str = format["Having func cond: %1", _func];
DLOG(_str);
_ix = call AVD_fnc_getIndex;
 _funcSName = format["wp_func_%1", _ix];
_funcStatement = format["%1 = %2; [%3, this, thislist, %4] call %1; %5 = nil; %1 = nil;", _funcSName, _statement, _radius, _sargs, _funcName];
 _str = format["Having func statement: %1", _funcStatement];
 DLOG(_str);

_wp = _group addwaypoint [_pos, _radius, _index];
_wp setWaypointStatements[_func, _funcStatement];
DLOG(str(waypointStatements _wp));
_wp;