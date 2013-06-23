
#define SELF "x_avd\lib\im\events.sqf"
#define PATH "x_avd\lib\im"
#include "include\avd.h"
#include "include\crimes.h"

DLOG("Adding avd_unit_create eventhandler");
// generate identity
["avd_unit_create", {
    //DLOG("set identity: " + str(_this));
    private ["_unit"];
    _unit = _this select 0;
	if(!isServer) exitWith {};
    if(isPlayer _unit) exitWith { DLOG("IS PLAYER"); };
    
    private "_var";
    _var = _unit getVariable "avd_identity";
    if(!isNil "_var") exitWith { DLOG("HAS IDENTITY"); };
   
  	private ["_age", "_brave"];
    
    _age = floor((((random 0.3) + 0.2) * 100));
    _unit setVariable ["avd_identity_age", _age, true];
    
    _brave = random 1;
    _unit setVariable ["avd_identity_brave", _brave, true];
    
    //DLOG("Unit " + str(_unit) + " created");
	[_unit, format["%2_%1", typeOf _unit, _unit]] call AVD_fnc_trackingMarker;
}] call CBA_fnc_addEventHandler;

/*
["avd_cron", {
 
}] call CBA_fnc_addEventHandler;

  */
DLOG("Adding avd_unit_killed eventhandler");

["avd_unit_killed", {
    if(!isServer) exitWith {};
    _this spawn { 
	private ["_unit", "_killer"];
    DLOG("FOO: " + str(_this));
    _unit = PARAM(0,nil);
    _killer = PARAM(1,nil);
    _str = format["Unit killed: %1 - %2", _unit, _killer];
   	DLOG(_str);
    

 
    //if(! local _unit) exitWith { DLOG("NOT LOCAL"); };
    if(side _unit != civilian) exitWith { DLOG("NOT CIVILIAN"); };
    if(_unit == _killer) exitWith { DLOG("SUICIDE"); };
    
                   
    // get all units in a circle of viewDistance
    private ["_list", "_crimeid"];
    _list = position _killer nearObjects ["Man", viewDistance];
    _crimeid = call AVD_fnc_getIndex;
	{
     
        _brave = _x getVariable "avd_identity_brave";
        if(isNil "_brave") then { _brave = random 1; };
        _knows = _x knowsAbout _killer;
        _distance = _x distance _killer;
        //DLOG("OMFG, " + str(_killer) + " has killed " + str(_unit) + ", distance: " + str(_distance) + ", knows: " + str(_knows) + "I (" + str(_x) + ")");
        if(_knows > 3.5) then {
            	if(_brave > 0.4) exitwith {
                    DLOG("OMFG, " + str(_killer) + " has killed " + str(_unit) + ", distance: " + str(_distance) + ", knows: " + str(_knows) + "I (" + str(_x) + ") will report!");
                	//[east, getPos _unit, 10, _x, _unit, 187, _killer, 3] call AVD_fnc_im_reportCrime;
                    ["avd_unit_crime_report_try", [_crimeid, _x, getPos _unit, 10, _unit, _killer, 187]] call CBA_fnc_globalEvent;  
				};  
 
        } else {
           // DLOG("unit: " + str(_x) + ", brave: " + str(_brave) + ", knows: " + str(_knows) + ", distance: " + str(_distance));
		};
    } foreach _list;
    };
}] call CBA_fnc_addEventHandler;
DLOG("Adding avd_unit_crime_report_try eventhandler");

["avd_unit_crime_report_try", {
    if(! local (_this select 1)) exitWith {};
    _this spawn {
	    private ["_crimeid", "_reporter", "_pos", "_radius", "_victim", "_committer", "_code", "_side"];
        _crimeid = PARAM(0, nil);
	    _reporter = PARAM(1, nil);
	    _pos = PARAM(2, nil);
	    _radius = PARAM(3, nil);
	    _victim = PARAM(4, nil);
	    _committer = PARAM(5, nil);
	    _code = PARAM(6, 0);
	    
        if(isNil "_crimeid") exitWith {};
	    if(isNil "_reporter") exitWith {};
	    
	    _side = side _reporter;
	    
	    if(!local _reporter) exitWith {};
	    
        // shock
        sleep random 2;
	    
	    // okay, find the next spot to report a crime.
	    private "_foundReportSpot";
        _foundReportSpot = getPos _reporter;
        waitUntil { !isNil "_foundReportSpot" and alive _reporter };
        if(!alive _reporter) exitWith {};
        ["avd_unit_crime_report", _this] call CBA_fnc_globalEvent;
	  
    };
    
    
}] call CBA_fnc_addEventHandler;
DLOG("Adding avd_unit_crime_report eventhandler");

["avd_unit_crime_report", {
    if(! local (_this select 1)) exitWith {};
    _this spawn {
	    private ["_crimeid", "_reporter", "_pos", "_radius", "_victim", "_committer", "_code", "_side"];
        _crimeid = PARAM(0, nil);
	    _reporter = PARAM(1, nil);
	    _pos = PARAM(2, nil);
	    _radius = PARAM(3, nil);
	    _victim = PARAM(4, nil);
	    _committer = PARAM(5, nil);
	    _code = PARAM(6, 0);
	    
        if(isNil "_crimeid") exitWith {};
	    if(isNil "_reporter") exitWith {};
	    
	    _side = side _reporter;
	    
	    if(!local _reporter) exitWith {};
	    
        DLOG(str(_code) + " REPORTED!");  
        ["CRIMES", _crimeid, _this, 1000] call AVD_fnc_queue_add;
	  
    };
}] call CBA_fnc_addEventHandler;

["avd_cron", {
    private ["_queue", "_next"];
    _next = ["CRIMES"] call AVD_fnc_queue_next;
    
    if(isNil "_next") exitWith {};
    
    DLOG("Next in CRIME queue: " + str(_next));
    _args = [_next, "args"] call CBA_fnc_hashGet;
    _code = _args select 6;
    DLOG("Crime with code: " + str(_code));
    
    //[325,var_47,[2916.98,6093.55,0.00158119],10,var_188,player_76561198014901266,187]
    
    DLOG("187 Detected!");  
    _args call AVD_fnc_im_handleCrime;
    
    
        
}] call CBA_fnc_addEventHandler;