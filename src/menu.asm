; More or less equivalent to the vanilla item toggle code
; but reworked to support toggling Dash items too
HandleMenuItemToggle: {
   PHY

   ; Not toggling suits/boots
   CPY.w #VanillaItemsEquipped
   BNE .toggle

   ; Jump to toggle logic if a collected vanilla item is selected
   LDA.w $0000,x
   BIT.w VanillaItemsCollected
   BNE .toggle

   ; Toggle Dash items instead
   LDY.w #DashItemsEquipped

.toggle:
   LDA.w $0000,y
   BIT.w $0000,x
   BNE .unequip

.equip:
   LDA.w $0000,y
   ORA.w $0000,x
   STA.w $0000,y

   PLY
   JMP.w $B5B4

.unequip:
   LDA.w $0000,x
   EOR.w #$FFFF
   STA.b $12
   LDA.w $0000,y
   AND.b $12
   STA.w $0000,y

   PLY
   JMP.w $B5DA
}

IsMenuItemCollected: {
   ; Simply return if the vanilla item is collected
   BIT.w VanillaItemsCollected
   BNE +

   ; Check to see if the Dash item is collected
   BIT.w DashItemsCollected
+  RTS
}

IsMenuItemEquipped: {
   ; Simply return if the vanilla item is equipped
   BIT.w VanillaItemsEquipped
   BEQ +
   RTS

   ; Move to the Dash item check if the vanilla item is not collected
+  BIT.w VanillaItemsCollected
   BEQ +

   ; Clear the zero flag and return
   SEP #$02
   RTS

   ; Check to see if the Dash item is equipped
+  BIT.w DashItemsEquipped
   RTS
}

; This is called when moving the menu cursor to determine whether
; the cursor should be able to move to specific spot.
CheckEquipmentBitmask: {
   ; Compute the address of the equipment bitmask
   PHA
   TXA
   CLC : ADC $01,s
   STA $01,s
   PLY

   ; Simply return if the vanilla item is collected
   LDA.w $0000,y
   BIT.w VanillaItemsCollected
   BNE +

   ; Check to see if the Dash item is collected
   BIT.w DashItemsCollected
+  RTS
}

; TODO: Make this cleaner. Currently does a brute force check on
; each vanilla item (Varia, Gravity, Space Jump) and uses the
; Dash equivalent tilemaps when appropriate.
SelectMenuTiles: {
   ; Move to the next check if not selecting Varia Suit
   CPX #$BF64
   BNE +

   ; Simply return if Varia Suit is collected
   LDA #$0001 : BIT.w VanillaItemsCollected
   BNE .ret

   ; Use the Heat Shield tilemap instead
   LDX.w #HeatShieldTileMap
   BRA .ret

   ; Move to the next check if not selecting Gravity Suit
+  CPX #$BF76
   BNE +

   ; Simply return if Gravity Suit is collected
   LDA #$0020 : BIT.w VanillaItemsCollected
   BNE .ret

   ; Use the Pressure Valve tilemap instead
   LDX.w #PressureValveTileMap
   BRA .ret

   ; Move to the next check if not selecting Space Jump
+  CPX #$BFE4
   BNE .ret

   ; Simply return if Space Jump is not collected
   LDA #$0200 : BIT.w VanillaItemsCollected
   BNE .ret

   ; Use the Double Jump timemap instead
   LDX.w #DoubleJumpTileMap

.ret:
   LDY.w #$0000
   RTS
}

; Loads the custom Dash tiles at $3600 in VRAM
LoadMenuTiles: {
   LDA #$02 : STA $420B ; What we wrote over
   
   ; VRAM address lo byte = 0x00
   LDA #$00
   STA $2116

   ; VRAM address hi by = 0x36
   LDA #$36
   STA $2117

   ; Write 128 bytes in one row
   LDA #$80
   STA $2115

   JSL $8091A9
   db $01,$01,$18
   dl DashMenuTiles
   dw $2A0

   ; Start a DMA transfer on channel 1
   LDA #$02
   STA $420B
   RTS
}

; oHEAT SHIELD
HeatShieldTileMap:
;dw $08FF, $0B60, $0B61, $0B62, $0B63, $0B64, $0B65, $08D4, $08D4
dw $08FF, $0903, $0904, $08D4, $08D4, $08D4, $08D4, $08D4, $08D4

; oPRESSURE VALVE
PressureValveTileMap:
;dw $08FF, $0B66, $0B67, $0B68, $0B69, $0B6A, $0B6B, $0B6C, $0B6D
dw $08FF, $0928, $0929, $08D4, $08D4, $08D4, $08D4, $08D4, $08D4

; oDOUBLE JUMP
DoubleJumpTileMap:
;dw $08FF, $0B6E, $0B6F, $0B70, $0B71, $0B72, $0B73, $0B74, $08D4
dw $08FF, $092A, $092B, $08D4, $08D4, $08D4, $08D4, $08D4, $08D4

SetHUDFlagMenu:
        LDA.b $8F : BIT.w #$0080 : BEQ + ; Check for button press
                INC.w HUDDrawFlag
        +
        JSR.w MenuCheckButton ; What we wrote over
RTS

pushpc
org $B6F200
DashMenuTiles:
incbin ../data/menu_tiles.bin

org $B6A064
dw $FFB6,$FFB5,$FF84,$FFB7,$FFB4

org $B6A084
dw $FF3F,$FFFF,$FF3F,$FFBF,$FF7F

org $B6A4E4
dw $FFFF,$FF7F,$FF7F,$FF7F,$FFFF

org $B6A504
dw $FF8D,$FFB5,$FF8D,$FFBD,$FFBE

org $B6A524
dw $FFBF,$FFBF,$FFBF,$FF7F,$FFFF

org $B6A544
dw $FF8E,$FFB7,$FFB7,$FFB5,$FF8E

org $B6A564
dw $FF3F,$FFBF,$FFBF,$FFBF,$FF7F

; oVARIA SUIT
org $82BF64 :            dw $08FF, $0900, $0901, $0902, $08D4, $08D4, $08D4, $08D4, $08D4

; oGRAVITY SUIT
org $82BF76 :            dw $08FF, $08D0, $08D1, $08D2, $08D3, $08D4, $08D4, $08D4, $08D4

; oSPEED BOOSTER
org $82BFF6 :            dw $08FF, $0924, $0925, $0926, $0927, $08D4, $08D4, $08D4, $08D4
pullpc
