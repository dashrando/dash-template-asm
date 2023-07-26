FixTransitionFX:
        PHA
        LDA.w DoorMisaligned : BIT.w #$4000 : BEQ +
        ; Always black out for misaligned doors
        LDA.w #1 : ORA $01,S
        STA $01,S
        +
        PLA
        STA.w CREBitset
RTS

FixDoorBits:
        PHA
        STZ.w DoorDirection
        LDA.w DoorMisaligned : BIT.w #$4000 : BNE +
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
                LDA.l DoorDirectionTable,X
                BEQ .done
                CMP $01,S
                BEQ .search
                TXA : CLC : ADC.w #10 : TAX
                BRA .loop
        .search:
        LDA.l DoorDirectionTable+4,X
        STA $01,S
        LDX.w #0
        .inner:
                LDA.l DoorDirectionTable+2,X
                BEQ .done
                CMP $03,S
                BEQ .compare
                TXA : CLC : ADC.w #10 : TAX
                BRA .inner
        .compare:
        LDA.w #$8000
        STA.w DoorMisaligned
        LDA.l DoorDirectionTable+4,X
        CMP $01,S : BEQ .done
                TXA : ORA.w #$C000
                STA.w DoorMisaligned

        .done:
        PLX : PLA
RTS
warnpc $94E000
pullpc