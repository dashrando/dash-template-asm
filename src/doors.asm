;------------------------------------------------------------------------------
; Doors
;------------------------------------------------------------------------------
PreOpenG4:
        LDA.l BossFlagsVanilla : BIT.w #$0100 : BEQ +
        LDA.l BossFlagsVanilla+$02 : AND.w #$0101 : CMP.w #$0101 : BNE +
        LDA.l EventFlags
        ORA.w #$0400
        STA.l EventFlags
+
RTS

WakeUpZebes: 
    LDA.l ItemBitArray+$02 : BIT.w #$0400 : BEQ .exit ; TODO: Fresh file save marker
    LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags
.exit
RTS

BTAnimalsDoor: ; Not sure what this is for
        LDA.l EventFlags : BIT.w #$4000 : BEQ .exit
        LDA.w #$0026 : STA.w GameState
.exit
RTS
;------------------------------------------------------------------------------
; Door ASM Pointers
;------------------------------------------------------------------------------
pushpc

org $838EB4 ; Into Construction Zone
dw WakeUpZebes

org $838C5C ; G4 Elevator
dw PreOpenG4

org $838BCC
dw BTAnimalsDoor

pullpc
