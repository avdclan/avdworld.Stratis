#define SELF "init.sqf"
#include "x_avd\include\avd.h"
AVD_VOID_LOADED = true;


//waitUntil { time >= 1 };
diag_log "";
diag_log "";
DLOG("Initializing AVD World " + AVD_META_VERSION + ", on " + missionName);
diag_log "";
diag_log "";
AVD_LOCATION_EXCLUDE=["Stratis Air Base", "Kamino Firing Range", "Pythos"];

civilian setFriend [west, 0];
civilian setFriend [east, 0.7];
civilian setFriend [resistance, 0.8];

west setFriend[civilian, 1];
west setFriend[east, 0.1];
west setFriend[resistance, 0];

east setFriend[civilian, 1];
east setFriend[west, 0];
east setFriend[resistance, 0];

resistance setFriend[civilian, 1];
resistance setFriend[east, 0];
resistance setFriend[west, 0];

onPlayerConnected "[_id, _name] execVM ""x_avd\onPlayerConnected.sqf""";
onPlayerDisconnected "[_id, _name] call compile preprocessFileLineNumbers ""x_avd\onPlayerDisconnected.sqf""";


DLOG("Waiting for mission to start.");
waitUntil { time > 0 };

if(isServer) then {

      
	  if(isNIL "AVD_D_CLIENT_CIV") then { AVD_D_CLIENT_CIV = AVD_SERVER; publicVariable "AVD_D_CLIENT_CIV"; DLOG("AVD_D_CLIENT_CIV is server."); };
	  if(isNIL "AVD_D_CLIENT_EAST") then { AVD_D_CLIENT_EAST = AVD_D_CLIENT_CIV; publicVariable "AVD_D_CLIENT_EAST"; DLOG("AVD_D_CLIENT_EAST is server."); };
	  if(isNIL "AVD_D_CLIENT_WEST") then { AVD_D_CLIENT_WEST = AVD_D_CLIENT_EAST; publicVariable "AVD_D_CLIENT_WEST"; DLOG("AVD_D_CLIENT_WEST is server."); };
	  if(isNIL "AVD_D_CLIENT_GUER") then { AVD_D_CLIENT_GUER = AVD_D_CLIENT_WEST; publicVariable "AVD_D_CLIENT_GUER"; DLOG("AVD_D_CLIENT_GUER is server."); };
	  
	  HC_CLIENTS = [AVD_D_CLIENT_CIV, AVD_D_CLIENT_EAST, AVD_D_CLIENT_WEST, AVD_D_CLIENT_GUER];
	  //publicVariable "HC_CLIENTS";      
};



//call compile preprocessFileLineNumbers 'x_avd\events.sqf';
/*if(hasInterface) then {
	startLoadingScreen["Loading AvD World " + AVD_META_VERSION];
};
*/


if(isServer) then {
	execVM "x_avd\server.sqf";
};

if(hasInterface) then {
    execVM "x_avd\client.sqf";
};


//["avdworld", "server", "starttime", date] call iniDB_write;


//DB_SAVE(player);
//DB_LOAD(getPlayerUID player, ["position", "alive"]);
//DB_WRITE("asd", "starttime", date);
finishMissionInit;