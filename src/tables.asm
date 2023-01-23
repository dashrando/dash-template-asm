;------------------------------------------------------------------------------
; Tables
;------------------------------------------------------------------------------
; Tables and data that should end up statically mapped for any given build for
; the frontend or any tools. Document the PC address for convenience.
;------------------------------------------------------------------------------

org $DF8000 ; PC 0x2F8000
FileSelectCode:
db $00, $01, $02, $03

org $DF80004 ; PC 0x2F8004
ChargeMode:
db $02  ; 0 = vanilla, 1 = starter, 2 = balance
db $01  ; 0 = no hud, 1 = charge damage on HUD

org $DF8006 ; PC 0x2F8006
SpaceJumpPhysics:
db $00  ; $00 = Vanilla | $01 = Water with gravity physics everywhere


