#define SELF "x_avd\lib\tasks.sqf"
#include "include\avd.h"

AVD_TASKS = [] call CBA_fnc_hashCreate;

["avd_task_success", {
	private ["_id", "_hash"];
    _id = PARAM(0, nil);
    _hash = PARAM(1, nil);
    _members = [_hash, "members"] call CBA_fnc_hashGet;
    DLOG("Task " + str(_id) + " succeeded. members: " + str(_members));
    {
        
    }

}] call CBA_fnc_addEventHandler;

AVD_fnc_tasks_update = {
    [{
	    private["_id", "_hash"];
	    _id = PARAM(0, nil);
	    _hash = PARAM(1, nil);
	    [AVD_TASKS, _id, _hash] call CBA_fnc_hashSet;

  	}, _this, AVD_SERVER] call AVD_fnc_remote_execute;  
};

AVD_fnc_tasks_create = {
    [{
        if(!isServer) exitWith {};
	private ["_unit", "_name", "_position", "_winCond", "_loseCond", "_won", "_lost", "_codeToWin", "_id", "_hash"];
	_unit = PARAM(0, nil);
    if(isNil "_unit") exitWith { ERROR("Won't create a task for a nil object."); };
    _name = PARAM(1, nil);
    if(isNil "_name") exitWith { ERROR("A task needs a name."); };
    _position = PARAM(2, getPos _unit);
    _winCond = PARAM(3, { true });
    _loseCond = PARAM(4, { false });
    _won = PARAM(5, {});
    _lost = PARAM(6, {});
    _codeToWin = PARAM(7, {});
    _id = call AVD_fnc_getIndex;
    _hash = [] call CBA_fnc_hashCreate;
    
    [_hash, "id", _id] call CBA_fnc_hashSet;
    [_hash, "name", _name] call CBA_fnc_hashSet;
    [_hash, "winCond", _winCond] call CBA_fnc_hashSet;
    [_hash, "loseCond", _loseCond] call CBA_fnc_hashSet;
    [_hash, "won", _won] call CBA_fnc_hashSet;
    [_hash, "lost", _lost] call CBA_fnc_hashSet;
    [_hash, "codeToWin", _codeToWin] call CBA_fnc_hashSet;
    [_hash, "members", [_unit]] call CBA_fnc_hashSet;
	[AVD_TASKS, _id, _hash] call CBA_fnc_hashSet;
	DLOG("Task " + str(_name select 0) + " for " + str(player) + " created.	");    

    
    //if(isPlayer _unit) then {
    	[{
        	private ["_task", "_hash", "_id", "_members", "_name", "_position"];
            _hash = _this;
            _id = [_hash, "id"] call CBA_fnc_hashGet;
            _members = [_hash, "members"] call CBA_fnc_hashGet;
            _name = [_hash, "name"] call CBA_fnc_hashGet;
            _position = [_hash, "position"] call CBA_fnc_hashGet;
            {
			    _task = _x createsimpletask [str(_id)];
				_task setsimpletaskdescription [_name select 0, _name select 1, _name select 2];
				_task setsimpletaskdestination _position;
				_task settaskstate "Created";     
                ["TaskCreated", _name] call bis_fnc_showNotification;     
		     } foreach _members;       
		    [_hash, "task", _task] call CBA_fnc_hashSet;
            [_id, _hash] call AVD_fnc_tasks_update;
			//[nil, nil, _task, "created"] execvm "\ca\modules\mp\data\scriptcommands\taskhint.sqf";
    	}, _hash, _unit] call AVD_fnc_remote_execute;
    //};
    
    [{
        if(!isServer) exitWith {};
   		 private ["_handler"];
	    _handler = (_this select 0) spawn {
            	sleep 5;
	        	private ["_hash", "_unit", "_name", "_position", "_winCond", "_loseCond", "_won", "_members", "_lost", "_id", "_exit", "_task"];
	            _hash = _this;
	            _name = [_hash, "name"] call CBA_fnc_hashGet;
	            _winCond = [_hash, "winCond"] call CBA_fnc_hashGet;
	            _loseCond = [_hash, "loseCond"] call CBA_fnc_hashGet;
	            _won = [_hash, "won"] call CBA_fnc_hashGet;
	            _lost = [_hash, "lost"] call CBA_fnc_hashGet;
                _task = [_hash, "task"] call CBA_fnc_hashGet;
	            _id = [_hash, "id"] call CBA_fnc_hashGet;
                DLOG("Creating Task Timer " + str(_id));
	    	    waitUntil {
	            	_members = [_hash, "members"] call CBA_fnc_hashGet;  
	            	_resWin = call _winCond;
	                _resLose = call _loseCond;
	                DLOG("Task Timer " + str(_name) + ": winCond: " + str(_resWin) + ", loseCond: " + str(_resLose));
	                if(_resWin) exitWith {
                        DLOG("Task " + str(_id) + " completed!"); 
                    	["avd_task_success", [_id, _hash]] call CBA_fnc_globalEvent;
                        DLOG("Event fired. " + str(_id) + ", " + str(_hash));
                        true; 
                    };
	                if(_resLose) exitWith {
                        DLOG("Task " + str(_id) + " failed!");
                    	["avd_task_fail", [_id, _hash]] call CBA_fnc_globalEvent;
                        DLOG("Event fired. " + str(_id) + ", " + str(_hash));
                        true; 
                    };
                    
	                sleep (random 1);
	                false;
	            };
	    };
  		call compile format["AVD_TASK_CHECKER_%1 = _handler; publicVariable ""AVD_TASK_CHECKER_%1"";", _this select 1];
    }, [_hash, _id], AVD_SERVER] call AVD_fnc_remote_execute;
    
	}, _this, AVD_SERVER] call AVD_fnc_remote_execute;
    
};

/*

_taskId = [player, "Attack die Emma", "Du musst die Emma attackieren! Gehe zu dem marker <t marker='foo'>bla</marker>", false, { !alive emma }, { sleep 3600; alive emma }] call AVD_fnc_tasks_create;
            
["avd_task_completed", {
    private ["_taskId", "_task"];
    _taskId = _this select 0;
    _task = _this select 1;
    _associatedWith = [_taskId] call AVD_fnc_tasks_getAssociatedWith;
    // ....
    
}] call CBA_fnc_addEventHandler;
["avd_task_failed", {
    private ["_taskId", "_task"];
    _taskId = _this select 0;
    _task = _this select 1;
    _associatedWith = [_taskId] call AVD_fnc_tasks_getAssociatedWith;
    // ....
    
}] call CBA_fnc_addEventHandler;
*/