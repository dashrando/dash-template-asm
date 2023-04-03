;------------------------------------------------------------------------------
; HUD HDMA
;------------------------------------------------------------------------------
; We use HDMA to put new colors on the HUD. We have a word in mirrored WRAM,
; HUDHDMAPtr, that's a pointer to some routine in this module and bank ($80.)
; These routines are responsible for:
; 
; 1. Placing our new colors in CGRAM before scanline 0 (use CGADD and CGDATA if
;    transferring less than several contiguous colors, the most common case.)
; 2. Selecting the appropriate HDMA channels for the situation and setting up
;    our HDMA tables in WRAM to replace our colors with their vanilla color during
;    the next frame.
;
; These channels and colors will be different in different situations, so we also
; need to hook in and change HUDHDMAPtr on game state changes that require different
; approaches to the two tasks above. Some things to check that our HDMA does not
; interfere with include but are not limited to the following: X-Ray/light cone,
; power bomb explosion, liquid visibility and scrolling, message boxes.
;------------------------------------------------------------------------------


HUDChangePalette:
        ;LDA.w NMIRequestFlag : BEQ .done
        ;JSR.w FindChannel
        ;PHX
        ;LDA.b #$03 : STA.b ($10)
        ;INC.b $10
        ;LDA.b #$21 : STA.b ($10)
        ;INC.b $10
        ;REP #$20
        ;LDA.w #HUDHDMAOneWRAM : STA.b ($10)
        ;SEP #$20
        ;INC.b $10 : INC.b $10
        ;LDA.b #HUDHDMAOneWRAM>>16 : STA.b ($10)
        ;PLA
        ;ORA.b HDMAChannels : STA.b HDMAChannels

        ;JSR.w FindChannel
        ;PHX
        ;LDA.b #$03 : STA.b ($10)
        ;INC.b $10
        ;LDA.b #$21 : STA.b ($10)
        ;INC.b $10
        ;REP #$20
        ;LDA.w #HUDHDMATwoWRAM : STA.b ($10)
        ;SEP #$20
        ;INC.b $10 : INC.b $10
        ;LDA.b #HUDHDMATwoWRAM>>16 : STA.b ($10)
        ;PLA
        ;ORA.b HDMAChannels : STA.b HDMAChannels

        SEP #$30
        LDX.w TimeFrozenFlag : BNE +
        LDX.w NMIRequestFlag : BNE +
                REP #$30
                RTL
        +
        LDA.b #$03 : STA.w $4300
        LDA.b #$21 : STA.w $4301
        REP #$20
        LDA.w #HUDHDMAOneWRAM : STA.w $4302
        SEP #$20
        LDA.b #HUDHDMAOneWRAM>>16 : STA.w $4304
        LDA.b #$01 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b #$03 : STA.w $4310
        LDA.b #$21 : STA.w $4311
        REP #$20
        LDA.w #HUDHDMATwoWRAM : STA.w $4312
        SEP #$20
        LDA.b #HUDHDMATwoWRAM>>16 : STA.w $4314
        LDA.b #$02 : ORA.b HDMAChannels : STA.b HDMAChannels

        ;LDA.b HDMAChannels : STA.w $420C

        ; Initial (new) colors
        LDA.b #$01 : STA.w $2121 ; Area Codes turquoise
        LDA.b #$E0 : STA.w $2122 ;
        LDA.b #$73 : STA.w $2122 ;
        LDA.b #$03 : STA.w $2121 ;
        LDA.b #$00 : STA.w $2122 ;
        LDA.b #$00 : STA.w $2122 ;

        LDA.b #$19 : STA.w $2121 ; Major Countdown red
        LDA.b #$1D : STA.w $2122 ;
        LDA.b #$08 : STA.w $2122 ;
        LDA.b #$1A : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        LDA.b #$1D : STA.w $2121 ; Tank Countdown green
        LDA.b #$60 : STA.w $2122 ;
        LDA.b #$02 : STA.w $2122 ;
        LDA.b #$1E : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        .done
        REP #$30
        ; HDMA table use vanilla palette buffer for fading color indexes we're using
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAOneWRAM+$08
        LDA.l PaletteBuffer+$06 : STA.l HUDHDMATwoWRAM+$08
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAOneWRAM+$0D
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMATwoWRAM+$0D
RTL

