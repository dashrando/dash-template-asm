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
        LDA.w VanillaItemsEquipped : BIT #$0200 : BNE .done ; What we wrote over
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
CheckWaterPhysicsLong:
        JSR.w CheckWaterPhysics
RTL

CheckWaterPhysics:
        PHB : PHK : PLB
        LDA.w VanillaItemsEquipped : BIT.w #$0020 : BNE .done ; What we wrote over
        LDA.w DashItemsEquipped : AND.w #$0004 : BEQ .done
                LDA.w AreaIndex : ASL : TAX
                JSR.w (.areas,X)
        .done
        PLB          ; Restore original bank before making physics bit test
        BIT.w #$0020 ; What we wrote over.
RTS

.areas
dw CrateriaWater
dw BrinstarWater
dw NorfairWater
dw WreckedShipWater
dw MaridiaWater
dw NoWater

CrateriaWater:
        LDA.w RoomIndex : ASL : TAX
        LDA.w CrateriaBootsTable,X
RTS
BrinstarWater:
        LDA.w #$0020
RTS
WreckedShipWater:
        LDA.w #$0020
RTS 
MaridiaWater:
        LDA.w RoomIndex : ASL : TAX
        LDA.w MaridiaBootsTable,X
RTS
NorfairWater:
        LDA.w RoomIndex : CMP.w #$0013 : BEQ .water
                          CMP.w #$0016 : BEQ .water
                LDA.w #$0000 : RTS
        .water
        LDA.w #$0020
RTS
NoWater:
        LDA.w #$0000
RTS

; Aqua Boots tables
MaridiaBootsTable:         ; Table for determining Aqua Boots behavior
fillword $0020 : fill 256  ; Initialize table with gravity behavior. Index never >= $80
%MaridiaNoBoots($1D)       ; Overwrite individual rooms with non-gravity behavior
%MaridiaNoBoots($1E)
%MaridiaNoBoots($1F)
%MaridiaNoBoots($20)
%MaridiaNoBoots($21)
%MaridiaNoBoots($23)
%MaridiaNoBoots($28)
%MaridiaNoBoots($2A)
%MaridiaNoBoots($2B)
%MaridiaNoBoots($31)
%MaridiaNoBoots($32)
%MaridiaNoBoots($37)

CrateriaBootsTable:
fillword $0020 : fill 256
%CrateriaNoBoots($01)
%CrateriaNoBoots($03)
%CrateriaNoBoots($10)
%CrateriaNoBoots($12)
%CrateriaNoBoots($1D)
