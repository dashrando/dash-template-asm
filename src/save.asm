;------------------------------------------------------------------------------
; Saving & Loading
;------------------------------------------------------------------------------
; Code for saving and loading our new, non-vanilla data.
;
; Bank $81
;------------------------------------------------------------------------------

LoadSaveExpanded:
; In: A - Save index
        TAX
        LDA.l ColdBootFlag : BNE .loadext
        TXA : INC : CMP.l CurrentSaveSlotSRAM : BEQ +
                .loadext
                TXA : INC : STA.l CurrentSaveSlotSRAM
                DEC
                JSL.l LoadExtendedStats
        +
        LDA.l CurrentSaveSlotSRAM : DEC
        JSR.w LoadExtendedData
        PHK : PLB
        LDA.w FileSelectCursor
        JSL.l LoadSave : BCS .newfile  ; What we wrote over
                JSR.w SetBootTest
                JSL.l LoadMapMirror
                RTS
        .newfile
        JSR.w NewSaveFile
        JSR.w ClearExtendedBuffers ; We've read from uninitialized SRAM
        JSR.w SetBootTest
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
        JSR.w UpdateSaveSlot
        JSL.l WriteExtendedSave
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
        
        PEA.w ExtendedSaveWRAM>>8 : PLB : PLB
        LDX.w #$00FE
        -
                STZ.w $FA00,X
                STZ.w $FB00,X
                STZ.w $FC00,X
                STZ.w $FD00,X
                STZ.w $FE00,X
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
        LDA.w ExtendedSRAMOffsets,X : TAX
        PEA $7000 : PLB : PLB
        LDY.w #$0FFE ; $1000 bytes allocated per slot
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
        LDA.w ExtendedSRAMOffsets,X : STA.b $00
        LDA.w CopyDestination : ASL : TAX
        LDA.w ExtendedSRAMOffsets,X : STA.b $03
        LDY.w #$0000 : LDX.w #$0FFE ; $1000 bytes allocated per slot
        -
                LDA.b [$00],Y : STA.b [$03],Y
                INY #2
                DEX #2
        BPL -
        PLY : PLX
        JSR.w LoadMenuTileMap ; What we wrote over
RTS

WriteExtendedSave:
; In: A - Save index
        PHA
        ASL : TAX
        PHK : PLB
        LDA.w ExtendedSRAMOffsets,X : STA.b $00
        LDA.w #$0070 : STA.b $02
        LDY.w #$0000
        LDX.w #$05EE
        PEA.w ExtendedSaveWRAM>>8 : PLB : PLB
        -
                 LDA.w ExtendedSaveWRAM,Y : STA.b [$00],Y
                 INY #2
                 DEX #2
        BPL -
        PLA
RTL

WriteExtendedStats:
; In: A - Save index
        PHA
        ASL : TAX
        LDA.l StatsSRAMOffsets,X : STA.b $00
        LDA.w #$0070 : STA.b $02
        LDY.w #$0000
        LDX.w #$01FE
        PEA.w StatsBlock>>8 : PLB : PLB
        -
                 LDA.w StatsBlock,Y : STA.b [$00],Y
                 INY #2
                 DEX #2
        BPL -
        PLA
RTL

LoadExtendedData:
        ASL : TAX
        LDA.l DataSRAMOffsets,X : STA.b $00
        LDA.w #$0070 : STA.b $02
        LDY.w #$0000
        LDX.w #$02EE ; Size of data block in bank $7F
        PEA.w DataBlock>>8 : PLB : PLB
        -
                 LDA.b [$00],Y : STA.w DataBlock,Y
                 INY #2
                 DEX #2
        BPL -
RTS

LoadExtendedStats:
        PHA
        ASL : TAX
        LDA.l StatsSRAMOffsets,X : STA.b $00
        LDA.w #$0070 : STA.b $02
        LDY.w #$0000
        LDX.w #$01FE ; Size of stats block in bank $7F
        PEA.w StatsBlock>>8 : PLB : PLB
        -
                 LDA.b [$00],Y : STA.w StatsBlock,Y
                 INY #2
                 DEX #2
        BPL -
        PLA
RTL

ExtendedSRAMOffsets:
dw SlotOneExtendedSRAM
dw SlotTwoExtendedSRAM
dw SlotThreeExtendedSRAM

StatsSRAMOffsets:
dw SlotOneStatsSRAM
dw SlotTwoStatsSRAM
dw SlotThreeStatsSRAM

DataSRAMOffsets:
dw SlotOneDataSRAM
dw SlotTwoDataSRAM
dw SlotThreeDataSRAM

UpdateSaveSlot:
        PHX : PHA

        ; Load the bitmask for the seleted slot
        ASL : TAX : LDA.l GenericBitmasks,X

        ; Selected slot unused? Use it
        BIT.w SaveSlotPresence : BEQ .done

        ; Move to the next slot
        AND.w #$0003
        STA $01,S

        ; Update non-slot SRAM
        STA.w SaveSlotSelected
        STA.l $701FEC
        EOR.w #$FFFF
        STA.l $701FEE
        
        ; Load the bitmask for the new slot
        LDA $01,S
        ASL : TAX : LDA.l GenericBitmasks,X

        .done:
        ; Note save slot has been used
        ORA.w SaveSlotPresence : STA.w SaveSlotPresence
        PLA : PLX
RTS

;------------------------------------------------------------------------------
; New Save Stations
;------------------------------------------------------------------------------

pushpc
org $80C917 : skip 14*4                         ; Maridia Save Stations
dw $D1A3,$A468,$0000,$0000,$0200,$0078,$0060    ; slot #4
dw $CFC9,$A3D8,$0000,$0100,$0500,$0078,$0010    ; slot #5 main street
dw $D104,$A42C,$0000,$0200,$0000,$0078,$0050    ; slot #6 red fish
pullpc
