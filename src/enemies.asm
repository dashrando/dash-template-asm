LoadEnemyData:
        PHX
        LDA.l AreaIndex : ASL : TAX
        JSR.w (EnemiesDisabled,X) : BNE +
                PLX
                LDA.l $A10000,X
                RTS
        +
        PLX
        LDA.w #$FFFF
RTS


EnemiesDisabled:
dw .crateria
dw .brinstar
dw .norfair
dw .wreckedship
dw .maridia
dw .tourian

.crateria
        LDA.l RoomIndex : TAX
        LDA.l CrateriaRooms_room_flags,X : BIT.w #$001
        RTS
.brinstar
        LDA.l RoomIndex : TAX
        LDA.l BrinstarRooms_room_flags,X : BIT.w #$0001
        RTS
.norfair
        LDA.l RoomIndex : TAX
        LDA.l NorfairRooms_room_flags,X : BIT.w #$0001
        RTS
.wreckedship
        LDA.l RoomIndex : TAX
        LDA.l WreckedShipRooms_room_flags,X : BIT.w #$0001
        RTS
.maridia
        LDA.l RoomIndex : TAX
        LDA.l MaridiaRooms_room_flags, X : BIT.w #$0001
        RTS
.tourian
        LDA.l RoomIndex : TAX
        LDA.l TourianRooms_room_flags, X : BIT.w #$0001
        RTS
