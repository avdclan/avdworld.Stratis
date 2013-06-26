private ["_data", "_ret"];
_data = _this select 0;
_ret = [];
{

    	//["using new code", "unpackData"] call dbg;
	   _class = _x select 0;
	   _count = _x select 1;
	   
	   for[{_i = 0}, {_i < _count}, {_i = _i+1 }] do {
	       _ret = _ret + [_class];
	   };

    
} foreach _data;
//[format["unpacked data: %1", _ret], "unpackData"] call dbg;
_ret;