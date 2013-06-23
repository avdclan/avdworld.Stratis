#define SELF "x_avd\server\events.sqf"
#define PATH "x_avd\server"
#include "include\avd.h"

["avd_cron", {
    // saving players
    if(time < 60) exitWith {};
    {
        DLOG("Having player: " + str(_x));
        
        _loaded = _x getVariable "avd_db_loaded";
        _str = format["loaded is: %1", _loaded];
        DLOG(_str);
        _x setVariable ["avd_db_loaded", true];
        _str = format["loaded is: %1", _loaded];
        DLOG(_str);
        /*if(isNil "_loaded" or isNull _loaded or !_loaded) exitWith {
            DLOG("Player " + str(_x) + "not loaded yet, won't save.");
        };
        
		[_x] call AVD_fnc_db_saveUnit;
        _val = [getPlayerUID _x, ["alive"]] call AVD_fnc_db_load;
    	DLOG("Alive: " + str(_val));
                                            */      
    } foreach playableUnits;

}] call CBA_fnc_addEventHandler;