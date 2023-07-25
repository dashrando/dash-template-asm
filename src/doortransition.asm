FixDoorBits:
        PHA
        STZ.w DoorDirection
        LDA.w DoorMisaligned : BIT.w #$0002 : BNE +
                LDA $01,S
                STA.w DoorDirection
        +
        PLA
RTS

pushpc
org $94DC00
HandleEnterDoor:
        LDA.l $8f0000,X
        PHA : PHX
        STZ.w DoorMisaligned
        LDX.w #0
.loop:
    lda.l DoorDirectionTable,X
    beq .done
    cmp $01,S
    beq .search
    inx #4
    bra .loop
.search:
    lda.l DoorDirectionTable+2,X
    sta $01,S
    ldx.w #0
    .inner:
        lda.l DoorVectorTable,X
        beq .done
        cmp $03,S
        beq .compare
        inx #4
        bra .inner
    .compare:
        lda.l DoorVectorTable+2,X
        cmp $01,S
        beq .done

        lda.w #1
        sta.w DoorMisaligned
        lda.l DoorVectorTable+2,X
        cmp.w #3
        bcc .done
        lda.w #3
        sta.w DoorMisaligned
.done:
plx
pla

RTS
warnpc $94E000
pullpc