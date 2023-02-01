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
dw !EmptySmall, !Small, charge_upgrade
;dw !EmptySmall, !Small, reserved
dw !EmptySmall, !Small, BtnArray

table data/box.tbl,rtl
double_jump:
dw "______    DOUBLE JUMP    _______"
heat_shield:
dw "______    HEAT SHIELD    _______"
aqua_boots:
dw "______   PRESSURE VALVE  _______"
charge_upgrade:
dw "______  CHARGE UPGRADE   _______"
; reserved:
;     dw "______     RESERVED      _______"

cleartable

BtnArray:
dw $0000, $012A, $012A, $012C, $012C, $012C, $0000, $0000, $0000, $0000, $0000, $0000, $0120, $0000, $0000
dw $0000, $0000, $0000, $012A, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

load_message: {

   ; Jump to the end if not charge beam.
   lda $00
   cmp #$8f3f
   bne +

   ; Jump to the end if using vanilla charge mode.
   LDA.l ChargeMode
   and #$000F
   beq +

   ; Load the address of our custom message.
   lda #charge_upgrade
   sta $00

   ; Call the hijacked code and return.
+  ldy #$0000
   rts
}

fix_1c1f:
; if $CE is set, it overrides the message box
        LDA.b $CE : BEQ +
                STA.w $1C1F
                STZ.b $CE
        +
	LDA.w $1C1F
	CMP.w #$001D
	BPL +
	        RTS
        +
	ADC.w #$027F
RTS

SetMessageBoxFlag:
        STA.w $1C1F ; What we wrote over
        INC.w MessageBoxFlag
RTS

UnsetMessageBoxFlag:
        JSR.w $80FA ; What we wrote over
        STZ.w MessageBoxFlag
RTS
