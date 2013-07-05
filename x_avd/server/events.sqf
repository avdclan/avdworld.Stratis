#define SELF "x_avd\server\events.sqf"
#define PATH "x_avd\server"
#include "include\avd.h"
/*
["avd_cron", {
    private ["_loaded"];
    // saving players
    if(time > 60) then { 
	    {
	        DLOG("Having player: " + str(_x));
	        
	        _loaded = _x getVariable "avd_player_loaded";
	        if(!isNil "_loaded") then {
	          DLOG("Saving " + str(_x));
	          [{
	            DLOG("Got save call for " + str(_this));
	           	if(! local player) exitWith {};            
	          	[player] call AVD_fnc_db_savePlayer;
	            
	          }, [], _x] call AVD_fnc_remote_execute;  
	        } else {
	            DLOG("Not saving coz of nil foo.");
			};      
	    } foreach playableUnits;
	};
}] call CBA_fnc_addEventHandler;
*/