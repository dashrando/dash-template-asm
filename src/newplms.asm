;------------------------------------------------------------------------------
; New Item PLMS
;------------------------------------------------------------------------------
; Organized for 21 new items. Chozo and hidden offsets identical to vanilla items.
;------------------------------------------------------------------------------
; Bank 84
; Borrowed from total
;------------------------------------------------------------------------------

DashItemPLMs:
        .visible : fillbyte $00 : fill $54
        .chozo   : fillbyte $00 : fill $54
        .hidden  : fillbyte $00 : fill $54
        .loadid  : fillbyte $00 : fill $FC

ItemHandlers:
        .visible : dw ItemTableLoad_visible
        .chozo   : dw ItemTableLoad_chozo   
        .hidden  : dw ItemTableLoad_hidden  

ItemTableLoad:
        .visible : LDY.w #VisibleItemTable : RTS
        .chozo   : LDY.w #ChozoItemTable : RTS
        .hidden  : LDY.w #HiddenItemTable : RTS

; Tables of mostly vectors, or pointers to some code dynamically jumped to, and
; some data for each type of item.
VisibleItemTable:
        dw LoadCustomGraphics
        dw RoomItemArgument, .end
        dw SetGoto, .trigger
        dw PLMPreInstruction, $DF89
        dw StartDrawLoop
        .loop
        dw DrawItemFrame1
        dw DrawItemFrame2
        dw PLMGoto, .loop
        .trigger
        dw SetRoomItem
        dw ItemSound : db $02
        dw ItemPickup
        .end
        dw PLMGoto, $DFA9

ChozoItemTable:
        dw LoadCustomGraphics
        dw RoomItemArgument, .end
        dw PLMInstruction, $DFAF
        dw PLMInstruction, $DFC7
        dw SetGoto, .trigger
        dw PLMPreInstruction, $DF89
        dw PLMTimer : db $16
        dw StartDrawLoop
        .loop
        dw DrawItemFrame1
        dw DrawItemFrame2
        dw PLMGoto, .loop
        .trigger
        dw SetRoomItem
        dw ItemSound : db $02
        dw ItemPickup
        .end
        dw $0001, $A2B5
        dw PLMDelete

HiddenItemTable:
        dw LoadCustomGraphics
        .loop2
        dw PLMInstruction, $E007
        dw RoomItemArgument, .end
        dw SetGoto, .trigger
        dw PLMPreInstruction, $DF89
        dw PLMTimer : db $16
        dw StartHiddenDrawLoop
        .loop
        dw DrawItemFrame1
        dw DrawItemFrame2
        dw PLMDecrementTimer, .loop
        dw PLMInstruction, $E020
        dw PLMGoto, .loop2
        .trigger
        dw SetRoomItem
        dw QueueMusic : db $02
        dw ItemPickup
        .end
        dw PLMInstruction, $E032
        dw PLMGoto, .loop2

; New item PLMs
;        id,  label name      visible, chozo, hidden
%ItemPLM($00, DoubleJump)    ; $EFE0,  $F034, $F088
%ItemPLM($01, HeatShield)    ; $EFE4,  $F038, $F08C
%ItemPLM($02, PressureValve) ; $EFE8,  $F03C, $F090
%ItemPLM($03, BeamUpgrade)   ; $EFEC,  $F040, $F094

; Graphics pointers for items (by item index)
; The first word is a pointer to 4bpp sprite data located at ItemTiles.
; The bytes are palette indices for each 8x8 tile of the dark tile (first four)
; and the light tile (last four.) Each tile is ordered upper left, upper right,
; lower left, lower right.
DashItemGraphics:
dw DoubleJumpTiles    : db $02, $02, $02, $02, $02, $02, $02, $02    ; $00 - Double Jump
dw HeatShieldTiles    : db $01, $01, $01, $01, $01, $01, $01, $01    ; $01 - Heat Shield
dw PressureValveTiles : db $03, $03, $03, $03, $03, $03, $03, $03    ; $02 - Pressure Valve
dw ChargeBeamTiles    : db $00, $00, $00, $00, $00, $00, $00, $00    ; $03 - Beam Upgrade
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $04 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $05 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $06 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $07 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $08 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $09 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $0A - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $0B - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $0C - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $0D - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $0E - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $0F - Unused

dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $20 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $21 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $22 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $23 - Unused
dw $0000              : db $00, $00, $00, $00, $00, $00, $00, $00    ; $24 - Unused

