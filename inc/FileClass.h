#ifndef _FILECLASS_H_
#define _FILECLASS_H_

#include <windows.h>
#include <stdbool.h>

#pragma pack(push, 1)
typedef struct Buffer
{
  int BufferPtr;
  int Size;
  char IsAllocated;
  char field_9[3];
} Buffer;
#pragma pack(pop)


#pragma pack(push, 1)
typedef struct FileClass
{
  void *vftable;
  void *unknown;
} FileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct RawFileClass
{
  FileClass f;
  int Rights;
  int BiasStart;
  int BiasLength;
  int Handle;
  char *Filename;
  int16_t Date;
  int16_t Time;
  char FilenameSet;
  char Pad[3];
} RawFileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct BufferIOFileClass
{
  RawFileClass r;
  char IsBufferOwner;
  char BoolOne;
  char IsFileOpen;
  char BoolThree;
  char Uncommitted;
  char Cached;
  char __Pad[2];
  int FileRights;
  float BufferPointer;
  int Size2;
  int BufferPosition;
  int Start2;
  int UncommittedStart;
  int UncommittedEnd;
  int BufferSize;
  int BiasStart;
  int Dword8;
} BufferIOFileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct CDFileClass
{
  BufferIOFileClass b;
  char SkipSearchDrives;
  char Padding[3];
} CDFileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct CCFileClass
{
  CDFileClass cd;
  Buffer CacheBuffer;
  int CachedSize;
} CCFileClass;
#pragma pack(pop)

void ac_free(void *m);
void *ac_malloc(size_t);
void *ac_realloc(void *, size_t);
void   __thiscall RawFileClass__RawFileClass(RawFileClass *this, char *fname);
size_t __thiscall RawFileClass__Read(RawFileClass *this, char *buf, size_t len);
bool   __thiscall RawFileClass__Is_Available(RawFileClass *this, bool forced);
void   __thiscall RawFileClass__DTOR(RawFileClass *this);
size_t __thiscall RawFileClass__Size(RawFileClass *this);

void   __thiscall CCFileClass__CCFileClass(CCFileClass *ccfile, char *name);
bool   __thiscall CCFileClass__Is_Available(CCFileClass *ccfile, bool force);
size_t __thiscall CCFileClass__Size(CCFileClass *ccfile);
size_t __thiscall CCFileClass__Read(CCFileClass *ccfile, void *buf, size_t len);
void   __thiscall CCFileClass__Destroy(CCFileClass *ccfile);
bool   __thiscall CCFileClass__Open(CCFileClass *fileClass, int mode);
int    __thiscall CCFileClass__Write(CCFileClass *fileClass, void *buf, size_t len);


#endif //_FILECLASS_H_
