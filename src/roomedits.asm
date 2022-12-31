;------------------------------------------------------------------------------
; Room Edits
;------------------------------------------------------------------------------
; Changes to maps (Red Towers, Early Supers, etc)
; TODO: A lot of these including DASH PLMs can probably be dynamically and
; efficiently replaced during room load.
;------------------------------------------------------------------------------


pushpc

org $C5A173
incbin data/dachora.bin
org $c5aa79
fillbyte $ff
fill 2771

org $c5976b
incbin data/earlysupers.bin
org $c599d8
fillbyte $ff
fill 295

org $c3bd92
incbin data/moat.bin
org $c3bd80
db $d5,$3a,$01,$11,$85

org $c6ecc3
incbin data/novaboost.bin
org $c6f0f4
fillbyte $ff
fill 492

org $c684f7
incbin data/redtower.bin

org $c6b92b
incbin data/spazer.bin

org $c7aa77
incbin data/hijump.bin

pullpc
