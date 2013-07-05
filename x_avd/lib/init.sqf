call compileFinal preprocessFileLineNumbers "x_avd\lib\debug.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\common.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\queue.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\cron.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\remote.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\db.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\component.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\trigger.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\cache.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\road.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\tasks.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\waypoint.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\group.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\military.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\im.sqf";



call compileFinal preprocessFileLineNumbers "x_avd\lib\scripts\arrest.sqf";
call compileFinal preprocessFileLineNumbers "x_avd\lib\scripts\switchUnitGear.sqf";

call compileFinal preprocessFile "x_avd\lib\precompile.sqf";


call compileFinal preprocessFileLineNumbers "x_avd\lib\ext.sqf";

AVD_lib_init = true;