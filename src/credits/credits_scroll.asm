; Bank $8B

; Load credits script data from bank $df instead of $8c
SetScroll:
        REP #$30
        PHB : PEA.w script>>8 : PLB : PLB
        LDA $0000,Y
        INY #2
        PLB
RTS

scroll:
    inc $1995
    lda $1995
    cmp CreditsScrollSpeed
    beq +
    lda $1997
    jml $8b9989
+
    stz $1995
    inc $1997
    lda $1997
    jml $8b9989
