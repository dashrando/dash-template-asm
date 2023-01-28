CountDashItems:
        LDX.w #$0004
        -
                LDA.w DashItemsCollected : BIT.w DashItemMasks,X : BEQ +
                        INC.b $12
                +
                DEX #2
        BPL -
        LDA.w BeamsCollected : AND.w #$0f00 : XBA ; load charge upgrades
        CLC : ADC.b $12 : STA.b $12
        LDX.w #$0014 ; What we wrote over
RTS

DashItemMasks:
dw $0200, $0020, $0001
