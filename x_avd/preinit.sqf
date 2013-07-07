#define SELF "x_avd\preinit.sqf"
#include "include\avd.h"
#include "include\db.h"
#include "include\component.h"
call compileFinal preProcessFile "\iniDB\init.sqf";

AVD_SERVER = (createGroup sideLogic) createUnit["LOGIC", [0, 0, 0], [], 0, ""];
AVD_SERVER allowDamage false;

publicVariable "AVD_SERVER";

AVDUMMY = (createGroup sideLogic) createUnit["LOGIC", [0, 0, 0], [], 0, ""];
AVDUMMY allowDamage false;
publicVariable "AVDUMMY";
call compileFinal preprocessFileLineNumbers 'x_avd\lib\init.sqf';

call compileFinal preprocessFileLineNumbers 'x_avd\events.sqf';


// create safe house
SAFE_HOUSE = "Land_MilOffices_V1_F" createVehicle [0, 0, 1500];
SAFE_HOUSE setPosASL [0, 0, 1500];
SAFE_HOUSE allowDamage false;
SAFE_HOUSE enableSimulation false;
publicVariable "SAFE_HOUSE";