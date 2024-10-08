;------------------------------------------------------------------------------
; New HUD
;------------------------------------------------------------------------------
; Max ammo display by personitis. Charge HUD by Masshesteria.
;------------------------------------------------------------------------------

InitHUDAmmoExpanded:
        .missiles
        PHP : PHB : PHX : PHY
        PHK : PLB
        REP #$30
        LDA.w MaxMissiles : LDX.w #$0014
        JSR.w HUDDrawThreeDigits
        LDA.l $7EC65C : CMP.w #$2C0F : BNE +
                LDA.w #$3449 : STA.l $7EC65C
                LDA.w #$344A : STA.l $7EC65E
                LDA.w #$344B : STA.l $7EC660
        +
        PLY : PLX : PLB : PLP
        RTL
        .supers
        PHP : PHB : PHX : PHY
        PHK : PLB
        REP #$30
        LDA.w MaxSupers : LDX.w #$001C
        JSR.w HUDDrawTwoDigits
        LDA.l $7EC664 : CMP.w #$2C0F : BNE +
                LDA.w #$3434 : STA.l $7EC664
                LDA.w #$3435 : STA.l $7EC666
        +
        PLY : PLX : PLB : PLP
        RTL
        .pbs
        PHP : PHB : PHX : PHY
        PHK : PLB
        REP #$30
        LDA.w MaxPBs : LDX.w #$0022
        JSR.w HUDDrawTwoDigits
        LDA.l $7EC66A : CMP.w #$2C0F : BNE +
                LDA.w #$3436 : STA.l $7EC66A
                LDA.w #$3437 : STA.l $7EC66C
        +
        PLY : PLX : PLB : PLP
RTL

NewHUDAmmo:
        PHA : PHX : PHY 
        LDA.w MaxMissiles : CMP.w PreviousMaxMissiles : BEQ +
                STA.w PreviousMaxMissiles
                JSR.w .missiles
        +
        LDA.w MaxSupers : CMP.w PreviousMaxSupers : BEQ +
                STA.w PreviousMaxSupers
                JSR.w .supers
        +
        LDA.w MaxPBs : CMP.w PreviousMaxPBs : BEQ +
                STA.w PreviousMaxPBs
                JSR.w .pbs
        +
        PLY : PLX : PLA
        LDA.w MaxMissiles
RTS

.missiles
        JSR.w MissilesHundredsDigit
        JSR.w DivideByFive
        ASL #2 : TAX
        LDA.w HUDItemIndex : CMP.w #$0001 : BEQ ..green
                LDA.b $0E : STA.l $7EC61C
                LDA.w MaxAmmoDigits,X : STA.l $7EC61E
                INX #2
                LDA.w MaxAmmoDigits,X : STA.l $7EC620
                RTS
        ..green
        LDA.b $0E : SBC.w #$0400 : STA.l $7EC61C
        LDA.w MaxAmmoDigits,X : SBC.w #$0400 : STA.l $7EC61E
        INX #2
        LDA.w MaxAmmoDigits,X : SBC.w #$0400 : STA.l $7EC620
RTS

.supers
        JSR.w DivideByFive
        ASL #2 : TAX
        LDA.w HUDItemIndex : CMP.w #$0002 : BEQ ..green
                LDA.w MaxAmmoDigits,X : STA.l $7EC624
                INX #2
                LDA.w MaxAmmoDigits,X : STA.l $7EC626
                RTS
        ..green
        LDA.w MaxAmmoDigits,X : SBC.w #$0400 : STA.l $7EC624
        INX #2
        LDA.w MaxAmmoDigits,X : SBC.w #$0400 : STA.l $7EC626
RTS

.pbs
        JSR.w DivideByFive
        ASL #2 : TAX
        LDA.w HUDItemIndex : CMP.w #$0003 : BEQ ..green
                LDA.w MaxAmmoDigits,X : STA.l $7EC62A
                INX #2
                LDA.w MaxAmmoDigits,X : STA.l $7EC62C
                RTS
        ..green
        LDA.w MaxAmmoDigits,X : SBC.w #$0400 : STA.l $7EC62A
        INX #2
        LDA.w MaxAmmoDigits,X : SBC.w #$0400 : STA.l $7EC62C
RTS

MissilesHundredsDigit:
; In: A - Max missile count
; Out: A   - Max missile count modulo 100
;      $0E - Hundreds digit tile offset
        TAX
        CMP.w #0300 : BCS .300
        CMP.w #0200 : BCS .200
        CMP.w #0100 : BCS .100
                LDA.w #$1445 : STA.b $0E
                TXA
                RTS
        .300
        LDA.w #$143E : STA.b $0E
        TXA
        SBC.w #0300
        RTS
        .200
        LDA.w #$143D : STA.b $0E
        TXA
        SBC.w #0200
        RTS
        .100
        LDA.w #$143C : STA.b $0E
        TXA
        SBC.w #0100
