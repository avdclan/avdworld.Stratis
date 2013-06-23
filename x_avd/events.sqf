if(!isServer) exitWith {};
#define SELF "x_avd\events.sqf"
#include "include\avd.h"

#include "lib\im\events.sqf"
#include "components\spawn\events.sqf"

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

["avd_vehicle_create", {
    private ["_unit"];
    _unit = _this select 0;
	_unit setVariable ["avd_xeh_init", true, true];
    
}] call CBA_fnc_addEventHandler;
["avd_unit_create", {
    DLOG("Creating unit: " + str(_this));
	private ["_unit", "_varName"];
	_unit = _this select 0;
	//if(!ocal _unit) exitWith {};
	if(isNull _unit) then {
	  _counter = 0;
	  waitUntil {
	  	!isNull _unit
	  };  
	};
	if(isPlayer _unit) exitWith { 
		//[format["Not running on player %1", _unit], "XEH-unit"] call AVD_fnc_log;
	    _var = format["player_%1", getPlayerUID player];
		[_unit,  _var] call AVD_fnc_setVehicleVarName;    
	    DLOG("Having player, calling event avd_player_create");
		["avd_player_create", [_unit]] call CBA_fnc_globalEvent; 
	};
	_varName = vehicleVarName _unit;
	if(_varName == "") then {    
	  _varName = call AVD_fnc_getValidVarName;
	  [_unit, _varName] call AVD_fnc_setVehicleVarName;
	  DLOG("Setting varName to " + str(_varName));
	};
	
	
	DLOG("Calling avd_unit_create event with " + str(_unit));
	_unit setVariable ["avd_xeh_init", true, true];
    _unit addEventHandler ["killed", { ["avd_unit_killed", _this] call CBA_fnc_globalEvent; }]; 
	_unit addEventHandler ["hit", { ["avd_unit_hit", _this] call CBA_fnc_globalEvent; }];
    
}] call CBA_fnc_addEventHandler;

["avd_unit_killed", {
  //  DLOG("KILLED: " + str(_this));
}] call CBA_fnc_addEventHandler;
["avd_unit_hit", {
  //  DLOG("HIT: " + str(_this));
}] call CBA_fnc_addEventHandler;

["avd_cron", {
    if(!isServer) exitWith {};
    
    if(((date select 4) % 5) == 0 or time < 62) then {
	DLOG("Fixing units. ");
	    	{
	        	_var = _x getVariable "avd_xeh_init";
	        	if(isNil "_var") then {
	            	DLOG("Fixing unit " + str(_x));
	          		["avd_unit_create", [_x]] call CBA_fnc_globalEvent;  
	        	};
	    	} foreach allUnits;
	    
	    	{
	        	_var = _x getVariable "avd_xeh_init";
	        	if(isNil "_var") then {
	          	DLOG("Fixing vehicle " + str(_x));
	          	["avd_vehicle_create", [_x]] call CBA_fnc_globalEvent;  
	        	};
	    	} foreach vehicles;
	    
	};
}] call CBA_fnc_addEventHandler;