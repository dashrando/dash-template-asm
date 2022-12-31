; Bank 85
; Borrowed from total and Kejardon's Message Box v4

!Big = $825A
!Small = $8289
!EmptySmall = $8436

dw !EmptySmall, !Small, double_jump
dw !EmptySmall, !Small, heat_shield
;dw !EmptySmall, !Small, reserved6
;dw !EmptySmall, !Small, reserved6
;dw !EmptySmall, !Small, reserved6
;dw !EmptySmall, !Small, reserved6
dw !EmptySmall, !Small, BtnArray

table data/box.tbl,rtl
    ;   0                              31
double_jump:
    dw "______    DOUBLE JUMP    _______"
heat_shield:
    dw "______    HEAT SHIELD    _______"
; reserved2:
;     dw "______     RESERVED      _______"
; reserved3:
;     dw "______     RESERVED      _______"
; reserved4:
;     dw "______     RESERVED      _______"
; reserved5:
;     dw "______     RESERVED      _______"
; reserved6:
;     dw "______     RESERVED      _______"

cleartable

BtnArray:
    dw $0000, $012A, $012A, $012C, $012C, $012C, $0000, $0000, $0000, $0000, $0000, $0000, $0120, $0000, $0000
    dw $0000, $0000, $0000, $012A, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

pushpc ; 1c1f fixes
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

pullpc
