pushpc
;------------------------------------------------------------------------------
; SRAM Assignments & Labels
;------------------------------------------------------------------------------
; There is a segment of mirrored WRAM from $09A2 - $0A01 which gets automtically saved
; and loaded. From $09EC to $0A01 is unused by the vanilla game.
; There is also a block in bank $7E which includes a copy of the WRAM block and gets
; saved to SRAM ($7ED7C0-$7EDE1B).
;
; Refer to disassembly for further documentation.
;------------------------------------------------------------------------------

SaveSlotSelected = $7E0952           ;
GameState = $7E0998                  ;
VanillaItemsEquipped = $7E09A2       ; Word-length bitfields used for vanilla items.
VanillaItemsCollected = $7E09A4      ; x p o t - - j h  - - g - s m b v
                                     ; v = Varia   | b = Spring Ball | m = Morph Ball | s = Screw Attack
                                     ; g = Gravity | h = Hi-Jump     | j = Space Jump | t = Bombs
                                     ; o = Speed   | p = Grapple     | x = X-Ray
CurrentHealth = $7E09C2              ; Current and max health (not counting reserves)
MaxHealth = $7E09C4                  ;
CurrentMissiles = $7E09C6            ; Current and max missiles.
MaxMissiles = $7E09C8                ;
CurrentSupers = $7E09CA              ; Current and max super missiles.
MaxSupers = $7E09CC                  ;
CurrentPBs = $7E09CE                 ; Current and max power bombs.
MaxPBs = $7E09D0                     ;
DashItemsCollected = $7E09EC         ; Word-length bitfields used for new items, similar to the
DashItemsEquipped = $7E09EE          ; vanilla item bitfields.
                                     ; - - - - - - - s  - - - - - - h d
                                     ; d = Double Jump | h = Heat Shield | s = Starter Charge

EventFlags = $7ED820                 ;
BossFlagsVanilla = $7ED828           ; Boss bitflags indexed by area. 8 bytes.
                                     ; 1: Area boss (Kraid, Phantoon, Draygon, both Ridleys)
                                     ; 2: Area mini-boss (Spore Spawn, Botwoon, Crocomire, Mother Brain)
                                     ; 4: Area torizo (Bomb Torizo, Golden Torizo)
ItemBitArray = $7ED870               ; Item location bit array. Bit set if item collected.
                                     ; $7ED870-AF. $84-AF unused.
DoorBitArray = $7ED8B0               ; Opened door bit array. Bit set if door opened.
                                     ; $7ED8B0-EF. $C6-EF Unused.


pullpc
