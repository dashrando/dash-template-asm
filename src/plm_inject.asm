org $82E8D5
JSL.l InjectPLMs
org $82EB8B
JSL.l InjectPLMs

injectplms:
    ldx.w #$0000
-
    ; check if the plm goes in this room, if the table is $0000 then exit
    lda.l customplmtable,x : beq .end
    cmp.w $079b : bne .next
        phx : txa : clc ; ok, spawn the plm
        adc.w customplmtable+$2 : tax
        lda.w $0000,x
        jsl.l $84846a
        plx
.next
    txa : clc
    adc.w #$0008 : tax
    bra -
.end
    jsl.l $8fe8a3  ; execute door asm
    rtl
