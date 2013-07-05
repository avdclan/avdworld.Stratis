#define SELF "x_avd\scripts\switchUnitGear.sqf"
#include "include\avd.h"

AVD_fnc_switchUnitGear = {
    private ["_source", "_destination", "_sideSwitch"];
    _source = PARAM(0, nil);
    _destination = PARAM(1, nil);
    _sideSwitch = PARAM(2, false);
    
    private ["_l1", "_l2", "_s1", "_s2", "_g1", "_g2"];
    _l1 = [_source, ["ammo"]] call AEROSON_fnc_getLoadout;
    _l2 = [_destination, ["ammo"]] call AEROSON_fnc_getLoadout;
    _s1 = [typeOf _source] call AVD_fnc_getSideByClass;
    _s2 = side _destination;
    _g1 = group _source;
    _g2 = group _destination;
    
    [_source, _l2, ["ammo"]] call AEROSON_fnc_setLoadout;
    [_destination, _l1, ["ammo"]] call AEROSON_fnc_setLoadout;
    
    If(_sideSwitch) then {
        DLOG("Switching side.");
        DLOG("Source side: " + str(_s1));
        DLOG("Destin side: " + str(_s2));
    	_source setVariable["sug_side_orig", _s1, true];
    	// .. and so on.
        
        [_source] joinSilent grpNull;
        [_source] joinSilent (createGroup _s2);
        
        [_destination] joinSilent grpNull;
		[_destination] joinSilent (createGroup _s1);
        
        DLOG("Source side: " + str(side _source));
        DLOG("Destin side: " + str(side _destination));
    	
    	
	};
    
    
};