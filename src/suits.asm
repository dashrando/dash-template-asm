; Original suits modifications by Smiley & MassHesteria

ApplyPeriodicDamage:
        PHP : REP #$30
        LDA.w TimeFrozenFlag : BEQ +
                JMP.w $EA3D
        +
        LDA.w SamusSubDamage : SEC : SBC.w PeriodicDamage
        STA.w SamusSubDamage
        LDA.w CurrentHealth : SBC.w PeriodicDamage+$02
        STA.w CurrentHealth
        BPL + ; Branch if still alive
                STZ.w SamusSubDamage : STZ.w CurrentHealth
        +
        STZ.w PeriodicDamage : STZ.w PeriodicDamage+$02
        PLP
RTS

HeatDamage:
        LDA.w #$0001 : BIT.w VanillaItemsEquipped : BNE .nodamage
                       BIT.w DashItemsEquipped : BNE .heatshield
        LDA.w #$0020 : BIT.w VanillaItemsEquipped : BNE .gravity
                BRA .fulldamage
        .gravity
if !STD == 0
        LDA.w #$3000 : BRA .applydamage
else
        LDA.w #$2000 : BRA .applydamage
endif
        .heatshield
        LDA.w SubAreaIndex : CMP.w !Area_LowerNorfair : BNE .nodamage
                .halfdamage
                LDA.w #$2000 : BRA .applydamage
        .fulldamage
        LDA.w #$4000
        .applydamage
        CLC : ADC.w PeriodicDamage : STA.w PeriodicDamage
        LDA.w PeriodicDamage+$02 : ADC.w #$0000 : STA.w PeriodicDamage+$02
        JML.l $8DE394
        .nodamage
JML $8DE3AB

LavaDamage: ; Never reached if gravity equipped
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BNE +
                LDA.w PeriodicDamage     : CLC : ADC.w #$8000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0000 : STA.w PeriodicDamage+$02
                JMP.w AnimateSamusLavaAcid
        +
        LDA.w PeriodicDamage     : ADC.w #$4000 : STA.w PeriodicDamage
        LDA.w PeriodicDamage+$02 : ADC.w #$0000 : STA.w PeriodicDamage+$02
JMP.w AnimateSamusLavaAcid

AcidDamage:
        LDA.w VanillaItemsEquipped : AND.w #$0021 : CMP.w #$0021 : BEQ .3_4
                                     BIT.w #$0020 : BNE .half
                                     BIT.w #$0001 : BNE .half
                .full
                LDA.w PeriodicDamage     : CLC : ADC.w #$8000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0001 : STA.w PeriodicDamage+$02
                JMP.w AnimateSamusLavaAcid
                .half
                LDA.w PeriodicDamage     : CLC : ADC.w #$C000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0000 : STA.w PeriodicDamage+$02
                JMP.w AnimateSamusLavaAcid
        .3_4
        LDA.w PeriodicDamage     : CLC : ADC.w #$2000 : STA.w PeriodicDamage
        LDA.w PeriodicDamage+$02       : ADC.w #$0001 : STA.w PeriodicDamage+$02
JMP.w AnimateSamusLavaAcid

SpikeDamage:
        LDA.w VanillaItemsEquipped : AND.w #$0021 : BEQ .full
                                     CMP.w #$0021 : BEQ .1_4
                LDA.w PeriodicDamage+$02 : CLC : ADC.w #$001E
                BRA .done
                .1_4
                LDA.w PeriodicDamage+$02 : CLC : ADC.w #$000F
                BRA .done
        .full
        LDA.w PeriodicDamage+$02 : CLC : ADC.w #$003C
        .done
RTL

pushpc

org $A3EECE ; Unused code
MetroidDamage:
        LDA.w SamusYPos : SEC : SBC.w #$0008 : STA.w BoundaryPosition
        LDA.w #$C000 : STA.b $12
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BEQ +
                LSR.b $12
        +
        BIT.w #$0020 : BEQ +
                LSR.b $12
        +
        LDA.l $7E7804,X : SEC : SBC.b $12 : STA.l $7E7804,X
        BCS +
        LDA.w #$0001
        JSL.l ReceiveDamageSamus 
        +
RTS
warnpc $A3EF07

org $A0A45E ; Unused code
EnemyDamageDivision:
        STA.b $12
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BEQ +
                LSR.b $12
        +
        BIT.w #$0020 : BEQ +
                LSR.b $12
        +
        LDA.b $12
RTL
warnpc $A0A477

pullpc 
