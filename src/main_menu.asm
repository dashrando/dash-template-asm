;------------------------------------------------------------------------------
; Main Menu Screens
;------------------------------------------------------------------------------
; File select and Game Options screens
;------------------------------------------------------------------------------

!BOSSES_KNOWN_TILEMAP_BASE = $7E3B30
;------------------------------------------------------------------------------
; Draw Game Hash Code
;------------------------------------------------------------------------------
DrawFileSelectHash:
        PHX
        LDA.w #$007F : STA.b $0A

        LDA.w #$C052 : STA.b $08
        LDA.l FileSelectCode+$00
        JSR.w WriteHashTiles

        LDA.w #$C060 : STA.b $08
        LDA.l FileSelectCode+$01
        JSR.w WriteHashTiles

        LDA.w #$C092 : STA.b $08
        LDA.l FileSelectCode+$02
        JSR.w WriteHashTiles

        LDA.w #$C0A0 : STA.b $08
        LDA.l FileSelectCode+$03
        JSR.w WriteHashTiles

        PLX
        LDX.w #$07FE
RTS

WriteHashTiles:
        AND.w #$001F
        ASL #3 : ADC.w #$0007 : TAX
        LDY.w #$000E
        -
                LDA.w WordTable,X : AND.w #$00FF
                ASL
                PHY : TAY
                LDA.w CharTable,Y
                PLY
                STA.b [$08],Y
                DEX : DEY #2
        BPL -
RTS

CharTable:
; 0x00																				  	     0x0F
dw $000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F
; 0x10																				  	     0x0F
dw $000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F
; 0x20																				  	     0x0F
dw $000F,$0084,$002D,$000F,$000F,$000F,$000F,$0022,$008A,$008B,$000F,$0086,$0089,$0087,$0088,$000F

NumTable:
; 0x30																				  	     0x0F
dw $0060,$0061,$0062,$0063,$0064,$0065,$0066,$0067,$0068,$0069,$000F,$000F,$000F,$000F,$000F,$0085
; 0x40																				  	     0x0F
dw $000F,$006A,$006B,$006C,$006D,$006E,$006F,$0070,$0071,$0072,$0073,$0074,$0075,$0076,$0077,$0078
; 0x50																				  	     0x0F
dw $0079,$007A,$007B,$007C,$007D,$007E,$007F,$0080,$0081,$0082,$0083,$000F,$000F,$000F,$000F,$000F

WordTable:
    db "GEEMER  "
    db "RIPPER  "
    db "ATOMIC  "
    db "POWAMP  "
    db "SCISER  "
    db "NAMIHE  "
    db "PUROMI  "
    db "ALCOON  "
    db "BEETOM  "
    db "OWTCH   "
    db "ZEBBO   "
    db "ZEELA   "
    db "HOLTZ   "
    db "VIOLA   "
    db "WAVER   "
    db "RINKA   "
    db "BOYON   "
    db "CHOOT   "
    db "KAGO    "
    db "SKREE   "
    db "COVERN  "
    db "EVIR    "
    db "TATORI  "
    db "OUM     "
    db "PUYO    "
    db "YARD    "
    db "ZOA     "
    db "FUNE    "
    db "GAMET   "
    db "GERUTA  "
    db "SOVA    "
    db "BULL    "

InfoStr:
    db "TOURNAMENT SEED!"

OnStartGame: ; Pressing "START GAME"
        LDA.l FreshFileMarker : BNE .skip
                LDA.w #$0001 : STA.l FreshFileMarker
                DEC
                STA.l NMIFrames : STA.l NMIFrames+$02
                STA.l MenuFrames : STA.l MenuFrames+$02
        .skip
RTS

DrawBossesKnown:
    LDA.l ShowBosses : BNE .draw
    LDA.w #$0001 : STA.w $198D ; What we wrote over.
    RTL