RTS

DivideByFive:
; From Omegamatrix on the NesDev forums
; https://forums.nesdev.org/viewtopic.php?t=11336
; Minor optimization made for two digit numbers.
        STA.b $18
        LSR
        ADC.b $18
        ROR
        LSR #2
        ADC $18
        ROR
        ADC $18
        ROR
        LSR #2
RTS

MaxAmmoDigits:
dw $1445, $1445
dw $1445, $1440
dw $143C, $1445
dw $143C, $1440
dw $143D, $1445
dw $143D, $1440
dw $143E, $1445
dw $143E, $1440
dw $143F, $1445
dw $143F, $1440
dw $1440, $1445
dw $1440, $1440
dw $1441, $1445
dw $1441, $1440
dw $1442, $1445
dw $1442, $1440
dw $1443, $1445
dw $1443, $1440
dw $1444, $1445
dw $1444, $1440

DrawNewHUD:
        LDA.w HUDDrawFlag : BEQ .done
                LDA.w #%00000001 : BIT.w HUDFlags : BEQ +
                        JSR.w NewHUDCharge
                +
                LDA.w #%00000010 : BIT.w HUDFlags : BEQ +
                        JSR.w NewHUDCounts
                +
                LDA.w #%00000100 : BIT.w HUDFlags : BEQ +
                        JSR.w NewHUDArea
                +
                LDA.w #%00001000 : BIT.w HUDFlags : BEQ +
                        JSR.w NewHUDItems
                +
                LDA.w #%00010000 : BIT.w HUDFlags : BEQ +
                        JSR.w NewHUDHeatReduction
                +
                STZ.w HUDDrawFlag
        .done:
        LDA.w #$9DD3 ; What we wrote over
RTS

; This table works with the table directly below it (HUDChargeIconTable)
; and needs to be in sync with it. For example, the 3rd index is set to 40
; so the 3rd set of icons in the HUDChargeIconTable needs to be set to the
; values for the left and right tile icons that make up "40" on the HUD.

HUDChargeDamageTable:
dw #$0014 ; 20
dw #$001E ; 30
dw #$0028 ; 40
dw #$0032 ; 50
dw #$003C ; 60
dw #$0046 ; 70
dw #$0050 ; 80
dw #$005A ; 90

dw #$0064 ; 100
dw #$00C8 ; 200
dw #$012C ; 300
dw #$0190 ; 400
dw #$01F4 ; 500
dw #$0258 ; 600
dw #$0384 ; 900

dw #$0096 ; 150
dw #$00FA ; 250
dw #$01C2 ; 450
dw #$02EE ; 750

dw #$0078 ; 120
dw #$008C ; 140
dw #$00B4 ; 180

dw #$00D2 ; 210
.end

HUDChargeIconTable:
; |L.Side||R.Side||Table Indexes||Damage Value|
dw #$0C70, #$0C6D;|   00 & 02   ||     20     |
dw #$0C71, #$0C6F;|   04 & 06   ||     30     |
dw #$0C72, #$0C6F;|   08 & 0A   ||     40     |
dw #$0C73, #$0C6E;|   0C & 0E   ||     50     |
dw #$0C74, #$0C6E;|   10 & 12   ||     60     |
dw #$0C75, #$0C6A;|   14 & 16   ||     70     |
dw #$0C74, #$0C6F;|   18 & 1A   ||     80     |
dw #$0C76, #$0C6F;|   1C & 1E   ||     90     |

dw #$0C77, #$0C6F;|   20 & 22   ||    100     |
dw #$0C78, #$0C6F;|   24 & 26   ||    200     |
dw #$0C79, #$0C6F;|   28 & 2A   ||    300     |
dw #$0C7A, #$0C6F;|   2C & 2E   ||    400     |
dw #$0C7B, #$0C6F;|   30 & 32   ||    500     |
dw #$0C7C, #$0C6F;|   34 & 36   ||    600     |
dw #$0C7D, #$0C6F;|   38 & 3A   ||    900     |

dw #$0C7E, #$0C6E;|   3C & 3E   ||    150     |
dw #$0C7F, #$0C6E;|   40 & 42   ||    250     |
dw #$0C68, #$0C6E;|   44 & 46   ||    450     |
dw #$0C69, #$0C6E;|   48 & 4A   ||    750     |

dw #$0C57, #$0C6D;|   4C & 4E   ||    120     |
dw #$0C2D, #$0C6F;|   50 & 52   ||    140     |
dw #$0C2E, #$0C6F;|   54 & 56   ||    180     |

