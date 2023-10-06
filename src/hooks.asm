pushpc
;------------------------------------------------------------------------------
; Hooks
;------------------------------------------------------------------------------
; This module hooks our code into the vanilla routines. In some cases smaller
; data writes or overwriting smaller bits of vanilla code can go here.
;------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; Init
;--------------------------------------------------------------------------------
org $808490
JMP.w InitRAM ; Jump because we're overwriting the stack

;--------------------------------------------------------------------------------
; Frame Hooks
;--------------------------------------------------------------------------------
org $82894B
JSL.l FrameHook
org $82897A
JSL.l PostFrameHook
org $809590
JSL.l NMIHook
org $8095F7
JSL.l PostNMIHook : NOP

;------------------------------------------------------------------------------
; Game State Initialization (doors, etc)
;------------------------------------------------------------------------------
org $828067
JSL.l InitGameState
org $82EED9 : LDA.w #$001F ; Skip intro

;------------------------------------------------------------------------------
; File Select And Game Options Screens
;------------------------------------------------------------------------------
; Draw game code
org $82ECBB
JSR.w DrawFileSelectHash

org $82EDB1
JSR.w OnStartGame : BRA + : NOP #7 : +

;------------------------------------------------------------------------------
; Decompression
;------------------------------------------------------------------------------
org $82EAA9
JSR.w PostRoomDecompression

;------------------------------------------------------------------------------
; PLMs
;------------------------------------------------------------------------------
;org $82E8D5
;JSL.l InjectPLMs
;org $82EB8B
;JSL.l InjectPLMs

; Special Blocks
org $94936B : skip 2*!bts
dw SpeedCollidePLM
org $84D010 ; Unused PLM header
SpeedCollidePLM:
dw SpecialSpeedCollide, $CCE3

org $94A012 : skip 2*!bts
dw SpeedProjectilePLM
org $84D00C ; Unused PLM header
SpeedProjectilePLM:
dw SpecialSpeedProjectile, $CCEA

org $94936B : skip 2*!bts2
dw $D040 ; Speedbooster tile (non-respawning)

org $94A012 : skip 2*!bts2
dw ShotProjectilePLM
org $84D014 ;Overwrite unused PLM header
ShotProjectilePLM:
dw SpecialShotProjectile, $CBB7

;------------------------------------------------------------------------------
; New Items
;------------------------------------------------------------------------------
org $8488F9
JSR.w VanillaEquipmentPickup

; Suits
org $90E74D
JSR.w ApplyPeriodicDamage
org $9081F7
JMP.w LavaDamage
org $908239
JMP.w AcidDamage
org $8DE379
JML.l HeatDamage : NOP #2
org $948EAF
JSL.l SpikeDamage : NOP #2
org $948EEA
JSL.l SmallSpikeDamage : NOP #2 ; Kraid Spikes
org $948F25
JSL.l SmallSpikeDamage : NOP #2 ; Draygon broken turrets
org $A9B5E1
JSR.w MotherBrainDamage : NOP

; Double Jump
org $90A46E
JSR.w CheckEligibleJump : NOP #3
org $90A490
JSR.w CheckJumpPhysics
org $90A4BF
JSR.w CheckDoubleJump
org $91F0A5
JSR.w ClearJumpFlag

; Pressure Valve
org $82936A
JSR.w SetRoomFlagsUnpause

; Replace gravity suit checks with check for our room flag
org $84B423 : LDA.w RoomFlags
org $84B4D1 : LDA.w RoomFlags
org $908096 : LDA.w RoomFlags : BIT.w #$0020
org $908198 : LDA.w RoomFlags
org $90841D : LDA.w RoomFlags
org $909741 : LDA.w RoomFlags
org $9098C2 : LDA.w RoomFlags
org $90994F : LDA.w RoomFlags
org $9099DC : LDA.w RoomFlags
org $909A2F : LDA.w RoomFlags
org $909BD4 : LDA.w RoomFlags
org $909C24 : LDA.w RoomFlags
org $909C5B : LDA.w RoomFlags
org $90A439 : LDA.w RoomFlags : BIT.w #$0020
org $91F68A : LDA.w RoomFlags
org $91F6EB : LDA.w RoomFlags
org $91FB0E : LDA.w RoomFlags
org $9BC4BE : LDA.w RoomFlags : BIT.w #$0020
; Screw Attack and Speed palette fix
org $91D9B2 : LDA.w RoomFlags : BIT.w #$0020

;------------------------------------------------------------------------------
; Beams
;------------------------------------------------------------------------------
; HUD Handler / timer
org $90B81B
JSR.w PrepareForChargeCheck
; Fire Charged Beam (called after projectile initialized)
org $90B9E6
JSR.w UpdateChargeDamage
; Fire Uncharged Beam (called after projectile initialized)
org $90B8EC
JSR.w UpdateUnchargedDamage

