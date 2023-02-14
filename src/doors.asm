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

pushpc
;------------------------------------------------------------------------------
; Door ASM Pointers
;------------------------------------------------------------------------------
org $838EB4 ; Into Construction Zone
dw WakeUpZebes

org $838C5C ; G4 Elevator
dw PreOpenG4

;------------------------------------------------------------------------------
; Door Edits
;------------------------------------------------------------------------------
if !STD == 0
    org $8FC571 ; Plasma Spark
    dw NoopPLM : dw $0000, $0000 ; Plasma door blue

    org $8FC773         ; Halfie Shaft
    skip 38 : dw NoopPLM : dw $0000, $0000  ; Plasma door blue

    org $8FC611 ; Back door to Draygon
    dw NoopPLM : dw $0000, $0000  ; Make door blue
endif

pullpc

