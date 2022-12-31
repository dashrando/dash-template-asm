; Bank $8B

; Load credits script data from bank $df instead of $8c
set_scroll:
    rep #$30
    phb : pea.w $DF00 : plb : plb
    lda $0000,y
    sta !scroll_speed
    iny
    iny
    plb
    rts

scroll:
    inc $1995
    lda $1995
    cmp !scroll_speed
    beq +
    lda $1997
    jml $8b9989
+
    stz $1995
    inc $1997
    lda $1997
    jml $8b9989
