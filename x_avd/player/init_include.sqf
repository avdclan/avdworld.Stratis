#define SELF "x_avd\player\init_include.sqf"
#define PATH "x_avd\player"
#include "include\avd.h"

DLOG("Loading Food & Drink System");
private ["_foodV", "_drinkV"];
_foodV = getPVAR(player, "avd_fds_foodVal", 1000);
_drinkV = getPVAR(player, "avd_fds_drinkVal", 1000);
[player, _foodV, _drinkV] COMP("modules\fooddrink\init");

