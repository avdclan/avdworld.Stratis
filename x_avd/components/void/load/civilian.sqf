#define SELF "x_avd\components\void\load\civilian.sqf"
#define PATH "x_avd\components\void\load"
#define NODEBUG
#include "include\avd.h"
#include "include\db.h"
#include "include\arrays.h"

private ["_allObjects", "_createUnits"];

_allObjects = DB_LOAD_ALL_FROM("civilian");

_createUnits = {
    _grp = createGroup civilian;
    _id = [_value, "_id"] call CBA_fnc_hashGet;
    DLOG("Restoring " + str(_id));
    _class = [_value, "class"] call CBA_fnc_hashGet;
    _name = [_value, "name"] call CBA_fnc_hashGet;
    _varN = [_value, "var_prefix"] call CBA_fnc_hashGet;
    _ident = [_name, " ", "_"] call CBA_fnc_replace;
    _housePos = [_value, "house_posATL"] call CBA_fnc_hashGet;
    _housePos = call compile _housePos;
    _unit = _grp createUnit[_class, _housePos, [], 0, "NONE"];
    DLOG("Created: " + name _unit + "(" + str(_name) + ")");
    DLOG("Created: " + str(_unit));
    _unit disableAI "MOVE";
    _unit disableAI "TARGET";
    _unit disableAI "AUTOTARGET";
    //_unit setIdentity _ident;
    _varName = format["%1_%2", _varN, _id];
    [_unit, _varName] call AVD_fnc_setVehicleVarName;
    DLOG("Now: " + name _unit);
    DLOG("Now: " + str(_unit));
    
    
};

[_allObjects, _createUnits] call CBA_fnc_hashEachPair;