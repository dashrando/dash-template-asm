;------------------------------------------------------------------------------
; HUD HDMA
;------------------------------------------------------------------------------
; Our HUD palette works in two phases. First we set our HUDHDMAPtr in WRAM which points
; to a routine that sets up our HDMA. Then we run a routine in our post-NMI hook that
; places all of our initial new HUD colors but one into CGRAM by interacting directly
; with the CGADD and CGDATA registers.
;
; Our HUDHDMAPtr routine is called where the vanilla NMI writes to $420C. This
; routine is responsible for selecting the appropriate channels for the situation.
; If we're not using HDMA during the next frame, we point it to #ActivateHDMA instead.
; We need to select two channels that will not interfere with vanilla effects
; including but not limited to: power bombs, X-ray, liquid effects and scrolling,
; and message boxes. This routine is also responsible for updating the HUD
; palette HDMA table in WRAM for the next frame.
;
; The HDMA table should restore the vanilla palettes before the final scanline
; of the HUD (31.) If using fading palettes, get the color from the main vanilla
; palette buffer at $7EC000 (PaletteBuffer.) Otherwise, we may set them statically.
; We always use scanline 0 to set one of our initial new HUD colors instead of
; setting that color during NMI because one HDMA must trigger on that scanline.
; When modifying our HDMA table in RAM the address is notated HUDHDMAWRAM+3+(5*r) where
; r = the row in the table.
;
; If the HDMA table is modified be sure to check the message box HDMA routines in
; messsageboxes.asm and update them accordingly if necessary. Message boxes do their
; own palette HDMA setup and tear down.
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
        LDX.b #$03 : STX.w $4300
        LDX.b #$21 : STX.w $4301
        LDA.w #HUDHDMAWRAM : STA.w $4302
        LDX.b #HUDHDMAWRAM>>16 : STX.w $4304
        SEP #$20
        LDA.b #$01 : ORA.b HDMAChannels : STA.b HDMAChannels
        REP #$20

        LDX.b HDMAChannels : STX.w $420C
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAWRAM+3+(5*1)
        LDA.l PaletteBuffer+$0A : STA.l HUDHDMAWRAM+3+(5*4)
        LDA.l PaletteBuffer+$0C : STA.l HUDHDMAWRAM+3+(5*3)
        LDA.l PaletteBuffer+$0E : STA.l HUDHDMAWRAM+3+(5*6)
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAWRAM+3+(5*8)
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMAWRAM+3+(5*9)
        LDA.l PaletteBuffer+$3C : STA.l HUDHDMAWRAM+3+(5*7)
        .done
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
        LDA.l PaletteBuffer+$02 : STA.l HUDHDMAWRAM+3+(5*1)
        LDA.l PaletteBuffer+$0A : STA.l HUDHDMAWRAM+3+(5*4)
        LDA.l PaletteBuffer+$0C : STA.l HUDHDMAWRAM+3+(5*3)
        LDA.l PaletteBuffer+$0E : STA.l HUDHDMAWRAM+3+(5*6)
        LDA.l PaletteBuffer+$32 : STA.l HUDHDMAWRAM+3+(5*8)
        LDA.l PaletteBuffer+$34 : STA.l HUDHDMAWRAM+3+(5*9)
        LDA.l PaletteBuffer+$3C : STA.l HUDHDMAWRAM+3+(5*7)
RTL

HUDHDMAOne:
db 14 : dw $0101 : dw $03DD ; Scanline 0  ; $00 | Area Code Yellow (Required write)
db 01 : dw $0101 : dw $02DF ; Scanline 14 ; $05 | Vanilla Write
db 06 : dw $0505 : dw $1C3B ; Scanline 15 ; $0A | Major Count Red
db 01 : dw $0606 : dw $2D08 ; Scanline 21 ; $0F | Vanilla Write
db 01 : dw $0505 : dw $41AD ; Scanline 22 ; $14 | Vanilla Write
db 05 : dw $1919 : dw $71C7 ; Scanline 23 ; $19 | Pressure Valve Blue
db 01 : dw $0707 : dw $1863 ; Scanline 28 ; $1E | Vanilla Write
db 01 : dw $1E1E : dw $001F ; Scanline 29 ; $23 | Vanilla Write
db 01 : dw $1919 : dw $5AD6 ; Scanline 30 ; $28 | Vanilla Write
db 01 : dw $1A1A : dw $4A52 ; Scanline 31 ; $2D | Vanilla Write
dw 00                                     ; $32 | Termination Byte

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

SetHDMAPointerPause:
        LDA.w #SetupPaletteTransfer : STA.w HUDHDMAPtr
        STZ.w ScreenFadeCounter : INC.w GameState ; What we wrote over
RTL

SetHDMAPointerUnpause:
        LDA.w #SetupPaletteTransfer : STA.w HUDHDMAPtr
        STZ.w ScreenFadeCounter : INC.w GameState ; What we wrote over
RTL

SetHDMAPointerEnding:
        LDA.w #ActivateHDMA : STA.w HUDHDMAPtr
        LDA.w #$0027 : STA.w GameState ; What we wrote over
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

HUDPaletteNMITransfer:
; We do these at the end of NMI where we hopefully have some more time compared to the frame
        LDA.w HUDHDMAPtr : CMP.w #ActivateHDMA : BEQ .skip
                LDX.b #$05 : STX.w $2121
                LDX.b #$0F : STX.w $2122
                LDX.b #$70 : STX.w $2122

                LDX.b #$06 : STX.w $2121
                LDX.b #$FF : STX.w $2122
                LDX.b #$7F : STX.w $2122

                LDX.b #$19 : STX.w $2121
                LDX.b #$87 : STX.w $2122
                LDX.b #$36 : STX.w $2122

                LDX.b #$1A : STX.w $2121
                LDX.b #$FF : STX.w $2122
                LDX.b #$7F : STX.w $2122

                LDX.b #$1E : STX.w $2121
                LDX.b #$FF : STX.w $2122
                LDX.b #$7F : STX.w $2122
        .skip
RTS

