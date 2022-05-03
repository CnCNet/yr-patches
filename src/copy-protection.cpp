#include <stdbool.h>
#include <windows.h>
#include "macros/patch.h"

CALL(0x006BBE2B, _CopyProtect_isLauncherRunning);
CALL(0x006BDD11, _CopyProtect_notifyLauncher);
CALL(0x005D4DB7, _CopyProtect_checkForMessage);
CALL(0x0055CFE1, _CopyProtect_validate);
CALL(0x0068599E, _CopyProtect_validate);
CALL(0x00685C1C, _CopyProtect_validate);
CALL(0x006BEC3D, _CopyProtect_shutdown);


bool CopyProtect_isLauncherRunning(void)
{
    return true;
}

bool CopyProtect_notifyLauncher(void)
{
    return true;
}

void CopyProtect_checkForMessage(unsigned int msg, int handle)
{

}

bool CopyProtect_validate(void)
{
    return true;
}

void *CopyProtect_shutdown(void)
{
    return NULL;
}