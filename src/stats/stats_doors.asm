DoorAdjustStart:
        LDA.w #$0001 : STA.w DoorAdjustFlag
        LDA.w #$E310 : STA.w DoorTransitionPtr
RTS

DoorAdjustStop:
        STZ.w DoorAdjustFlag
        LDA.w #$E353 : STA.w DoorTransitionPtr
RTS

IncrementDoorTransitions:
        LDA.l DoorTransitions : INC : STA.l DoorTransitions
        INC.w GameState
        PLP
JMP.w $E1B7
