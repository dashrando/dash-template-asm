;------------------------------------------------------------------------------
; New Item Behavior
;------------------------------------------------------------------------------
; Code to handle new item behavior. Primarily in the free space of banks 90 and 91
;------------------------------------------------------------------------------

pushpc ; Code below is placed in free space in the middle of banks $90 & $91,
       ; code before or after will be in the free block at the end of $90
;------------------------------------------------------------------------------
org $9092EA
CheckDoubleJump:
; In: A - $8F, Controller 1 inputs
; Out: z - Jump if unset
        AND.w $09B4 : BNE + ; What we wrote over
                RTS
        +
        LDA.w VanillaItemsEquipped : BIT.w #$0200 : BNE .done
                LDA.w DoubleJumpFlag : BNE .nojump
                        LDA.w SamusAnimationFrame
                        AND.w #$000F : CMP.w #$000B : BEQ + ; Handle wall jumping
                                INC.w DoubleJumpFlag
                        +
                        RTS
        .nojump
        SEP #$02
.done
RTS

CheckWaterPhysics:
        LDA.w #$0020
        BIT.w VanillaItemsEquipped : BEQ + ; What we wrote over
                RTS
        +
        BIT.w VanillaItemsCollected : BEQ +
                SEP #$02
                RTS
        +
        BIT.w DashItemsEquipped : BNE +
                RTS
        +
        PHB : PHK : PLB
        LDA.w AreaIndex : ASL : TAX
        JSR.w (AquaHandlers,X)
        PLB          ; Restore original bank before making physics bit test
        BIT.w #$0020 ; What we wrote over.
RTS

warnpc $909347

;------------------------------------------------------------------------------
org $90A607
CheckJumpPhysics:
        LDA.l SpaceJumpPhysics : BIT.w #$0001 : BNE .done
                LDA.w LiquidPhysicsType
        .done
RTS
CheckWaterPhysicsLong:
        JSR.w CheckWaterPhysics
RTL
warnpc $90A61C
;------------------------------------------------------------------------------
org $9180BE
ClearJumpFlag:
        STZ.w DoubleJumpFlag
        LDA.w $079F ; What we wrote over
RTS
CheckGravityPaletteOrPressureValve:
        BIT.w #$0004 : BNE .done ; What we wrote over
                LDA.w DashItemsEquipped : BIT.w #$0020
        .done
RTS
warnpc $91810A
;------------------------------------------------------------------------------
org $82E675
SetRoomFlagsEntry:
        JSL.l CheckWaterPhysicsLong : BNE .gravity
                LDA.w #$0000 : STA.w RoomFlags
                RTS
        .gravity
        LDA.w #$0020 : STA.w RoomFlags
RTS

SetRoomFlagsUnpause:
        JSR.w ClearSamusBeamTiles
        JSR.w SetRoomFlagsEntry
RTS
warnpc $82E6A1
;------------------------------------------------------------------------------
pullpc

CheckEligibleJump:
        LDA.w #$0200
        BIT.w VanillaItemsEquipped : BEQ + ; What we wrote over
                RTS
        +
        BIT.w VanillaItemsCollected : BEQ +
                SEP #$02
                RTS
        +
        BIT.w DashItemsEquipped
RTS

;------------------------------------------------------------------------------

AquaHandlers:
dw .crateria
dw .onlywater
dw .norfair
dw .onlywater
dw .maridia
dw .nowater

.crateria
        LDA.w RoomIndex : TAX
        LDA.l CrateriaRooms_room_flags,X
        AND.w #$0020
RTS
.maridia:
        LDA.w RoomIndex : TAX
        LDA.l MaridiaRooms_room_flags,X
        AND.w #$0020
RTS
.norfair:
        LDA.w RoomIndex : TAX
        LDA.l NorfairRooms_room_flags,X
        AND.w #$0020
RTS
.onlywater:
        LDA.w #$0020
RTS
.nowater:
        LDA.w #$0000
RTS

