;------------------------------------------------------------------------------
; HUD HDMA
;------------------------------------------------------------------------------
; Our HUD palette works in two phases using two pointers in mirrored WRAM
; (HUDHDMAPtr and HUDColorsPtr.) First we need to hook into vanilla on various
; game state changes to set both these pointers to routines in this module and
; bank ($80.) 
;
; 1. Our HUDHDMAPtr routine is called where the vanilla NMI writes to $420C. This
;    routine is responsible for selecting the appropriate channels for the situation.
;    We need to select two channels that will not interfere with vanilla effects
;    including but not limited to: power bombs, X-ray, liquid effects and scrolling,
;    and message boxes. This routine is also responsible for updating the HUD
;    palette HDMA table in WRAM for the next frame.
;
;    The HDMA table should restore the vanilla palettes before the final scanline
;    of the HUD (31.) If using fading palettes, get the color from the main vanilla
;    palette buffer at $7EC000 (PaletteBuffer.) Otherwise, we may set them statically.
;
; 2. Our HUDColorsPtr routine is called in our post-NMI hook before the return
;    from interrupt. This routine is responsible for putting our new colors into
;    CGRAM during v-blank. For the most part we should use the CGADD and CGDATA
;    registers directly unless we are transferring larger batches at once.
;
; We have to have one HDMA on scanline 0 per channel on every frame it's used,
; so we should use that to set two of our original colors in order to save as
; much time as possible during v-blank.
;------------------------------------------------------------------------------
HUDHDMACommand:
        LDA.w HUDHDMAPtr : BEQ .return
                PEA.w .return-1 ; Arrange stack for RTS return
                JMP.w (HUDHDMAPtr)
        .return
RTS

ActivateHDMA:
        LDX.b HDMAChannels : STX.w $420C
RTS

SetupPaletteTransfer:
        SEP #$30

        LDA.b #$03 : STA.w $4300
        LDA.b #$21 : STA.w $4301
        REP #$20
        LDA.w #HUDHDMAWRAM : STA.w $4302
        SEP #$20
        LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
        LDA.b #$01 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDX.b HDMAChannels : STX.w $420C

        REP #$20
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAWRAM+$2B
        LDA.l PaletteBuffer+$0A : STA.l HUDHDMAWRAM+$3A
        LDA.l PaletteBuffer+$0C : STA.l HUDHDMAWRAM+$35
        LDA.l PaletteBuffer+$0E : STA.l HUDHDMAWRAM+$44
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAWRAM+$4E
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMAWRAM+$53
        LDA.l PaletteBuffer+$3C : STA.l HUDHDMAWRAM+$49
        .done
RTS

.door_fade
        SEP #$30
        LDA.b #$03 : STA.w $4300
        LDA.b #$21 : STA.w $4301
        REP #$20
        LDA.w #HUDHDMAWRAM : STA.w $4302
        SEP #$20
        LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
        LDA.b #$01 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDX.b HDMAChannels : STX.w $420C

        REP #$20
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAWRAM+$26
        LDA.l PaletteBuffer+$0A : STA.l HUDHDMAWRAM+$08
        LDA.l PaletteBuffer+$0C : STA.l HUDHDMAWRAM+$30
        LDA.l PaletteBuffer+$0E : STA.l HUDHDMAWRAM+$35
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAWRAM+$3A
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMAWRAM+$44
        LDA.l PaletteBuffer+$3C : STA.l HUDHDMAWRAM+$38
RTS

.door
        ; Screen has faded and is mostly black
        SEP #$30
        LDA.b #$03 : STA.w $4300
        LDA.b #$21 : STA.w $4301
        REP #$20
        LDA.w #HUDHDMAWRAM : STA.w $4302
        SEP #$20
        LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
        LDA.b #$01 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDX.b HDMAChannels : STX.w $420C

        REP #$20
        LDA.w #$0000
        STA.l HUDHDMAWRAM+$21
        STA.l HUDHDMAWRAM+$26
        STA.l HUDHDMAWRAM+$2B
        STA.l HUDHDMAWRAM+$30
        STA.l HUDHDMAWRAM+$3A
        STA.l HUDHDMAWRAM+$3F
