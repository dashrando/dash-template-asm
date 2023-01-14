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

org $8FC571 ; Plasma Spark
dw $0000    ; Make all doors blue

org $8FC773         ; Halfie Shaft
skip 38 : dw $C8A8  ; Make plasma door blue

pullpc

