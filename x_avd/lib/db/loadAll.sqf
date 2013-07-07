#define SELF "x_avd\lib\db\load.sqf"
#include "include\avd.h"
#include "include\db.h"

if(!isServer) exitWith {
    DLOG("Loading is only for servers, exiting.");
};

private ["_table", "_indexs", "_time"];
_time = time;
_table = PARAM(0, nil);
_table = format["avdworld\%1", _table];
_h = [] call CBA_fnc_hashCreate;
//DLOG("Loading indexs from " + str(_table));
_indexs = DB_LOAD_NUMBER_FROM(_table, "index", "count");
//DLOG("Indexs: " + str(_indexs));
for "_i" from 0 to _indexs-1 do {
  //DLOG("Loading data for entity " + str(_i));
  _ent = format["entity_%1", _i];
  _id = DB_LOAD_NUMBER_FROM(_table, "index", _ent);
  //DLOG("id: " + str(_id));
  _tbl = format["%1_%2", _table, _id];
  //DLOG("entity: " + str(_tbl));
  _hh = [] call CBA_fnc_hashCreate;
  _keys = DB_LOAD_ARRAY_FROM(_tbl, "entity", "_keys");
  {
      //DLOG("Fetching field " + str(_x));
      _f = DB_LOAD_FROM(_tbl, "entity", _x);
      //DLOG("value: " + str(_f));
      [_hh, _x, _f] call CBA_fnc_hashSet;
  } foreach _keys;
  //DLOG("Object fetched.");
  [_h, _id, _hh] call CBA_fnc_hashSet;
};
_took = time - _time;
DLOG("All objects loaded (took " + str(_took) + " seconds)");
_h;