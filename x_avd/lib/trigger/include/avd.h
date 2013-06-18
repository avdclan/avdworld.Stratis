#include "debug.h"
#include "meta.h"
#include "remote.h"
#define DB "avdworld"

#define ccp(path) call compile preprocessFileLineNumbers path
#define ccpf(path) call compileFinal preprocessFileLineNumbers path

#define getIndex call AVD_fnc_getIndex

#define isAdmin (serverCommandAvailable "#kick" || isServer)