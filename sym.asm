%include "macros/setsym.inc"

setcglob 0x006BB9A0, WinMain@16
setcglob 0x0052BA60, InitGame

; imports
setcglob 0x007E1220, _imp__LoadLibraryA
setcglob 0x007E1250, _imp__GetProcAddress
setcglob 0x007E10D0, _imp__VirtualProtect

; WWDebug
setcglob 0x004068E0, WWDebug_Printf
setcglob 0x00A8ED6B, Debug_Map

setcglob 0x007E12CC, _imp__GetStdHandle
setcglob 0x007E1344, _imp__WriteConsoleA
setcglob 0x007E1218, _imp__AllocConsole
setcglob 0x007E11A8, _imp__GetModuleFileNameA
setcglob 0x007E11A4, _imp__GetCurrentProcess_hack
setcglob 0x007E12BC, _imp__GetCurrentThread
setcglob 0x007CB7BA, vsprintf
setcglob 0x007CDA90, _strcmp
setcglob 0x007E11C4, _imp__MultiByteToWideChar
setcglob 0x007E1548, _imp__htons
setcglob 0x007C8D20, strcmpi
setcglob 0x007E1280, _imp__GetCommandLineA
setcglob 0x007E1460, _imp__MessageBoxA
setcglob 0x004C8FE0, PrintException
setcglob 0x007CA489, wcscpy
setcglob 0x007E11F0, _imp__Sleep
setcglob 0x007E13EC, _imp__GetSystemMetrics

; winapi
setcglob 0x007C89B0, sendto
setcglob 0x007C89AA, recvfrom
setcglob 0x007E1558, _imp__sendto
setcglob 0x007E154C, _imp__recvfrom
setcglob 0x007C899E, _imp__socket
setcglob 0x007C8962, htonl
setcglob 0x007C8968, htons
setcglob 0x007E1280, GetCommandLineA
setcglob 0x007CA4B0, strstr
setcglob 0x007E1220, LoadLibraryA
setcglob 0x007E1250, GetProcAddress
setcglob 0x007C8EF4, sprintf
setcglob 0x007CC2AC, mbstowcs
setcglob 0x007CA67F, time
setcglob 0x007C9602, fwrite
setcglob 0x007CA845, fopen
setcglob 0x007CA75B, fclose
setcglob 0x007D75E0, memset
setcglob 0x007E11F8, _imp__CreateThread
setcglob 0x007E1248, _imp__CreateMutexA
setcglob 0x007E1168, _imp__CreateEventA
setcglob 0x007E11DC, _imp__WaitForSingleObject
setcglob 0x007C9430, ac_malloc
setcglob 0x007D0F45, ac_realloc
setcglob 0x007D4BF0, _strcpy
setcglob 0x007D15A0, _strlen
setcglob 0x007E1198, _imp__ReleaseMutex
setcglob 0x007E1234, _imp__SetEvent
setcglob 0x007E1178, _imp__ResetEvent

; Memory
setcglob 0x007C8E17, new
setcglob 0x007CA090, memcpy
setcglob 0x007D3374, calloc
setcglob 0x007C93E8, ac_free  ; Memory that's been allocated by the game exe or calloc or ac_malloc must bee freed with ac_free

; House
setcglob 0x00A8022C, HouseClassArray
setcglob 0x00A80238, HouseClassArray_Count
setcglob 0x00A83C9C, HouseTypeClassArray
setcglob 0x00A83CA8, HouseTypeClassArray_Count
;setcglob 0x004BB460, HouseClass__Assign_Handicap
setcglob 0x004F9B50, HouseClass__Make_Ally_id
setcglob 0x004F9B70, HouseClass__Make_Ally_house
setcglob 0x004F9F90, HouseClass__Alliance_Broken
setcglob 0x00687F10, Assign_Houses
;setcglob 0x005EEF70, Get_MP_Color
setcglob 0x00AC10C8, ObserverMode
setcglob 0x00A8B29C, PlayersCountries
setcglob 0x00A8B2BC, PlayersColors
setcglob 0x00A8B2DC, PlayersSpawns
setcglob 0x00A8B27C, PlayersHandicaps
setcglob 0x00A8B2FC, PlayersTeams

