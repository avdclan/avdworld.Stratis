#define SELF "x_avd\lib\queue.sqf"
#define NODEBUG
#include "include\avd.h"

AVD_QUEUES = [[], objNull] call CBA_fnc_hashCreate;
publicVariable "AVD_QUEUES";

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
  
  if(typeName _myHash != "ARRAY") exitWith { ERROR("_myHash is not an array!" + str(_myHash)); false; };
  [_queue, _id, _myHash] call CBA_fnc_hashSet;
  [AVD_QUEUES, _name, _queue] call CBA_fnc_hashSet;
  publicVariable "AVD_QUEUES";
  //DLOG("Added " + str(_myHash) + " to " + str(_queue));
  
  true;
};

AVD_fnc_queue_next = {
  DLOG("next");
  private ["_name", "_queue", "_ret", "_nums", "_t1", "_t2", "_data"];
  _name = PARAM(0, nil);
  if(isNil "_name") exitWith { nil; };
  _queue = [_name] call AVD_fnc_queue_getQueue;
  DLOG("Having queue '" + str(_name) + "': " + str(_queue));
  //CBA_fnc_hashRem
  // get next element in array
  _nums = _queue select 1;
  _data = _queue select 2;
  
  // get element
  DLOG("Getting element " + str(_nums select 0));
  _ret = [_queue, _nums select 0] call CBA_fnc_hashGet;
  if(isNil "_ret") exitWith { nil; };
  
  DLOG("Having val: " + str(_ret));
  DLOG("Deleting element " + str(_nums select 0));
  [_queue, _nums select 0, objNull] call CBA_fnc_hashSet;
  DLOG("queue: " + str(_queue));
  DLOG("Resetting queue");
  [AVD_QUEUES, _name, objNull] call CBA_fnc_hashSet;
  [AVD_QUEUES, _name, _queue] call CBA_fnc_hashSet;
  switch(tolower typeName _ret) do {
      case "string": {
    	if(_ret == "UNDEF") then {
          DLOG("WTF is UNDEF?!");
          DLOG("Skipping this fscking element, getting next!");
          _ret = _this call AVD_fnc_queue_next;  
        };     
      };
  };
  DLOG("Returning: " + str(_ret));
  _ret;
  
};

AVD_fnc_queue_getQueue = {
  DLOG("getQueue");
  private ["_queue", "_myHash", "_ret"];
  _queue = PARAM(0, nil);
  _myHash = nil;
  if(isNil "_queue") exitWith {};
  _ret = [AVD_QUEUES, _queue] call CBA_fnc_hashHasKey;
  if(_ret) then {
  	_myHash = [AVD_QUEUES, _queue]  call CBA_fnc_hashGet;
  } else {
      _myHash = [_queue] call AVD_fnc_queue_create;
  };
  DLOG("Returning queue: " + str(_myhash));
  _myHash;
};

AVD_fnc_queue_setQueue = {
  private ["_queue", "_myHash", "_queueName"];
  _queue = PARAM(0, nil);
  _queueName = PARAM(1, nil);
  if(isNil "_queue") exitWith {};
  
  [AVD_QUEUES, _queueName, _queue] call CBA_fnc_hashSet;
  publicVariable "AVD_QUEUES";
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
      	_myHash = [[], objNull] call CBA_fnc_hashCreate;
        [AVD_QUEUES, _queue, _myHash] call CBA_fnc_hashSet; 
         
    };
    publicVariable "AVD_QUEUES";
    _myHash;
}