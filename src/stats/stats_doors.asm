DoorAdjustStart:
        LDA.l GoalComplete : BNE .skip
                LDA.w #$0001 : STA.w DoorAdjustFlag
        .skip
        LDA.w #$E310 : STA.w DoorTransitionPtr
RTS

DoorAdjustStop:
; Subtract one so perfect doors count as 0
        LDA.l GoalComplete : BNE .skip
                STZ.w DoorAdjustFlag
                LDA.l DoorAlignFrames : DEC : STA.l DoorAlignFrames
                CMP.w #$FFFF : BEQ +
                        LDA.w #$E353 : STA.w DoorTransitionPtr
                        RTS
                +
                LDA.l DoorAlignFrames+$02 : DEC : STA.l DoorAlignFrames+$02
        .skip
        LDA.w #$E353 : STA.w DoorTransitionPtr
RTS

IncrementDoorTransitions:
        LDA.l GoalComplete : BNE .skip
                LDA.l DoorTransitions : INC : STA.l DoorTransitions
        .skip
        INC.w GameState
        PLP
JMP.w $E1B7
