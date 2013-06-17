private ["_unit", "_color", "_label", "_marker", "_side"];
_unit = _this select 0;
_label = _this select 1;

if(isNil "_label") then { _label = name _unit; };

_index = call AVD_fnc_getIndex;
if(_unit == objNull) exitWith { ["Sorry, I won't create a marker for a null object."] call dbg; };

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


[_unit, _marker] spawn {
    _unit = _this select 0;
    _marker = _this select 1;
    _unit setVariable ["avd_tracking_marker", _marker, true];
    _unit setVariable ["avd_tracking_marker_original", getMarkerColor _marker, true];
	waitUntil {
		  _marker setMarkerPos getPos _unit;
          _marker setMarkerText format["%1 (%2)", name _unit, owner _unit];
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
          _res = [_unit] call AVD_fnc_cache_isCached;
          if(_res) then {
            	_col = "ColorWhite";  
          };
          _marker setMarkerColorLocal _col;
          
	      sleep 0.5;
	      (isNull _unit || !(alive _unit));
	};
    deleteMarkerLocal _marker;
};

