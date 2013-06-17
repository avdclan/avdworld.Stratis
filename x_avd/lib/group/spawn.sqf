#define SELF "x_avd\lib\group\spawn.sqf"
#include "include\avd.h"
#include "arrays.h"

//_group = [east, 8, "SEARCH", "CITY_SEARCH"] call AVD_fnc_group_spawn;
    
private ["_side", "_num", "_template", "_task", "_group", "_pos"];
_side = _this select 0;
_pos = _this select 1;
_num = _this select 2;
_template = _this select 3;
_task = _this select 4;
_group = [_side, _pos, _template, _num] call AVD_fnc_group_create;