; Statistics
setcglob 0x00A8F900, StatisticsPacketSent
setcglob 0x00B779D4, WOLGameID
setcglob 0x00A8B8C2, OutOfSync
setcglob 0x00B77788, PlanetWestwoodStartTime
setcglob 0x00B73814, GameStockKeepingUnit
setcglob 0x005C9720, ScoreScreen_Present

; INI
setcglob 0x00535B30, INIClass__INIClass
setcglob 0x005256F0, INIClass__DTOR
setcglob 0x004741F0, INIClass__Load
setcglob 0x00525A10, INIClass__Save
setcglob 0x005295F0, INIClass__GetBool
setcglob 0x005276D0, INIClass__GetInt
setcglob 0x00528A10, INIClass__GetString
setcglob 0x00529560, INIClass__PutBool
setcglob 0x005275C0, INIClass__PutInt
setcglob 0x00528660, INIClass__PutString
setcglob 0x00526960, INIClass__EntryCount
setcglob 0x00526CC0, INIClass__GetEntry

; File
setcglob 0x004739F0, CCFileClass__CCFileClass
setcglob 0x00473C50, CCFileClass__Is_Available
setcglob 0x00473AE0, CCFileClass__Write
setcglob 0x00473B10, CCFileClass__Read
setcglob 0x00473CE0, CCFileClass__Close
setcglob 0x00473D10, CCFileClass__Open
setcglob 0x00473C00, CCFileClass__Size
setcglob 0x004019A0, CCFileClass__Destroy
setcglob 0x0065CB50, RawFileClass__Open
setcglob 0x0065D190, RawFileClass__Delete
setcglob 0x0065CA80, RawFileClass__RawFileClass
setcglob 0x0065CBF0, RawFileClass__Is_Available
setcglob 0x0065CA00, RawFileClass__DTOR
setcglob 0x0065CCE0, RawFileClass__Read
setcglob 0x0065D0D0, RawFileClass__Size

;RulesClass
setcglob 0x008871E0, Rules
setcglob 0x00887048, RulesINI
setcglob 0x00668BF0, RulesClass__Process
setcglob 0x006722F0, RulesClass__Countries
setcglob 0x00672440, RulesClass__Sides

; Session
setcglob 0x00A8B238, SessionClass_this
setcglob 0x00697B70, SessionClass__Create_Connections
setcglob 0x005D5F30, Set_Game_Mode
setcglob 0x00A8E9A0, GameActive
setcglob 0x00A8B238, SessionType
setcglob 0x00A8B270, UnitCount
setcglob 0x00822CF4, TechLevel
setcglob 0x00A8B274, AIPlayers
setcglob 0x00A8B278, AIDifficulty
setcglob 0x00A8B264, BuildOffAlly
setcglob 0x00A8B260, BridgeDestroy
setcglob 0x00A8B31F, FogOfWar
setcglob 0x00A8B261, Crates
setcglob 0x00A8B262, ShortGame
setcglob 0x00A8B258, Bases
setcglob 0x00A8B320, MCVRedeploy
setcglob 0x00A8B25C, Credits
setcglob 0x00A8B31D, HarvesterTruce
setcglob 0x00A8B263, SuperWeapons
setcglob 0x00A8EB60, GameSpeed				; NOT the GameSpeed debug lines var but the one loaded from ra2md.ini
setcglob 0x00A8B26C, MultiEngineer
setcglob 0x00A8B394, PlayerColor
setcglob 0x00A8B23C, GameMode
setcglob 0x008871E0, RulesData

setcglob 0x0061f210, Game_LoadPCXFiles
setcglob 0x00600560, InitCommonDialogStuff
setcglob 0x0061F190, InitUIColorShifts
setcglob 0x0052F620, Parse_Command_Line

;CCHyper 18.06.2015
setcglob 0x00A8B31C, AlliesAllowed

; Network
setcglob 0x00841F30, ListenPort
setcglob 0x004A1D50, CRC_DWORD
setcglob 0x0083737C, ReconnectTimeout
; Random
setcglob 0x00A8ED94, Seed
setcglob 0x0052FC20, Init_Random

; Message
;setcglob 0x007E2C34, MessageListClass_this
setcglob 0x00A83D4C, PlayerPtr
;setcglob 0x00572FE0, MessageListClass__Add_Message
;setcglob 0x006B2330, Get_Message_Delay_Or_Duration
setcglob 0x005D4430, MessageListClass__Manage ;

