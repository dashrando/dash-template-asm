LoadEnemyData:
        PHX
        LDX.w #0000
        -
        LDA.l Disable_Room_Enemies,X : CMP.w #$FFFF : BEQ .ret
                INX #4 : CMP.w RoomPointer : BNE -
                        LDA.l Disable_Room_Enemies-2,X : BEQ -
                                PLX
                                LDA.w #$FFFF
                                RTS

        .ret:
        PLX
        LDA.l $A10000,X
        RTS