dw #$0C2F, #$0C6F;|   58 & 5A   ||    210     |
.end

; Routine that draws the charge damage on the HUD
NewHUDCharge:
        LDA.w HyperBeamFlag : BNE .hyper
                LDA.w #HUDHealthDigits : STA.b $00
                JSL.l ExternalLoadChargeDamage ; This subroutine loads the charge damage value into the accumulator.

                ;________________________________________________________________
                ; This code we'll need if we have the three-tile mode togglable.

                ;CMP.w #0100 : BCS .draw_3
                ;        .draw_2
                ;        LDX.w #$00BC
                ;        JSR.w HUDDrawTwoDigits
                ;        LDA.w #$2C0F : STA.l $7EC6C2 ; Blank tile
                ;        BRA +
                ;.draw_3
                ;LDX.w #$00BA
                ;JSR.w HUDDrawThreeDigits
                ;_________________________________________________________________

                LDX.w #$0000 ; Loop Counter (which also acts as our table index picker)
                      - CMP HUDChargeDamageTable,X
                        BNE .notEqual
                                TXA ;\
                                ASL ; Multiply the loop counter by 2
                                TAX ;/

                                ; Store the left-side icon
                                LDA.w HUDChargeIconTable,X
                                STA.l RightHUDThree+$08

                                ; Store the right-side icon
                                INX #2
                                LDA.w HUDChargeIconTable,X
                                STA.l RightHUDThree+$0A
                                BRA +
                        .notEqual
                        ; Check to see if we've gotten to the end of the table
                        CPX.w #HUDChargeDamageTable_end-HUDChargeDamageTable
                        BEQ +

                        ; Go to the next entry in the table and loop back
                        INX #2
                        BRA -
                BRA + 
        .hyper
        LDA.w #$2C0F
        STA.l RightHUDThree+$08
        STA.l RightHUDThree+$0A
        ;STA.l RightHUDThree+$0C <- This is needed if we have three-tile mode togglable
        +
RTS

NewHUDCounts:
        LDA.w SubAreaIndex : ASL : TAX : TAY
        LDA.l MajorCounters,X : ASL #2 : TAX

        ; This is needed if we have three-tile mode togglable
        ;LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDOne+$0A
        
        INX #2

        ; This is needed if we have three-tile mode togglable
        ;LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDOne+$0C

        LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDOne+$08

        TYX
        LDA.l TankCounters,X : ASL #2 : TAX

        ; This is needed if we have three-tile mode togglable
        ;LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDTwo+$0A

        INX #2

        ; This is needed if we have three-tile mode togglable
        ;LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDTwo+$0C

        LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDTwo+$08
RTS

InitRightHUDTiles:
        LDA.w #$2C0F
        LDX.w #$000C
        -
                STA.l RightHUDOne,X
                STA.l RightHUDTwo,X
                STA.l RightHUDThree,X
                DEX #2
        BPL -
        LDA.w #$2C10
        STA.l RightHUDOne
        STA.l RightHUDTwo
        LDA.w #$2C11
        STA.l RightHUDThree

        LDA.w #%00000010 : BIT.w HUDFlags : BEQ +
                ; This is needed if we have three-tile mode togglable
                ;LDA.w #$3867 : STA.l RightHUDOne+$08
                ;LDA.w #$3866 : STA.l RightHUDTwo+$08
                
                LDA.w #$3867 : STA.l RightHUDOne+$0A
                LDA.w #$3866 : STA.l RightHUDTwo+$0A                
        +
RTL

NewHUDArea:
        LDA.w SubAreaIndex : ASL #2 : TAX
        LDA.w HUDAreaCodes,X : STA.l RightHUDOne+$02
        INX #2
        LDA.w HUDAreaCodes,X : STA.l RightHUDOne+$04
RTS

NewHUDItems:
        LDA.w DashItemsCollected : BEQ .none
                LDA.w #$0020 : LDX.w #HUDItemTiles_pressure_valve
                BIT.w DashItemsCollected : BEQ +
                        INX #2 ; Go to greyed out icon
                +
                BIT.w DashItemsEquipped : BEQ +
                        INX #2 ; Go to full icon
                +
                LDA.w $0000,X : STA.l RightHUDThree+$04

                LDA.w #$0001 : LDX.w #HUDItemTiles_heat_shield
                BIT.w DashItemsCollected : BEQ +
                        INX #2 ; Go to greyed out icon
                +
                BIT.w DashItemsEquipped : BEQ +
                        INX #2 ; Go to full icon
                +
                LDA.w $0000,X : STA.l RightHUDTwo+$04

                LDA.w #$0200 : LDX.w #HUDItemTiles_double_jump
                BIT.w DashItemsCollected : BEQ +
                        INX #2 ; Go to greyed out icon
                +
                BIT.w DashItemsEquipped : BEQ +
                        INX #2 ; Go to full icon
                +
                LDA.w $0000,X : STA.l RightHUDThree+$02
                
                RTS
        .none
        ;Set all icons to be blank
        LDA.w #$2C0F : STA.l RightHUDThree+$02
        LDA.w #$2C0F : STA.l RightHUDThree+$04
        LDA.w #$2C0F : STA.l RightHUDTwo+$04
