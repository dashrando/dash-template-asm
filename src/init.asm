;------------------------------------------------------------------------------
; Init
;------------------------------------------------------------------------------
; We can put any kind of initialization here. A lot of things we may want to
; modify are in bank $80 but there's room for long routines as well.
;------------------------------------------------------------------------------

InitGameState:
        LDA.w GameState : CMP.w #$001F : BNE .ret
        .main
        LDA.l FreshFileMarker : CMP.w #$07 : BEQ .ret
                LDA.l FreshFileMarker : ORA.w #$0004 : STA.l FreshFileMarker
                ; Construction zone and red tower elevator doors
                LDA.l DoorBitArray+$06 : ORA.w #$0004 : STA.l DoorBitArray+$06
                LDA.l DoorBitArray+$02 : ORA.w #$0001 : STA.l DoorBitArray+$02
                LDX.w #$0018
                -
                        LDA.l AreaItemCounts,X : TAY
                        AND.w #$00FF : STA.l MajorCounters,X
                        TYA : XBA : AND.w #$00FF : STA.l TankCounters,X
                        DEX #2
                BPL -
                .save
                LDA.w SaveSlotSelected
                JSL.l SaveToSRAM
        .ret
        LDA.w #$0FF0 : STA.w PreviousBeams ; Force charge HUD draw
        JSL.l InitRightHUDTiles
        INC.w HUDDrawFlag
        LDA.w #$0000
RTL

InitRAM:
        PEA $7E00
        PLB : PLB
        LDX #$1FFE
        -
                STZ $0000,X
                STZ $2000,X
                STZ $4000,X
                STZ $6000,X
                STZ $8000,X
                STZ $A000,X
                STZ $C000,X
                STZ $E000,X
                DEX #2
        BPL -
        LDA.w #HUDChangePalette_done : STA.w HUDHDMAPtr
        LDA.w #$FFFF : STA.w SubAreaIndex
        LDA.l BootTest+$00 : EOR.l BootTestInverse+$00 : CMP.w #$FFFF : BNE .coldboot
        LDA.l BootTest+$02 : EOR.l BootTestInverse+$02 : CMP.w #$FFFF : BNE .coldboot
        LDA.l CurrentSaveSlotSRAM : BEQ .coldboot
                DEC
                JSL.l WriteExtendedStats
                BRA .done
        .coldboot       
        PEA $7F00
        PLB : PLB
        LDX #$1FFE
        -
                STZ $0000,X
                STZ $2000,X
                STZ $4000,X
                STZ $6000,X
                STZ $8000,X
                STZ $A000,X
                STZ $C000,X
                STZ $E000,X
                DEX #2
        BPL -
        LDA.w #$0001 : STA.l ColdBootFlag
        .done
        LDX.w #$0014
        -
                LDA.l HUDHDMAOne,X : STA.l HUDHDMAOneWRAM,X
                LDA.l HUDHDMATwo,X : STA.l HUDHDMATwoWRAM,X
                DEX #2
        BPL -
        PHK : PLB
JMP.w $84B1

