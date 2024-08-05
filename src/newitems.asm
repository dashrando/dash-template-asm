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
                ; Always increment the double jump flag
                INC.w DoubleJumpFlag

                ; Note that we should decrement the double jump flag
                ; if we are transitioning to a wall jump
                INC.w SubtractWallJump

                ; We are good to jump again if the incremented double
                ; jump flag is exactly equal to one
                LDA.w DoubleJumpFlag : CMP.w #$0001 : BEQ +
                        SEP #$02
                        RTS
                +
                REP #$02
                RTS
.done
RTS

CheckWaterPhysics:
        LDA.w #$0020
        BIT.w VanillaItemsEquipped : BEQ +
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
        LDA.w AquaHandlers,X
        ADC.w RoomIndex : TAX
        LDA.l $DF0000,X : AND #$0020
        PLB          ; Restore original bank before making physics bit test
        BIT.w #$0020
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
org $91A7F6
ClearJumpFlag:
        STZ.w DoubleJumpFlag
        LDA.w $079F ; What we wrote over
RTS
warnpc $91A834
;------------------------------------------------------------------------------
org $91FC42
HandleWallJumpForDoubleJump:
        PHA
        STA.w $0A1E ; What we wrote over

        ; If transitioning to wall jump
        AND #$FF00 : CMP #$1400 : BNE +
                ; Should we decrement the double jump flag
                LDA.w SubtractWallJump : BEQ +
                        DEC.w DoubleJumpFlag
                +
        +
        STZ.w SubtractWallJump
        PLA
RTS
warnpc $91FC66
;------------------------------------------------------------------------------
org $82E675
SetRoomFlags:
        JSL.l CheckWaterPhysicsLong : BNE .gravity
                LDA.w #$0000 : STA.w RoomFlags
                RTL
        .gravity
        LDA.w #$0020 : STA.w RoomFlags
RTL

SetRoomFlagsUnpause:
        JSR.w ClearSamusBeamTiles
        JSL.l SetRoomFlags
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
dw CrateriaRooms_room_flags
dw BrinstarRooms_room_flags
dw NorfairRooms_room_flags
dw WreckedShipRooms_room_flags
dw MaridiaRooms_room_flags
dw TourianRooms_room_flags

