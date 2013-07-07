#include "include\avd.h"
if(true) exitWith {};
private ["_obj"];
_obj = PARAM(0, nil);

if(isNil "_obj") exitWith {};

waitUntil {
    private "_index";
    _index = getIndex;
  _marker = createMarkerLocal[format["FOO%1", _index], getPos _obj];
_marker setMarkerTypeLocal "mil_dot";
_marker setMarkerSizeLocal [1,1];
_marker setMarkerColorLocal "ColorBlack";
  sleep 0.5;
  ! alive _obj;  
};