;------------------------------------------------------------------------------
; Stats
;------------------------------------------------------------------------------
; General handling of timers and counters.
;------------------------------------------------------------------------------
HandleTimersNMI:
        LDA.l GoalComplete : BNE .skip
                LDA.w GameState : ASL : TAX
                JMP.w  (TimerHandlers_nmi,X)
        .skip
        RTS

IncrementLagTimer:
        LDA.l GoalComplete   : BNE .skip
        LDA.w MessageBoxFlag : BNE .skip
                LDA.w GameState : TAX
                LDA.w TimerHandlers_lag,X : AND.w #$00FF : BEQ .skip
                        LDA.l LagFrames : INC : STA.l LagFrames : BNE +
                                LDA.l LagFrames+$02 : INC : STA.l LagFrames
                        +
        .skip
        LDX.w $05BA ; What we wrote over
RTS

TimersNMI:
        LDA.w SubAreaIndex : CMP.w #$FFFF : BEQ +
                JSR.w IncrementAreaTimers
        +
        LDA.l NMIFrames : INC : STA.l NMIFrames : BNE +
                LDA.l NMIFrames+$02 : INC : STA.l NMIFrames+$02
        +
NoTimer:
RTS

DoorTimersNMI:
        LDA.w SubAreaIndex
        JSR.w IncrementAreaTimers
        LDA.l NMIFrames : INC : STA.l NMIFrames : BNE +
                LDA.l NMIFrames+$02 : INC : STA.l NMIFrames+$02
        +
        LDA.l DoorFrames : INC : STA.l DoorFrames : BNE +
                LDA.l DoorFrames+$02 : INC : STA.l DoorFrames+$02
        +
        LDA.w DoorAdjustFlag : BEQ +
                LDA.l DoorAlignFrames : INC : STA.l DoorAlignFrames : BNE +
                        LDA.l DoorAlignFrames+$02 : INC : STA.l DoorAlignFrames+$02
        +
RTS

MenuTimersNMI:
        LDA.w SubAreaIndex : CMP.w #$FFFF : BEQ +
                JSR.w IncrementAreaTimers
        +
        LDA.l NMIFrames : INC : STA.l NMIFrames : BNE +
                LDA.l NMIFrames+$02 : INC : STA.l NMIFrames+$02
        +
        LDA.l MenuFrames : INC : STA.l MenuFrames : BNE +
                LDA.l MenuFrames+$02 : INC : STA.l MenuFrames+$02
        +
RTS

TimerHandlers:
        .nmi : fillword NoTimer : fill ($2C*2)+2
        .lag : fillbyte $00     : fill $2C+1

IncrementAreaTimers:
; In: A - Sub Area index
        ASL : TAX
        LDA.w #StatsBlock>>16 : STA.b $2E+$02
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

; Game states where we're counting our RTA timers
pushpc
org TimerHandlers_nmi+($02*2) : dw MenuTimersNMI
org TimerHandlers_nmi+($05*2) : dw TimersNMI
org TimerHandlers_nmi+($06*2) : dw TimersNMI
org TimerHandlers_nmi+($07*2) : dw TimersNMI
org TimerHandlers_nmi+($08*2) : dw TimersNMI
org TimerHandlers_nmi+($09*2) : dw DoorTimersNMI
org TimerHandlers_nmi+($0A*2) : dw DoorTimersNMI
org TimerHandlers_nmi+($0B*2) : dw DoorTimersNMI
org TimerHandlers_nmi+($0C*2) : dw TimersNMI
org TimerHandlers_nmi+($0D*2) : dw TimersNMI
org TimerHandlers_nmi+($0E*2) : dw MenuTimersNMI
org TimerHandlers_nmi+($0F*2) : dw MenuTimersNMI
org TimerHandlers_nmi+($10*2) : dw MenuTimersNMI
org TimerHandlers_nmi+($11*2) : dw MenuTimersNMI
org TimerHandlers_nmi+($12*2) : dw TimersNMI
org TimerHandlers_nmi+($13*2) : dw TimersNMI
org TimerHandlers_nmi+($14*2) : dw TimersNMI
org TimerHandlers_nmi+($15*2) : dw TimersNMI
org TimerHandlers_nmi+($16*2) : dw TimersNMI
org TimerHandlers_nmi+($17*2) : dw TimersNMI
org TimerHandlers_nmi+($18*2) : dw TimersNMI
org TimerHandlers_nmi+($19*2) : dw TimersNMI
org TimerHandlers_nmi+($1A*2) : dw TimersNMI
org TimerHandlers_nmi+($1B*2) : dw TimersNMI
org TimerHandlers_nmi+($1C*2) : dw TimersNMI
org TimerHandlers_nmi+($1D*2) : dw TimersNMI
org TimerHandlers_nmi+($1E*2) : dw TimersNMI
org TimerHandlers_nmi+($1F*2) : dw TimersNMI
pullpc

; Game states where we're counting our lag timer
pushpc
org TimerHandlers_lag+$08 : db $01
org TimerHandlers_lag+$0C : db $01
org TimerHandlers_lag+$0D : db $01
org TimerHandlers_lag+$0E : db $01
org TimerHandlers_lag+$0F : db $01
org TimerHandlers_lag+$10 : db $01
org TimerHandlers_lag+$11 : db $01
org TimerHandlers_lag+$12 : db $01
org TimerHandlers_lag+$13 : db $01
org TimerHandlers_lag+$14 : db $01
org TimerHandlers_lag+$15 : db $01
org TimerHandlers_lag+$16 : db $01
org TimerHandlers_lag+$17 : db $01
org TimerHandlers_lag+$18 : db $01
org TimerHandlers_lag+$19 : db $01
org TimerHandlers_lag+$1A : db $01
org TimerHandlers_lag+$1B : db $01
org TimerHandlers_lag+$1C : db $01
pullpc


