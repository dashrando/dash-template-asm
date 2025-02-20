;------------------------------------------------------------------------------
; Menu
;------------------------------------------------------------------------------
; Code and data related to the pause menu.
;------------------------------------------------------------------------------
!DASH_ITEMS_BITMASK = $0221 ; Every bit for all custom items in DashItemsCollected/Equipped

; More or less equivalent to the vanilla item toggle code
; but reworked to support toggling Dash items too
HandleMenuItemToggle:
        CPY.w #VanillaItemsEquipped
        BNE .toggle
                LDA.w $0000,X : BIT.w VanillaItemsCollected
                BNE .toggle
                        LDY.w #DashItemsEquipped
                        INC.b $3A
        .toggle:
        LDA.w $0000,Y : BIT.w $0000,X : BNE .unequip
                .equip:
                LDA.w $0000,Y : ORA.w $0000,X : STA.w $0000,Y
                PLY
                JMP.w $B5B4
        .unequip:
        LDA.w $0000,X : EOR.w #$FFFF : STA.b $12
        LDA.w $0000,Y : AND.b $12 : STA.w $0000,Y
        JMP.w $B5DA

LoadMenuTileMapPointer:
; In: $3A - DASH item if not 0
        LDA.b $3A : BNE .dash_item
                LDA.w $C044,X ; What we wrote over
                BRA .done
        .dash_item
        LDA.w DASHTilemapPointerList,X
        .done
RTS

DASHTilemapPointerList:
dw $0000, $0000, DashSuitTilemaps, DashBootTilemaps

; This is called when moving the menu cursor to determine whether
; the cursor should be able to move to specific spot.
CheckEquipmentBitmask:
        ; Compute the address of the equipment bitmask
        PHA
        TXA
        CLC : ADC $01,s
        STA $01,s
        PLY
        ; Simply return if the vanilla item is collected
        LDA.w $0000,y
        BIT.w VanillaItemsCollected
        BNE .exit
                ; Check to see if the Dash item is collected
                BIT.w DashItemsCollected
.exit
RTS

; Loads the custom Dash tiles at $2D00 in VRAM
LoadMenuTiles:
        SEP #$20
        LDA.b #$00 : STA.w $2116
        LDA.b #$2D : STA.w $2117
        LDA.b #$80 : STA.w $2115
        JSL $8091A9
        db $01,$01,$18
        dl DashMenuTiles
        dw $2A0
        LDA.b #$02 : STA.w $420B
        REP #$20
        JSR.w LoadReserveHealthTilemap ; What we wrote over
RTS


HeatShieldTilemap:
dw $08FF, $0AD0, $0AD1, $0AD2, $0AD3, $0AD4, $0AD5, $08D4, $08D4

PressureValveTilemap:
dw $08FF, $0AD6, $0AD7, $0AD8, $0AD9, $0ADA, $0ADB, $0ADC, $0ADD

DoubleJumpTilemap:
dw $08FF, $0ADE, $0ADF, $0AE0, $0AE1, $0AE2, $0AE3, $0AE4, $08D4

SetHUDFlagMenu:
        LDA.b $8F : BIT.w #$0080 : BEQ + ; Check for button press
                INC.w HUDDrawFlag
        +
        JSR.w MenuCheckButton ; What we wrote over
        STZ.b $3A ; Clear temp variable we use
RTS

;------------------------------------------------------------------------------

CheckDashSuitsMenu:
        LDX.w DashSuitTilemaps,Y
        BRA CheckDashItemsMenu
CheckDashBootsMenu:
        LDX.w DashBootTilemaps,Y
CheckDashItemsMenu:
        BIT.w #!DASH_ITEMS_BITMASK : BNE .dash_item
                .empty
                LDX.w #$C01A
                LDA.w #$0012 : STA.b $16
                JSR.w CopyFromDPToTilemap
                RTS
        .dash_item
        BIT.w DashItemsCollected : BEQ .empty
        PHA
        LDA.w #$0012  : STA.b $16
        JSR.w CopyFromDPToTilemap
        PLA : BIT.w DashItemsEquipped : BNE .not_equipped
                LDA.w #$0C00 : STA.b $12
                LDA.w #$0012 : STA.b $16
                JSR.w SetMenuTilePalettes
        .not_equipped
RTS

; Pointers to equipment tilemaps. Resembles vanilla table at $82C088 in layout.
DashSuitTilemaps:
dw HeatShieldTilemap, PressureValveTilemap
DashBootTilemaps:
dw $0000, DoubleJumpTilemap
