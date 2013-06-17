#define SELF "x_avd\scripts\arrest.sqf"
#include "include\avd.h"


AVD_fnc_arrest = {
  DLOG(_this);
  private ["_target", "_side", "_group", "_leader", "_sol1", "_sol2", "_array", "_road", "_vec", "_pos", "_dir"];
  _target = _this select 0;  
  _side = _this select 1;
  _array = [];
  switch(_side) do {
      case WEST: {	
        _array = ["B_Soldier_TL_F", "B_Soldier_F", "B_medic_F", "B_Hunter_F"];  
      };
      case EAST: {	
        _array = ["O_Soldier_TL_F", "O_Soldier_F", "O_medic_F", "O_Ifrit_F"];  
      };
      default {
        _array = ["C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F", "c_offroad"];
      };
  };
  
  _road = [_target, 500] call AVD_fnc_getDistantRoad;
  DLOG("Got Road: " + str(_road) + ", distance " + str((_road select 0) distance _target));
  
  _pos = position (_road select 0);
  _dir = [(_road select 0), (_road select 1)] call BIS_fnc_DirTo;
  _group = createGroup _side;
  
  _leader = _group createUnit[(_array select 0), _pos, [], 0, ""];
  _leader disableAI "AUTOTARGET";
  DLOG("Got Leader " + str(_leader));
  _group selectLeader _leader;
  _sol1 = _group createUnit[(_array select 1), _pos, [], 0, ""];
  _sol1 disableAI "AUTOTARGET";
  _sol2 = _group createUnit[(_array select 2), _pos, [], 0, ""];
  _sol2  disableAI "AUTOTARGET";
  _group setBehaviour "CARELESS";
  _vec = (_array select 3) createVehicle _pos;
  _vec setDir _dir;
  _sol1 moveInDriver _vec;
  _leader moveInCargo _vec;
  _sol2 moveInCargo _vec;
 // player moveInCargo _vec;
  
  [_leader] call AVD_fnc_trackingMarker;
  _leader doMove getPos _target;
	[_leader, _target] spawn {
     	private ["_leader", "_target", "_vec", "_driver", "_group", "_sols", "_road"];
        _leader = _this select 0;
        _target = _this select 1;
        _target stop true;
        _group = group _leader;
        _sols = units _group;
        _sols = _sols - [_leader];
        DLOG("Sending " + str(_leader) + " to " + str(_target));
        _road = [_target, 1000] call AVD_fnc_getNearestRoad;
        DLOG(str(_road));
        DLOG(str(position (_road select 0)));
        DLOG(str(getPos _target));
        DLOG(str(_target distance (_road select 0)));
        _wp = (group _leader) addwaypoint [position (_road select 0), 100, 1];  
		_wp setWaypointType "GETOUT";
        _wp setWaypointBehaviour "CARELESS";
        _wp setWaypointSpeed "NORMAL";
        _wp setWaypointCombatMode "GREEN";
        _group setCurrentWaypoint _wp;
       
         _wp = [_group, getPos _target, {
            private ["_wp", "_leader", "_list", "_args", "_target", "_res"];
            _radius = _this select 0;
            _leader = _this select 1;
            _list = _this select 2;
            _args = _this select 3;
            _target = _args select 0;
            _res = (_leader distance _target) < _radius;
            _res;
            
        }, [_target], { 
        	_this spawn {
                DLOG("GO GO TARGET " + str(_this));
        	private ["_wp", "_leader", "_list", "_args", "_target", "_res", "_units", "_group"];
            _radius = _this select 0;
            _leader = _this select 1;
            _list = _this select 2;
            _args = _this select 3;
            _target = _args select 0;
            _group = group _leader;
            _units = units _group;
            //_units = _units - [_leader];
            {
                doStop _x;
                _x doTarget _target;
                [_x, format["%1, get on the ground! Don't move or you get shot! You have the permission to shut the fuck up!", name _target]] call AVD_fnc_say; 
                DLOG("Setting target for " + str(_x) + " to " + str(_target));
                
            } foreach _units;
            };
              
        }, [_target], 20] call AVD_fnc_waypoint_add;
        _wp setWaypointBehaviour "AWARE";
        _wp setWaypointSpeed "NORMAL";  
		_wp setWaypointType "MOVE";
        _wp setWaypointCombatMode "GREEN";
        /*
        _wp = (group _leader) addwaypoint [getPos _target, 20, 2];
        _wp setWaypointBehaviour "AWARE";
        _wp setWaypointSpeed "NORMAL";  
		_wp setWaypointType "MOVE";
        _wp setWaypointCombatMode "GREEN";
        _wp setWaypointStatements[format["(this distance %1) < 20", _target], format["hint '20'; { _x doTarget %1; } foreach units group this;", _target]];
        
        
        
        _wp = _group addWaypoint [getPos _target, 1, 3];
       	_wp setWaypointBehaviour "AWARE";
        _wp setWaypointCombatMode "GREEN";
        _wp setWaypointSpeed "LIMITED";
        _wp setWaypointStatements[format["(this distance %1) <= 2", _target], "hint 'arrest him!'"];
        _group setCurrentWaypoint _wp;
        */
        
        
        
          
    };
  
};

