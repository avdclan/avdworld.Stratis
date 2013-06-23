#define SELF "x_avd\lib\common\getMissionParam.sqf"
#include "include\avd.h"
private ["_name", "_ret"];
_name = _this select 0;
_ret = 0;
for "_i" from (0) to ((count paramsArray) - 1) do
{
	_str = configName((missionConfigFile/"Params") select _i);
    if(_str == _name) exitWith { _ret = paramsArray select _i };
};
_ret;