; Original suits modifications by Smiley & MassHesteria

HandlePeriodicDamage:
        PHP : REP #$30
        LDA.w TimeFrozenFlag : BEQ +
                JMP.w $EA3D
        +
        ; Check damage reduction items from most reduction to least
        LDA.w VanillaItemsEquipped : AND.w #$0021 : CMP.w #$0021 : BEQ .both
                                     BIT.w #$0001 : BNE .varia
                                     BIT.w #$0020 : BNE .gravity
        LDA.w DashItemsEquipped    : BIT.w #$0002 : BNE .heatshield
                BRA .subtract_dmg ; No damage reduction

        .both ; Gravity and Varia stack for full 1/4th reduction
        LDA.w SamusPeriodicSubDamage+$01 : LSR #2
        TAX : XBA : AND.w #$FF00
        STA.w SamusPeriodicSubDamage
        TXA : XBA : AND.w #$00FF
        STA.w SamusPeriodicDamage
        BRA .subtract_dmg

        .varia
        LDA SamusPeriodicSubDamage+$01 : LSR
        TAX : XBA : AND.w #$FF00
        STA.w SamusPeriodicSubDamage
        TXA : XBA : AND.w #$00FF
        STA.w SamusPeriodicDamage
        BRA .subtract_dmg

        .gravity ; Gravity provides 25% reduction
        LDA.w SamusPeriodicSubDamage+$01 : TAX
        LSR #2 : STA.w SamusPeriodicSubDamage+$01    ; Divide by four and store for subtraction
        TXA : CLC : SBC.w SamusPeriodicSubDamage+$01
        BPL +
                LDA.w #$0000 ; Don't kill Samus if carry subtracting 0 from 0.
        +
        TAX : XBA : AND.w #$FF00
        STA.w SamusPeriodicSubDamage
        TXA : XBA : AND.w #$00FF
        STA.w SamusPeriodicDamage
        BRA .subtract_dmg

        .heatshield
        ; TODO:
        ; Efficiently (runs every frame) check area & branch or do arithmetic

        .subtract_dmg
        LDA.w SamusSubDamage : SEC : SBC.w SamusPeriodicSubDamage
        STA.w SamusSubDamage
        LDA.w CurrentHealth : SBC.w SamusPeriodicDamage
        STA.w CurrentHealth
        BPL + ; Branch if still alive
                STZ.w SamusSubDamage : STZ.w CurrentHealth
        +
        STZ.w SamusPeriodicSubDamage : STZ.w SamusPeriodicDamage
        PLP
RTS
