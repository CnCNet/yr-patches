#ifndef IPADDRESSCLASS_H
#define IPADDRESSCLASS_H

#include <windows.h>

void __thiscall IPXAddressClass__IPXAddressClass(void *ipa);
#pragma pack(push, 1)
struct ListAddress
{
    unsigned int port;
    struct in_addr ip;
};
#pragma pack(pop)

// globals referenced in spawner
struct ListAddress AddressList[8];

//typedef WINSOCK_API_LINKAGE IN_ADDR (PASCAL *inet_addr_function)(const char *cp);

typedef struct in_addr (*inet_addr_function)(const char *cp);

inet_addr_function inet_addr_;
#endif //IPADDRESSCLASS_H
