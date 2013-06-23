#define SELF "x_avd\lib\im.sqf"
#include "include\avd.h"
#include "include\arrays.h"

AVD_fnc_im_canIdentify = {
  private ["_target"];
  _target = _this select 0;
  
  if(ITEM_PASSPORT in magazines _target) exitWith { true; };
  
  false;  
};


AVD_fnc_im_reportCrime = {
    
  private ["_side", "_position", "_radius", "_reporter", "_victim", "_code", "_commiter", "_state", "_date"];
  
  _side = PARAM(0, east);
  
  _position = PARAM(1, getPos player);
  
  _radius = PARAM(2, 10000);
  _reporter = PARAM(3, objNull);
  _victim = PARAM(4, objNull);
  _code = PARAM(5, 415); // see http://en.wikipedia.org/wiki/Police_code
  _committer = PARAM(6, objNull);
  _state = PARAM(7, 0); // 0 = unknown, 1 = pre, 2 = in progress, 3 = post, 4 = future
  _date = PARAM(8, date);
  
  private "_str";
  _str = format["[%1] crime reported from %2 at position %7 (radius: %8). Code is %3, victim: %4. Current state is %5 and date %6", _side, _reporter, _code, _victim, _state, _date, _position, _radius];
  DLOG(_str);
  ["avd_im_crime_report", [_side, _position, _radius, _reporter, _victim, _code, _committer, _state, _date]] call CBA_fnc_globalEvent;
};

AVD_fnc_im_handleCrime = {
    DLOG("Handle crime: " + str(_this));
  //[325,var_47,[2916.98,6093.55,0.00158119],10,var_188,player_76561198014901266,187]
  private ["_queueid", "_reporter", "_position", "_radius", "_victim", "_target", "_code", "_rside", "_vside", "_tside"];
  _queueid = PARAM(0, nil);
  _reporter = PARAM(1, nil);
  _position = PARAM(2, nil);
  _radius = PARAM(3, nil);
  _victim = PARAM(4, nil);
  _target = PARAM(5, nil);
  _code = PARAM(6, nil);
  
  _rside = side _reporter;
  _vside = side _victim;
  _tside = side _target;
  
  switch(_code) do {
    case 187: {
        DLOG("187! Arresting!");
		_this call AVD_fnc_im_arrest;        
    };
    default {
        DLOG("Arresting!");
		_this call AVD_fnc_im_arrest; 
    };
  };
    
        
};




AVD_fnc_im_arrest = {
  DLOG(_this);
  private ["_queueid", "_reporter", "_position", "_radius", "_victim", "_target", "_code", "_rside", "_vside", "_tside", "_side"];
  _queueid = PARAM(0, nil);
  _reporter = PARAM(1, nil);
  _position = PARAM(2, nil);
  _radius = PARAM(3, nil);
  _victim = PARAM(4, nil);
  _target = PARAM(5, nil);
  _code = PARAM(6, nil);
  
  _rside = side _reporter;
  _vside = side _victim;
  _tside = side _target;
  
  _array = [];
  switch(_vside) do {
      case WEST: {	
        _array = ["B_medic_F", "B_medic_F", "B_medic_F", "O_MRAP_01_F"];  
      };
      case EAST: {	
        _array = ["O_medic_F", "O_medic_F", "O_medic_F", "O_MRAP_02_F"];  
      };
      default {
        _array = ["O_medic_F", "O_medic_F", "O_medic_F", "O_MRAP_02_F"];
        _vside = east; 
      };
  };
  _side = _vside;
  _road = [_target, 500] call AVD_fnc_getDistantRoad;
  DLOG("Got Road: " + str(_road) + ", distance " + str((_road select 0) distance _target));
  
  _pos = position (_road select 0);
  _dir = [(_road select 0), (_road select 1)] call BIS_fnc_DirTo;
  _group = createGroup _side;
  DLOG("Creating leader: " + str(_array select 0));
  _leader = _group createUnit[(_array select 0), _pos, [], 0, ""];
  _leader disableAI "AUTOTARGET";
  DLOG("Got Leader " + str(_leader));
  _group selectLeader _leader;
  DLOG("Creating sol1: " + str(_array select 1));
  _sol1 = _group createUnit[(_array select 1), _pos, [], 0, ""];
  _sol1 disableAI "AUTOTARGET";
  DLOG("Creating sol2: " + str(_array select 2));
  _sol2 = _group createUnit[(_array select 2), _pos, [], 0, ""];
  _sol2  disableAI "AUTOTARGET";
  _group setBehaviour "CARELESS";
  _vec = (_array select 3) createVehicle _pos;
  _vec setDir _dir;
  _sol1 moveInDriver _vec;
  _leader moveInCargo _vec;
  _sol2 moveInCargo _vec;
  _leader setVariable ["avd_im_arrest_vehicle", _vec, true];
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
            
            	if(!isPlayer _target) then {
                        _brave = _target getVariable "avd_identity_brave";
                        if(isNil "_brave") then {
                          _brave = random 1;  
                        };
                        if(random 1 < _brave) then {
                            DLOG("I will flee motherfucker!");
                            _target setVariable ["avd_im_arrest_flee", true, true];
                        }; 
            	} else {
                    // add player action.
                    _target setVariable ["avd_im_arrest_flee", true, true];
                };
                
                // wait 5 seconds to react.
                sleep 5;
                private "_d";
                _d = _target getVariable "avd_im_arrest_flee";
                if(isNil "_d") then { _d = false; };
                
                if(_d) then {
                  // target wants to flee, shoot.  
                  _leader commandFire _target; 
                } else {
                  // arrest target
                  if(isPlayer _target) exitWith { DLOG("not working on player yet."); };
                  
                 _target playMoveNow ANIM_HANDCUFF;
                };
                
                private "_time";
                
                _target attachTo [_leader, [-0.3, 0.2, 0]];
                _target setVariable ["avd_im_arrested_attached", true, true];
                [_target, _leader] spawn {
                	waitUntil {
                      _var = (_this select 0) getVariable "avd_im_arrested_attached";
                      if(!isNil "_var" and !_var) exitWith {};
                      (_this select 0) playMove animationState (_this select 1);
                      sleep 0.5;
                      !(alive (_this select 0)) or !(alive (_this select 1));  
                    };  
                    detach (_this select 0);                  
                };
                
                _leader setVariable ["avd_im_arrested_attached_target", _target, true];
                
                
                
                
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


call compileFinal preprocessFileLineNumbers "x_avd\lib\im\init.sqf";