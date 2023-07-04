;------------------------------------------------------------------------------
; Vanilla Labels
;------------------------------------------------------------------------------
; Unless noted as long, these are either routines that return short or pointers
; to data.
;------------------------------------------------------------------------------
WaitForNMI = $808338 ; long
EnableNMI = $80834B ; long
DisableNMI = $80835D ; long
LoadMapMirror = $80858C ; long
QueueMusicTrack = $808FC1 ; long
QueueSoundLibraryOne = $809049
SetupDMATransfer = $8091A9 ; long
HUDMissiles_bottomrow = $8099F6
InitializeHUD = $809A79 ; long
HUDDrawThreeDigits = $809D78
HUDDrawTwoDigits = $809D98
HUDHealthDigits = $809DBF
ClearFXTileMap = $80A29C ; long
SaveToSRAM = $818000 ; long
LoadSave = $818085 ; long
LoadMap = $8182E4
FileSelect_CursorSound = $81A2B2
FileSelect_Done = $81A2B9
NewSaveFile = $81B2CB
LoadMenuTileMap = $81B3E2
LoadStandardBG3 = $8282E2
LoadPauseMenuTiles = $828E75
ClearSamusBeamTiles = $82A2BE
PlasmaSpazerMenuCheck = $82B068
MenuCheckButton = $82B568
DrawFileSelectMissile = $82BA6E ; long
PlayRoomMusic = $82E118 ; long
TransferToVRAMRoomCommand = $82E5EB
LoadDestinationRoom = $82E76B ; long
PLMDelete = $8486BC
PLMPreInstruction = $8486C1
PLMGoto = $848724
PLMDecrementTimer = $84873F
PLMTimer = $84874E
RoomItemArgument = $84887C
SetRoomItem = $848899
SetGoto = $848A24
PLMInstruction = $848A2E
QueueMusic = $848BDD
NoopPLM = $84B6F7 ; Skips PLM. Also zero out overwrite x/y coordinates and room argument.
DrawItemFrame1 = $84E04F
DrawItemFrame2 = $84E067
ShowMessage = $858080 ; long
HDMAObjectHandler = $8884B9 ; long
ChargeBeamTiles = $898B00
ClearBGObjects = $8B95CE ; long
AnimateSamusLavaAcid = $90824C
MakeSamusJump = $9098BC ; long
SpaceJumpEligible = $90A488
HudSelectionHandler = $90B80D
HudSelectionHandler_charge = $90B82D
FireBeam = $90B887
FireBeam_charge_equipped = $90B91C
AnimateSamusGeneral = $90F084 ; long
ReceiveDamageSamus = $91DF51
InitializeProjectile = $938000
ProjectilePointers = $9383C1

; Boss Doors
DoorToKraidBoss      = $8FA594 ; 0x07A594
DoorToPhantoonBoss   = $8FCCB9 ; 0x07CCB9
DoorToDraygonBoss    = $8FD7D7 ; 0x07D7D7
DoorToRidleyBoss     = $8FB3A1 ; 0x07B3A1

DoorFromKraidRoom    = $8FA5E5 ; 0x07A5E5
DoorFromPhantoonRoom = $8FCD59 ; 0x07CD59
DoorFromDraygonRoom  = $8FDAA6 ; 0x07DAA6
DoorFromRidleyRoom   = $8FB376 ; 0x07B376

; Boss Door Vectors
DoorVectorToKraid       = $8391B6 ; 0x0191B6
DoorVectorToPhantoon    = $83A2AC ; 0x01A2AC
DoorVectorToDraygon     = $83A840 ; 0x01A840
DoorVectorToRidley      = $8398CA ; 0x0198CA

DoorVectorToPreKraid    = $8391CE ; 0x0191CE
DoorVectorToPrePhantoon = $83A2C4 ; 0x01A2C4
DoorVectorToPreDraygon  = $83A96C ; 0x01A96C
DoorVectorToPreRidley   = $8398BE ; 0x0198BE

; Room Headers
RoomHeaderPreKraid    = $8FA56B
RoomHeaderPrePhantoon = $8FCC6F
RoomHeaderPreDraygon  = $8FD78F
RoomHeaderPreRidley   = $8FB37A

RoomHeaderKraid    = $8FA59F
RoomHeaderPhantoon = $8FCD13
RoomHeaderDraygon  = $8FDA60
RoomHeaderRidley   = $8FB32E