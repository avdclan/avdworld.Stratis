#define SELF "x_avd\init.sqf"
#include "include\avd.h"
#include "include\db.h"

diag_log "";
diag_log "";
DLOG("Initializing AVD World " + AVD_META_VERSION);
diag_log "";
diag_log "";
AVD_WORLD_SERVER_INIT = false;

AVD_LOCATION_EXCLUDE=["Stratis Air Base", "Kamino Firing Range", "Pythos"];

civilian setFriend [west, 0];
civilian setFriend [east, 0.7];
civilian setFriend [resistance, 0.8];

west setFriend[civilian, 1];
west setFriend[east, 0.7];
west setFriend[resistance, 0];

east setFriend[civilian, 1];
east setFriend[west, 0.7];
east setFriend[resistance, 0];

resistance setFriend[civilian, 1];
resistance setFriend[east, 0];
resistance setFriend[west, 0];

if(isServer) then {
  AVD_SERVER = (createGroup sideLogic) createUnit["LOGIC", [0, 0, 0], [], 0, ""];
  publicVariable "AVD_SERVER";
      
	  if(isNIL "AVD_D_CLIENT_CIV") then { AVD_D_CLIENT_CIV = AVD_SERVER; publicVariable "AVD_D_CLIENT_CIV"; DLOG("AVD_D_CLIENT_CIV is server."); };
	  if(isNIL "AVD_D_CLIENT_EAST") then { AVD_D_CLIENT_EAST = AVD_D_CLIENT_CIV; publicVariable "AVD_D_CLIENT_EAST"; DLOG("AVD_D_CLIENT_EAST is server."); };
	  if(isNIL "AVD_D_CLIENT_WEST") then { AVD_D_CLIENT_WEST = AVD_D_CLIENT_EAST; publicVariable "AVD_D_CLIENT_WEST"; DLOG("AVD_D_CLIENT_WEST is server."); };
	  if(isNIL "AVD_D_CLIENT_GUER") then { AVD_D_CLIENT_GUER = AVD_D_CLIENT_GUER; publicVariable "AVD_D_CLIENT_GUER"; DLOG("AVD_D_CLIENT_GUER is server."); };
	  
	  HC_CLIENTS = [AVD_D_CLIENT_CIV, AVD_D_CLIENT_EAST, AVD_D_CLIENT_WEST, AVD_D_CLIENT_GUER];
	  //publicVariable "HC_CLIENTS";


  

            
};



[] spawn {
call compile preprocessFile "x_avd\lib\init.sqf";
waitUntil { !isNil "AVD_lib_init" };
/*
["avd_unit_zone_activated", {
    DLOG("location enter: " + str(_this));
}] call CBA_fnc_addEventHandler;
["avd_unit_zone__deactivated", {
    DLOG("location deactivated: " + str(_this));
}] call CBA_fnc_addEventHandler;
*/



//DLOG("Initializing UPSMON.");
//call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";	


if(isServer) then {
	execVM "x_avd\server.sqf";
};

if(hasInterface) then {
    execVM "x_avd\player\setup.sqf";
};


//["avdworld", "server", "starttime", date] call iniDB_write;


//DB_SAVE(player);
//DB_LOAD(getPlayerUID player, ["position", "alive"]);
//DB_WRITE("asd", "starttime", date);
};