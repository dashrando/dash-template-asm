;------------------------------------------------------------------------------
; Suits
;------------------------------------------------------------------------------
; Code related to suit changes and new DASH suit items. Some code related to the
; DASH suits may also be found in newitems.asm and newplms.asm.
;------------------------------------------------------------------------------

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
        PHX
        LDA.w #$0001 : BIT.w VanillaItemsEquipped : BNE .varia
                       BIT.w DashItemsEquipped : BNE .heatshield
        LDA.w #$0020 : BIT.w VanillaItemsEquipped : BNE .gravity
                BRA .fulldamage
        .varia
        LDX.w  #$0008 : BRA .applydamage
        .gravity
        LDX.w  #$0002 : BRA .applydamage
        .heatshield
        LDA.w SubAreaIndex : CMP.w !Area_LowerNorfair : BEQ .lowernorfair
                LDX.w #$0004 : BRA .applydamage
        .lowernorfair
        LDX.w #$0006 : BRA .applydamage
        .fulldamage
        LDX.w #$0000
        .applydamage
        LDA.l HeatDamageTable,X : BEQ .nodamage
        CLC : ADC.w PeriodicDamage : STA.w PeriodicDamage
        LDA.w PeriodicDamage+$02 : ADC.w #$0000 : STA.w PeriodicDamage+$02
        PLX
        JML.l $8DE394
        .nodamage
        PLX
JML $8DE3AB

LavaDamage: ; Never reached if gravity equipped
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BNE +
                LDA.w PeriodicDamage     : CLC : ADC.w #$8000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0000 : STA.w PeriodicDamage+$02
                JMP.w AnimateSamusLavaAcid
        +
        LDA.w PeriodicDamage     : ADC.w #$2000 : STA.w PeriodicDamage
        LDA.w PeriodicDamage+$02 : ADC.w #$0000 : STA.w PeriodicDamage+$02
JMP.w AnimateSamusLavaAcid

AcidDamage:
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BNE .1_4
                                     BIT.w #$0020 : BNE .half
                .full
                LDA.w PeriodicDamage     : CLC : ADC.w #$8000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0001 : STA.w PeriodicDamage+$02
                JMP.w AnimateSamusLavaAcid
                .half
                LDA.w PeriodicDamage     : CLC : ADC.w #$C000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0000 : STA.w PeriodicDamage+$02
                JMP.w AnimateSamusLavaAcid
        .1_4
        LDA.w PeriodicDamage     : CLC : ADC.w #$6000 : STA.w PeriodicDamage
        LDA.w PeriodicDamage+$02       : ADC.w #$0000 : STA.w PeriodicDamage+$02
JMP.w AnimateSamusLavaAcid

SpikeDamage:
        STZ.w DoubleJumpFlag
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BNE .1_4
                                     BIT.w #$0020 : BNE .half
                .full
                LDA.w PeriodicDamage+$02 : CLC : ADC.w #$003C
                RTL
                .half
                LDA.w PeriodicDamage+$02 : CLC : ADC.w #$001E
                RTL
        .1_4
        LDA.w PeriodicDamage+$02 : CLC : ADC.w #$000F
RTL

SmallSpikeDamage:
        STZ.w DoubleJumpFlag
        LDA.w VanillaItemsEquipped : BIT.w #$0001 : BNE .1_4
                                     BIT.w #$0020 : BNE .half
                .full
                LDA.w PeriodicDamage+$02 : CLC : ADC.w #$0010
                RTL
                .half
                LDA.w PeriodicDamage+$02 : CLC : ADC.w #$0008
                RTL
        .1_4
        LDA.w PeriodicDamage+$02 : CLC : ADC.w #$0004
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

org $A9C2E5 ; Unused code
MotherBrainDamage:
        LDX.w EnemyIndex
        LDA.w EnemyData,X : TAX
        LDA.l $A00006,X : STA.b $12
        LDA.w VanillaItemsEquipped : AND.w #$0021 : BEQ +
                LSR.b $12
                BIT.w #$0020 : BEQ +
                        LSR.b $12
        +
        LDA.b $12
        JSL.l ReceiveDamageSamus
RTS
warnpc $A9C313

pullpc 