DashItemTable:
;  pickup,              qty,   msg,   type,  ext2,  ext3,  loop,  hloop
dw CollectEquipment,    $0200, $001D, $0004, $0000, $0000, $0000, $0000  ; $00 - Double Jump
dw CollectEquipment,    $0001, $001E, $0004, $0000, $0000, $0000, $0000  ; $01 - Heat Shield
dw CollectEquipment,    $0020, $001F, $0004, $0000, $0000, $0000, $0000  ; $02 - Pressure Valve
dw BeamUpgradePickup,   $1000, $0020, $0001, $0000, $0000, $0000, $0000  ; $03 - BeamUpgrade
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $04 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $05 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $06 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $07 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $08 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $09 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $0A - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $0B - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $0C - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $0D - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $0E - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $0F - Unused

dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $10 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $11 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $12 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $13 - Unused
dw $0000,               $0000, $0000, $0004, $0000, $0000, $0000, $0000  ; $14 - Unused

StartDrawLoop:
        PHY : PHX
        LDA.l PLMIds,X ; Load item id
        ASL #4
        CLC : ADC.w #$000C : TAX
        LDA.w DashItemTable,X
        PLX : PLY
RTS

StartHiddenDrawLoop:
        PHY : PHX
        LDA.l PLMIds,X ; Load item id
        ASL #4
        CLC : ADC.w #$000E : TAX
        LDA.l DashItemTable,X
        PLX : PLY
RTS

LoadCustomGraphics:
        PHY : PHX
        LDA.l ItemPLMBuffer,X
        ASL : STA.b MultiplyResult
        ASL #2 : CLC : ADC.b MultiplyResult ; Multiply by 10
        ADC.w #DashItemGraphics : TAY ; Add it to the graphics table and transfer into Y
        LDA.w $0000,Y
        JSR.w $8764  ; Jump to original PLM graphics loading routine
        PLX : PLY
RTS

VisibleItemSetup:
        TYX : STA.l ItemPLMBuffer,X
        ASL : STA.b MultiplyResult
        ASL #2 : CLC : ADC.b MultiplyResult ; Multiply by 10
        TAX
        LDA.w DashItemGraphics,X
JMP.w $EE64

HiddenItemSetup:
        TYX : STA.l ItemPLMBuffer,X
        ASL : STA.b MultiplyResult
        ASL #2 : CLC : ADC.b MultiplyResult ; Multiply by 10
        TAX
        LDA.w DashItemGraphics,X
JMP.w $EE8E

ItemPickup:
        PHY : PHX
        LDA.l ItemPLMBuffer,X
        ASL #4
        CLC : ADC.w #DashItemTable
        TAX : TAY : INY #2
        JSR.w ($0000,X)
        PLX : PLY
RTS

CollectEquipment:
        LDA.w $0000,Y : BIT.w VanillaItemsCollected : BNE .dont_equip
        ORA.w DashItemsEquipped : STA.w DashItemsEquipped
        .dont_equip
        ORA.w DashItemsCollected : STA.w DashItemsCollected
        LDA.l NoFanfare : BNE +
                LDA.w #$0168
                JSL.l PlayRoomMusic
        +
        JSR.w DecrementMajorCount
        JSL.l SetRoomFlags
        LDA.w $0002,Y : AND.w #$00FF : TAX
        JSL.l ShowMessage
        INC.w HUDDrawFlag
        INY #3
RTS

VanillaEquipmentPickup:
        PHA : PHX
        STA.w VanillaItemsEquipped ; What we wrote over
        EOR.w #$FFFF : AND.w DashItemsEquipped : STA.w DashItemsEquipped ; Unequip overlapping DASH items
        JSR.w DecrementMajorCount
        JSL.l SetRoomFlags
        PLX : PLA
RTS

BeamUpgradePickup:
        LDA.l ChargeMode : AND.w #$000F : BEQ +
            LDA.w BeamsCollected : BIT.w #$1000 : BEQ +
                    INC.w BeamUpgrades
        +
CollectBeam:
        LDA.w $0000,Y : ORA.w BeamsCollected : STA.w BeamsCollected
        LDA.w $0000,Y : ORA.w BeamsEquipped  : STA.w BeamsEquipped
        LDA.l NoFanfare : BNE +
                LDA.w #$0168
                JSL.l PlayRoomMusic
        +
        JSR.w DecrementMajorCount
        LDA.w $0002,Y : AND.w #$00FF : TAX
        JSL.l ShowMessage
        INC.w HUDDrawFlag
        INY #3
RTS

