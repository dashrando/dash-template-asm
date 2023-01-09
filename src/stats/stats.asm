IncrementTimers:
        LDA.w GameState : CMP.w #$0002 : BEQ .menu    ; Count Game Options menu
                          CMP.w #$001F : BEQ .playing ; Count loading ship save
                          CMP.w #$0007 : BCC .notplaying
                          CMP.w #$0026 : BCS .notplaying
                .playing
                LDA.l LoopFrames : INC : STA.l LoopFrames : BNE +
                        LDA.l LoopFrames+$02 : INC : STA.l LoopFrames+$02
                +
                LDA.w GameState : CMP.w #$000F : BNE .notmenu
                        .menu
                        LDA.l MenuFrames : INC : STA.l MenuFrames : BNE +
                                LDA.l MenuFrames+$02 : INC : STA.l MenuFrames+$02
                        +
        .notplaying
        .notmenu
RTS

IncrementTimersNMI:
        LDA.w GameState : CMP.w #$0002 : BEQ .rta
                          CMP.w #$001F : BEQ .rta
                          CMP.w #$0007 : BCC .notplaying
                          CMP.w #$0026 : BCS .notplaying
                JSR.w IncrementAreaTimers
                .rta
                LDA.l NMIFrames : INC : STA.l NMIFrames : BNE +
                        LDA.l NMIFrames+$02 : INC : STA.l NMIFrames+$02
                +
                LDA.w GameState : CMP.w #$0009 : BCC .notdoor
                                  CMP.w #$000C : BCS .notdoor
                        LDA.l DoorFrames : INC : STA.l DoorFrames : BNE +
                                LDA.l DoorFrames+$02 : INC : STA.l DoorFrames+$02
                        +
                        LDA.w DoorAdjustFlag : BEQ .notdoor
                                LDA.l DoorAlignFrames : INC : STA.l DoorAlignFrames
        .notplaying
        .notdoor
RTS

IncrementLagTimer:
; Excluding doors in this counter because the game is mostly not "lagging"
; in the colloquial sense during door transitions and NMI is scrolling
; the door without interruption basically (I think.)
        LDA.w GameState : CMP.w #$000C : BCC .notplaying
                          CMP.w #$0026 : BCS .notplaying
        LDA.l LagFrames : INC : STA.l LagFrames : BNE +
                LDA.l LagFrames+$02 : INC : STA.l LagFrames+$02
        +
        .notplaying
        LDX.w $05BA ; What we wrote over
RTS

IncrementAreaTimers:
        LDA.l SubAreaIndex : ASL : TAX
        LDA.w #$007F : STA.b $2E+$02
        LDA.w AreaTimers,X : STA.w $2E

        LDA.b [$2E] : INC : STA.b [$2E] : BNE +
                INC.b $2E : INC.b $2E
                LDA.b [$2E] : INC : STA.b [$2E]
        +
RTS

AreaTimers:
dw CrateriaFrames
dw GreenBrinstarFrames
dw UpperNorfairFrames
dw WreckedShipFrames
dw EastMaridiaFrames
dw TourianFrames
dw $FFFF
dw $FFFF
dw RedBrinstarFrames
dw KraidFrames
dw WestMaridiaFrames
dw LowerNorfairFrames
dw CrocomireFrames
