;------------------------------------------------------------------------------
; New HUD
;------------------------------------------------------------------------------
; Max ammo display by personitis. Charge HUD by Masshesteria.
;------------------------------------------------------------------------------

InitHUDAmmoExpanded:
        .missiles
        JSR.w HUDDrawThreeDigits
        LDA.w MaxMissiles : LDX.w #$0014
        JSR.w HUDDrawThreeDigits
        RTS
        .supers
        JSR.w HUDDrawTwoDigits
        LDA.w MaxSupers : LDX.w #$001C
        JSR.w HUDDrawTwoDigits
        RTS
        .pbs
        JSR.w HUDDrawTwoDigits
        LDA.w MaxPBs : LDX.w #$0022
        JSR.w HUDDrawTwoDigits
RTS

NewHUDAmmo:
        PHA : PHX : PHY 
        LDA.w MaxMissiles
        BEQ +
                JSR.w .missiles
        +
        LDA.w MaxSupers
        BEQ +
                JSR.w .supers
        +
        LDA.w MaxPBs
        BEQ +
                JSR.w .pbs
        +
        PLY : PLX : PLA
        LDA.w MaxMissiles
RTS

.missiles
        JSR.w NewHUDDivision
        LDA.w HUDItemIndex : CMP.w #$0001 : BEQ +
                LDA.w #$1400 : STA.b $18 : BRA .writemissiles
        +
        LDA.w #$1000 : STA.b $18
        .writemissiles
        LDX.b $12 : LDA.w AmmoDigits,X : ORA.b $18 : STA.l $7EC61C
        LDX.b $14 : LDA.w AmmoDigits,X : ORA.b $18 : STA.l $7EC61E
        LDX.b $16 : LDA.w AmmoDigits,X : ORA.b $18 : STA.l $7EC620
        LDA.w #$0049 : ORA.b $18 : STA.l $7EC65C
        LDA.w #$004A : ORA.b $18 : STA.l $7EC65E
        LDA.w #$004B : ORA.b $18 : STA.l $7EC660
RTS

.supers
        JSR.w NewHUDDivision_by10
        LDA.w HUDItemIndex : CMP.w #$0002 : BEQ +
                LDA.w #$1400 : STA.b $18 : BRA .writesupers
        +
        LDA.w #$1000 : STA.b $18
        .writesupers
        LDX.b $14 : LDA.w AmmoDigits,X : ORA.b $18 : STA.l $7EC624
        LDX.b $16 : LDA.w AmmoDigits,X : ORA.b $18 : STA.l $7EC626
        LDA.w #$0034 : ORA.b $18 : STA.l $7EC664
        LDA.w #$0035 : ORA.b $18 : STA.l $7EC666
RTS

.pbs
        JSR.w NewHUDDivision_by10
        LDA.w HUDItemIndex : CMP.w #$0003 : BEQ +
                LDA.w #$1400 : STA.b $18 : BRA .writepbs
        +
        LDA.w #$1000 : STA.b $18
        .writepbs
        LDX.b $14 : LDA.w AmmoDigits,X : ORA.b $18 : STA.l $7EC62A
        LDX.b $16 : LDA.w AmmoDigits,X : ORA.b $18 : STA.l $7EC62C
        LDA.w #$0036 : ORA.b $18 : STA.l $7EC66A
        LDA.w #$0037 : ORA.b $18 : STA.l $7EC66C
RTS

NewHUDDivision:
        STA.w $4204
        SEP #$20
        LDA.b #$64 : STA.w $4206
        REP #$20
        PHA : PLA : NOP
        LDA.w $4214 : ASL : STA.b $12
        LDA.w $4216
        
        .by10
        STA.w $4204
        SEP #$20
        LDA.b #$0A : STA.w $4206
        REP #$20
        PHA : PLA : NOP
        LDA.w $4214 : ASL : STA.b $14
        LDA.w $4216 : ASL : STA.b $16
RTS

AmmoDigits:
dw $0045, $003C, $003D, $003E, $003F, $0040, $0041, $0042, $0043, $0044

