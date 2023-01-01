;------------------------------------------------------------------------------
; Tables
;------------------------------------------------------------------------------
; Tables and data that should end up statically mapped for any given build for
; the frontend or any tools. Document the PC address for convenience.
;------------------------------------------------------------------------------


                ; PC 0x2F8000
FileSelectCode: ; TODO: document
db $00, $01, $02, $03

; We don't use this currently but we could.
; Keep this at the end for now.
CustomPLMTable:
;   room, plm,   yyxx,  args
dw $0000, $0000, $0000, $0000


