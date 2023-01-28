CountDashItems:
        LDX.w #$0004
        -
                LDA.w DashItemsCollected : BIT.w DashItemMasks,X : BEQ +
                        INC.b $12
                +
                DEX #2
        BPL -
        LDX.w #$0014 ; What we wrote over
RTS

DashItemMasks:
dw $0200, $0020, $0001
