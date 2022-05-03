#include <stdbool.h>
#include <windows.h>
#include <winbase.h>

typedef BOOL (WINAPI *SetProcAffinityFunction)(HANDLE, DWORD_PTR);
bool SingleProcAffinity;

/* ld was core-dumping when I tried to include the actual GetCurrentProcess */
WINBASEAPI HANDLE WINAPI GetCurrentProcess_hack (VOID);

void
SetSingleProcAffinity() {
  HMODULE library;
  SetProcAffinityFunction SetProcAffinityMask;
  HANDLE CurrentProcess;

  library = LoadLibraryA("kernel32.dll");
  if (!library)
    abort;

  SetProcAffinityMask = GetProcAddress(library, "SetProcessAffinityMask");
  if (!SetProcAffinityMask)
    return;

  CurrentProcess = GetCurrentProcess_hack();
  if (!CurrentProcess)
    return;

  if (SingleProcAffinity)
  {
      SetProcAffinityMask(CurrentProcess,1);
  }
}
