#define SELF "x_avd\lib\queue.sqf"
#include "include\avd.h"

AVD_QUEUES = [] call CBA_fnc_hashCreate;


AVD_fnc_queue_add = {
  private ["_name", "_index", "_args", "_myVal", "_prio", "_ttl", "_id", "_queue", "_myHash", "_date", "_ret"];
  _name = PARAM(0, nil);
  if(isNil "_name") exitWith {};
  _id = PARAM(1, nil);
  _args = PARAM(2, nil);
  _prio = PARAM(3, 0);
  _ttl = PARAM(4, 0);
  _date = PARAM(5, date);
  _queue = [_name] call AVD_fnc_queue_getQueue;
  if(isNil "_id") then {
  _id = call AVD_fnc_getIndex;
  };
  
  _ret = [_queue, _id] call CBA_fnc_hashHasKey;
  if(_ret) exitWith { false; };
  _myHash = [] call CBA_fnc_hashCreate;
  [_myHash, "date", date] call CBA_fnc_hashSet;
  [_myHash, "time", time] call CBA_fnc_hashSet;
  [_myHash, "priority", _prio] call CBA_fnc_hashSet;
  [_myHash, "queue", _name] call CBA_fnc_hashSet;
  [_myHash, "args", _args] call CBA_fnc_hashSet;
  [_queue, _id, _myHash] call CBA_fnc_hashSet;
  [AVD_QUEUES, _name, _queue] call CBA_fnc_hashSet;
  
  //DLOG("Added " + str(_myHash) + " to " + str(_queue));
  true;
};

AVD_fnc_queue_next = {
  private ["_name", "_queue", "_ret"];
  _name = PARAM(0, nil);
  if(isNil "_name") exitWith { nil; };
  _queue = [_name] call AVD_fnc_queue_getQueue;
  _n = _queue select 1;
  _args = _queue select 2;
  
  if(count(_n) == 0) exitWith { nil; };
  
  
  _ret = [_queue, _n select 0] call CBA_fnc_hashGet;
  [_queue, _n select 0, nil] call CBA_fnc_hashSet;
  _ret;
  
  
};

AVD_fnc_queue_getQueue = {
  private ["_queue", "_myHash", "_ret"];
  _queue = PARAM(0, nil);
  if(isNil "_queue") exitWith {};
  _ret = [AVD_QUEUES, _queue] call CBA_fnc_hashHasKey;
  if(_ret) then {
  	_myHash = [AVD_QUEUES, _queue]  call CBA_fnc_hashGet;
  } else {
      _myHash = [_queue] call AVD_fnc_queue_create;
  };
  _myHash;
};

AVD_fnc_queue_setQueue = {
  private ["_queue", "_myHash", "_queueName"];
  _queue = PARAM(0, nil);
  _queueName = PARAM(1, nil);
  if(isNil "_queue") exitWith {};
  
  [AVD_QUEUES, _queueName, _queue] call CBA_fnc_hashSet;
  true;
  
};

AVD_fnc_queue_create = {
    private ["_queue", "_myHash", "_ret"];
    _queue = PARAM(0, nil);
    if(isNil "_queue") exitWith {};
    _ret = [AVD_QUEUES, _queue] call CBA_fnc_hashHasKey;
    if(_ret) then {
        _myHash = [AVD_QUEUES, _queue] call CBA_fnc_hashGet;
    } else {
      	_myHash = [] call CBA_fnc_hashCreate;
        [AVD_QUEUES, _queue, _myHash] call CBA_fnc_hashSet;  
    };
    _myHash;
}