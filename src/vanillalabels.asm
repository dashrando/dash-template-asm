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

; Boss Room Headers
RoomHeaderPreKraid    = $8FA56B
RoomHeaderPrePhantoon = $8FCC6F
RoomHeaderPreDraygon  = $8FD78F
RoomHeaderPreRidley   = $8FB37A

RoomHeaderKraid    = $8FA59F
RoomHeaderPhantoon = $8FCD13
RoomHeaderDraygon  = $8FDA60
RoomHeaderRidley   = $8FB32E

; Boss Doors
DoorToKraidBoss      = $8FA594
DoorToPhantoonBoss   = $8FCCB9
DoorToDraygonBoss    = $8FD7D7
DoorToRidleyBoss     = $8FB3A1

DoorFromKraidRoom    = $8FA5E5
DoorFromPhantoonRoom = $8FCD59
DoorFromDraygonRoom  = $8FDAA6
DoorFromRidleyRoom   = $8FB376

; Boss Door Vectors
DoorVectorToKraid       = $8391B6
DoorVectorToPhantoon    = $83A2AC
DoorVectorToDraygon     = $83A840
DoorVectorToRidley      = $8398CA

DoorVectorToPreKraid    = $8391CE
DoorVectorToPrePhantoon = $83A2C4
DoorVectorToPreDraygon  = $83A96C
DoorVectorToPreRidley   = $8398BE

; Area Room Headers
RoomHeaderRetroPBs = $8F9E9F
RoomHeaderGreenHills = $8F9E52
RoomHeaderMoat = $8F95FF
RoomHeaderOcean = $8F93FE
RoomHeaderG4 = $8F998B
RoomHeaderTourian = $8FA5ED
RoomHeaderKago = $8F9969
RoomHeaderGreenElevator = $8F9938
RoomHeaderCrabs = $8F948C
RoomHeaderRedElevator = $8F962A
RoomHeaderHighwayExit = $8F957D
RoomHeaderHighway = $8F95A8
RoomHeaderNoobBridge = $8F9FBA
RoomHeaderRedTower = $8FA253
RoomHeaderMaridiaEscape = $8FA322
RoomHeaderRedFish = $8FD104
RoomHeaderMaridiaTube = $8FCEFB
RoomHeaderMainStreet = $8FCFC9
RoomHeaderKraidEntry = $8FCF80
RoomHeaderElevatorEntry = $8FA6A1
RoomHeaderAboveKraid = $8FCF80
RoomHeaderMaridiaMap = $8FD21C
RoomHeaderKraidMouth = $8FA6A1
RoomHeaderKraidsLair = $8FA471
RoomHeaderCrocEntry = $8FA923
RoomHeaderCroc = $8FA98D
RoomHeaderSingleChamber = $8FAD5E
RoomHeaderMuskateers = $8FB656
RoomHeaderLavaDive = $8FAE74
RoomHeaderRidleyMouth = $8FAF14
RoomHeaderPreAqueduct = $8FD1A3
RoomHeaderAqueduct = $8FD5A7

; Area Doors
Door_RetroPBs = $8F
Door_GreenHills = $8F
Door_Moat = $8F
Door_Ocean = $8F
Door_G4 = $8F
Door_Tourian = $8F
Door_Kago = $8F
Door_GreenElevator = $8F
Door_Crabs = $8F
Door_RedElevator = $8F
Door_HighwayExit = $8F
Door_Highway = $8F
Door_NoobBridge = $8F
Door_RedTower = $8F
Door_MaridiaEscape = $8F
Door_RedFish = $8F
Door_MaridiaTube = $8F
Door_MainStreet = $8F
Door_KraidEntry = $8F
Door_ElevatorEntry = $8F
Door_AboveKraid = $8F
Door_MaridiaMap = $8F
Door_KraidMouth = $8F
Door_KraidsLair = $8F
Door_CrocEntry = $8F
Door_Croc = $8F
Door_SingleChamber = $8F
Door_Muskateers = $8F
Door_LavaDive = $8F
Door_RidleyMouth = $8F
Door_PreAqueduct = $8F
Door_Aqueduct = $8F

; Area Door Vectors
DoorVectorToRetroPBs = $838E86
DoorVectorToGreenHills = $838E9E
DoorVectorToMoat = $8389CA
DoorVectorToOcean = $838AEA
DoorVectorToG4 = $8391E6
DoorVectorToTourian = $838C52
DoorVectorToKago = $838BFE
DoorVectorToGreenElevator = $838C22
DoorVectorToCrabs = $838AF6
DoorVectorToRedElevator = $838A42
DoorVectorToHighwayExit = $838AA2
DoorVectorToHighway = $838AAE
DoorVectorToNoobBridge = $83902A
DoorVectorToRedTower = $838F0A
DoorVectorToMaridiaEscape = $83A480
DoorVectorToRedFish = $8390C6
DoorVectorToMaridiaTube = $83A39C
DoorVectorToMainStreet = $83A330
DoorVectorToKraidEntry = $83922E
DoorVectorToElevatorEntry = $83A384
DoorVectorToAboveKraid = $83A510
DoorVectorToMaridiaMap = $83A390
DoorVectorToKraidMouth = $83913E
DoorVectorToKraidsLair = $83923A
DoorVectorToCrocEntry = $8393EA
DoorVectorToCroc = $8393D2
DoorVectorToSingleChamber = $839A4A
DoorVectorToMuskateers = $8395FA
DoorVectorToLavaDive = $8396D2
DoorVectorToRidleyMouth = $83967E
DoorVectorToPreAqueduct = $83A708
DoorVectorToAqueduct = $83A4C8