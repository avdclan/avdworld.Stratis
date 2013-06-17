#define SELF "x_avd\player\actions\debug.sqf"
#include "include\avd.h"

[player, "das ist ein test, yoyo"] call AVD_fnc_say;
[{
    DLOG(_this);
    hint "Hallo";
}, ["test arg1", "test arg2"]] call compile preprocessFile "x_avd\lib\remote\execute.sqf";