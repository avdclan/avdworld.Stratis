#define SELF "x_avd\events.sqf"
#include "include\avd.h"

#include "lib\im\events.sqf"

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

["avd_network_opc", {
    [{
    private ["_player"];
    _player = _this select 0;
    //execVM "x_avd\player\setup.sqf";
    }, _this, (_this select 0), false] call AVD_fnc_remote_execute;
    
}] call CBA_fnc_addEventHandler;

["avd_unit_create", {
    private ["_unit"];
    _unit = _this select 0;
    if(! local _unit) exitWith {};
    
    _unit addEventHandler ["killed", { ["avd_unit_killed", _this] call CBA_fnc_globalEvent; }]; 
	_unit addEventHandler ["hit", { ["avd_unit_hit", _this] call CBA_fnc_globalEvent; }];
    
}] call CBA_fnc_addEventHandler;

["avd_unit_killed", {
  //  DLOG("KILLED: " + str(_this));
}] call CBA_fnc_addEventHandler;
["avd_unit_hit", {
  //  DLOG("HIT: " + str(_this));
}] call CBA_fnc_addEventHandler;

