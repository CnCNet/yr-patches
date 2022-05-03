#ifndef _DSURFACE_H_
#define _DSURFACE_H_

#include "ddraw.h"

#pragma pack(push, 1)
typedef struct DSurface DSurface;

typedef struct {
    void *DSurface__Destroy;
    void *Dsurface_BlitWhole;
    void *BlitPart;
    void *Blit;
    void *FillRectEx;
    void *FillRect;
    void (__thiscall *Fill)(DSurface *this, int32_t a1);
    void (__thiscall *v4BB830)(DSurface *this, int32_t a1, int32_t a2, int32_t a3);
    void *v7BB350;
    void *Put_Pixel;
    void *Get_Pixel;
    void *DrawLineEx;
    void *DrawLine;
    void *Draw_Brackets;
    void *v4BBCA0;
    void *v4BC750;
    void *Draw_Circle;
    void *Rotating_Rect;
    void *Draw_Dotted_Line;
    void *Draw_Moving_Dashed_Line;
    void *v4C0E30;
    void *DrawRectEx;
    void *DrawRect;
    char *(__thiscall *Lock)(DSurface *this, int32_t X, int32_t Y);
    void *(__thiscall *Unlock)(DSurface *this);
    void *sub4BAEC0;
    void *Has_Focus;
    void *Is_Locked;
    int32_t (__thiscall *Get_BytesPerPixel)(DSurface *this);
    void *Get_Pitch;
    void *Get_Rect;
    int32_t (__thiscall *Get_Width)(DSurface *this);
    int32_t (__thiscall *Get_Height)(DSurface *this);
    void *v4C1AB0;
    void *v7BAF90;
    void *v7BAF10;
    void *v4BF750;
    void *Get_Blit_Status;
} vtDSurface;


typedef struct DSurface {
    vtDSurface *vtable;
    int32_t Width;
    int32_t Height;
    int32_t LockLevel;
    int32_t BitsPerPixel;
    char *  Buffer;
    char    Allocated;
    char    InVideoMemory;
    char    Unknown;
    char    Unknown2;
    DDSURFACEDESC *SurfaceDesc;
} DSurface;

extern DSurface *DSurface_Hidden;
extern DSurface *DSurface_Temp;

#pragma pack(pop)

#endif //_DSURFACE_H_
