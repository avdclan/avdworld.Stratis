#include "debug.h"
#include "meta.h"
#include "remote.h"
#define DB "avdworld"

#define ccp(path) call compile preprocessFileLineNumbers path
#define ccpf(path) call compileFinal preprocessFileLineNumbers path

#define getIndex call AVD_fnc_getIndex

#define VAR(obj, var, val) obj setVariable[var, val, false]
#define pVAR(obj, var, val) obj setVariable[var, val, false]

#define isAdmin (serverCommandAvailable "#kick" || isServer)

#ifndef PATH
	#define PATH "x_avd"
#endif

#define COMP(file) call compile preprocessFile format["%1\%2.sqf", PATH, file]
#define SPWN(file) execVM format["%1\%2.sqf", PATH, file]
#define PARAM(num, def) if(!isNil "_this" and count(_this) >= num) then { _this select num; } else { def; }

#define x_hashSet(h, k, v) [h, k, v] call CBA_fnc_hashSet
#define x_hashGet(h, k) [h, k] call CBA_fnc_hashGet
#define x_hash() [] call CBA_fnc_hashCreate