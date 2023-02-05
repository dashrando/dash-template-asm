;------------------------------------------------------------------------------
; Credits Scroll
;------------------------------------------------------------------------------
; Our set scroll command for the credits and a routine to handle processing it.
;
; Bank $8B
;------------------------------------------------------------------------------

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
