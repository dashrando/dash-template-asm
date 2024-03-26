;------------------------------------------------------------------------------
; Init
;------------------------------------------------------------------------------
; We can put any kind of initialization here. A lot of things we may want to
; modify are in bank $80 but there's room for long routines as well.
;------------------------------------------------------------------------------

InitGameState:
        LDA.w GameState : CMP.w #$001F : BNE .ret
        .main
        LDA.l FreshFileMarker : BIT.w #$0002 : BNE .ret
                ORA.w #$0002 : STA.l FreshFileMarker

                ; Equip charge beam if needed
                LDA.l ChargeMode : AND.w #$0003 : BEQ + 
                        LDA.w BeamsCollected : ORA.w #$1000 : STA.w BeamsCollected
                        LDA.w BeamsEquipped : ORA.w #$1000 : STA.w BeamsEquipped
                +
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
        LDA.l HUDBitField : AND.w #$00FF : STA.w HUDFlags
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
        LDA.w #ActivateHDMA : STA.w HUDHDMAPtr
        LDA.w #$FFFF : STA.w SubAreaIndex
        LDA.l BootTest+$00 : EOR.l BootTestInverse+$00 : CMP.w #$FFFF : BNE .coldboot
        LDA.l BootTest+$02 : EOR.l BootTestInverse+$02 : CMP.w #$FFFF : BNE .coldboot
        LDA.l CurrentSaveSlotSRAM : BEQ .coldboot
                DEC
                JSL.l WriteExtendedStats
                BRA .hud_hdma_table
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
        .hud_hdma_table
        LDX.w #$0032
        -
                LDA.l HUDHDMAOne,X : STA.l HUDHDMAWRAM,X
                DEX #2
        BPL -
        .sram
        PEA.w $7000 : PLB : PLB
        LDA.w SRAMInitialized+$00 : EOR.w SRAMInitializedInverse+$00 : CMP.w #$FFFF : BNE .init_sram
        LDA.w SRAMInitialized+$02 : EOR.w SRAMInitializedInverse+$02 : CMP.w #$FFFF : BNE .init_sram
        BRA .done
        .init_sram
        LDX.w #$0FFE
        -
                STZ.w $2000,X
                STZ.w $3000,X
                STZ.w $4000,X
                STZ.w $5000,X
                STZ.w $6000,X
                STZ.w $7000,X
                DEX #2
        BPL -
        LDA.w #$5A5A : STA.w SRAMInitialized+$00 : STA.w SRAMInitialized+$02
        LDA.w #$A5A5 : STA.w SRAMInitializedInverse+$00 : STA.w SRAMInitializedInverse+$02
        .done
        PHK : PLB
JMP.w $84B1