; Network
setcglob 0x007B2DB0, UDPInterfaceClass__UDPInterfaceClass
setcglob 0x00887628, WinsockInterface_this
setcglob 0x007B1DE0, WinsockInterfaceClass__Init
setcglob 0x007B30B0, UDPInterfaceClass__Open_Socket
setcglob 0x007B1BC0, WinsockInterfaceClass__Start_Listening
setcglob 0x007B1CA0, WinsockInterfaceClass__Discard_In_Buffers
setcglob 0x007B1D10, WinsockInterfaceClass__Discard_Out_Buffers
setcglob 0x00A8E9C0, IPXManagerClass_this
setcglob 0x00540C60, IPXManagerClass__Set_Timing
setcglob 0x0053ECB0, IPXAddressClass__IPXAddressClass
setcglob 0x00A8B8B4, MPDEBUG
setcglob 0x00A8B8B5, MPDEBUG1
setcglob 0X00B04880, MPSYNCDEBUG

setcglob 0x00A8B550, MaxAhead
setcglob 0x00A8B568, MaxMaxAhead
setcglob 0x00A8B554, FrameSendRate
setcglob 0x00A8DB9C, LatencyFudge
setcglob 0x00A8B558, RequestedFPS
setcglob 0x00A8B570, PrecalcFrameRate
setcglob 0x00A8B56C, PrecalcMaxAhead
setcglob 0x00A8B24C, ProtocolVersion
setcglob 0x00A8ED84, Frame

setcglob 0x005DA6C0, Init_Network
setcglob 0x00A8DA84, NameNodes_CurrentSize
setcglob 0x00A8B54C, HumanPlayers

; Scenario
setcglob 0x00A8B230, Scenario
setcglob 0x00A8B8E0, ScenarioName
setcglob 0x00683AB0, Start_Scenario
setcglob 0x00A8DA74, NameNodeVector
setcglob 0x00A8DA78, NameNode
setcglob 0x00477EC0, NameNodeVector_Add
setcglob 0x00699980, SessionClass__Read_Scenario_Descriptions
setcglob 0x00689E90, ScenarioClass_ReadLightingAndBasic
setcglob 0x00A8ED5C, InScenario1
setcglob 0x00A8E378, InScenario2
setcglob 0x00b779C4, Tournament
setcglob 0x00684370, Scenario_Load_Wait

; Save games
setcglob 0x0067E440, Load_Game

; Mouse
setcglob 0x00887640, WWMouseClas_Mouse
setcglob 0x00887640, WWMouseClass_Mouse
setcglob 0x0087F7E8, MouseClass_Map
setcglob 0x0055DEE0, Keyboard_Process
setcglob 0x005BDC80, MouseClass__Override_Mouse_Shape
setcglob 0x005BDAA0, MouseClass__Revert_Mouse_Shape


; misc
setcglob 0x008870C0, INIClass_RA2md_INI
setcglob 0x008254DC, str_Options
setcglob 0x00833160, str_Video
setcglob 0x0089F978, WindowedMode
setcglob 0x0052D9A6, Init_Main_Menu
setcglob 0x005D74A0, MPGameMode_AllyTeams
setcglob 0x006471A0, Queue_Exit

; Drawing
setcglob 0x00887314, DSurface_Temp
setcglob 0x0088730C, DSurface_Hidden
setcglob 0x004F4780, GScreenClass__Do_Blit
setcglob 0x006D04F0, GScreenClass_6D04F0
setcglob 0x004F42F0, GScreenClass__Flag_To_Redraw
setcglob 0x00560BF0, SetVideoMode
setcglob 0x00A8EB84, ScreenWidth
setcglob 0x00A8EB88, ScreenHeight
setcglob 0x00A8EB8C, LoadScreenWidth
setcglob 0x00A8EB90, LoadScreenHeight
setcglob 0x00643670, ProgressScreenClass_PrintPlayer
setcglob 0x006BA580, Draw_Confined_PCX
setcglob 0x007B05C0, Write_PCX_File

; CSF
setcglob 0x00B1CF78, CSF_Text_Array
setcglob 0x00B1CF70, CSF_Text_Array_Count
setcglob 0x00B1CF74, CSF_Label_Array
setcglob 0x00B1CF6C, CSF_Label_Array_Count
setcglob 0x007C8B48, qsort


; CommandClass
setcglob 0x00537BC0, ScreenCaptureCommandClass_Execute
