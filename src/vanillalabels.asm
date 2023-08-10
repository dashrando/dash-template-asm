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
GenericBitmasks = $8085B6
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

RoomHeaderKraidInBrinstar       = $8FA59F
RoomHeaderPhantoonInWreckedShip = $8FCD13
RoomHeaderDraygonInMaridia      = $8FDA60
RoomHeaderRidleyInNorfair       = $8FB32E

; Boss Doors
DoorToKraidBoss      = $8FA594
DoorToPhantoonBoss   = $8FCCB9
DoorToDraygonBoss    = $8FD7D7
DoorToRidleyBoss     = $8FB3A1

DoorFromKraidInBrinstar       = $8FA5E5
DoorFromPhantoonInWreckedShip = $8FCD59
DoorFromDraygonInMaridia      = $8FDAA6
DoorFromRidleyInNorfair       = $8FB376

; Boss Door Vectors
DoorVectorToKraidInBrinstar       = $8391B6
DoorVectorToPhantoonInWreckedShip = $83A2AC
DoorVectorToDraygonInMaridia      = $83A840
DoorVectorToRidleyInNorfair       = $8398CA

DoorVectorToPreKraid    = $8391CE
DoorVectorToPrePhantoon = $83A2C4
DoorVectorToPreDraygon  = $83A96C
DoorVectorToPreRidley   = $8398BE

; Area Room Headers
RoomHeaderRetroPBs = $8F9E9F
RoomHeaderGreenHills = $8F9E52
RoomHeaderMoat = $8F95FF
RoomHeaderOcean = $8F93FE
RoomHeaderG4 = $8F99BD
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
Door_RetroPBs = $8F9EE5+0
Door_GreenHills = $8F9E79+2
Door_Moat = $8F9626+2
Door_Ocean = $8F9425+0
Door_G4 = $8F99E4+4
Door_Tourian = $8FA614+0
Door_Kago = $8F9990+2
Door_GreenElevator = $8F995F+0
Door_Crabs = $8F94B3+4
Door_RedElevator = $8F9651+0
Door_HighwayExit = $8F95A4+2
Door_Highway = $8F95CF+0
Door_NoobBridge = $8F9FE1+2
Door_RedTower = $8FA27A+2
Door_MaridiaEscape = $8FA349+8
Door_RedFish = $8FD12B+2
Door_MaridiaTube = $8FCF41+0
Door_MainStreet = $8FCFF0+0
Door_KraidEntry = $8FCFA7+2
Door_ElevatorEntry = $8FA6C8+0
Door_AboveKraid = $8FCFA7+4
Door_MaridiaMap = $8FD243+4
Door_KraidMouth = $8FA6C8+2
Door_KraidsLair = $8FA498+0
Door_CrocEntry = $8FA94A+8
Door_Croc = $8FA9D3+2
Door_SingleChamber = $8FAD85+8
Door_Muskateers = $8FB67D+0
Door_LavaDive = $8FAE9B+4
Door_RidleyMouth = $8FAF3B+0
Door_PreAqueduct = $8FD1CA+4
Door_Aqueduct = $8FD5CE+0

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

; Non-Area Door Vectors
DoorVectorToTourianElevator = $839222

; Room State Vectors
RoomState1RetroPBs = $8F9EB1        ; ok
RoomState2RetroPBs = $8F9ECB        ; ok
RoomState1GreenHills = $8F9E5F      ; ok
RoomState1Moat = $8F960C            ; fixed
RoomState1Ocean = $8F940B           ; ok
RoomState1G4 = $8F99CA              ; fixed
RoomState1Tourian = $8FA5FA         ; ok
RoomState1Kago = $8F9976            ; fixed
RoomState1GreenElevator = $8F9945   ; ok
RoomState1Crabs = $8F9499           ; fixed
RoomState1RedElevator = $8F9637     ; ok
RoomState1HighwayExit = $8F958A     ; fixed
RoomState1Highway = $8F95B5         ; ok
RoomState1NoobBridge = $8F9FC7      ; ok
RoomState1RedTower = $8FA260        ; ok
RoomState1MaridiaEscape = $8FA32F   ; ok
RoomState1RedFish = $8FD111         ; ok
RoomState1MaridiaTube = $8FCF0D     ; ok
RoomState2MaridiaTube = $8FCF27     ; ok
RoomState1MainStreet = $8FCFD6      ; ok
RoomState1KraidEntry = $8FCF8D      ; ok
RoomState1ElevatorEntry = $8FA6AE   ; ok
RoomState1AboveKraid = $8FCF8D      ; ok
RoomState1MaridiaMap = $8FD229      ; ok
RoomState1KraidMouth = $8FA6AE      ; ok
RoomState1KraidsLair = $8FA47E      ; fixed
RoomState1CrocEntry = $8FA930       ; ok
RoomState1Croc = $8FA99F            ; ok
RoomState2Croc = $8FA9B9            ; fixed
RoomState1SingleChamber = $8FAD6B   ; ok
RoomState1Muskateers = $8FB663      ; ok
RoomState1LavaDive = $8FAE81        ; fixed
RoomState1RidleyMouth = $8FAF21     ; fixed
RoomState1PreAqueduct = $8FD1B0     ; ok
RoomState1Aqueduct = $8FD5B4        ; ok
RoomState1CrabShaft = $8FD097       ; ok? (Pops added this for custom PLM use in plmlists.asm)