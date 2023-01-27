OnCompleteGoal:
        LDA.w #$0001 : STA.l GoalComplete
        LDA.l NMIFrames : SEC : SBC.w #$013D : STA.l NMIFrames ; Down press to this code running
        LDA.l NMIFrames+$02 : SBC.w #$0000 : STA.l NMIFrames+$02
        LDA.l CurrentSaveSlotSRAM : DEC
        JSL.l WriteStats
        LDA.w #$000A
        JSL.l AnimateSamusGeneral
RTL