DrawNewHUD:
        LDA.w HUDDrawFlag : BEQ +
                JSR.w NewHUDCharge
                JSR.w NewHUDCounts
                JSR.w NewHUDArea
                JSR.w NewHUDItems
                STZ.w HUDDrawFlag
        +
        LDA.w #$9DD3 ; What we wrote over
RTS

; Routine that draws the charge damage on the HUD
NewHUDCharge:
        LDA.l ChargeMode : CMP.w #$0101 : BCC +
                LDA.w BeamUpgrades : XBA : ORA.w BeamsEquipped ; 000c-nnnn-0000-psiw
                CMP.w PreviousBeams : BEQ +
                        STA.w PreviousBeams
                        LDA.w #HUDHealthDigits : STA.b $00
                        JSL.l ExternalLoadChargeDamage
                        CMP.w #0100 : BCS .draw_3
                                .draw_2
                                LDX.w #$00BC
                                JSR.w HUDDrawTwoDigits
                                LDA.w #$2C0F : STA.l $7EC6C2 ; Blank tile
                                BRA +
                        .draw_3
                        LDX.w #$00BA
                        JSR.w HUDDrawThreeDigits
        +
RTS

NewHUDCounts:
        LDA.w SubAreaIndex : ASL : TAX : TAY
        LDA.l MajorCounters,X : ASL #2 : TAX
        LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDOne+$0A
        INX #2
        LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDOne+$0C

        TYX
        LDA.l TankCounters,X : ASL #2 : TAX
        LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDTwo+$0A
        INX #2
        LDA.w CountdownDigits,X : ORA.w #$0400 : STA.l RightHUDTwo+$0C
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

        LDA.w #$3867 : STA.l RightHUDOne+$08
        LDA.w #$3866 : STA.l RightHUDTwo+$08

RTL

NewHUDArea:
        LDA.w SubAreaIndex : ASL #2 : TAX
        LDA.w HUDAreaCodes,X : STA.l RightHUDOne+$02
        INX #2
        LDA.w HUDAreaCodes,X : STA.l RightHUDOne+$04

RTS

NewHUDItems:
        LDA.w DashItemsEquipped : BEQ .none
                TAY
                LDX.w #HUDItemTiles+$00
                BIT #$0020 : BEQ +
                        INX #2
                +
                LDA.w $0000,X : STA.l RightHUDThree+$02
                LDX.w #HUDItemTiles+$04
                TYA
                BIT #$0001 : BEQ +
                        INX #2
                +
                LDA.w $0000,X : STA.l RightHUDThree+$04
                LDX.w #HUDItemTiles+$08
                TYA
                BIT #$0200 : BEQ +
                        INX #2
                +
                LDA.w $0000,X : STA.l RightHUDThree+$06
                RTS
        .none
        LDA.w #$3460 : STA.l RightHUDThree+$02
        LDA.w #$3462 : STA.l RightHUDThree+$06
        LDA.w #$3464 : STA.l RightHUDThree+$04
RTS

RedDigits:
dw $2809, $2800, $2801, $2802, $2803, $2804, $2805, $2806, $2807, $2808

HUDAreaCodes:
dw $2015, $2013 ; CA
dw $2019, $2014 ; GB
dw $2027, $2020 ; UN
dw $2029, $2025 ; WS
dw $2017, $201F ; EM
dw $2026, $2020 ; TN
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
;dw $200F, $2009 ;  0
;dw $200F, $2000 ;  1
;dw $200F, $2001 ;  2
;dw $200F, $2002 ;  3
;dw $200F, $2003 ;  4
;dw $200F, $2004 ;  5
;dw $200F, $2005 ;  6
;dw $200F, $2006 ;  7
;dw $200F, $2007 ;  8
;dw $200F, $2008 ;  9
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

HUDItemTiles:
dw $3460, $2C61 ; Pressure Valve
dw $3464, $3C65 ; Heat Shield
dw $3462, $2863 ; Double Jump

pushpc
org $80988B
incsrc data/hudtoprow.asm
pullpc
