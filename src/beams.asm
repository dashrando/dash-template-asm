;------------------------------------------------------------------------------
; Beam Enhancements
;------------------------------------------------------------------------------

; Setup pointers to damage tables. The first pointer is for an uncharged shot,
; second is a charged shot without charge being equipped (aka starter charge),
; and remaining pointers increment based on number of charge beams collected.
BeamDamagePointers:
; Vanilla
dw vanilla_1x, vanilla_3x, vanilla_3x, vanilla_3x
dw vanilla_3x, vanilla_3x, vanilla_3x, vanilla_3x
; Starter Charge (Legacy)
dw vanilla_1x, vanilla_1x, vanilla_3x, vanilla_3x
dw vanilla_3x, vanilla_3x, vanilla_3x, vanilla_3x
; Progressive
dw balance_1x, balance_1x, balance_2x, balance_3x
dw balance_4x, balance_5x, balance_5x, balance_5x
; Placeholder
dw balance_1x, balance_2x, balance_3x, balance_3x
dw balance_3x, balance_3x, balance_3x, balance_3x


; Beam damage tables
BeamDamageTables:
vanilla_1x: %beam_dmg( 20, 30, 40, 50, 60, 60, 70,100,150,200,250,300)
vanilla_3x: %beam_dmg( 60, 90,120,150,180,180,210,300,450,600,750,900)

balance_1x: %beam_dmg( 20, 30, 40, 50, 50, 60, 80,100,100,100,100,100)
balance_2x: %beam_dmg( 40, 60, 80,100,100,120,180,200,200,200,200,200)
balance_3x: %beam_dmg( 60, 90,120,150,150,180,250,300,300,300,300,300)
balance_4x: %beam_dmg( 80,120,160,200,200,240,360,400,400,400,400,400)
balance_5x: %beam_dmg(100,150,200,250,250,300,450,500,500,500,500,500)

; Routine that loads either the equipped beams or $1000 based on the charge
; mode because the next instructions checks to see if charge is equipped.
PrepareForChargeCheck:
        LDA.l ChargeMode : AND.w #$000F : BEQ +
                LDA.w #$1000
                RTS
        +
        LDA.w BeamsEquipped
RTS

; Routine that loads the charge damage from another
; bank. Used when drawing on the HUD.
ExternalLoadChargeDamage:
        PHY : PHB
        PEA.w BeamDamageTables>>8 : PLB : PLB
        LDY.w #0001
        JSR.w LoadBeamDamage
        PLB : PLY
RTL

; Routine that loads beam damage from our custom
; tables where the value in Y indicates charged
; or not. [0 = uncharged, 1 = charged]
LoadBeamDamage:
        PHX
        LDA.l ChargeMode : AND.w #$0003
        ASL #4 : TAX
        CPY.w #$0000 : BEQ +
                INX #2
                LDA.w BeamsEquipped : BIT.w #$1000 : BEQ +
                        INX #2 : STX.b $06
                        LDA.w ChargeUpgrades : ASL : CLC : ADC.b $06
                        TAX
        +
        LDA.w BeamDamagePointers,X : STA.b $08
        LDA.w BeamsEquipped : AND.w #$00FF
        ASL : TAY
        LDA.b ($08),Y
        PLX
RTS

; Routine that updates damage for a charged shot
UpdateChargeDamage: 
        LDY.w #0001
        JSR.w LoadBeamDamage
        STA.w ProjectileDamage,X
        LDA.w ProjectileType,X
RTS


; Routine that updates damage for an uncharged shot
UpdateUnchargedDamage:
        LDY.w #0000
        JSR.w LoadBeamDamage
        STA.w ProjectileDamage,X
        JSR.w PrepareForChargeCheck
RTS


