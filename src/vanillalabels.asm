;------------------------------------------------------------------------------
; Vanilla Labels
;------------------------------------------------------------------------------
; Unless noted as long, these are either routines that return short or pointers
; to data.
;------------------------------------------------------------------------------
WaitForNMI = $808338 ; long
LoadMapMirror = $80858C ; long
QueueMusicTrack = $808FC1 ; long
QueueSoundLibraryOne = $809049
HUDMissiles_bottomrow = $8099F6
InitializeHUD = $809A79 ; long
HUDDrawThreeDigits = $809D78
HUDDrawTwoDigits = $809D98
HUDHealthDigits = $809DBF
SaveToSRAM = $818000 ; long
LoadSave = $818085 ; long
LoadMap = $8182E4
FileSelect_CursorSound = $81A2B2
FileSelect_Done = $81A2B9
NewSaveFile = $81B2CB
LoadMenuTileMap = $81B3E2
ClearSamusBeamTiles = $82A2BE
DrawFileSelectMissile = $82BA6E ; long
PlayRoomMusic = $82E118 ; long
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
NoopPLM = $84B62F ; Skips PLM. Also zero out overwrite x/y coordinates and room argument.
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
