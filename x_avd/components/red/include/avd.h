#include "debug.h"
#include "meta.h"
#include "remote.h"
#define DB "avdworld"

#define ccp(path) call compile preprocessFileLineNumbers path
#define ccpf(path) call compileFinal preprocessFileLineNumbers path

#define isAdmin (serverCommandAvailable "#kick" || isServer)