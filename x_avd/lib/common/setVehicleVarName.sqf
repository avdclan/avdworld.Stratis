private ["_unit", "_value"];
_unit = _this select 0;
_value = _this select 1;
_unit setVehicleVarName _value;
call compile format["%1 = _unit; publicVariable ""%1"";", _value];
//[{
//private ["_unit", "_value"];
//_unit = _this select 0;
//_value = _this select 1;
//_unit setVehicleVarName _value;
//}, _this] call AVD_fnc_remote_execute;
_unit;

