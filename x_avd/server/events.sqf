#define SELF "x_avd\server\events.sqf"
#define PATH "x_avd\server"
#include "include\avd.h"

["avd_cron", {
    private ["_time", "_offset", "_format", "_avgOffset", "_count", "_avg"];
    _avgOffset = missionNamespace getVariable "avd_cron_check_avgoffset";
    _count = missionNamespace getVariable "avd_cron_check_count";
    if(isNil "_avgOffset") then {
      _avgOffset = 0;  
    };
    if(isNil "_count") then {
      _count = 1;  
    };
    _offset = time % 60;
    _avg = _avgOffset + _offset;
    missionNamespace setVariable["avd_cron_check_avgoffset", _avg];
    missionNamespace setVariable["avd_cron_check_count", (_count + 1)];
    _format = format["offset: %1 (avg: %8), allGroups: %9, allUnits: %2, allDead: %3, vehicles: %4, players: %5, fps: %6, fpsmin: %7", _offset, count(allUnits), count(allDead), count(vehicles), count(playableUnits), diag_fps, diag_fpsmin, (_avg / _count), count(allGroups)];
    DLOG(_format);
}] call CBA_fnc_addEventHandler;