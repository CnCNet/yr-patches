#ifndef RULES_H
#define RULES_H

#include "INIClass.h"

typedef struct RulesClass RulesClass;

extern RulesClass Rules;
extern INIClass *RulesINI;

int __thiscall RulesClass__Countries(RulesClass *rules, INIClass *ini);
int __thiscall RulesClass__Sides(RulesClass *rules, INIClass *ini);

#endif //RULES_H
