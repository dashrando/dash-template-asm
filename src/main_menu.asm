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
                LDA.l WordTable,X : AND.w #$00FF
                ASL
                PHX : TAX
                LDA.l CharTable,X
                PLX
                STA.b [$08],Y
                DEX : DEY #2
        BPL -
RTS

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

    ;Draw the randomized boss letter for the random K Boss in the middle row
    LDA.l BossTable_bosses : ASL : TAX
    LDA.l BossKnownTiles,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$138

    ;-------------
    ;Wrecked Ship (WS)
    ;-------------

    ;Draw the randomized boss letter for the random P Boss in the middle row
    LDA.l BossTable_bosses+$02 : ASL : TAX
    LDA.l BossKnownTiles,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$13E

    ;-------------
    ;East Maridia (EM)
    ;-------------

    ;Draw the randomized boss letter for the random D Boss in the middle row
    LDA.l BossTable_bosses+$04 : ASL : TAX
    LDA.l BossKnownTiles,X
    STA.l !BOSSES_KNOWN_TILEMAP_BASE+$144


    ;-------------
    ;Lower Norfair (LN)
    ;-------------

    ;Draw the randomized boss letter for the random R Boss in the middle row
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