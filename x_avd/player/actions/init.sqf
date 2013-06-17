#define SELF "x_avd\player\actions\init.sqf"
#include "include\avd.h"


player addAction ["Debug", "x_avd\player\actions\debug.sqf", [player], 0, true, true, "", "true"];
player addAction ["Arrest", "x_avd\player\actions\arrest.sqf", [player], 0, true, true, "", "true"];