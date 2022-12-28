;------------------------------------------------------------------------------
; Init
;------------------------------------------------------------------------------
; We can put any kind of initialization here. A lot of things we may want to
; modify are in bank $80 but there's room for long routines as well.
;------------------------------------------------------------------------------

InitGameState:
        LDA.w GameState : CMP.w #$001F : BNE .ret
        LDA.l $7ED7E2 : BNE .ret ; TODO: Fresh file save marker
                ; Construction zone and red tower elevator doors
                LDA.l DoorBitArray+$06 : ORA.w #$0004 : STA.l DoorBitArray+$06
                LDA.l DoorBitArray+$02 : ORA.w #$0001 : STA.l DoorBitArray+$02
                LDA.w SaveSlotSelected
                JSL.l SaveToSRAM
                .ret:   
                LDA.w #$0000
RTL