.door_fade
        SEP #$30
        LDA.b #$03 : STA.w $4300
        LDA.b #$21 : STA.w $4301
        REP #$20
        LDA.w #HUDHDMAOneWRAM : STA.w $4302
        SEP #$20
        LDA.b #HUDHDMAOneWRAM>>16 : STA.w $4304
        LDA.b #$01 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b #$03 : STA.w $4310
        LDA.b #$21 : STA.w $4311
        REP #$20
        LDA.w #HUDHDMATwoWRAM : STA.w $4312
        SEP #$20
        LDA.b #HUDHDMATwoWRAM>>16 : STA.w $4314
        LDA.b #$02 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b HDMAChannels : STA.w $420C

        ; Initial (new) colors
        LDA.b #$01 : STA.w $2121 ; Area Codes turquoise
        LDA.b #$E0 : STA.w $2122 ;
        LDA.b #$73 : STA.w $2122 ;
        LDA.b #$03 : STA.w $2121 ;
        LDA.b #$00 : STA.w $2122 ;
        LDA.b #$00 : STA.w $2122 ;

        LDA.b #$19 : STA.w $2121 ; Major Countdown red
        LDA.b #$1D : STA.w $2122 ;
        LDA.b #$08 : STA.w $2122 ;
        LDA.b #$1A : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        LDA.b #$1D : STA.w $2121 ; Tank Countdown green
        LDA.b #$60 : STA.w $2122 ;
        LDA.b #$02 : STA.w $2122 ;
        LDA.b #$1E : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        REP #$30
        ; HDMA table use vanilla palette buffer for fading color indexes we're using
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAOneWRAM+$08
        LDA.l PaletteBuffer+$06 : STA.l HUDHDMATwoWRAM+$08
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAOneWRAM+$0D
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMATwoWRAM+$0D
RTL

.door
        ; Screen has faded and is mostly black
        SEP #$20
        LDA.b #$03 : STA.w $4350
        LDA.b #$21 : STA.w $4351
        REP #$20
        LDA.w #HUDHDMAOneWRAM : STA.w $4352
        SEP #$20
        LDA.b #HUDHDMAOneWRAM>>16 : STA.w $4354
        LDA.b #$20 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b #$03 : STA.w $4340
        LDA.b #$21 : STA.w $4341
        REP #$20
        LDA.w #HUDHDMATwoWRAM : STA.w $4342
        SEP #$20
        LDA.b #HUDHDMATwoWRAM>>16 : STA.w $4344
        LDA.b #$10 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b HDMAChannels : STA.w $420C

        LDA.b #$01 : STA.w $2121 ; Area Codes turquoise
        LDA.b #$E0 : STA.w $2122 ;
        LDA.b #$73 : STA.w $2122 ;
        LDA.b #$03 : STA.w $2121 ;
        LDA.b #$00 : STA.w $2122 ;
        LDA.b #$00 : STA.w $2122 ;

        LDA.b #$19 : STA.w $2121 ; Major Countdown red
        LDA.b #$1D : STA.w $2122 ;
        LDA.b #$08 : STA.w $2122 ;
        LDA.b #$1A : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        LDA.b #$1D : STA.w $2121 ; Tank Countdown green
        LDA.b #$60 : STA.w $2122 ;
        LDA.b #$02 : STA.w $2122 ;
        LDA.b #$1E : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        REP #$20
        LDA.w #$0000 : STA.l HUDHDMAOneWRAM+$08
        LDA.w #$0000 : STA.l HUDHDMATwoWRAM+$08
        LDA.w #$0000 : STA.l HUDHDMATwoWRAM+$0D
        LDA.w #$0000 : STA.l HUDHDMATwoWRAM+$12
RTL

