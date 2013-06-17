#define DB_WRITE(wobject, wkey, wvalue) [wobject, wkey, wvalue] call AVD_fnc_db_write
#define DB_SAVE(savunit) [savunit] call AVD_fnc_db_saveUnit
#define DB_LOAD(sobject, skeys) [sobject, skeys] call AVD_fnc_db_load