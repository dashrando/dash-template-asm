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
org $82EED9
LDA.w #$001F ; Skip intro

;------------------------------------------------------------------------------
; File Select And Game Options Screens
;------------------------------------------------------------------------------
; Draw game code
org $82ECBB
JSR.w DrawFileSelectHash

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
org $848794
JSR.w SetItemGraphicsBank

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

; Double Jump
org $90A46E
JSR.w CheckEligibleJump : NOP #3
org $90A490
JSR.w CheckJumpPhysics
org $90A4BF
JSR.w CheckDoubleJump
org $91F0A5
JSR.w ClearJumpFlag

; Aqua Boots
org $908096
JSR.w CheckWaterPhysics : NOP #3
org $908198
JSR.w CheckWaterPhysics : NOP #3
org $90841D
JSR.w CheckWaterPhysics : NOP #3
org $909741
JSR.w CheckWaterPhysics : NOP #3
org $9098C2
JSR.w CheckWaterPhysics : NOP #3
org $90994F
JSR.w CheckWaterPhysics : NOP #3
org $9099DC
JSR.w CheckWaterPhysics : NOP #3
org $909A2F
JSR.w CheckWaterPhysics : NOP #3
org $909BD4
JSR.w CheckWaterPhysics : NOP #3
org $909C24
JSR.w CheckWaterPhysics : NOP #3
org $909C5B
JSR.w CheckWaterPhysics : NOP #3
org $90A439
JSR.w CheckWaterPhysics : NOP #3
org $91F68A
JSL.l CheckWaterPhysicsLong : NOP #2
org $91F6EB
JSL.l CheckWaterPhysicsLong : NOP #2
org $91FB0E
JSL.l CheckWaterPhysicsLong : NOP #2
org $9BC4BE
JSL.l CheckWaterPhysicsLong : NOP #2
org $84B423
JSL.l CheckWaterPhysicsLong : NOP #2
org $84B4D1
JSL.l CheckWaterPhysicsLong : NOP #2

;------------------------------------------------------------------------------
; Beams
;------------------------------------------------------------------------------
; PLM called when a beam is collected
org $8488B0
JSR.w CollectBeam
; HUD Handler / timer
org $90B81B
JSR.w PrepareForChargeCheck
; Fire Charged Beam (called after projectile initialized)
org $90B9E6
JSR.w UpdateChargeDamage
; Fire Uncharged Beam (called after projectile initialized)
org $90B8EC
JSR.w UpdateUnchargedDamage

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


;------------------------------------------------------------------------------
; Credits
;------------------------------------------------------------------------------

; Patch soft reset to retain value of RTA counter
;org $80844B
;jml patch_reset1
;org $808490
;jml patch_reset2

; Patch loading and saving routines
;org $81807f
;jmp patch_save
;org $8180f7
;jmp patch_load

; Hijack loading new game to reset stats
;org $828063
;jsl clear_values

; Hijack the original credits code to read the script from bank $DF

; org $8b9976
; jml scroll
; org $8b999b
; jml patch1
; org $8b99e5
; jml patch2
; org $8b9a08
; jml patch3
; org $8b9a19
; jml patch4
; 
; ; Hijack when samus is in the ship and ready to leave the planet
; org $a2ab13
; jsl game_end
; 
; ; Hijack after decompression of regular credits tilemaps
; org $8be0d1
; jsl copy

;------------------------------------------------------------------------------
; Subareas
;------------------------------------------------------------------------------
org $82DE86
JSR DetermineSubArea

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

;------------------------------------------------------------------------------
; Saves
;------------------------------------------------------------------------------
; Loading save after file selection, transition to game options screen.
org $81A24A
JSR.w LoadSaveExpanded : BRA FileSelect_Done

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
org $809b0d
dw InitHUDAmmoExpanded_missiles
org $809b1b
dw InitHUDAmmoExpanded_supers
org $809b29
dw InitHUDAmmoExpanded_pbs
org $809c00
JSR.w NewHUDAmmo

; Charge damage display
org $809ab1
JSR.w InitHUDCharge
org $809bfb
JSR.w NewHUDCharge

;------------------------------------------------------------------------------
; Message Boxes
;------------------------------------------------------------------------------
org $85830C
JSR.w load_message

org $858243
JSR.w fix_1c1f
org $8582E5
JSR.w fix_1c1f

org $858413
dw BtnArray

; Max ammo tile changes
org $858851
db $0f,$28,$0f,$28,$0f,$28
org $858891
db $49,$30,$4a,$30,$4b,$30
org $858951
db $0f,$28,$0f,$28,$0f,$28
org $858993
db $34,$30,$35,$30
org $858a4f
db $0f,$28,$0f,$28
org $858a8f
db $36,$30,$37,$30

pullpc
