#define SELF "x_avd\player\actions\init.sqf"
#include "include\avd.h"


player addAction ["<t color='#FF6600'>Player Menu</t>", "x_avd\player\actions\playerMenu.sqf", [player], 0, true, true, "", "true"];
player addAction ["Debug", "x_avd\player\actions\debug.sqf", [player], 0, true, true, "", "true"];
player addAction ["Debug1", "x_avd\player\actions\debug1.sqf", [player], 0, true, true, "", "true"];
player addAction ["Arrest", "x_avd\player\actions\arrest.sqf", [player], 0, true, true, "", "true"];
player addAction ["Change Unit Gear", "x_avd\player\actions\switchUnitGear.sqf", [true], 0, true, true, "", "(((cursorTarget distance player) < 2) and (cursorTarget iskindOf 'Man') and !(cursorTarget iskindOf 'Animal') and !(alive cursorTarget))"];



if(isNil "AVD_PLAYER_BUTTON") then {
  	AVD_PLAYER_BUTTON = false;  
};


