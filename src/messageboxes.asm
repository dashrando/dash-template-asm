; Bank 85
; Borrowed from total and Kejardon's Message Box v4

!Big = $825A
!Small = $8289
!EmptyBig = #$8441
!EmptySmall = $8436
!Shot = #$83C5
!Dash = #$83CC
!Jump = #$8756
!ItemCancel = #$875D
!ItemSelect = #$8764
!AimDown = #$876B
!AimUp = #$8773

dw !EmptySmall, !Small, double_jump
dw !EmptySmall, !Small, heat_shield
dw !EmptySmall, !Small, pressure_valve
dw !EmptySmall, !Small, beam_upgrade
dw !EmptySmall, !Small, BtnArray

table data/box.tbl,rtl
double_jump:
dw "______    DOUBLE JUMP    _______"
heat_shield:
dw "______    HEAT SHIELD    _______"
pressure_valve:
dw "______   PRESSURE VALVE  _______"
beam_upgrade:
dw "______   CHARGE UPGRADE  _______"

cleartable

BtnArray:
dw $0000, $012A, $012A, $012C, $012C, $012C, $0000, $0000, $0000, $0000, $0000, $0000, $0120, $0000, $0000
dw $0000, $0000, $0000, $012A, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

fix_1c1f:
; if $CE is set, it overrides the message box
        LDA.b $CE : BEQ +
                STA.w $1C1F
                STZ.b $CE
        +
	LDA.w $1C1F
	CMP.w #$001D
	BPL +
	        RTS
        +
	ADC.w #$027F
RTS

SetMessageBoxFlag:
        STA.w $1C1F ; What we wrote over
        INC.w MessageBoxFlag
RTS

UnsetMessageBoxFlag:
        JSR.w $80FA ; What we wrote over
        STZ.w MessageBoxFlag
RTS

MessageBoxTimer:
        LDA.l NoFanfare : BNE +
                LDX.w #$0168
                RTS
        +
        LDX.w #$000A
RTS

MessageBoxPostLagFrame:
        JSR.w MessageBoxCloseHDMA
        JSR.w MessageBoxWaitForLagFrame
RTS

MessageBoxHDMA:
                LDA.b #$03 : STA.w $4300
                LDA.b #$21 : STA.w $4301
                REP #$20
                LDA.w #HUDHDMAWRAM : STA.w $4302
                SEP #$20
                LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
                LDA.b #$41 : STA.w $420C ; What we wrote over
RTS

MessageBoxInitHDMA:
                LDX.w #$2103 : STX.w $4300
                LDX.w #HUDHDMAWRAM : STX.w $4302
                LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
                LDA.b #$01 : STA.w $420C ; What we wrote over

                REP #$20
                LDA.w #$0BB1 : STA.l HUDHDMAWRAM+3+(5*8) ; Set message box vanilla palette colors
                LDA.w #$001F : STA.l HUDHDMAWRAM+3+(5*9) ; Could also make affected tiles use palette 7?
                SEP #$20
                LDA.b #$05 : STA.w $2121
                LDA.b #$0F : STA.w $2122
                LDA.b #$70 : STA.w $2122

                LDA.b #$06 : STA.w $2121
                LDA.b #$FF : STA.w $2122
                LDA.b #$7F : STA.w $2122

                LDA.b #$19 : STA.w $2121
                LDA.b #$87 : STA.w $2122
                LDA.b #$36 : STA.w $2122

                LDA.b #$1A : STA.w $2121
                LDA.b #$FF : STA.w $2122
                LDA.b #$7F : STA.w $2122

                LDA.b #$1E : STA.w $2121
                LDA.b #$FF : STA.w $2122
                LDA.b #$7F : STA.w $2122
RTS

MessageBoxCloseHDMA:
                LDA.b #$03 : STA.w $4300
                LDA.b #$21 : STA.w $4301
                LDX.w #HUDHDMAWRAM : STX.w $4302
                LDA.b #HUDHDMAWRAM>>16 : STA.w $4304

                LDA.l HDMAChannelsCached : ORA.b #$01
                STA.w $420C ; What we wrote over

                REP #$20
                LDA.l PaletteBuffer+$32 : STA.l HUDHDMAWRAM+3+(5*8)
                LDA.l PaletteBuffer+$34 : STA.l HUDHDMAWRAM+3+(5*9)
                SEP #$20
RTS
