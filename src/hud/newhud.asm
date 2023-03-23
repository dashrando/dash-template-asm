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
                ;JSR.w NewHUDCounts
                JSR.w NewHUDArea
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
                                LDX.w #$00B6
                                JSR.w HUDDrawTwoDigits
                                BRA +
                        .draw_3
                        LDX.w #$00B4
                        JSR.w HUDDrawThreeDigits
        +
RTS

NewHUDCounts:
        LDA.w #HUDHealthDigits : STA.b $00
        LDA.w SubAreaIndex : ASL : TAX
        LDA.l MajorCounters,X : ASL : STA.b MultiplyResult
        ASL #2 : CLC : ADC.b MultiplyResult : STA.b MultiplyResult ; Multiply by 10
        LDA.l TankCounters,X : ADC.b MultiplyResult
        LDX.w #$00A8
        JSR.w HUDDrawTwoDigits
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

RTL

NewHUDArea:
        LDA.w SubAreaIndex : ASL #2 : TAX
        LDA.w HUDAreaCodes,X : STA.l RightHUDOne+$02
        INX #2
        LDA.w HUDAreaCodes,X : STA.l RightHUDOne+$04

RTS

RedDigits:
dw $2809, $2800, $2801, $2802, $2803, $2804, $2805, $2806, $2807, $2808

HUDAreaCodes:
dw $28E2, $28E0 ; CA
dw $28E6, $28E1 ; GB
dw $28F4, $28ED ; UN
dw $28F6, $28F2 ; WS
dw $28E4, $28EC ; EM
dw $28F3, $28ED ; TN
dw $28E2, $28F2 ; CS
dw $28E3, $28E1 ; DB
dw $28F1, $28E1 ; RB
dw $28EA, $28F1 ; KR
dw $28F6, $28EC ; WM
dw $28EB, $28ED ; LN
dw $28E2, $28F1 ; CR
dw $28ED, $28EC ; NM
dw $28F2, $28EC ; SM

pushpc
org $80988B
incsrc data/hudtoprow.asm
pullpc
