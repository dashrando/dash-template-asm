IncrementChargedShots:
        LDA.l ChargedShots : INC : STA.l ChargedShots
        LDX.w #$0000 ; What we wrote over
RTS

IncrementSpecialBeams:
        CMP.w CurrentPBs : BEQ +
                TAY
                LDA.l SpecialBeams : INC : STA.l SpecialBeams
                TYA
        +
        STA.w CurrentPBs
RTS

IncrementMissiles:
        LDA.w HUDItemIndex : CMP.w #$0002 : BEQ .super
                DEC.w CurrentMissiles
                LDA.l MissilesFired : INC : STA.l MissilesFired
                BRA +
        .super
        DEC.w CurrentSupers
        LDA.l SupersFired : INC : STA.l SupersFired
        +
JMP.w $BEC7

IncrementBombs:
        LDA.w HUDItemIndex : CMP.w #$0003 : BEQ .pbs
                LDA.l BombsLaid : INC : STA.l BombsLaid
                BRA +
        .pbs
        LDA.l PowerBombsLaid : INC : STA.l PowerBombsLaid
        +
        LDA.w BombCounter ; What we wrote over
RTS