BrokenTurretBlock: ; Damage reduction for Draygon turrets
        LDA.w VanillaItemsEquipped : AND.w #$0021 : CMP.w #$0021 : BEQ .3_4
                                     BIT.w #$0020 : BNE .half
                                     BIT.w #$0001 : BNE .half
                .full
                LDA.w PeriodicDamage     : CLC : ADC.w #$0000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0001 : STA.w PeriodicDamage+$02
                SEP #$41
                RTS
                .half
                LDA.w PeriodicDamage     : CLC : ADC.w #$8000 : STA.w PeriodicDamage
                LDA.w PeriodicDamage+$02       : ADC.w #$0000 : STA.w PeriodicDamage+$02
                SEP #$41
                RTS
        .3_4
        LDA.w PeriodicDamage     : CLC : ADC.w #$4000 : STA.w PeriodicDamage
        LDA.w PeriodicDamage+$02       : ADC.w #$0000 : STA.w PeriodicDamage+$02
        SEP #$41
RTS

MaybeEquipSpazer:
; In: A - (beam pickup bit << 1) & $0008
        BIT.w BeamsEquipped
        BEQ +
                LSR : TRB.w BeamsEquipped
        +
RTS

DecrementMajorCount:
        LDA.w SubAreaIndex : ASL : TAX
        LDA.l MajorCounters,X : DEC : STA.l MajorCounters,X
        INC.w HUDDrawFlag
RTS

DecrementMajorCountHUDBeam:
        PHX
        LDA.w SubAreaIndex : ASL : TAX
        LDA.l MajorCounters,X : DEC : STA.l MajorCounters,X
        INC.w HUDDrawFlag
        INY #2
        PLX
RTS

DecrementTankCount:
        PHX
        LDA.w SubAreaIndex : ASL : TAX
        LDA.l TankCounters,X : DEC : STA.l TankCounters,X
        INC.w HUDDrawFlag
        INY #2
        PLX
RTS

FlashingDoor:
        PHY : PHX
        JMP $BE0B
CustomGreyDoorList:
        %CopyBytes($84BE4B,14)
        dw FlashingDoor

;------------------------------------------------------------
; Handles processing of special meta PLM values which are
; processed prior to other PLMs.
;
; Meta PLMs Supported:
;   1 = Jump to another PLM list by loading the address
;       of the next list into X, if the second value
;       is non-zero, just run a PLM at a different
;       address and return.
;   2 = Skip this PLM without calling any other code
;       associated with PLMs
;      
; Register states when called:
;   A = PLM identifier
;   X = Address of the PLM within the PLM list
;------------------------------------------------------------
PreProcessRoomPLM:
        CMP.w #2        ; skip?
        BEQ .done
        CMP.w #1        ; jump?
        BEQ .jump
        JML $84846A
        .jump:
        LDA.w $0002,X : BEQ +
                PHX
                LDA.w $0004,X
                TAX
                JSL $84846A
                PLX
                RTL
        +
        LDA.w $0004,X
        SEC : SBC.w #6
        TAX
        .done:
RTL

MaybeActivateLNChozo:
        LDA.l LNChozoTrigger : BNE .done
                LDA.w VanillaItemsCollected : AND.w #$0200
        .done
RTS

SaveStationMini:
.entry
dw $B5EE, .instruction_list

.instruction_list
dw $0001, .draw_one
dw $86B4
dw $8CF1, .used
dw $B00E
dw $8C07 : db $2E
dw $874E : db $15
.timer
dw $0004, .draw_three
dw $0004, .draw_two
dw $873F, .timer
dw $B024
.used
dw $B030
dw $8724, .instruction_list

.draw_one
dw $0002, $B859, $8C59
dw $0000 ; Termination

.draw_two
dw $0002, $8859, $8C59
dw $0000

.draw_three
dw $0002, $885A, $8C5A
dw $0000

pushpc
org $84D0E8
dw BrokenTurretBlock ; Replace Draygon grapple turret block instruction
; Special Blocks (original by Smiley)
org $84D409
SpecialSpeedCollide:
        LDA.w SpeedStepCounter : CMP.w #$03FF : BPL +
                LDA.w SamusPose : CMP.w #$0081 : BEQ ++
                                  CMP.w #$0082 : BEQ ++
        +
        JMP.w $CE83 ; Treat as bomb block
        ++
        LDA.w #$0000 : STA.w PLMIds,Y
        SEC
RTS

SpecialSpeedProjectile:
        LDX.w ProjectileIndex : LDA.w ProjectileType,X : AND.w #$0F00 : CMP #$0500 : BNE +
                JMP.w $CF0C ; Break block
        +
        LDA.w #$0000 : STA.w PLMIds,Y
RTS

SpecialShotProjectile:
        ; Check for Spazer
        LDX.w ProjectileIndex : LDA.w ProjectileType,X : BIT.w #$0004 : BEQ +
                JMP.w $CF0C ; Break block
        +
        LDA.w #$0000 : STA.w PLMIds,Y ;Else delete PLM
RTS
warnpc $84D490

pullpc
