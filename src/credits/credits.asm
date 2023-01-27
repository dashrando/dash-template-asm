
StatsPrepFinal:
        PHY : PHP
        LDA.l CurrentSaveSlotSRAM : DEC
        JSL.l LoadStats
        PEA.w StatsTables>>8 : PLB : PLB
        REP #$30
        STZ.w $0787 ; Current stat index
        LDA.w #StatsBlock>>16 : STA.b $89
        .loop
        LDA.w $0787 : TAX
        LDA.w StatsTables_type,X : AND.w #$00FF : ASL : TAX
        JMP.w (.type,X)
.number:
        ;ASL : TAX
        LDA.w $0787 : ASL : TAX
        LDA.w StatsTables_ram,X : STA.b $87
        LDA.w StatsTables_row,X : TAY
        LDA.b [$87]
        JSR.w DrawValue
        INC.w $0787
        BRA .loop
.time
        ;ASL : TAX
        LDA.w $0787 : ASL : TAX
        LDA.w StatsTables_ram,X : STA.b $87
        LDA.w StatsTables_row,X : TAY
        LDA.b $87
        JSR.w DrawFullTime
        INC.w $0787
        BRA .loop
.done:
        PLP : PLY
RTL

.type
dw .done ; 0
dw .number ; 1
dw .time ; 2

; $10-$14 frames 32 bit
; $16 hours
; $17 minutes
; $18 seconds
; $19 frames
; $1A-$1D scratch

DrawFullTime:
        PHX : PHB
        PEA.w StatsBlock>>8 : PLB : PLB
        TAX
        LDA.w $0000,X : STA.l $7E0014
        LDA.w $0002,X : STA.l $7E0016
        LDA.w #$003C  : STA.l $7E0012
        LDA.w #$FFFF  : STA.l $7E001A
        PLB
        JSR.w div32
        INY #6
        LDA.b $16
        JSR.w DrawTwo
        TYA : SEC : SBC.w #$0010
        TAY
        LDA.b $14
        JSR.w DrawTime
        PLX
RTS

; Draw time as xx:yy:zz
DrawTime:
        PHY : PHX : PHB
        DEY #6
        PHK : PLB
        ;PEA.w StatsBlock>>8 : PLB : PLB
        STA.w $4204
        LDA.w #$FFFF : STA.b $1A
        LDA.w #$003C : STA.w $4206
        NOP #8
        LDA.w $4216  : STA.b $12
        LDA.w $4214  : STA.w $4204
        LDA.w #$003C : STA.w $4206
        NOP #8
        LDA.w $4216 : STA.b $14
        LDA.w $4214
        JSR.w DrawTwo
        INY #2
        LDA.b $14
        ;JSR.w DrawTwo
        INY #2
        LDA.b $12
        ;JSR.w DrawTwo
        PLB : PLX : PLY
RTS

; Draw 5-digit value to credits tilemap
; A = number to draw, Y = row address
DrawValue:
        PHY : PHX : PHB
        STZ.b $1A ; Leading zeroes flag
        STA.w $4204
        LDA.w #0100 : STA.w $4206
        NOP #8
        LDA.w $4216 : PHA
        LDA.w $4214
        JSR.w DrawThree
        PLA
        JSR.w DrawTwo
        PLB : PLX : PLY
RTS

DrawThree:
        LDX.w #0100
        STA.w $4204
        STX.w $4206
        NOP #8
        LDA.w $4214 : BEQ +
                JSR.w DrawDigit
        +
        INY #2
        LDA.w $4216 : STA.w $4204
        LDA.w #0010 : STA.w $4206
        NOP #8
        LDA.w $4214 : BEQ +
                JSR.w DrawDigit
        +
        INY #2
        LDA.w $4216 : BEQ +
                JSR.w DrawDigit
        +
        INY #2
RTS

DrawTwo:
        STA.w $4204
        LDA.w #0010 : STA.w $4206
        NOP #8
        LDA.w $4214 : CMP.b $1A : BEQ +
                JSR.w DrawDigit                
        +
        INY #2
        LDA.w $4216
        JSR.w DrawDigit
RTS

DrawDigit:
        PHB
        ASL : TAX
        PEA.w $7F00 : PLB : PLB
        LDA.l CreditsNumbersTop,X : STA.w $0034,Y
        LDA.l CreditsNumbersBottom,X : STA.w $0074,Y
        PLB
RTS

; 32-bit by 16-bit division routine I found somewhere
div32:
        PHY : PHX : PHP : PHB
        REP #$30
        SEC
        LDA.b $16 : SBC.b $12 : BCS .uoflo
        LDX.w #$0011
.ushftl
        ROL.b $14
        DEX : BEQ .umend
        ROL.b $16
        LDA.w #$0000 : ROL : STA.b $18
        SEC
        LDA.b $16 : SBC.b $12 : TAY
        LDA.b $18
        SBC.w #$0000 : BCC .ushftl
        STY.b $16
        BRA .ushftl
.uoflo
        LDA.w #$FFFF
        STA.b $14 : STA.b $16
.umend
        PLB : PLP : PLX : PLY
RTS

StatsTables:
        .ram         : fillword $0000 : fill (17*2)+2
        .row         : fillword $0000 : fill (17*2)+2
        .type        : fillbyte $00   : fill 17+1
%StatEntry($00, NMIFrames, !row*217, 2)
%StatEntry($01, DoorTransitions, !row*185, 1)
%StatEntry($02, DoorFrames, !row*187, 2)
%StatEntry($03, DoorAlignFrames, !row*189, 2)
%StatEntry($04, CrateriaFrames, !row*192, 2)
%StatEntry($05, BrinstarFrames, !row*194, 2)
%StatEntry($06, NorfairFrames, !row*196, 2)
%StatEntry($07, WreckedShipFrames, !row*198, 2)
%StatEntry($08, MaridiaFrames, !row*200, 2)
%StatEntry($09, TourianFrames, !row*202, 2)
%StatEntry($0A, ChargedShots, !row*205, 1)
%StatEntry($0B, SpecialBeamsFired, !row*207, 1)
%StatEntry($0C, MissilesFired, !row*209, 1)
%StatEntry($0D, SupersFired, !row*211, 1)
%StatEntry($0E, PowerBombsLaid, !row*213, 1)
%StatEntry($0F, BombsLaid, !row*215, 1)
%StatEntry($10, $0000, $0000, 0)


CopyCreditsTileMap:
        PHA : PHX : PHB
        LDX.w #$0000
        -
                LDA.l credits,x : CMP.w #$DEAD : BEQ +
                        STA.l $7F2000,X
                        INX #2
                        BRA -
        +
        LDX.w #$0000
        -
                LDA.l itemlocations,X : BEQ +
                        STA.l $7FA000,X
                        INX #2
                        BRA -
        +
        LDA.w #$0002 : STA.l CreditsScrollSpeed
        JSL.l StatsPrepFinal
        PLB : PLX : PLA
        JSL.l ClearBGObjects
RTL