.pause
        SEP #$30
        LDA.b #$03 : STA.w $4340
        LDA.b #$21 : STA.w $4341
        REP #$20
        LDA.w #HUDHDMAOneWRAM : STA.w $4342
        SEP #$20
        LDA.b #HUDHDMAOneWRAM>>16 : STA.w $4344
        LDA.b #$10 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b #$03 : STA.w $4350
        LDA.b #$21 : STA.w $4351
        REP #$20
        LDA.w #HUDHDMATwoWRAM : STA.w $4352
        SEP #$20
        LDA.b #HUDHDMATwoWRAM>>16 : STA.w $4354
        LDA.b #$20 : ORA.b HDMAChannels : STA.b HDMAChannels

        LDA.b HDMAChannels : STA.w $420C

        ; Initial (new) colors
        LDA.b #$01 : STA.w $2121 ; Area Codes turquoise
        LDA.b #$E0 : STA.w $2122 ;
        LDA.b #$73 : STA.w $2122 ;
        LDA.b #$03 : STA.w $2121 ;
        LDA.b #$00 : STA.w $2122 ;
        LDA.b #$00 : STA.w $2122 ;

        LDA.b #$19 : STA.w $2121 ; Major Countdown red
        LDA.b #$1D : STA.w $2122 ;
        LDA.b #$08 : STA.w $2122 ;
        LDA.b #$1A : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        LDA.b #$1D : STA.w $2121 ; Tank Countdown green
        LDA.b #$60 : STA.w $2122 ;
        LDA.b #$02 : STA.w $2122 ;
        LDA.b #$1E : STA.w $2121 ;
        LDA.b #$FF : STA.w $2122 ;
        LDA.b #$7F : STA.w $2122 ;

        REP #$30
        ; HDMA table use vanilla palette buffer for fading color indexes we're using
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAOneWRAM+$08
        LDA.l PaletteBuffer+$06 : STA.l HUDHDMATwoWRAM+$08
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAOneWRAM+$0D
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMATwoWRAM+$0D
RTL

HUDHDMAOne:
db 15 : dw $0F0F : dw $0000 ; Scanline 0
db 08 : dw $0101 : dw $0BB1 ; Scanline 14
db 07 : dw $1919 : dw $5AD6 ; Scanline 23
db 01 : dw $1D1D : dw $02DF ; Scanline 30
dw 00

HUDHDMATwo:
db 15 : dw $0F0F : dw $0000 ; Scanline 0
db 08 : dw $0303 : dw $0145 ; Scanline 14
db 07 : dw $1A1A : dw $4A52 ; Scanline 23
db 01 : dw $1E1E : dw $001F ; Scanline 30
dw 00

SetHDMAPointerLoad:
        LDA.w #HUDChangePalette : STA.w HUDHDMAPtr
        LDA.w #$0007 : STA.w GameState ; What we wrote over
RTL

SetHDMAPointerDoorFadeOut:
        LDA.w #HUDChangePalette_door_fade : STA.w HUDHDMAPtr
        LDA.w #$0009 : STA.w GameState ; What we wrote over
RTL

SetHDMAPointerDoorFadeIn:
        LDA.w #HUDChangePalette_door_fade : STA.w HUDHDMAPtr
        LDA.w #$E659 : STA.w DoorTransitionPtr ; What we wrote over
RTL

SetHDMAPointerDoorStart:
        LDA.w #HUDChangePalette_door : STA.w HUDHDMAPtr
        LDA.w #$E353 : STA.w DoorTransitionPtr ; What we wrote over
RTL

SetHDMAPointerDoorEnd:
        LDA.w #HUDChangePalette : STA.w HUDHDMAPtr
        LDA.w #$0008 : STA.w GameState
RTL

SetHDMAPointerPause:
        LDA.w #HUDChangePalette_pause : STA.w HUDHDMAPtr
        STZ.w ScreenFadeCounter : INC.w GameState ; What we wrote over
RTL

SetHDMAPointerUnpause:
        LDA.w #HUDChangePalette : STA.w HUDHDMAPtr
        STZ.w ScreenFadeCounter : INC.w GameState ; What we wrote over
RTL

MessageBoxHDMA:
                LDA.b #$03 : STA.w $4300
                LDA.b #$21 : STA.w $4301
                REP #$20
                LDA.w #HUDHDMAOne : STA.w $4302
                SEP #$20
                LDA.b #HUDHDMAOne>>16 : STA.w $4304
                LDA.b #$41 : STA.w $420C ; What we wrote over
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

; Vanilla palette colors
; dw $0000, $02DF, $01D7, $00AC, $5A73, $41AD, $2D08, $1863, $0BB1, $48FB, $7FFF, $0000, $7FFF, $44E5, $7FFF, $0000
; dw $2003, $0BB1, $1EA9, $0145, $5EBB, $3DB3, $292E, $1486, $6318, $5AD6, $4A52, $0000, $7FFF, $02DF, $001F, $0000

; NOTES
;
; water fx - 2 3 4 5 7
;
;
;
;
;
;
