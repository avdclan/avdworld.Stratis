#define SELF "x_avd\lib\cron.sqf"
#include "include\avd.h"


// run only on server.
if(isServer) then {
  
  if(! isNil "AVD_CRON_DAEMON") exitWith {
    DLOG("Cron already running.");  
  };
  
  AVD_CRON_DAEMON = [] spawn {
   private ["_sleep", "_nextRun"];
   waitUntil { time > 0 };
   DLOG("Starting CRON Daemon");
    waitUntil {
        _time = time;
        _nextRun = floor(time + 60);
        _args = [date];
        DLOG("Calling cron." + str(_args));
		["avd_cron", _args] call CBA_fnc_globalEvent;
        _took = time - _time;
        DLOG("Cron took " + str(_took) + " seconds.");
        if(_took >= 60) then {
          ERROR("Cron jobs are consuming more than 60 minutes. Consider tweaking!");  
        };
        _mod = time	 % 60;
        _sleep = 60 - _mod;
        DLOG("Adjusted sleep: " + str(_sleep));     
      	sleep _sleep;
        false;  
    };
  };
    
        
};