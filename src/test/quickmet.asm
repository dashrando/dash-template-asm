;------------------------------------------------------------------------------
; QuickMet from SMILE
;------------------------------------------------------------------------------
; This module provides a macro that can be called when testing to skip the
; loading screen and start in a specific room. Disassemble from PJ.
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Rooms (roomId,samusX,samusY,doorCapX,doorCapY,destX,destY)
;------------------------------------------------------------------------------

!pre_kraid = $A56B,$0050,$0088,$ff,$ff,$01,$01
!pre_phantoon = $CC6F,$04CC,$008B,$ff,$ff,$04,$00
!pre_draygon = $D78F,$0040,$0088,$ff,$ff,$00,$02
!pre_shaktool = $D646,$0030,$0088,$ff,$ff,$00,$03
!pre_plasma = $D340,$00b0,$0088,$ff,$ff,$02,$01
!plasma = $D2AA,$0030,$0088,$ff,$ff,$00,$00
!pre_moat = $948C,$0090,$0098,$ff,$ff,$02,$00
!pre_moat_elevator = $962A,$0080,$00A8,$ff,$ff,$00,$00
!big_pink_bottom = $9D19,$0050,$0078,$ff,$ff,$02,$06
!speed_room = $AD1B,$0030,$0088,$ff,$ff,$00,$00
!wrecked_ship_reserve = $C98E,$00B0,$0078,$ff,$ff,$05,$02
!outside_ws_reserve = $93FE,$00a0,$0088,$ff,$ff,$07,$01
!crab_tunnel = $D08A,$00B0,$00A8,$ff,$ff,$00,$00
!sandfalls = $D6FD,$0020,$00A8,$ff,$ff,$03,$00
!green_hills = $9E52,$01C0,$0088,$FF,$FF,$01,$00
!single_chamber = $AD5E,$05A4,$0088,$FF,$FF,$00,$00

; Room scrolls when you jump (needs to be fixed)
!big_pink_next_to_charge = $9D19,$0070,$0076,$ff,$ff,$02,$07

;------------------------------------------------------------------------------
; QuickMet macro
;------------------------------------------------------------------------------

macro quickmet(roomId,samusX,samusY,doorCapX,doorCapY,destX,destY)

pushpc

!roomId = <roomId>
!samusX_start = <samusX>
!samusY_start = <samusY>

!decompressionSource    = $47
!decompressionDest      = $4C
!tempDoorEntry          = $02A0
!doorPointer            = $078D
!specialGfxBitflag      = $07B3
!gameState              = $0998
!doorTransitionFunction = $099C
!samusX                 = $0AF6
!samusY                 = $0AFA
!creTileTable           = $7EA000


; Skip area select screen?
{
org $819154
NOP : NOP
}


; Combine PPU register initialisation with VRAM initialisation (saves a call I guess...)
{
org $8282C3
BRA +

org $8282E3
+

; Change the RTS to an RTL so it can be called from bank $8B
org $828366
RTL
}


; Gamestate 01 - opening. The main code
{
org $8B9A22
REP #$30
PHB
PHK : PLB
SEI

; Set game state to door transition
LDA #$000B : STA !gameState

; Skip waiting for sounds to finish and screen to fade out
LDA #$E2F7 : STA !doorTransitionFunction

; Set up a door entry in RAM
LDA #!tempDoorEntry : STA !doorPointer
LDX #$000A

-
lda.l doorEntry,x : STA !tempDoorEntry,x
DEX : DEX
BPL -

; Initialise PPU registers and VRAM
JSL $8281DD

; Initialise Samus
JSL $91E00D

; Load from SRAM (slot 0)
LDA #$0000 : JSL $818085

; Decompress CRE tiles to VRAM $2800
LDA #$0080 : STA $2115
LDA #$B900 : STA.l !decompressionSource+1
LDA #$8000 : STA !decompressionSource
LDA #$5000 : STA !decompressionDest
LSR A : STA $2116
JSL $80B271

; Decompress CRE tile table to $7E:A000
LDA #$B900 : STA.l !decompressionSource+1
LDA #$A09D : STA !decompressionSource
JSL $80B0FF : dl !creTileTable

; Set Samus' position
LDA #!samusX_start : STA !samusX
LDA #!samusY_start : STA !samusY

; Make sure Samus has some health
LDA.w #402 : STA $7e09C2
LDA.w #599 : STA $7e09C4

; Call our custom code to initialize the game state
JSL.l InitGameState_main

; Load timer until Samus can move?
LDA #$0167 : STA $0DEC

; Enable screen (full brightness)
SEP #$20
LDA #$0F : STA $51

; Load HUD
JSL $809A79

; Load special GFX bitflag
LDX doorEntry : LDA $8F0008,x : STA !specialGfxBitflag

JSL $8483AD ; Enable PLMs
JSL $868000 ; Enable enemy projectiles
JSL $878000 ; Enable animated tiles objects
CLI
REP #$30
PLB

; Display the viewable part of the room
JSL $80A176

; Enable atmospheric effects?
LDA #$8000 : STA $1E79
RTL

; Padding I guess
dl $000000, $000000

doorEntry:
dw !roomId  ; Destination room
db $00      ; Flags
db $00      ; Direction
db <doorCapX> ; Doorcap X
db <doorCapY> ; Doorcap Y
db <destX>    ; Destination X
db <destY>    ; Destination Y
dw $03F0    ; Distance from door
dw $0000    ; Door ASM

}
warnpc $8b9b19

pullpc

endmacro
