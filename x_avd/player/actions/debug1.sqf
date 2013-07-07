#define SELF "x_avd\player\actions\debug1.sqf"
#include "include\avd.h"
#include "include\db.h"
#include "include\arrays.h"

/*
 if(isNil "MYDATA") then {
   MYDATA = [];  
   T_MYDATA = [];
 };
 if(!(cursorTarget isKindOf "House")) exitWith { DLOG("NO HOUSE"); };
 if(typeOf cursorTarget in T_MYDATA) exitWith { DLOG("Already have " + str(typeOf cursorTarget))}
 T_MYDATA = T_MYDATA + [typeOf cursorTarget];
 
 DLOG("Calculating buildingPositions.");
 
 for "_i" from 0 to 50 do {
   _pos = cursorTarget buildingPos _i;
   _res = [_pos, [0, 0, 0]] call BIS_fnc_areEqual;  
 };
 */
 
 /*
 {
     if(side _x == civilian) then {
     	_g = group _x;
        deleteVehicle _x;
        deleteGroup _g;
     };
 } foreach allUnits;
 
 _group = createGroup civilian;
 for "_i" from 1 to 100 do {
   
   _u = _group createUnit["C_man_1", getPos player, [], 0, ""];
	hideObject _u;
    _u enableSimulation false;
 };
 */
 _group = createGroup civilian;
 
 _t = cursorTarget;


//if(local _t) then {
//  _t = (createGroup civilian) createUnit["C_man_1", getPos player, [], 0, ""];  
//};

 /*
 _group = createGroup civilian;
 for "_i" from 1 to 100 do {
   
   _u = _group createUnit["C_man_1", getPos player, [], 0, ""];
	[_u] call AVD_fnc_cache_enable;
 };
 
 
 
 */
 onMapSingleClick "[player, _pos] execVM ""x_avd\lib\teleport.sqf""; onMapSingleClick """";";
 