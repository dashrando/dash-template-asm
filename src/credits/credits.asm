
StatsPrepFinal:
        PHY : PHP
        LDA.l CurrentSaveSlotSRAM : DEC
        JSL.l LoadStats ; Load stats saved at ship. Final cinematic uses ALL of bank $7F.
        PEA.w StatsTables>>8 : PLB : PLB
        REP #$30
        STZ.w $0787 ; Current stat index
        LDA.w #StatsBlock>>16 : STA.b $89
        .loop
        LDA.w $0787 : TAX
        LDA.w StatsTables_type,X : AND.w #$00FF : ASL : TAX
        JMP.w (.type,X)
.number:
        LDA.w $0787 : ASL : TAX
        LDA.w StatsTables_ram,X : STA.b $87
        LDA.w StatsTables_row,X : TAY
        LDA.b [$87]
        JSR.w DrawValue
        INC.w $0787
        BRA .loop
.time
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

; Draw time as xx:yy:zz.ff
DrawFullTime:
        PHX : PHB
        PEA.w StatsBlock>>8 : PLB : PLB
        TAX
        LDA.w $0000,X : STA.l $7E0014
        LDA.w $0002,X : STA.l $7E0016
        LDA.w #$003C  : STA.l $7E0012
        LDA.w #$FFFF  : STA.l $7E001A
        PLB
        JSR.w Div32
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
        LDA.w $4216  : STA.b $12 ; seconds
        LDA.w $4214  : STA.w $4204
        LDA.w #$003C : STA.w $4206
        NOP #8
        LDA.w $4216 : STA.b $14 ; minutes
        LDA.w $4214
        JSR.w DrawTwo
        INY #2
        LDA.b $14
        JSR.w DrawTwo
        INY #2
        LDA.b $12
        JSR.w DrawTwo
        PLB : PLX : PLY
RTS

; Draw 5-digit value to credits tilemap
DrawValue:
; In: A - value, Y - row address
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
        LDA.w #$FFFF : STA.b $1A
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
        INY #2
RTS

DrawDigit:
        PHB
        ASL : TAX
        PEA.w $7F00 : PLB : PLB
        LDA.l CreditsNumbersTop,X : STA.w $0034,Y
        LDA.l CreditsNumbersBottom,X : STA.w $0074,Y
        PLB
RTS

Div32:
; In: $12 - 16-bit divisor, $14 - 32-bit dividend
; Out: $14 - quotient (seconds), $16 - remainder (frames)
        PHY : PHX : PHP : PHB
        REP #$30
        SEC
        LDA.b $16 : SBC.b $12 : BCS .overflow
        LDX.w #$0011
.ushftl
        ROL.b $14
        DEX : BEQ .end
        ROL.b $16
        LDA.w #$0000 : ROL : STA.b $18
        SEC
        LDA.b $16 : SBC.b $12 : TAY
        LDA.b $18
        SBC.w #$0000 : BCC .ushftl
        STY.b $16
        BRA .ushftl
.overflow
        LDA.w #$FFFF
        STA.b $14 : STA.b $16
.end
        PLB : PLP : PLX : PLY
RTS

StatsTables:
        .ram  : fillword $0000 : fill ($17*2)+2 ; Size of pointer
        .row  : fillword $0000 : fill ($17*2)+2 ; Size of pointer
        .type : fillbyte $00   : fill $17+1     ; Size of type
%StatEntry($00, NMIFrames, !row*231, 2)
%StatEntry($01, LagFrames, !row*229, 2)
%StatEntry($02, MenuFrames, !row*227, 2)
%StatEntry($03, DoorTransitions, !row*185, 1)
%StatEntry($04, DoorFrames, !row*187, 2)
%StatEntry($05, DoorAlignFrames, !row*189, 2)
%StatEntry($06, CrateriaFrames, !row*192, 2)
%StatEntry($07, GreenBrinstarFrames, !row*194, 2)
%StatEntry($08, RedBrinstarFrames, !row*196, 2)
%StatEntry($09, WreckedShipFrames, !row*198, 2)
%StatEntry($0A, KraidFrames, !row*200, 2)
%StatEntry($0B, UpperNorfairFrames, !row*202, 2)
%StatEntry($0C, LowerNorfairFrames, !row*204, 2)
%StatEntry($0D, CrocomireFrames, !row*206, 2)
%StatEntry($0E, EastMaridiaFrames, !row*208, 2)
%StatEntry($0F, WestMaridiaFrames, !row*210, 2)
%StatEntry($10, TourianFrames, !row*212, 2)
%StatEntry($11, ChargedShots, !row*215, 1)
%StatEntry($12, SpecialBeamsFired, !row*217, 1)
%StatEntry($13, MissilesFired, !row*219, 1)
%StatEntry($14, SupersFired, !row*221, 1)
%StatEntry($15, PowerBombsLaid, !row*223, 1)
%StatEntry($16, BombsLaid, !row*225, 1)
%StatEntry($17, $0000, $0000, 0)

CopyCreditsTileMap:
        PHA : PHX : PHB
        LDX.w #$0000
        -
                LDA.l CreditsTileData,X : CMP.w #$DEAD : BEQ +
                        STA.l $7F2000,X
                        INX #2
                        BRA -
        +
        LDX.w #$0000
        -
                LDA.l CreditsItemLocations,X : BEQ +
                        STA.l $7FA000,X
                        INX #2
                        BRA -
        +
        LDA.w #$0002 : STA.l CreditsScrollSpeed
        JSL.l StatsPrepFinal
        PLB : PLX : PLA
        JSL.l ClearBGObjects
RTL

