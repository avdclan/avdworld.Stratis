#define SELF "x_avd\lib\common\trackingMarker"
#include "include\avd.h"

[{
private ["_unit", "_color", "_label", "_marker", "_side", "_timeout"];
_unit = _this select 0;
if(isNil "_unit") exitWith {};
if(_unit == objNull) exitWith {};

_label = PARAM(1, nil);
_timeout  = PARAM(2, 0);
if(isNil "_label") then {
  if(_unit isKindOf "Man") then {
    _label = name _unit;  
  } else {
    _label = typeOf _unit;  
  };
}; 
_index = call AVD_fnc_getIndex;

_oldMarker = _unit getVariable "avd_tracing_marker";
if(! isNil "_oldMarker") then {
	deleteMarker _oldMarker;
};

_markerName = format["avd_tracingmarker_%1", _index];
_unit setVariable["avd_tracing_marker", _markerName, false];
_marker = createMarkerLocal[_markerName, getPos _unit];
_marker setMarkerTypeLocal "mil_dot";
_marker setMarkerTextLocal _label;
_marker setMarkerSizeLocal [1,1];
_col = "ColorBlack";
_side = side _unit;
_vside = _unit getVariable "avd_side";
if(! isNil "_vside") then {
    _side = _vside; 
};
switch(_side) do {
    case WEST: {
		_col = "ColorBlue";  
    };
    case EAST: {
      	_col = "ColorRed";  
    };
	case RESISTANCE: {
      	_col = "ColorGreen";  
    };
    case CIVILIAN: {
      	_col = "ColorYellow";  
    };
};
_marker setMarkerColorLocal _col;


[_unit, _marker, _label, _timeout] spawn {
    private ["_unit", "_marker", "_time", "_label", "_timeout"];
    _unit = _this select 0;
    _marker = _this select 1;
    _label = _this select 2;
    _timeout = _this select 3;
    _unit setVariable ["avd_tracking_marker", _marker, true];
    _unit setVariable ["avd_tracking_marker_original", getMarkerColor _marker, true];
    _time = time;
	waitUntil {
		  _marker setMarkerPos getPos _unit;
          _nlabel = format["%1 (%2)", _label, owner _unit];
		  _marker setMarkerTextLocal _nlabel;
          _side = side _unit;
          _col = "colorBlack";
          switch(_side) do {
			    case WEST: {
					_col = "ColorBlue";  
			    };
			    case EAST: {
			      	_col = "ColorRed";  
			    };
				case RESISTANCE: {
			      	_col = "ColorGreen";  
			    };
			    case CIVILIAN: {
			      	_col = "ColorYellow";  
			    };
          };
          _res = simulationEnabled _unit;
          if(! _res) then {
            	_col = "ColorWhite";  
          };
          _marker setMarkerColorLocal _col;
          
	      sleep (random 1);
          if(_timeout > 0) then {
          	_str = format["_time: %1, _timeout: %2, diff: %3", _time, _timeout, (time - _time)];
            DLOG(_str);
          };
	      (isNull _unit || !(alive _unit) || ((_timeout > 0) and _timeout < (time - _time)));
	};
    deleteMarkerLocal _marker;
};
}, _this, true, true] call AVD_fnc_remote_execute;