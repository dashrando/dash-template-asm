; Bank 85
; Borrowed from total and Kejardon's Message Box v4

!Big = $825A
!Small = $8289
!EmptyBig = #$8441
!EmptySmall = $8436
!Shot = #$83C5
!Dash = #$83CC
!Jump = #$8756
!ItemCancel = #$875D
!ItemSelect = #$8764
!AimDown = #$876B
!AimUp = #$8773

dw !EmptySmall, !Small, double_jump
dw !EmptySmall, !Small, heat_shield
dw !EmptySmall, !Small, aqua_boots
;dw !EmptySmall, !Small, reserved
dw !EmptySmall, !Small, BtnArray

table data/box.tbl,rtl
double_jump:
    dw "______    DOUBLE JUMP     ______"
heat_shield:
    dw "______    HEAT SHIELD     ______"
aqua_boots:
    dw "______     AQUA BOOTS     ______"
; reserved:
;     dw "______     RESERVED      _______"

cleartable

BtnArray:
dw $0000, $012A, $012A, $012C, $012C, $012C, $0000, $0000, $0000, $0000, $0000, $0000, $0120, $0000, $0000
dw $0000, $0000, $0000, $012A, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

pushpc
; 1c1f fixes
org $858749
fix_1c1f:
        LDA.b $CE : BEQ +     ; if $CE is set, it overrides the message box
                STA.w $1C1F
                STZ.b $CE     ; Clear $CE
        +
	LDA.w $1C1F
	CMP.w #$001D
	BPL +
	        RTS
        +
	ADC.w #$027F
RTS

org $858243
	JSR.w fix_1c1f

org $8582E5
	JSR.w fix_1c1f

org $858413
	dw BtnArray

; Max ammo tile changes
org $858851
db $0f,$28,$0f,$28,$0f,$28

org $858891
db $49,$30,$4a,$30,$4b,$30

org $858951
db $0f,$28,$0f,$28,$0f,$28

org $858993
db $34,$30,$35,$30

org $858a4f
db $0f,$28,$0f,$28

org $858a8f
db $36,$30,$37,$30

pullpc

