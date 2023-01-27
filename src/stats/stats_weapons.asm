IncrementChargedShots:
        LDA.l GoalComplete : BNE .skip
                LDA.l ChargedShots : INC : STA.l ChargedShots
        .skip
        LDX.w #$0000 ; What we wrote over
RTS

IncrementSpecialBeams:
        TAY
        LDA.l GoalComplete : BNE .skip
        TYA
        CMP.w CurrentPBs : BEQ .skip
                TAY
                LDA.l SpecialBeamsFired : INC : STA.l SpecialBeamsFired
                TYA
        .skip
        STA.w CurrentPBs
RTS

IncrementMissiles:
        LDA.l GoalComplete : BNE .skip
                LDA.w HUDItemIndex : CMP.w #$0002 : BEQ .super
                        DEC.w CurrentMissiles
                        LDA.l MissilesFired : INC : STA.l MissilesFired
                        BRA .skip
                .super
                DEC.w CurrentSupers
                LDA.l SupersFired : INC : STA.l SupersFired
        .skip
JMP.w $BEC7

IncrementBombs:
        LDA.l GoalComplete : BNE .skip
                LDA.w HUDItemIndex : CMP.w #$0003 : BEQ .pbs
                        LDA.l BombsLaid : INC : STA.l BombsLaid
                        BRA +
                .pbs
                LDA.l PowerBombsLaid : INC : STA.l PowerBombsLaid
                +
        .skip
        LDA.w BombCounter ; What we wrote over
RTS