RTS

.door_transition
        SEP #$30
        LDA.b #$03 : STA.w $4300
        LDA.b #$21 : STA.w $4301
        REP #$20
        LDA.w #HUDHDMAWRAM : STA.w $4302
        SEP #$20
        LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
        LDA.b #$01 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDX.b HDMAChannels : STX.w $420C

        REP #$20
        LDA.w #$0000
        STA.l HUDHDMAWRAM+$21
        STA.l HUDHDMAWRAM+$26
        STA.l HUDHDMAWRAM+$2B
        STA.l HUDHDMAWRAM+$30
        STA.l HUDHDMAWRAM+$3A
        STA.l HUDHDMAWRAM+$3F
RTS

.pause
        SEP #$30
        LDA.b #$03 : STA.w $4340
        LDA.b #$21 : STA.w $4341
        REP #$20
        LDA.w #HUDHDMAWRAM : STA.w $4342
        SEP #$20
        LDA.b #HUDHDMAWRAM>>16 : STA.w $4344
        LDA.b #$10 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b HDMAChannels : STA.w $420C

        REP #$30
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAWRAM+$2B
        LDA.l PaletteBuffer+$0A : STA.l HUDHDMAWRAM+$3A
        LDA.l PaletteBuffer+$0C : STA.l HUDHDMAWRAM+$35
        LDA.l PaletteBuffer+$0E : STA.l HUDHDMAWRAM+$44
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAWRAM+$4E
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMAWRAM+$53
        LDA.l PaletteBuffer+$3C : STA.l HUDHDMAWRAM+$49
RTL

HUDHDMAOne:
db 01 : dw $0101 : dw $03DD ; Scanline 0  ; $00
db 01 : dw $0505 : dw $132E ; Scanline 1  ; $05
db 01 : dw $0606 : dw $7FFF ; Scanline 2  ; $0A
db 01 : dw $0707 : dw $0000 ; Scanline 3  ; $0F
db 01 : dw $1919 : dw $3B00 ; Scanline 4  ; $14
db 01 : dw $1A1A : dw $7FFF ; Scanline 5  ; $19
db 07 : dw $1E1E : dw $7FFF ; Scanline 6  ; $1E
db 01 : dw $0F0F : dw $0000 ; Scanline 13 ; $23
db 01 : dw $0101 : dw $02DF ; Scanline 14 ; $28
db 06 : dw $0F0F : dw $0000 ; Scanline 15 ; $2D
db 01 : dw $0606 : dw $2D08 ; Scanline 21 ; $32
db 01 : dw $0505 : dw $41AD ; Scanline 22 ; $37
db 05 : dw $1919 : dw $71C7 ; Scanline 23 ; $3C ; Pressure Valve replacement
db 01 : dw $0707 : dw $1863 ; Scanline 28 ; $41
db 01 : dw $1E1E : dw $001F ; Scanline 29 ; $46
db 01 : dw $1919 : dw $5AD6 ; Scanline 30 ; $4B
db 01 : dw $1A1A : dw $4A52 ; Scanline 31 ; $50
db 00                                     ; $55

HUDHDMATwo: ; Reserved
db 01 : dw $0000 : dw $0000 ; Scanline 0  ; $00
db 01 : dw $0000 : dw $0000 ; Scanline 1  ; $05
db 01 : dw $0000 : dw $0000 ; Scanline 2  ; $0A
db 01 : dw $0000 : dw $0000 ; Scanline 3  ; $0F
db 01 : dw $0000 : dw $0000 ; Scanline 4  ; $14
db 01 : dw $0000 : dw $0000 ; Scanline 5  ; $19
db 08 : dw $0000 : dw $0000 ; Scanline 6  ; $1E
db 01 : dw $0000 : dw $0000 ; Scanline 14 ; $23
db 06 : dw $0000 : dw $0000 ; Scanline 15 ; $28
db 01 : dw $0000 : dw $0000 ; Scanline 22 ; $32
db 01 : dw $0000 : dw $0000 ; Scanline 21 ; $2D
db 06 : dw $0000 : dw $0000 ; Scanline 23 ; $37
db 01 : dw $0000 : dw $0000 ; Scanline 29 ; $3C
db 01 : dw $0000 : dw $0000 ; Scanline 30 ; $41
db 01 : dw $0000 : dw $0000 ; Scanline 31 ; $46
db 00                                     ; $4B

