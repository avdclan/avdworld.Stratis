#define SELF "x_avd\lib\common\say.sqf"
#include "include\avd.h"

private ["_speaker", "_message", "_str", "_color"];
_speaker = _this select 0;
_message = _this select 1;
_color = "#FF3B3E";
//_str = format["<t color='%1'>%2</t>: %3", _color, name _speaker, _message];
_str = format["%1: %2", name _speaker, _message];
[-2, {
    private ["_str"];
    if(!hasInterface) exitWith {};
    //DLOG(_this);
    _str = _this;
    cutText[_str, "PLAIN DOWN", 1];
    
}, _str] call CBA_fnc_globalExecute;