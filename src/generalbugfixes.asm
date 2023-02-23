;------------------------------------------------------------------------------
; Bug & Miscellaneous Fixes
;------------------------------------------------------------------------------
; Small fixes, "common" Super Meroid randomizer patches.
;------------------------------------------------------------------------------
pushpc

; Disable Space/Time select in menu
org $82B174
LDX.w #$0001

; Fix Screw Attack selection in menu
org $82B4C4
CPX.w #$000C

; Menu bug fixes (avoid processing Varia twice)
org $82A1BB
CPY #$000A
org $82A1D6
CPY #$000A

; Suit acquisition animation skip
org $848717
NOP #4

; Fix Morph Ball Hidden/Chozo PLM's
org $84E8CE : db $04
org $84EE02 : db $04

; Fix Morph & Missile Room State
org $8fE655
NOP #3 : BEQ $0C
JMP.w $E65F

; Fix heat damage speed echoes bug
org $91B629 : db $01

; Mother Brain Cutscene Edits
org $A98824 : db $01
org $A98848 : db $01
org $A98867 : db $01
org $A9887F : db $01
org $A9897D : db $10
org $A989AF : db $10
org $A989E1 : db $10
org $A98A09 : db $10
org $A98A31 : db $10
org $A98A63 : db $10
org $A98A95 : db $10
org $A98B33 : db $10
org $A98B8D : db $12
org $A98Bdb : db $04
org $A98D74 : db $00
org $A98D86 : db $00
org $A98DC6 : db $B0
org $A98E51 : db $01
org $A98F0F : db $60,$00
org $A9AF0D : db $0A
org $A9AF4E : db $0A
org $A9B00D : db $00
org $A9B132 : db $40
org $A9B16D : db $00
org $A9B19F : db $20
org $A9B1B2 : db $30,$00
org $A9B20C : db $03

org $A995D4 ; Unused code
DisableAcidMotherBrain:
        LDA.w #$8000 : STA.w LiquidYPos
        LDA.w #$000A ; What we wrote over
RTS
warnpc $A995DE


; Disable GT Code
org $AAC91C
BRA $3F

; Remove space jump requirement for LN chozo
org $84D195
NOP #2

pullpc