.draw:
    ;*********************************************************************
    ;ROW - LOCATION (STATIC INFO)
    ;*********************************************************************
    
    ;Draw a STATIC "LOC:" at the beginning of the TOP row for the Location label
    LDA.w #$0075 ; L
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$F0
    LDA.w #$0078 ; O
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$F2
    LDA.w #$006C ; C
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$F4
    LDA.w #$008C ; :
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$F6

    ;-------------
    ;Kraid's Lair (KR)
    ;-------------

    ;Draw a STATIC KR in the top row
    LDA.w #$0074 ; K
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$F8
    LDA.w #$007B ; R
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$FA

    ;-------------
    ;Wrecked Ship (WS)
    ;-------------

    ;Draw a STATIC WS in the top row
    LDA.w #$0080 ; W
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$FE
    LDA.w #$007C ; S
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$100

    ;-------------
    ;East Maridia (EM)
    ;-------------

    ;Draw a STATIC EM in the top row
    LDA.w #$006E ; E
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$104
    LDA.w #$0076 ; M
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$106

    ;-------------
    ;Lower Norfair (LN)
    ;-------------

    ;Draw a STATIC LN in the top row
    LDA.w #$0075 ; L
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$10A
    LDA.w #$0077 ; N
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$10C

    ;*********************************************************************
    ;ROW - BOSS (DYNAMIC INFO)
    ;*********************************************************************

    ;Draw a STATIC "BOSS:" at the beginning of the MIDDLE row for the Boss label
    LDA.w #$006B ; B
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$12E
    LDA.w #$0078 ; O
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$130
    LDA.w #$007C ; S
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$132
    LDA.w #$007C ; S
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$134
    LDA.w #$008C ; :
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$136

    ;-------------
    ;Kraid's Lair (KR)
    ;-------------

    ;Draw the randomized boss letter for the KR Location in the bottom row
    LDA.l BossTable_bosses : ASL : TAX
    LDA.l BossKnownTiles,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$138

    ;-------------
    ;Wrecked Ship (WS)
    ;-------------

    ;Draw the randomized boss letter for the WS Location in the bottom row
    LDA.l BossTable_bosses+$02 : ASL : TAX
    LDA.l BossKnownTiles,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$13E

    ;-------------
    ;East Maridia (EM)
    ;-------------

    ;Draw the randomized boss letter for the EM Location in the bottom row
    LDA.l BossTable_bosses+$04 : ASL : TAX
    LDA.l BossKnownTiles,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$144


    ;-------------
    ;Lower Norfair (LN)
    ;-------------

    ;Draw the randomized boss letter for the LN Location in the bottom row
    LDA.l BossTable_bosses+$06 : ASL : TAX
    LDA.l BossKnownTiles,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$14A

    ;*********************************************************************
    ;ROW - OPENS (DYNAMIC INFO)
    ;*********************************************************************

    ;Draw a STATIC "OPENS:" at the beginning of the BOTTOM row for the Location label
    LDA.w #$0078 ; O
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$16C
    LDA.w #$0079 ; P
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$16E
    LDA.w #$006E ; E
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$170
    LDA.w #$0077 ; N
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$172
    LDA.w #$007C ; S
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$174
    LDA.w #$008C ; :
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$176

    ;-------------
    ;Kraid's Lair (KR)
    ;-------------

    LDA.l BossTable_areas+$00 : ASL #2 : TAX
    LDA.l BossKnownTiles_areas,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$178
    LDA.l BossKnownTiles_areas+$02,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$17A

    ;-------------
    ;Wrecked Ship (WS)
    ;-------------

    LDA.l BossTable_areas+$02 : ASL #2 : TAX
    LDA.l BossKnownTiles_areas,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$17E
    LDA.l BossKnownTiles_areas+$02,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$180

    ;-------------
    ;East Maridia (EM)
    ;-------------

    LDA.l BossTable_areas+$04 : ASL #2 : TAX
    LDA.l BossKnownTiles_areas,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$184
    LDA.l BossKnownTiles_areas+$02,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$186

    ;-------------
    ;Lower Norfair (LN)
    ;-------------

    LDA.l BossTable_areas+$06 : ASL #2 : TAX
    LDA.l BossKnownTiles_areas,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$18A
    LDA.l BossKnownTiles_areas+$02,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$18C

RTL


BossKnownTiles:
; The order of these needs to stay the same for the bosses known info to be correct.
dw #$0074 ; K | $00
dw #$0079 ; P | $02
dw #$006D ; D | $04
dw #$007B ; R | $06

.areas:
dw #$0074 ; K | $08
dw #$007B ; R | $0A

dw #$0080 ; W | $0C
dw #$007C ; S | $0E

dw #$006E ; E | $10
dw #$0076 ; M | $12

dw #$0075 ; L | $14
dw #$0077 ; N | $16
