pushpc
org 0
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
VanillaItemsEquipped = $7E09A2       ; Word-length bitfields used for vanilla items.
VanillaItemsCollected = $7E09A4      ; x p o t - - j h  - - g - s m b v
                                     ; v = Varia   | b = Spring Ball | m = Morph Ball | s = Screw Attack
                                     ; g = Gravity | h = Hi-Jump     | j = Space Jump | t = Bombs
                                     ; o = Speed   | p = Grapple     | x = X-Ray
BeamsEquipped = $7E09A6              ; Word-length bitfields used for beams
BeamsCollected = $7E09A8             ; - - - c - - - -  - - - - p s i w
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
                                     ; - - - - - - - -  - - - - - q h d
ChargeUpgrades = $7E0A00             ;
                                     ; d = Double Jump | h = Heat Shield | q = Aqua Boots
EventFlags = $7ED820                 ;
BossFlagsVanilla = $7ED828           ; Boss bitflags indexed by area. 8 bytes.
                                     ; 1: Area boss (Kraid, Phantoon, Draygon, both Ridleys)
                                     ; 2: Area mini-boss (Spore Spawn, Botwoon, Crocomire, Mother Brain)
                                     ; 4: Area torizo (Bomb Torizo, Golden Torizo)
ItemBitArray = $7ED870               ; Item location bit array. Bit set if item collected.
                                     ; $7ED870-AF. $84-AF unused.
DoorBitArray = $7ED8B0               ; Opened door bit array. Bit set if door opened.
                                     ; $7ED8B0-EF. $C6-EF Unused.

;------------------------------------------------------------------------------
; Bank $7F
;------------------------------------------------------------------------------
; $7FFB00-$7FFCFF reserved for file save data.
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Stats Block
;------------------------------------------------------------------------------
base $7FFB00                         ;
StatsBlock:                          ; $100 bytes. $7FFB00-$7FFBFF
LoopFrames: skip 4                   ;
NMIFrames: skip 4                    ;
LagFrames: skip 4                    ;
MenuFrames: skip 4                   ;
DoorFrames: skip 4                   ;
DoorAlignFrames: skip 2              ;
DoorTransitions: skip 2              ;
CrateriaFrames: skip 4               ; Frame counters for randomizer's new areas.
WreckedShipFrames: skip 4            ;
GreenBrinstarFrames: skip 4          ;
RedBrinstarFrames: skip 4            ;
KraidFrames: skip 4                  ;
UpperNorfairFrames: skip 4           ;
LowerNorfairFrames: skip 4           ;
CrocomireFrames: skip 4              ;
EastMaridiaFrames: skip 4            ;
WestMaridiaFrames: skip 4            ;
TourianFrames: skip 4                ;
ChargedShots: skip 2                 ;
SpecialBeams: skip 2                 ;
MissilesFired: skip 2                ;
SupersFired: skip 2                  ;
PowerBombsLaid: skip 2               ;
BombsLaid: skip 2                    ;
GoalComplete: skip 2                 ;
                                     ;

;------------------------------------------------------------------------------
; Extended Cartridge SRAM
;------------------------------------------------------------------------------
; We allocate $500 bytes per slot for general use, then slot-agnostic data we
; may want to save (such as the most recent save slot played.)
;------------------------------------------------------------------------------
base $702000
ExpandedSRAM:                        ;
SlotOneExtendedSRAM:                 ;
SlotOneStatsSRAM: skip $500          ; Stat block. $100 bytes.
                                     ;
SlotTwoExtendedSRAM:                 ;
SlotTwoStatsSRAM: skip $500          ; Stat block. $100 bytes.
                                     ;
SlotThreeExtendedSRAM:               ;
SlotThreeStatsSRAM: skip $500        ; Stat block. $100 bytes.
                                     ;
CurrentSaveSlotSRAM: skip 2          ; Same index as the game uses + 1. No previous game if zero.




base off
pullpc