org $8488C9
JSR.w MaybeEquipSpazer

;------------------------------------------------------------------------------
; Menu
;------------------------------------------------------------------------------
org $82A1EF
JSR.w IsMenuItemCollected
org $82A240
JSR.w IsMenuItemCollected
org $82A20F
JSR.w IsMenuItemEquipped
org $82A260
JSR.w IsMenuItemEquipped
org $82A288
JSR.w SelectMenuTiles
org $82AC43
JSR.w LoadMenuTiles : NOP #2
org $82B5A6
JMP.w HandleMenuItemToggle

; Menu cursor movement
org $82B4BA
LDA.w #$C056 : JSR.w CheckEquipmentBitmask
org $82B4E9
LDA.w #$C056 : JSR.w CheckEquipmentBitmask
org $82B514
LDA.w #$C062 : JSR.w CheckEquipmentBitmask
org $82B542
LDA.w #$C062 : JSR.w CheckEquipmentBitmask

org $82AFD3
JSR.w SetHUDFlagMenu
org $82B0CD
JSR.w SetHUDFlagMenu
org $82B15B
JSR.w SetHUDFlagMenu

;------------------------------------------------------------------------------
; Credits
;------------------------------------------------------------------------------
org $8B9971
PEA.w CreditsScript>>8
org $8B9976
JML.l ScrollCredits
org $8BF6FC
dw CreditsScript

; Hijack after decompression of regular credits tilemaps
org $8BE0D1
JSL.l CopyCreditsTileMap

; Add DASH items to final collection rate
org $8BE65B
JSR.w CountDashItems

; Post-credits Samus
org $8BE00A
LDA.w RTASeconds : CMP.w #$0A8B
org $8BE1E0
LDA.w RTASeconds : CMP.w #$0A8B : skip 2 : CMP.w #$0E10
org $8BE276
LDA.w RTASeconds : CMP.w #$0A8B
org $8BE2E4
LDA.w RTASeconds : CMP.w #$0A8B : skip 2 : CMP.w #$0E10
org $8BE325
LDA.w RTASeconds : CMP.w #$0A8B
org $8BE36C
LDA.w RTASeconds : CMP.w #$0A8B : skip 2 : CMP.w #$0E10
org $8BF555
LDA.w RTASeconds : CMP.w #$0E10
org $8BF597
LDA.w RTASeconds : CMP.w #$0E10
org $8BF5BA
LDA.w RTASeconds : CMP.w #$0E10

;------------------------------------------------------------------------------
; Subareas
;------------------------------------------------------------------------------
org $82DE86
JSR OnRoomLoad

;------------------------------------------------------------------------------
; Stats
;------------------------------------------------------------------------------
org $809602
JSR.w IncrementLagTimer

org $82E309
JMP.w DoorAdjustStart
org $82E34C
JMP.w DoorAdjustStop
org $82E176
JMP.w IncrementDoorTransitions
org $90B9A1
JSR.w IncrementChargedShots
org $90CCDE
JSR.w IncrementSpecialBeams
org $90BEB7
JMP.w IncrementMissiles
org $90C107
JSR.w IncrementBombs

org $A2AB13
JSL.l OnCompleteGoal

;------------------------------------------------------------------------------
; Saves
;------------------------------------------------------------------------------
; Loading save after file selection, transition to game options screen.
org $81A24A
JSR.w LoadSaveExpanded : BRA FileSelect_Done
org $81916C
JSR.w LoadSaveExpanded : NOP

org $818006
JSL.l OnWriteSave : NOP

org $819AEE
JSR.w CopyExtendedBuffers
org $819D1A
JSR.w ClearExtendedSRAM

;------------------------------------------------------------------------------
; New HUD
;------------------------------------------------------------------------------
org $8099E1
BRA HUDMissiles_bottomrow

; NOP out vanilla missile/super/pb tile initialization
org $809ACE
NOP #4
org $809AD7
NOP #4
org $809AE0
NOP #4

; Max ammo display
org $809B0D
dw InitHUDAmmoExpanded_missiles
org $809B1B
dw InitHUDAmmoExpanded_supers
org $809B29
dw InitHUDAmmoExpanded_pbs
org $809C00
JSR.w NewHUDAmmo

; Charge damage display
org $809BFB
JSR.w DrawNewHUD

; Max ammo tile changes
org $858851
db $0F,$28,$0F,$28,$0F,$28
org $858891
db $49,$30,$4A,$30,$4B,$30
org $858951
db $0F,$28,$0F,$28,$0F,$28
org $858993
db $34,$30,$35,$30
org $858A4F
db $0F,$28,$0F,$28
org $858a8f
db $36,$30,$37,$30

