#define DB_WRITE(wobject, wkey, wvalue) [wobject, wkey, wvalue] call AVD_fnc_db_write
#define DB_WRITE_TO(wdb, wobject, wkey, wvalue) [wobject, wkey, wvalue, wdb] call AVD_fnc_db_write
#define DB_SAVE(savunit) [savunit] call AVD_fnc_db_saveUnit
#define DB_LOAD(sobject, skeys) [sobject, skeys] call AVD_fnc_db_load
#define DB_LOAD_FROM(sdb, sobject, skeys) [sobject, skeys, "STRING", sdb] call AVD_fnc_db_load
#define DB_LOAD_ARRAY(sobject, skeys) [sobject, skeys, "ARRAY"] call AVD_fnc_db_load
#define DB_LOAD_ARRAY_FROM(sdb, sobject, skeys) [sobject, skeys, "ARRAY", sdb] call AVD_fnc_db_load
#define DB_LOAD_NUMBER(sobject, skeys) [sobject, skeys, "NUMBER"] call AVD_fnc_db_load
#define DB_LOAD_NUMBER_FROM(sdb, sobject, skeys) [sobject, skeys, "NUMBER", sdb] call AVD_fnc_db_load
#define PACK(data) ([data] call AVD_fnc_db_packData)
#define UNPACK(data) ([data] call AVD_fnc_db_unpackData)