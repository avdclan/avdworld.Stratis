#define SELF "x_avd\lib\group\create.sqf"
#include "include\avd.h"
#include "arrays.h"

private ["_side", "_template", "_group", "_num", "_arrays", "_leader", "_squad", "_pos"];
_side = _this select 0;
_pos = _this select 1;
_template = _this select 2;
_num = _this select 3;
_arrays = [];
/*
switch(_template) do {
  

    default {
        switch(_side) do {
            east: {
              _leader = "O_Soldier_TL_F";
              _squad = ["O_Soldier_F", "O_medic_F"];  
            };
        	default {
                
            };  
        };
    };
};*/
_group = [_pos, _side, _num] call BIS_fnc_spawnGroup;
_group;