RTS

NewHUDHeatReduction:
        ; Simply return if Gravity is not collected
        LDA.w VanillaItemsCollected : BIT.w #$0020 : BNE +
                ; Set the icon to be blank
                LDA.w #$2C0F : STA.l RightHUDTwo+$02
                RTS
        +

        ; Initially assume the icon will be greyed out
        PHX
        LDX.w #HUDItemTiles_heat_reduction+$02

        ; Check equipped items first
        LDA.w VanillaItemsEquipped : BIT.w #$0020 : BEQ .noHeatReduction ; If Grav isn't equipped
                                     BIT.w #$0001 : BNE .noHeatReduction ; If Varia is equipped
        LDA.w DashItemsEquipped : BIT.w #$0001 : BNE .noHeatReduction ; If heat shield is equipped

        ; Then check if heat reduction is turned on 
        LDA.l HeatDamageTable_gravity : CMP.l HeatDamageTable_suitless : BEQ .noHeatReduction ; If grav's heat damage is -25%
                INX #2 ; Use the non-grey icon instead
        
        .noHeatReduction
        LDA.w $0000,X
        STA.l RightHUDTwo+$02
        PLX 
RTS      

UpdateHUDHyperBeam:
        LDA.w #$8000 : STA.w HyperBeamFlag ; What we wrote over
        INC.w HUDDrawFlag
RTL

RedDigits:
dw $2809, $2800, $2801, $2802, $2803, $2804, $2805, $2806, $2807, $2808

HUDAreaCodes:
dw $2015, $2013 ; CA
dw $2019, $2014 ; GB
dw $2027, $2020 ; UN
dw $2029, $2025 ; WS
dw $2017, $201F ; EM
dw $2026, $2021 ; TO
dw $2015, $2025 ; CS
dw $2016, $2014 ; DB
dw $2024, $2014 ; RB
dw $201D, $2024 ; KR
dw $2029, $201F ; WM
dw $201E, $2020 ; LN
dw $2015, $2024 ; CR
dw $2020, $201F ; NM
dw $2025, $201F ; SM

CountdownDigits:
; Need a palette ORed in if not 0
dw $2009, $2009 ;  0
dw $2009, $2000 ;  1
dw $2009, $2001 ;  2
dw $2009, $2002 ;  3
dw $2009, $2003 ;  4
dw $2009, $2004 ;  5
dw $2009, $2005 ;  6
dw $2009, $2006 ;  7
dw $2009, $2007 ;  8
dw $2009, $2008 ;  9
dw $2000, $2009 ; 10
dw $2000, $2000 ; 11
dw $2000, $2001 ; 12
dw $2000, $2002 ; 13
dw $2000, $2003 ; 14
dw $2000, $2004 ; 15
dw $2000, $2005 ; 16
dw $2000, $2006 ; 17
dw $2000, $2007 ; 18
dw $2000, $2008 ; 19
dw $2001, $2009 ; 20
dw $2001, $2000 ; 21
dw $2001, $2001 ; 22
dw $2001, $2002 ; 23
dw $2001, $2003 ; 24
dw $2001, $2004 ; 25
dw $2001, $2005 ; 26
dw $2001, $2006 ; 27
dw $2001, $2007 ; 28
dw $2001, $2008 ; 29
dw $2002, $2009 ; 30

HUDItemTiles:
;  Not Collected | Unequipped | Equipped
.pressure_valve
dw $2C0F, $3460, $3861 ; Pressure Valve

.heat_shield
dw $2C0F, $3464, $3C65 ; Heat Shield

.double_jump
dw $2C0F, $3462, $2863 ; Double Jump

.heat_reduction
dw $2C0F, $346B, $1C6C ; Heat Reduction Icon

pushpc
org $80988B
incsrc data/hudtoprow.asm

org $90AA92         ; Reclaimed segment of mini map draw code
MaybeMarkTileAbove: ; Needed to mark fractional diagonal tiles as visited.
        INY #4
        LDA.b [$03], Y : AND.w #$00FF : CMP.w #$0028 : BNE +
                JSR.w MarkTileAboveSamus
        +
        PLP
RTL
warnpc $90AB5F

pullpc
