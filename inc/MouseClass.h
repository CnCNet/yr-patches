
extern char MouseClass_Map;

void __thiscall MouseClass__Override_Mouse_Shape(void *this, int32_t a1, void *a2);
void __thiscall MouseClass__Revert_Mouse_Shape(void *this);

#pragma pack(push, 1)

typedef struct WWMouseClass WWMouseClass;

typedef struct {
    void *Destroy;
    void *Set_Cursor;//(int,int,void *)
    void *WWMouseClass_7BA320;
    void __thiscall (*Hide_Mouse)(WWMouseClass *this);//(void)
    void __thiscall (*Show_Mouse)(WWMouseClass *this);//(void)
    void *Release_Mouse;//(void)
    void *Capture_Mouse;//(void)
    void *WWMouseClass_7BA330;
    void *WWMouseClass_7B9D70;
    void *WWMouseClass_7B9D80;
    void *WWMouseClass_7B89F0;
    void *Get_Mouse_State;//(void)
    void *Get_Mouse_X;// int (void)
    void *Get_Mouse_Y;// int (void)
    void *Get_Mouse_XY;//(int &,int &)
    void *Draw_Mouse;//(GraphicViewPortClass *)
    void *Erase_Mouse;//(GraphicViewPortClass *,int)
    void *WWMouseClass_7B9D90;
} WWMouse_vtable;

typedef struct WWMouseClass {
    WWMouse_vtable *vtable;
    char v[128];
} WWMouseClass;

extern WWMouseClass *WWMouseClass_Mouse;
