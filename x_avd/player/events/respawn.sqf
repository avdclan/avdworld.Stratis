#define SELF "x_avd\player\events\respawn.sqf"
#include "include\avd.h"
private ["_unit", "_corpse", "_timeout", "_hasBack", "_backpack", "_backpackWeapons", "_backpackMagazines"];
_unit = _this select 0;
_corpse = _this select 1;
DLOG(_this);

call AVD_fnc_player_init;