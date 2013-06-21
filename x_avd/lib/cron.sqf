#define SELF "x_avd\lib\cron.sqf"
#include "include\avd.h"


// run only on server.
if(isServer) then {
  
  if(! isNil "AVD_CRON_DAEMON") exitWith {
    DLOG("Cron already running.");  
  };
  
  AVD_CRON_DAEMON = [] spawn {
    waitUntil {
        
        _args = [date];
        DLOG("Calling cron." + str(_args));
		["avd_cron", _args] call CBA_fnc_globalEvent;     
      	sleep 60;
        false;  
    };
  };
    
        
};