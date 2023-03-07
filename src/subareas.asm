;------------------------------------------------------------------------------
; Subareas
;------------------------------------------------------------------------------
; Determines subareas within the major areas
;------------------------------------------------------------------------------

OnRoomLoad:
        PHX
        JSR.w DetermineSubArea ; Keep first
        JSL.l SetRoomFlags
        INC.w HUDDrawFlag
        PLX
RTS

DetermineSubArea:
        STA.w AreaIndex ; What we wrote over
        ASL : TAX
        JMP.w (SubAreaHandlers,X)

SubAreaHandlers:
dw .crateria
dw .brinstar
dw .norfair
dw .wreckedship
dw .maridia
dw .tourian

.crateria
        LDA.w RoomIndex : TAX
        LDA.l CrateriaRooms_sub_areas,X
        BRA .done
.brinstar
        LDA.w RoomIndex : TAX
        LDA.l BrinstarRooms_sub_areas,X
        BRA .done
.norfair
        LDA.w RoomIndex : TAX
        LDA.l NorfairRooms_sub_areas,X
        BRA .done
.wreckedship
        LDA.w RoomIndex : TAX
        LDA.l WreckedShipRooms_sub_areas,X
        BRA .done
.maridia
        LDA.w RoomIndex : TAX
        LDA.l MaridiaRooms_sub_areas,X
        BRA .done
.tourian
        LDA.w RoomIndex : TAX
        LDA.l TourianRooms_sub_areas,X
        BRA .done
.done
        AND.w #$00FF : STA.w SubAreaIndex
RTS
