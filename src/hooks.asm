pushpc
;------------------------------------------------------------------------------
; Hooks
;------------------------------------------------------------------------------
; This module hooks our code into the vanilla routines. In some cases smaller
; data writes or overwriting smaller bits of vanilla code can go here.
;------------------------------------------------------------------------------

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
org $90E74D
JSR.w HandlePeriodicDamage ; Replace vanilla handling with our own.
; Gravity Suit
org $8DE379
LDA.w VanillaItemsEquipped : AND.w #$0001 ; Remove vanilla gravity heat protection

; Double Jump
org $90A46E
JMP.w CheckEligibleJump : NOP #5
org $90A4BF
JSR.w CheckDoubleJump
org $91F0A5
JSR.w ClearJumpFlag

pullpc
