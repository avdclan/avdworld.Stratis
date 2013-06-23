#define SELF "x_avd\preinit.sqf"
#include "include\avd.h"
#include "include\db.h"
AVD_SERVER = (createGroup sideLogic) createUnit["LOGIC", [0, 0, 0], [], 0, ""];
AVD_SERVER allowDamage false;

publicVariable "AVD_SERVER";
call compileFinal preprocessFileLineNumbers 'x_avd\lib\init.sqf';
call compileFinal preprocessFileLineNumbers 'x_avd\events.sqf';
