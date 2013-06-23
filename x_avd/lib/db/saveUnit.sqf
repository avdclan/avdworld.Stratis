#define SELF "x_avd\lib\db\saveUnit.sqf"
#include "include\avd.h"
#include "include\db.h"



private ["_unit", "_ukey"];
_unit = _this select 0;

if(!isPlayer _unit) exitWith {};

if(vehicleVarName _unit == "" and !isPlayer _unit) exitWith {
    DLOG("Won't save " + str(_unit) + " (no valid varname)");
    false;
};

if(isPlayer _unit) then {
    _ukey = getPlayerUID _unit;
};


DLOG("Saving " + str(_unit));
DB_WRITE(_ukey, "side", side _unit);
DB_WRITE(_ukey, "varname", vehicleVarName _unit);
DB_WRITE(_ukey, "isplayer", isPlayer _unit);
DB_WRITE(_ukey, "posASL", getPosASL _unit);
DB_WRITE(_ukey, "posATL", getPosATL _unit);
DB_WRITE(_ukey, "alive", alive _unit);
DB_WRITE(_ukey, "dir", getDir _unit);
DB_WRITE(_ukey, "damage", damage _unit);
DB_WRITE(_ukey, "weapons", weapons _unit);
DB_WRITE(_ukey, "magazines", magazines _unit);
DB_WRITE(_ukey, "items", items _unit);
DB_WRITE(_ukey, "headgear", headgear _unit);
DB_WRITE(_ukey, "vest", vest _unit);
DB_WRITE(_ukey, "uniform", uniform _unit);
DB_WRITE(_ukey, "backpack", backpack _unit);
DB_WRITE(_ukey, "backpackItems", backpackItems _unit);
DB_WRITE(_ukey, "avd_fds_foodVal", _unit getVariable "avd_fds_foodVal");
DB_WRITE(_ukey, "avd_fds_drinkVal", _unit getVariable "avd_fds_drinkVal");
DB_WRITE(_ukey, "avd_identity_age", _unit getVariable "avd_identity_age");
DB_WRITE(_ukey, "avd_identity_brave", _unit getVariable "avd_identity_brave");





DLOG(str(_unit) + " saved as " + str(_ukey))
