private ["_unit", "_value"];
_unit = _this select 0;
_value = _this select 1;
_unit setVehicleVarName _value;
call compile format["%1 = _unit; publicVariable ""%1"";", _value];
[-2, {
private ["_unit", "_value"];
_unit = _this select 0;
_value = _this select 1;
_unit setVehicleVarName _value;
}, _this] call CBA_fnc_globalExecute;
_unit;

