;------------------------------------------------------------------------------
; Bug & Miscellaneous Fixes
;------------------------------------------------------------------------------
; Small fixes, "common" Super Meroid randomizer patches.
;------------------------------------------------------------------------------

FixDoorBG1Scroll:
        LDA.w BG1XScroll : AND.w #$FF00
        SEC
RTS

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
org $8FE655
NOP #3 : BEQ $0C
JMP.w $E65F

; Fix heat damage speed echoes bug
org $91B629 : db $01

; Disable GT Code
org $AAC91C
BRA $3F

pullpc
