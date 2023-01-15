;------------------------------------------------------------------------------
; Tables
;------------------------------------------------------------------------------
; Tables and data that should end up statically mapped for any given build for
; the frontend or any tools. Document the PC address for convenience.
;------------------------------------------------------------------------------
; TODO: annotate snes and pc addresses

                ; PC 0x2F8000
FileSelectCode: ; TODO: document
db $00, $01, $02, $03

ChargeMode:
db $02  ; 0 = vanilla, 1 = starter, 2 = balance
db $01  ; 0 = no hud, 1 = charge damage on HUD

SpaceJumpPhysics:
db $01            ; $00 = Vanilla | $01 = Water with gravity physics everywhere






