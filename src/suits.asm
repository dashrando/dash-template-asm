; Original suits modifications by Smiley & MassHesteria

; TODO: Fully separate & properly handle heat, acid, and lava damage.
PeriodicDamageDivision:
        PHP : REP #$30
        LDA.w TimeFrozenFlag : BEQ +
                JMP.w $EA3D
        +
        ; Check damage reduction items from most reduction to least
        LDA.w VanillaItemsEquipped : TAX
                                     AND.w #$0021 : CMP.w #$0021 : BEQ .both
                                     BIT.w #$0001 : BNE .varia
        LDA.w DashItemsEquipped    : BIT.w #$0002 : BNE .varia
        TXA                        : BIT.w #$0020 : BNE .gravity
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

HeatDamage:
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BNE .nodamage
        LDA.w DashItemsEquipped : BIT #$0002 : BEQ .fulldamage
                LDA.l SubAreaIndex : CMP.w !Area_LowerNorfair : BNE .nodamage
                        .halfdamage
                        LDA.w SamusPeriodicSubDamage
                        CLC : ADC.w #$2000
                        STA.w SamusPeriodicSubDamage
                        JML.l $8DE38B
        .fulldamage
        LDA.w SamusPeriodicSubDamage
        CLC : ADC.w #$4000
        STA.w SamusPeriodicSubDamage
        JML.l $8DE38B
        .nodamage
JML $8DE3AB
