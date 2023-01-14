;------------------------------------------------------------------------------
; Enemies
;------------------------------------------------------------------------------
pushpc

org $B4ED3A                   ; Maridia pink pirates vulnerability table
dw $0101, $0101, $0101, $0101 ; Pink pirates vulnerable to uncharged beams, no multiplier

pullpc
