#define SELF "x_avd\player\gear.sqf"
#define PATH "x_avd\player"
#include "include\avd.h"
#include "player.h"

private ["_rand"];

removeAllWeapons player;
removeAllItems player;
removeBackpack player;
removeGoggles player;
removeHeadgear player;
removeUniform player; 
removeVest player;
_rand = random 1;

_vest = [PLAYER_DEFAULT_VESTS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       player addVest _class;
   }
} foreach _vest;
_uniform = [PLAYER_DEFAULT_UNIFORMS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       player addUniform _class;
   }
} foreach _uniform;

_headgear = [PLAYER_DEFAULT_HEADGEARS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       player addHeadgear _class;
   }
} foreach _headgear;

_backpack = [PLAYER_DEFAULT_BACKPACKS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       player addBackpack _class;
   }
} foreach _backpack;

_item = [PLAYER_DEFAULT_ITEMS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       player addItem _class;
   }
} foreach _item;

