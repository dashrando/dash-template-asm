; Bank $81

LoadSaveExpanded:
; In: A - Save index
        TAX
        LDA.l ColdBootFlag : BNE .loadstats
        TXA : INC : CMP.l CurrentSaveSlotSRAM : BEQ +
                .loadstats
                TXA : STA.l CurrentSaveSlotSRAM
                JSL.l LoadStats
                PHK : PLB
        +
        JSR.w SetBootTest
        
        LDA.w FileSelectCursor
        JSL.l LoadSave : BCS .newfile  ; What we wrote over
                JSL.l LoadMapMirror
                RTS
        .newfile
        JSR.w NewSaveFile
        JSR.w ClearExtendedBuffers ; We've read from uninitialized SRAM
        STZ.w AreaMapFlag
RTS

SetBootTest:
        LDA.w #$5A5A : STA.l BootTest
                       STA.l BootTest+$02
        LDA.w #$A5A5 : STA.l BootTestInverse
                       STA.l BootTestInverse+$02
        LDA.w #$0000 : STA.l ColdBootFlag
RTS

OnWriteSave:
        JSL.l WriteStats
        INC : STA.l CurrentSaveSlotSRAM : DEC
        PEA.w $7E00 : PLB : PLB ; What we wrote over
RTL

ClearExtendedBuffers:
        PEA.w $7E00 : PLB : PLB
        STZ.w $09EC : STZ.w $09EE ; Reclaimed section of mirrored WRAM buffer
        STZ.w $09F0 : STZ.w $09F2
        STZ.w $09F4 : STZ.w $09F6
        STZ.w $09F8 : STZ.w $09FA
        STZ.w $09FC : STZ.w $09FE
        STZ.w $0A00
        
        PEA.w StatsBlock>>8 : PLB : PLB
        LDX.w #$003E
        -
                STZ.w $FB00,X ; Stats block
                STZ.w $FB40,X
                STZ.w $FB80,X
                STZ.w $FBC0,X
                STZ.w $FC00,X
                STZ.w $FC40,X
                STZ.w $FC80,X
                STZ.w $FCC0,X
                DEX #2
        BPL -
        PHK : PLB
RTS

ClearExtendedSRAM:
        PHX : PHY
        LDA.w CopyClearSource : TAX
        INC : CMP.l CurrentSaveSlotSRAM : BNE +
                LDA.w #$0000 : STA.l CurrentSaveSlotSRAM
        +
        TXA
        ASL : TAX
        LDA.w StatsSRAMOffsets,X : TAX
        PEA $7000 : PLB : PLB
        LDY.w #$04FE ; $500 bytes allocated per slot
        -
                STZ.w $0000,X
                INX #2
                DEY #2
        BPL -
        PHK : PLB
        PLY : PLX
        JSR.w LoadMenuTileMap ; What we wrote over
RTS

CopyExtendedBuffers:
        PHX : PHY
        LDA.w CopyClearSource : ASL : TAX
        LDA.w StatsSRAMOffsets,X : STA.b $00
        LDA.w CopyDestination : ASL : TAX
        LDA.w StatsSRAMOffsets,X : STA.b $03
        LDY.w #$0000 : LDX.w #$04FE ; $500 bytes allocated per slot
        -
                LDA.b [$00],Y : STA.b [$03],Y
                INY #2
                DEX #2
        BPL -
        PLY : PLX
        JSR.w LoadMenuTileMap ; What we wrote over
RTS

WriteStats:
; In: A - Save index
        PHA
        ASL : TAX
        PHK : PLB
        LDA.w StatsSRAMOffsets,X : STA.b $00
        LDA.w #$0070 : STA.b $02
        LDY.w #$0000 ; Stats block $100 bytes
        LDX.w #$00FE
        PEA.w StatsBlock>>8 : PLB : PLB
        -
                 LDA.w StatsBlock,Y : STA.b [$00],Y
                 INY #2
                 DEX #2
        BPL -
        PLA
RTL

LoadStats:
        PHA
        ASL : TAX
        PHK : PLB
        LDA.w StatsSRAMOffsets,X : STA.b $00
        LDA.w #$0070 : STA.b $02
        LDY.w #$0000
        LDX.w #$00FE
        PEA.w StatsBlock>>8 : PLB : PLB
        -
                 LDA.b [$00],Y : STA.w StatsBlock,Y
                 INY #2
                 DEX #2
        BPL -
        PLA
RTL

StatsSRAMOffsets:
dw SlotOneStatsSRAM
dw SlotTwoStatsSRAM
dw SlotThreeStatsSRAM
