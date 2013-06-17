#define SELF "x_avd\lib\db\saveUnit.sqf"
#include "include\avd.h"
#include "include\db.h"

private ["_unit", "_ukey"];
_unit = _this select 0;

if(vehicleVarName _unit == "" and !isPlayer _unit) exitWith {
    DLOG("Won't save " + str(_unit) + " (no valid varname)");
    false;
};

if(isPlayer _unit) then {
    _ukey = getPlayerUID _unit;
};


DLOG("Saving " + str(_unit));
DB_WRITE(_ukey, "position", position _unit);
DB_WRITE(_ukey, "alive", alive _unit);
DB_WRITE(_ukey, "direction", getDir _unit);
DB_WRITE(_ukey, "damage", damage _unit);
DB_WRITE(_ukey, "alive", alive _unit);
DLOG(str(_unit) + " saved as " + str(_ukey))