; Item counts
org $848983
JMP.w DecrementTankCount
;org $8489A6
;JMP.w DecrementTankCount
org $8488F0
JMP.w DecrementMajorCountHUDBeam
org $84893E
JMP.w DecrementMajorCountHUDBeam
org $848965
JMP.w DecrementMajorCountHUDBeam

org $809AF3 : NOP #4 ; Skip mini map initialization
org $90E734 : NOP #4 ; Skip mini map update
org $90E801 : NOP #4
org $90E873 : NOP #4
org $90E8E5 : NOP #4
org $90E8F8 : NOP #4
org $A48A7F : NOP #4 ; Skip mini map boss rooms
org $A586F7 : NOP #4
org $A6A122 : NOP #4
org $A7AA7C : NOP #4
org $A7CE24 : NOP #4
org $A98809 : NOP #4

org $8583C1 : JSR.w MessageBoxHDMA
org $85814D : JSR.w MessageBoxInitHDMA
org $85865C : JSR.w MessageBoxCloseHDMA

; HUD HDMA command pointer hooks
org $828106
JSL.l SetHDMAPointerLoad : NOP #2
;org $82E309
;JSL.l SetHDMAPointerDoorStart : NOP #2
;org $82E729
;JSL.l SetHDMAPointerDoorFadeIn : NOP #2
;org $82E764
;JSL.l SetHDMAPointerDoorEnd : NOP #2
org $828CE7
JSL.l SetHDMAPointerPause : NOP #2
org $829343
JSL.l SetHDMAPointerUnpause : NOP #2
;org $9493B5
;JSL.l SetHDMAPointerDoorFadeOut : NOP #2
;org $82E367
;JSL.l SetHDMAPointerDoorDark : NOP #2
org $828500
JSL.l SetHDMAPointerEnding : NOP #2

org $8095DE
JSR.w HUDHDMACommand

org $91E601 ; Samus acquiring Hyper Beam
JSL.l UpdateHUDHyperBeam : NOP #2

;------------------------------------------------------------------------------
; Message Boxes
;------------------------------------------------------------------------------
org $858243
JSR.w fix_1c1f
org $8582E5
JSR.w fix_1c1f

org $858086
JSR.w SetMessageBoxFlag
org $8580B7
JSR.w UnsetMessageBoxFlag

org $858413
dw BtnArray

org $858490
JSR.w MessageBoxTimer
org $8488DE
JSR.w HandleRoomMusicPickup : NOP #4
org $848905
JSR.w HandleRoomMusicPickup : NOP #4
org $848930
JSR.w HandleRoomMusicPickup : NOP #4
org $848957
JSR.w HandleRoomMusicPickup : NOP #4
org $848975
JSR.w HandleRoomMusicPickup : NOP #4
org $848998
JSR.w HandleRoomMusicPickup : NOP #4
org $8489C1
JSR.w HandleRoomMusicPickup : NOP #4
org $8489EA
JSR.w HandleRoomMusicPickup : NOP #4
org $848A13
JSR.w HandleRoomMusicPickup : NOP #4
org $8488DE
JSR.w HandleRoomMusicPickup : NOP #4

;------------------------------------------------------------------------------
; Setup DASH Logo
;------------------------------------------------------------------------------
org $8B9CAF
JSL.l LoadTitleLogo

;------------------------------------------------------------------------------
; Disable Demo
;------------------------------------------------------------------------------
org $8B9F29
LDA.w #1

;------------------------------------------------------------------------------
; Misc
;------------------------------------------------------------------------------
org $80AE29 : JSR.w FixDoorBG1Scroll

org $89AC62 : LDA.w FxAreaIndex

; PLM $D6DA - LN Chozo
org $84D18F : JSR.w MaybeActivateLNChozo : BRA + : NOP : +

;------------------------------------------------------------------------------
; Ridley Fixes (assume always in Norfair)
;------------------------------------------------------------------------------
org $A6A15C : LDA.w #2
org $A6A369 : LDY.w #2
org $A6A424 : LDA.w #2
org $A6A469 : LDA.w #2
org $A6A478 : LDA.w #2
org $A6D914 : LDA.w #2
org $A6D93B : LDA.w #2
org $A6DF8A : LDA.w #2
org $A6E4D2 : LDA.w #2

;------------------------------------------------------------------------------
; Door Transitions
;------------------------------------------------------------------------------
org $9493A7
JSR.w HandleEnterDoor : NOP
org $9493EA
JSR.w HandleEnterDoor : NOP

org $8FE8BA
JMP.w TeleportSamus

org $82DE32
JSR.w FixDoorBits

;org $82DE0C
;JSR.w FixTransitionFX

;------------------------------------------------------------------------------
; Flashing Doors
;------------------------------------------------------------------------------
org $84BE43
LDA.w CustomGreyDoorList,y

org $82EB7F
JSL PreProcessRoomPLM
org $82E8C9
JSL PreProcessRoomPLM
pullpc
