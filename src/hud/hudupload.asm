UploadHUDTiles:
; Overwriting mini-map tiles we're no longer using
        SEP #$20
        LDA.b #$80 : STA.w $2115
        LDA.b #$80 : STA.w $2116
        LDA.b #$40 : STA.w $2117
        JSL.l SetupDMATransfer
        db $01,$01,$18
        dl HUDTilesAlphabet
        dw $0200
        LDA.b #$02 : STA.w $420B

        LDA.b #$80 : STA.w $2115
        LDA.b #$00 : STA.w $2116
        LDA.b #$43 : STA.w $2117
        JSL.l SetupDMATransfer
        db $01,$01,$18
        dl HUDTilesIcons
        dw $0200
        LDA.b #$02 : STA.w $420B
        REP #$20
RTS

LoadStandardBG3Expanded:
        JSR.w LoadStandardBG3 ; Keep first, what we wrote over
        JSR.w UploadHUDTiles
RTS

LoadHUDTilesDoors:
        JSR.w UploadHUDTiles
        SEP #$20
        LDA.b #$0F : STA.w $2100 ; What we wrote over. Disable forced blank.
RTL

LoadPauseTilesExpanded:
        JSL.l LoadPauseMenuTiles
        JSR.w UploadHUDTiles
RTS

