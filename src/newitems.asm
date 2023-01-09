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
                JSR.w (AquaTables,X)
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

AquaTables:
dw CrateriaWater
dw OnlyWater
dw NorfairWater
dw OnlyWater
dw MaridiaWater
dw NoWater

CrateriaWater:
        LDA.w RoomIndex : ASL : TAX
        LDA.w CrateriaBoots,X
RTS
MaridiaWater:
        LDA.w RoomIndex : ASL : TAX
        LDA.w MaridiaBoots,X
RTS
NorfairWater:
        LDA.w RoomIndex : CMP.w #$0013 : BEQ .water
                          CMP.w #$0016 : BEQ .water
                LDA.w #$0000 : RTS
        .water
        LDA.w #$0020
RTS
OnlyWater:
        LDA.w #$0020
RTS
NoWater:
        LDA.w #$0000
RTS

; Aqua Boots tables
MaridiaBoots:        ; Table for determining Aqua Boots behavior
fillword $0020 : fill 256 ; Initialize table with gravity behavior. Index never >= $80
%DisableBoots(MaridiaBoots, $1D)        ; Overwrite individual rooms with non-gravity behavior
%DisableBoots(MaridiaBoots, $1E)
%DisableBoots(MaridiaBoots, $1F)
%DisableBoots(MaridiaBoots, $20)
%DisableBoots(MaridiaBoots, $21)
%DisableBoots(MaridiaBoots, $23)
%DisableBoots(MaridiaBoots, $28)
%DisableBoots(MaridiaBoots, $2A)
%DisableBoots(MaridiaBoots, $2B)
%DisableBoots(MaridiaBoots, $31)
%DisableBoots(MaridiaBoots, $32)
%DisableBoots(MaridiaBoots, $37)

CrateriaBoots:
fillword $0020 : fill 256
%DisableBoots(CrateriaBoots, $01)
%DisableBoots(CrateriaBoots, $03)
%DisableBoots(CrateriaBoots, $10)
%DisableBoots(CrateriaBoots, $12)
%DisableBoots(CrateriaBoots, $1D)
