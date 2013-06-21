#define SELF "x_avd\player\modules\fooddrink\actions.sqf"
#define PATH "x_avd\player\modules\fooddrink\"
#include "include\avd.h"

player addAction ["Drink", "x_avd\player\modules\fooddrink\actions\drink.sqf", [], 0, true, true, "", "[player] call AVD_fnc_fds_canDrink"];
player addAction ["Eat", "x_avd\player\modules\fooddrink\actions\food.sqf", [], 0, true, true, "", "[player] call AVD_fnc_fds_canEat"];