#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

// linker transparently uses this instead of binary's, see org/gamemd_callsites.asm
int CALLBACK WinMain(
  _In_  HINSTANCE hInstance     __attribute__((unused)),
  _In_  HINSTANCE hPrevInstance __attribute__((unused)),
  _In_  LPSTR lpCmdLine         __attribute__((unused)),
  _In_  int nCmdShow            __attribute__((unused)))
{
    return EXIT_SUCCESS;
}