; Commands with hooks in hooks.asm on different game state changes.
; We may not need these or their hooks. When we're finished testing the
; countdown HUD, we can remove any we're not using (which may be most
; of them.)
SetHDMAPointerLoad:
        LDA.w #SetupPaletteTransfer : STA.w HUDHDMAPtr
        LDA.w #$0007 : STA.w GameState ; What we wrote over
RTL

SetHDMAPointerDoorFadeOut:
        LDA.w #SetupPaletteTransfer : STA.w HUDHDMAPtr
        LDA.w #$0009 : STA.w GameState ; What we wrote over
RTL

SetHDMAPointerDoorFadeIn:
        LDA.w #SetupPaletteTransfer_door_fade : STA.w HUDHDMAPtr
        LDA.w #$E737 : STA.w DoorTransitionPtr ; What we wrote over
RTL

SetHDMAPointerDoorStart:
        LDA.w #SetupPaletteTransfer_done : STA.w HUDHDMAPtr
        LDA.w #$E310 : STA.w DoorTransitionPtr ; What we wrote over
RTL

SetHDMAPointerDoorEnd:
        LDA.w #SetupPaletteTransfer : STA.w HUDHDMAPtr
        LDA.w #$0008 : STA.w GameState
RTL

SetHDMAPointerPause:
        LDA.w #SetupPaletteTransfer : STA.w HUDHDMAPtr
        STZ.w ScreenFadeCounter : INC.w GameState ; What we wrote over
RTL

SetHDMAPointerUnpause:
        LDA.w #SetupPaletteTransfer : STA.w HUDHDMAPtr
        STZ.w ScreenFadeCounter : INC.w GameState ; What we wrote over
RTL

SetHDMAPointerDoorDark:
        LDA.w #SetupPaletteTransfer_door_transition : STA.w HUDHDMAPtr
        LDA.w #$E36E : STA.w DoorTransitionPtr ; What we wrote over
RTL

SetHDMAPointerEnding:
        LDA.w #ActivateHDMA : STA.w HUDHDMAPtr
        LDA.w #$0027 : STA.w GameState ; What we wrote over
RTL

MessageBoxHDMA:
                LDA.b #$03 : STA.w $4300
                LDA.b #$21 : STA.w $4301
                REP #$20
                LDA.w #HUDHDMAWRAM : STA.w $4302
                SEP #$20
                LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
                LDA.b #$41 : STA.w $420C ; What we wrote over
RTL

MessageBoxInitHDMA:
                SEP #$20 ; What we wrote over
                LDA.b #$03 : STA.w $4300
                LDA.b #$21 : STA.w $4301
                REP #$20
                LDA.w #HUDHDMAWRAM : STA.w $4302
                SEP #$20
                LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
                LDA.b #$01 : STA.w $420C ; What we wrote over
RTL

MessageBoxCloseHDMA:
                SEP #$20 ; What we wrote over
                LDA.b #$03 : STA.w $4300
                LDA.b #$21 : STA.w $4301
                REP #$20
                LDA.w #HUDHDMAWRAM : STA.w $4302
                SEP #$20
                LDA.b #HUDHDMAWRAM>>16 : STA.w $4304
                LDA.b #$01 : STA.w $420C ; What we wrote over
RTL

FindChannel:
        SEP #$30
        LDA.b #$01
        LDY.b #$00
        -
        BIT.b HDMAChannels : BEQ .found
                ASL : INY : BRA -
        .found
        TAX
        REP #$30
        LDA.w #$4300 : STA.b $10
        TYA : ASL #4
        CLC : ADC.b $10 : STA.b $10
        SEP #$30
RTS

