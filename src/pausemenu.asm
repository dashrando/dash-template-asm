;------------------------------------------------------------------------------
; Pause Menu Screens
; Both Map and Equipment screens are actually one texture/screen and the code 
; just scrolls the screen to the right or left depending on which screen is being displayed.
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; This draws the bosses known info in the bottom portion of the pause menus.
;------------------------------------------------------------------------------
DrawBossesKnownPauseMenu:
    JSR $B20C                   ; What we wrote over.

    REP #$30
    PHX : PHY                   ;We're using both X and Y for looping the middle and bottom rows.
    SEP #$20                    ; 8-bit A to check 1-byte flag
    LDA.l ShowBosses            
    BNE .drawBossesKnown
    JMP.w .skip                 ; Skip drawing all the UI if Bosses Known is off.

.drawBossesKnown:
;------------------------------------------------------------------------------
; THE TOP ROW: 
;------------------------------------------------------------------------------
; Row 24 - Write directly to BG2 VRAM ($3B00.w base + Col)
; This row covers up the boarder tiles at the bottom of the map boarder. We have to
; draw differently here because the boarder tiles are already written to VRAM and 
; won't be drawn over with the passing in of the WRAM buffer (like the other rows are).
;------------------------------------------------------------------------------
    LDA #$80                    ; Increment VRAM word address by +1 after high byte write
    STA.l $002115

    REP #$30                    ; 16-bit A, X, Y
    LDA #$3B05                  ; BG2 Row 24, Col 5 ($3B00 + 5) — adjust column offset as needed
    STA.l $002116

    LDX #$0000                  ;Initialize loop counter

.topRow_loop:
    LDA.l TopTextRow,X
    CMP #$FFFF                  ; Check for end of loop.
    BEQ .start_middleRow
    STA.l $002118               ; Write tile directly to VRAM and auto-increment
    INX #2
    BRA .topRow_loop

;------------------------------------------------------------------------------
; THE MIDDLE ROW: 
;------------------------------------------------------------------------------
; Row 25 - Write to BG2 WRAM buffer ($7E:3640 base + Col*2) ---

.start_middleRow:
    LDX #$0000                  ;Reset loop counters
    LDY #$0000
.middleRow_loop:
    LDA.l MiddleTextRow,X
    BNE .continueDrawingMiddleRow

    ; This section is for when we need to draw the randomized boss letter rolled by the seed.
    PHX
    TYX
    LDA.l BossTable_bosses,X
    ASL : TAX
    LDA.l BossKnownTiles,X
    CLC : ADC #$37C6            ; This is the conversion value needed from the Main Menu TileMap 
                                ; added to the Pause Menu Tilemap to get the right letters displayed.
                                ; All calculations from the main menu tilemap to the pause menu tilemap were
                                ; exactly 3A less. So we add $3800-3A to the tile value here. Voila!
    PLX                           
    INY #2
    
.continueDrawingMiddleRow:
    CMP #$FFFF                  ; Check for end of loop.
    BEQ .start_bottomRow
    STA.l $7E364A,X             ; Print the letter tile. BG2 Row 25, Col 5 ($7E:3640 + 10)
    INX #2
    BRA .middleRow_loop

;------------------------------------------------------------------------------
; THE BOTTOM ROW: 
;------------------------------------------------------------------------------
; ROW 26 - Write to BG2 WRAM buffer ($7E:3680 base + Col*2) ---
.start_bottomRow:
    LDX #$0000                  ;Reset loop counters
    LDY #$0000

.bottomRow_loop:
    LDA.l BottomTextRow,X
    BNE .continueDrawingBottomRow

    PHX
    TYA : AND #$FFFE : TAX       ; This rounds down to the nearest even number, so we can keep both letters in the same area.
                                 ; We do this to get the following numerical pattern: 0, 0, 2, 2, 4, 4, 6, 6.
                                 ; So 1st area, 1st area, 2nd area, 2nd area, 3rd area, 3rd area, 4th area, 4th area.
    LDA.l BossTable_areas,X
    ASL #2 : TAX                 ; Area ID * 4: The start of its two-letter pair. This is so we can have the following
                                 ; numerical pattern: 0, 2, 4, 6, 8, A, C, E.
    TYA : AND #$0001
    BNE .bottomRow_secondAreaLetter
    LDA.l BossKnownTiles_areas,X ; Select the first letter of the chosen area.
    BRA .bottomRow_letterChosen

.bottomRow_secondAreaLetter:
    LDA.l BossKnownTiles_areas+$02,X ; Select the second letter of the chosen area.

.bottomRow_letterChosen:
    CLC : ADC #$37C6            ; This is the conversion value needed from the Main Menu TileMap 
                                ; added to the Pause Menu Tilemap to get the right letters displayed. 
                                ; All calculations from the main menu tilemap to the pause menu tilemap were
                                ; exactly 3A less. So we add $3800-3A to the tile value here. Voila! 
    PLX
    INY
    
.continueDrawingBottomRow:
    CMP #$FFFF
    BEQ .skip
    STA.l $7E368A,X             ; Print the letter tile. BG2 Row 26, Col 5 ($7E:3680 + 10)
    INX #2
    BRA .bottomRow_loop

.skip:
    PLY : PLX
    RTS
    
; ---------------------------------------------------------------------
; For the MAP and EQUIPMENT Screens
; Skips over all routines that recolor the blue rectangles when the "Map"
; and "Samus" texts are not displayed inside them (next to the L and R
; button UI) when ShowBosses is true. Otherwise we just run the original code.
; ---------------------------------------------------------------------
CheckPauseMapButtonRecoloring:
    REP #$30 : PHP              ; What we jumped over
    LDA.l ShowBosses
    BEQ .run_original

    PLP
    RTS                         ; Just return, skipping the button recoloring

.run_original:
    JMP.w $A62B                 ; Jump back to the original code

CheckPauseSamusButtonRecoloring:
    REP #$30 : PHP              ; What we jumped over
    LDA.l ShowBosses
    BEQ .run_original

    PLP
    RTS                         ; Just return, skipping the button recoloring

.run_original:
    JMP.w $A6E2                 ; Jump back to the original code

CheckMapScreenLabels:
    REP #$30 : PHP              ; What we jumped over
    LDA.l ShowBosses
    BEQ .run_original

    PLP
    RTS                         ; Skip button recoloring when ShowBosses is active

.run_original:
    JMP.w $A799                 ; Jump back to the original code

; ---------------------------------------------------------------------
; Skips over the routine that displays the Red "EXIT" Sprite when the
; player unpauses the game from the Pause Menu when ShowBosses is true.
; Otherwise we just run the original code.
; ---------------------------------------------------------------------
CheckUnpauseHighlight:
    ; No need to run what we overwrote because we replaced STA with STZ
    LDA.l ShowBosses
    BEQ .run_original           ; If ShowBosses == 0, draw normal red EXIT highlight

    JMP.w $A612                 ; Skip JSL $81891F and jump straight to PLB : PLP : RTL

.run_original:
    JMP.w $A603                 ; Resume at STZ $03 ($82:A603)