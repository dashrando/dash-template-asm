PostHUDChangePalette:
        PHA
        LDA.w GameState : CMP.w #$0007 : BCC +
                          CMP.w #$0015 : BCS +
        LDA.w MessageBoxFlag : BNE +
                SEP #$30
                JSR.w FindIndex
                PHX
                LDA.b #$03 : STA.b (MultiplyResult)
                INC.b MultiplyResult
                LDA.b #$21 : STA.b (MultiplyResult)
                INC.b MultiplyResult
                REP #$20
                LDA.w #HUDHDMA : STA.b (MultiplyResult)
                SEP #$20
                INC.b MultiplyResult : INC.b MultiplyResult
                LDA.b #HUDHDMA>>16 : STA.b (MultiplyResult)
                PLA
                ORA.b HDMAChannels : STA.w $420C
                REP #$30
        +
        PLA
RTS

HUDHDMA:
db 01 : dw $0000 : dw $0000 ; Scanline zero, noop write to color index 0
db 30 : dw $0909 : dw $48FB ; Scanline one, write vanilla pink color
db 01 : dw $0909 : dw $0BB1 ; Scanline 31, overwrite pink with green (pink written again during vblank I think)
db 00

FindIndex:
        LDA.b #$01
        LDY.b #$00
        -
        BIT.b HDMAChannels : BEQ .found
                ASL : INY : BRA -
        .found
        TAX
        REP #$30
        LDA.w #$4300 : STA.b MultiplyResult
        TYA : ASL #4
        CLC : ADC.b MultiplyResult : STA.b MultiplyResult

        SEP #$30
RTS

MessageBoxHDMA:
                LDA.b #$03 : STA.w $4300
                LDA.b #$21 : STA.w $4301
                REP #$20
                LDA.w #HUDHDMA : STA.w $4302
                SEP #$20
                LDA.b #HUDHDMA>>16 : STA.w $4304
                LDA.b #$41 : STA.w $420C ; What we wrote over
RTL

