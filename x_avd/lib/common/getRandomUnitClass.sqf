private ["_side", "_ret", "_arr", "_val"];
_side = _this select 0;
_ret = nil;
_arr = [];
switch(_side) do {
	case EAST: {
        
    };  
    case WEST: {
        
    };
    case CIVILIAN: {
     	  _arr = ["C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F"];
            
    };
    default {
        
    };
};
_val = [_arr] call CBA_fnc_shuffle;
_ret = _val select 0;
//[format["randomUnitClass (%2): %1", _ret, _side], "debug"] call AVD_fnc_log;
_ret;