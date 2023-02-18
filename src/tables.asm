;------------------------------------------------------------------------------
; Tables
;------------------------------------------------------------------------------
; Tables and data that should end up statically mapped for any given build for
; the frontend or any tools. Document the PC address for convenience.
;------------------------------------------------------------------------------

org $DF8000 ; 0x2F8000
FileSelectCode:
db $00, $01, $02, $03

org $DF8004 ; 0x2F8004
ChargeMode:
if !STD == 1
    db $01  ; 0 = vanilla, 1 = starter, 2 = balance
    db $00  ; 0 = no hud, 1 = charge damage on HUD
else
    db $02  ; 0 = vanilla, 1 = starter, 2 = balance
    db $01  ; 0 = no hud, 1 = charge damage on HUD
endif

org $DF8006 ; 0x2F8006
SpaceJumpPhysics:
db $00  ; $00 = Vanilla | $01 = Water with gravity physics everywhere

org $DF8007  ; Each value will have the 1-based index of the location
CreditsItems:
dw $0001 ; 0x2F8007  Morph
dw $0002 ; 0x2F8009  Bombs
dw $0003 ; 0x2F800B  Ice Beam
dw $0004 ; 0x2F800D  Wave Beam
dw $0005 ; 0x2F800F  Spazer Beam
dw $0006 ; 0x2F8011  Plasma Beam
dw $0007 ; 0x2F8013  Varia Suit
dw $0008 ; 0x2F8015  Gravity Suit
dw $0009 ; 0x2F8017  Hijump Boots
dw $000A ; 0x2F8019  Space Jump
dw $000B ; 0x2F801B  Speed Booster
dw $000C ; 0x2F801D  Screw Attack
dw $000D ; 0x2F801F  Spring Ball
dw $000E ; 0x2F8021  Xray Scope
dw $000F ; 0x2F8023  Grappling Beam
dw $0000 ; 0x2F8025  Heat Shield
dw $0000 ; 0x2F8027  Pressure Valve
dw $0000 ; 0x2F8029  Double Jump
dw $0000 ; 0x2F802B  Charge Beam
dw $0000 ; 0x2F802D  Charge Upgrade 1
dw $0000 ; 0x2F802F  Charge Upgrade 2
dw $0000 ; 0x2F8031  Charge Upgrade 3
dw $0000 ; 0x2F8033  Charge Upgrade 4
dw $0000 ; 0x2F8035  Charge Upgrade 5
dw $DEAD

org $DF8039  ; Item counts for each area
AreaCounts:
dw $0000 ; 0x2F8039  Crateria / Blue Brinstar
dw $0000 ; 0x2F803B  Green Brinstar
dw $0000 ; 0x2F803D  Upper Norfair
dw $0000 ; 0x2F803F  Wrecked Ship
dw $0000 ; 0x2F8041  East Maridia
dw $0000 ; 0x2F8043  Tourian
dw $0000 ; 0x2F8045  Ceres
dw $0000 ; 0x2F8047  Debug
dw $0000 ; 0x2F8049  Red Brinstar
dw $0000 ; 0x2F804B  Kraid
dw $0000 ; 0x2F804D  West Maridia
dw $0000 ; 0x2F804F  Lower Norfair
dw $0000 ; 0x2F8051  Crocomire

org $DF8B0B ; 0x2F8B0B
NoFanfare:  ; $00 = Fanfare | $01 = No fanfare
dw $0000

org $DF8B0D ; 0x2F8B0D
