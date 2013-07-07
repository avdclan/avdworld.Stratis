#define SELF "x_avd\lib\db\writeHash.sqf"
#define NODEBUG
#include "include\avd.h"
#include "include\db.h"
if(!isServer) exitWith {
    DLOG("Saving is only for servers, exiting.");
};

private ["_table", "_hash", "_dumpHash", "_id"];
_table = PARAM(0, nil);
_table = format["avdworld\%1", _table];
_hash = PARAM(1, nil);
_db = PARAM(2, AVD_DB);

if(isNil "AVD_DB_WRITE_LOCK") then {
    AVD_DB_WRITE_LOCK = false;
};

waitUntil { !AVD_DB_WRITE_LOCK };
AVD_DB_WRITE_LOCK = true;

// load Index.
DLOG("Checking if " + str(_table) + " exists.");
_ret = _table call iniDB_exists;
_indexs = [];
if(_ret) then {
    _indexCount = DB_LOAD_NUMBER_FROM(_table, "index", "count");
    
    for "_i" from 0 to _indexCount-1 do {
      // load ids..
      _ref = format["entity_%1", _i];
      _num = DB_LOAD_NUMBER_FROM(_table, "index", _ref);
      _indexs = _indexs + [_num];  
    };
};

_id = count(_indexs);
_ddb = format["%1_%2", _table, _id];
[_hash, "_id", _id] call CBA_fnc_hashSet;
_allKeys = _hash select 1;
_dumpHash = {
	DB_WRITE_TO(_ddb, "entity", _key, _value);    
};  
DB_WRITE_TO(_ddb, "entity", "_keys", str(_allKeys));  
[_hash, _dumpHash] call CBA_fnc_hashEachPair;
_indexs = _indexs + [_id];

DB_WRITE_TO(_table, "index", "count", count(_indexs));
_cc = 0;
{
    _str = format["entity_%1", _cc];
    DB_WRITE_TO(_table, "index", _str, _x);
    _cc = _cc + 1;
} foreach _indexs;
AVD_DB_WRITE_LOCK = false;
_id;
