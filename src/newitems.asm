;------------------------------------------------------------------------------
; New Item Behavior
;------------------------------------------------------------------------------
; Code to handle new item behavior. Primarily in the free space of banks 90 and 91
;------------------------------------------------------------------------------

pushpc ; Code below is placed in free space in the middle of banks $90 & $91,
       ; code before or after will be in the free block at the end of $90
;------------------------------------------------------------------------------
org $9092EA
CheckEligibleJump:
        LDA.w VanillaItemsEquipped : BIT.w #$0200 : BNE .done ; What we wrote over
                LDA.w DashItemsEquipped : AND.w #$0001 : BEQ .done
                        LDA.w #$0200
.done
RTS
;------------------------------------------------------------------------------
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

CheckWaterPhysicsLong:
        JSR.w CheckWaterPhysics
RTL

CheckWaterPhysics:
        PHB : PHK : PLB
        LDA.w VanillaItemsEquipped : BIT.w #$0020 : BNE .done ; What we wrote over
        LDA.w DashItemsEquipped : AND.w #$0004 : BEQ .done
                LDA.w AreaIndex : ASL : TAX
                JSR.w (AquaHandlers,X)
        .done
        PLB          ; Restore original bank before making physics bit test
        BIT.w #$0020 ; What we wrote over.
RTS

warnpc $90934F
;------------------------------------------------------------------------------
org $9180BE
ClearJumpFlag:
        STZ.w DoubleJumpFlag
        LDA.w $079F ; What we wrote over
RTS
warnpc $91810A
;------------------------------------------------------------------------------
pullpc

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

