private ["_data", "_ret", "_arr", "_tmp"];
_data = _this select 0;
_ret = [];

/*
 *    _emptyHash = [] call CBA_fnc_hashCreate;
    [_emptyHash, "frog"] call CBA_fnc_hashGet; // => nil

    _pairs = [["frog", 12], ["fish", 9]];
    _animalCounts = [_pairs, 0] call CBA_fnc_hashCreate;
    [_animalCounts, "frog"] call CBA_fnc_hashGet; // => 12
    [_animalCounts, "monkey"] call CBA_fnc_hashGet; // => 0 
 */
_arr = [];
{
    
    _val = _x;
   	if(! (_val in _arr)) then {
        _count = 0;
    	{
        	if(_val == _x) then {
				_count = _count + 1;
	        };
    	} foreach _data;

        _arr = _arr + [_val];
        _ret = _ret + [[_val, _count]];
                    	
    }
    
} foreach _data;

_ret;