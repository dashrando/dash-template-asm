pushpc
;------------------------------------------------------------------------------
; Hooks
;------------------------------------------------------------------------------
; This module hooks our code into the vanilla routines. In some cases smaller
; data writes or overwriting smaller bits of vanilla code can go here.
;------------------------------------------------------------------------------


;--------------------------------------------------------------------------------
; Frame Hooks
;--------------------------------------------------------------------------------
org $82894B
JSL.l FrameHook
org $82897A
JSL.l PostFrameHook

;--------------------------------------------------------------------------------
; NMI Hooks
;--------------------------------------------------------------------------------
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
; File Select Screen
;------------------------------------------------------------------------------
org $82ECBB
JSR.w DrawFileSelectHash

;------------------------------------------------------------------------------
; Injecting arbitrary PLMs.
;------------------------------------------------------------------------------
org $82E8D5
JSL.l InjectPLMs
org $82EB8B
JSL.l InjectPLMs

;------------------------------------------------------------------------------
; New Items
;------------------------------------------------------------------------------
; Starter Charge
org $90B821
BRA HudSelectionHandler_charge
org $90B8F2
BRA FireBeam_charge_equipped
org $90B9E2
JSL InitializeProjectileExpanded

; Suits
org $90E74D
JSR.w PeriodicDamageDivision
org $8DE379
JML.l HeatDamage : NOP #2

; Double Jump
org $90A46E
JSR.w CheckEligibleJump
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
;------------------------------------------------------------------------------
; Credits
;------------------------------------------------------------------------------

; Patch soft reset to retain value of RTA counter
org $80844B
jml patch_reset1
org $808490
jml patch_reset2

; Patch loading and saving routines
org $81807f
jmp patch_save
org $8180f7
jmp patch_load

; Hijack loading new game to reset stats
org $828063
jsl clear_values

; Hijack the original credits code to read the script from bank $DF

org $8b9976
jml scroll
org $8b999b
jml patch1
org $8b99e5
jml patch2
org $8b9a08
jml patch3
org $8b9a19
jml patch4



; Hijack when samus is in the ship and ready to leave the planet
org $a2ab13
jsl game_end

; Hijack after decompression of regular credits tilemaps
org $8be0d1
jsl copy

pullpc
