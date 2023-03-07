OnCompleteGoal:
        LDA.w #$0001 : STA.l GoalComplete
        LDA.l NMIFrames : SEC : SBC.w #$013D : STA.l NMIFrames ; Down press to this code running
        LDA.l NMIFrames+$02 : SBC.w #$0000 : STA.l NMIFrames+$02
        LDA.l CurrentSaveSlotSRAM : DEC
        JSL.l WriteExtendedSave
        PHK : PLB

        ; Calculate RTA seconds now for post-credits big samus tile upload
        LDA.l NMIFrames+$00 : STA.b $14
        LDA.l NMIFrames+$02 : STA.b $16
        LDA.w #$003C : STA.b $12
        JSL.l Div32
        LDA.b $14 : STA.w RTASeconds

        LDA.w #$000A
        JSL.l AnimateSamusGeneral ; What we wrote over
RTL

