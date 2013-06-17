
enableSaving false;

#define SELF "x_avd\init.sqf"
#include "include\avd.h"
#include "include\db.h"

AVD_WORLD_SERVER_INIT = false;

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
  [] spawn {
      
	  if(isNIL "AVD_D_CLIENT_CIV") then { AVD_D_CLIENT_CIV = AVD_SERVER; publicVariable "AVD_D_CLIENT_CIV"; DLOG("AVD_D_CLIENT_CIV is server."); };
	  if(isNIL "AVD_D_CLIENT_EAST") then { AVD_D_CLIENT_EAST = AVD_SERVER; publicVariable "AVD_D_CLIENT_EAST"; DLOG("AVD_D_CLIENT_EAST is server."); };
	  if(isNIL "AVD_D_CLIENT_WEST") then { AVD_D_CLIENT_WEST = AVD_SERVER; publicVariable "AVD_D_CLIENT_WEST"; DLOG("AVD_D_CLIENT_WEST is server."); };
	  if(isNIL "AVD_D_CLIENT_GUER") then { AVD_D_CLIENT_GUER = AVD_SERVER; publicVariable "AVD_D_CLIENT_GUER"; DLOG("AVD_D_CLIENT_GUER is server."); };
	  
	  HC_CLIENTS = [AVD_D_CLIENT_CIV, AVD_D_CLIENT_EAST, AVD_D_CLIENT_WEST, AVD_D_CLIENT_GUER];
	  //publicVariable "HC_CLIENTS";


  	["avd_network_opc", {
        if(!isServer) exitWith {};
        private ["_player", "_hc", "_owner", "_list"];
    	_player = _this select 0;
        _list = allUnits + allDead;
        if(_player in HC_CLIENTS) then {
          // omfg, we're loosing a headless client.
          // just for now, we transfer all dead and alive units
          // onto the server. this will be extended to transfer
          // the units to another hc.
          DLOG("Alert! We have lost a headless client.");
          DLOG("Trying to transfer all of his units to the server");
          _hc = owner _player;
          {
              if((owner _x) == _hc) then {
                  DLOG("Transfering unit " + str(_x) + "..");
              	  if(_x setOwner (owner AVD_SERVER)) then {
                    DLOG("success!");  
                  } else {
                  	DLOG("error!");
                  };
              };
          } foreach _list;
        };
    	    
	}] call CBA_fnc_addEventHandler;
  };
            
};


call compile preprocessFile "x_avd\lib\init.sqf";

/*
["avd_unit_zone_activated", {
    DLOG("location enter: " + str(_this));
}] call CBA_fnc_addEventHandler;
["avd_unit_zone__deactivated", {
    DLOG("location deactivated: " + str(_this));
}] call CBA_fnc_addEventHandler;
*/
diag_log "";
diag_log "";
DLOG("Initializing AVD World " + AVD_META_VERSION);
diag_log "";
diag_log "";


//DLOG("Initializing UPSMON.");
//call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";	


if(isServer) then {
	execVM "x_avd\server.sqf";  
};

if(! isDedicated) then {
    execVM "x_avd\client.sqf";
};



//["avdworld", "server", "starttime", date] call iniDB_write;


//DB_SAVE(player);
//DB_LOAD(getPlayerUID player, ["position", "alive"]);
//DB_WRITE("asd", "starttime", date);
