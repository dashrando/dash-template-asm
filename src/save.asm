; Bank $81

LoadSaveExpanded:
; In: A - Save index
        TAX
        LDA.l ColdBootFlag : BNE .loadstats
        TXA : INC : CMP.l CurrentSaveSlotSRAM : BEQ +
                .loadstats
                TXA : STA.l CurrentSaveSlotSRAM
                JSR.w LoadStats
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
        LDA.w #$5A5A : STA.l BootTest+$02
        LDA.w #$A5A5 : STA.l BootTestInverse
        LDA.w #$A5A5 : STA.l BootTestInverse+$02
        LDA.w #$0000 : STA.l ColdBootFlag
RTS

OnWriteSave:
        JSL.l WriteStats
        INC : STA.l CurrentSaveSlotSRAM : DEC
        PEA.w $7E00 : PLB : PLB ; What we wrote over
RTL

ClearExtendedBuffers:
        PEA $7E00 : PLB : PLB
        STZ.w $09EC : STZ.w $09EE ; Reclaimed section of mirrored WRAM buffer
        STZ.w $09F0 : STZ.w $09F2
        STZ.w $09F4 : STZ.w $09F6
        STZ.w $09F8 : STZ.w $09FA
        STZ.w $09FC : STZ.w $09FE
        STZ.w $0A00
        
        PEA $7F00 : PLB : PLB
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
        LDA.w CopyClearSource : ASL : TAX
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

StatsSRAMOffsets:
dw SlotOneStatsSRAM
dw SlotTwoStatsSRAM
dw SlotThreeStatsSRAM

WriteStats:
; In: A - Save index
        PHA
        ASL : TAX
        PHK : PLB
        LDA.w StatsSRAMOffsets,X : STA.b $00
        LDA.w #$0070 : STA.b $03
        LDY.w #$0000 ; Stats block $100 bytes
        LDX.w #$00FE
        PEA $7F00 : PLB : PLB
        -
                 LDA.w StatsBlock,Y : STA.b [MultiplyResult],Y
                 INY #2
                 DEX #2
        BPL -
        PLA
RTL

LoadStats:
        PHA
        ASL : TAX
        PHK : PLB
        LDA.w StatsSRAMOffsets,X : STA.b MultiplyResult
        LDA.w #$0070 : STA.b MultiplyResult+$02 ; Scratch space
        LDY.w #$0000
        LDX.w #$00FE
        PEA $7F00 : PLB : PLB
        -
                 LDA.b [MultiplyResult],Y : STA.w StatsBlock,Y
                 INY #2
                 DEX #2
        BPL -
        PLA
        PHK : PLB
RTS

; In: A - Save index

; ; Defines for the script and credits data
; !speed = $f770
; !set = $9a17
; !delay = $9a0d
; !draw = $0000
; !end = $f6fe, $99fe
; !blank = $1fc0
; !row = $0040
; 
; !last_saveslot = $7fffe0
; !timer_backup1 = $7fffe2
; !timer_backup2 = $7fffe4
; !softreset = $7fffe6
; !scroll_speed = $7fffe8
; 
; ; Patch soft reset to save the value of the RTA timer
; patch_reset1:
;     lda !softreset ; Check if we're softresetting
;     cmp #$babe
;     beq save_timer
;     lda #$babe
;     sta !softreset
;     lda #$0000
;     sta !timer_backup1
;     sta !timer_backup2
;     sta !last_saveslot
;     bra skipsave
; save_timer:
;     lda !timer1
;     sta !timer_backup1
;     lda !timer2
;     sta !timer_backup2
; skipsave:
;     ldx #$1ffe
;     lda #$0000
; -
;     stz $0000,x
;     dex
;     dex
;     bpl -
;     lda !timer_backup1
;     sta !timer1
;     lda !timer_backup2
;     sta !timer2
;     jml $808455
; 
; patch_reset2:
;     lda !timer1
;     sta !timer_backup1
;     lda !timer2
;     sta !timer_backup2
;     ldx #$1ffe
; -
;     stz $0000,x
;     stz $2000,x
;     stz $4000,x
;     stz $6000,x
;     stz $8000,x
;     stz $a000,x
;     stz $c000,x
;     stz $e000,x
;     dex
;     dex
;     bpl -
; 
;     ldx #$00df          ; clear temp variables
;     lda #$0000
; -
;     sta $7fff00,x
;     dex
;     dex
;     bpl -
; 
;     lda !timer_backup1
;     sta !timer1
;     lda !timer_backup2
;     sta !timer2
;     jml $8084af
; 
; 
; ; Patch load and save routines
; pushpc
; org $81ef20
; patch_save:
;     lda !timer1
;     sta $7ffc00
;     lda !timer2
;     sta $7ffc02
;     jsl save_stats
;     lda $7e0952
;     clc
;     adc #$0010
;     sta !last_saveslot
;     ply
;     plx
;     clc
;     plb
;     plp
;     rtl
; 
; patch_load:
;     lda $7e0952
;     clc
;     adc #$0010
;     cmp !last_saveslot      ; If we're loading the same save that's played last
;     beq +                   ; don't restore stats from SRAM, only do this if
;     jsl load_stats          ; a new save slot is loaded, or loading from hard reset
;     lda $7ffc00
;     sta !timer1
;     lda $7ffc02
;     sta !timer2
; +
;     ply
;     plx
;     clc
;     plb
;     rtl
; pullpc
