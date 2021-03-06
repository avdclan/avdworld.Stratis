#define SELF "x_avd\_player\gear.sqf"
#define PATH "x_avd\_player"
#include "include\avd.h"
#include "player.h"



private ["_rand", "_player"];
_player = PARAM(0, player);
_rand = random 1;
removeAllWeapons _player;
removeAllItems _player;
removeBackpack _player;
removeGoggles _player;
removeHeadgear _player;
removeUniform _player; 
removeVest _player;
_vest = [PLAYER_DEFAULT_VESTS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       _player addVest _class;
   }
} foreach _vest;
_uniform = [PLAYER_DEFAULT_UNIFORMS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       _player addUniform _class;
   }
} foreach _uniform;

_headgear = [PLAYER_DEFAULT_HEADGEARS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       _player addHeadgear _class;
   }
} foreach _headgear;

_backpack = [PLAYER_DEFAULT_BACKPACKS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       _player addBackpack _class;
   }
} foreach _backpack;

_item = [PLAYER_DEFAULT_ITEMS] call CBA_fnc_shuffle;
{
   _class = _x select 0;
   _r = _x select 1;
   if(_rand < _r) exitWith {
       _player addItem _class;
   }
} foreach _item;

/*
[_player] joinSilent grpNull;
[_player] joinSilent (createGroup resistance);
*/