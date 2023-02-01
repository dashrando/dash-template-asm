; Bank $8B

; Load credits script data from bank $df instead of $8c
SetScroll:
        REP #$30
        PHB
        PEA.w CreditsScript>>8 : PLB : PLB
        LDA.w $0000,Y
        STA.l CreditsScrollSpeed
        INY #2
        PLB
RTS

ScrollCredits:
        INC.w $1995
        LDA.w $1995 : CMP.l CreditsScrollSpeed : BEQ +
                LDA.w $1997
                JML.l $8B9989
        +
        STZ.w $1995
        INC.w $1997
        LDA.w $1997
        JML.l $8B9989
