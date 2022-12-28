;------------------------------------------------------------------------------
; Tables
;------------------------------------------------------------------------------
; Tables and data that should end up statically mapped for any given build for
; the frontend or any tools. Document the PC address for convenience.
;------------------------------------------------------------------------------


                ; PC 0x2F8000
FileSelectCode: ; TODO: document
db $00, $01, $02, $03

; For animals surprise we can use a table that will index into a table of our door
; asm pointers. TODO: include animals stuff or scrap.
;AnimalsSurprise: ; PC 0x2F8004
;db $00           ; $00 = vanilla
;
;AnimalsSurprisePointers:
;dw AnimalsVanilla
;dw AnimalsDraygon
;dw AnimalsRidley
;dw AnimalsPhantton


; We don't use this currently but we could
CustomPLMTable:
;   room, plm,   yyxx,  args
dw $0000, $0000, $0000, $0000


