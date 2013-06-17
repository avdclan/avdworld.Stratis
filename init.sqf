
onPlayerConnected "[_id, _name] execVM ""x_avd\onPlayerConnected.sqf""";
onPlayerDisconnected "[_id, _name] call compile preprocessFileLineNumbers ""x_avd\onPlayerDisconnected.sqf""";	
//execVM "x_avd\init.sqf";
