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
        LDA.w DashItemsEquipped : BIT.w #$0001 : BNE .jump
        LDA.w VanillaItemsEquipped : BIT #$0200 : BNE .jump ; What we wrote over
                JMP.w $A476
.jump
JMP.w SpaceJumpEligible
;------------------------------------------------------------------------------
CheckDoubleJump:
; In: A - $8F, Controller 1 inputs
; Out: z - Jump if unset
        AND.w $09B4 : BNE + ; What we wrote over
                RTS
        +
        LDA.w VanillaItemsEquipped : BIT.w #$0200 : BNE .done
                LDA.w DoubleJumpFlag : BNE .nojump
                        INC.w DoubleJumpFlag : RTS
        .nojump
        SEP #$02
.done
RTS
warnpc $909347
;------------------------------------------------------------------------------
org $9180BE
ClearJumpFlag:
        STZ.w DoubleJumpFlag
        LDA.w $079F ; What we wrote over
RTS
warnpc $91810A
;------------------------------------------------------------------------------
pullpc

