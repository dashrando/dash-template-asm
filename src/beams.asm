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
; Starter Charge + 1 Upgrade
dw vanilla_1x, vanilla_1x, vanilla_3x, vanilla_3x
dw vanilla_3x, vanilla_3x, vanilla_3x, vanilla_3x
; Progressive
dw balance_1x, balance_1x, balance_2x, balance_3x
dw balance_4x, balance_5x, balance_5x, balance_5x
; Starter Charge + 2 Upgrades
dw vanilla_1x, vanilla_1x, vanilla_2x, vanilla_3x
dw vanilla_3x, vanilla_3x, vanilla_3x, vanilla_3x


; Beam damage tables
BeamDamageTables:
vanilla_1x: %beam_dmg( 20, 30, 40, 50, 60, 60, 70,100,150,200,250,300)
vanilla_2x: %beam_dmg( 40, 60, 80,100,120,120,140,200,300,400,500,600)
vanilla_3x: %beam_dmg( 60, 90,120,150,180,180,210,300,450,600,750,900)

balance_1x: %beam_dmg( 20, 30, 40, 50, 50, 60, 80,100,100,100,100,100)
balance_2x: %beam_dmg( 40, 60, 80,100,100,120,180,200,200,200,200,200)
balance_3x: %beam_dmg( 60, 90,120,150,150,180,250,300,300,300,300,300)
balance_4x: %beam_dmg( 80,120,160,200,200,240,360,400,400,400,400,400)
balance_5x: %beam_dmg(100,150,200,250,250,300,450,500,500,500,500,500)

; Routine that loads the charge damage from another
; bank. Used when drawing on the HUD.
ExternalLoadChargeDamage:
        PHY
        LDY.w #0001
        JSR.w LoadBeamDamage
        PLY
RTL

; Routine that loads beam damage from our custom
; tables where the value in Y indicates charged
; or not. [0 = uncharged, 1 = charged]
LoadBeamDamage:
        PHX
        LDA.w #bank(BeamDamageTables) : STA.b $08
        LDA.l ChargeMode : AND.w #$0003
        ASL #4 : TAX
        CPY.w #$0000 : BEQ +
                ; Start at the 2nd entry in the table
                CLC : ADC.w #2
                ; Move to the entry which corresponds with
                ; the number of beam upgrades
                ADC.w BeamUpgrades : ADC.w BeamUpgrades
                TAX
        +
        LDA.l BeamDamagePointers,X : STA.b $06
        LDA.w BeamsEquipped : AND.w #$00FF
        ASL : TAY
        LDA.b [$06],Y
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
        LDA.w BeamsEquipped
RTS


