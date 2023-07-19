;------------------------------------------------------------------------------
; Subareas
;------------------------------------------------------------------------------
; Determines subareas within the major areas
;------------------------------------------------------------------------------

OnRoomLoad:
        PHX
        JSR.w DetermineSubArea ; Keep first
        JSL.l SetRoomFlags
        PLX
RTS

SubAreaHandlers:
dw CrateriaRooms_sub_areas
dw BrinstarRooms_sub_areas
dw NorfairRooms_sub_areas
dw WreckedShipRooms_sub_areas
dw MaridiaRooms_sub_areas
dw TourianRooms_sub_areas

DetermineSubArea:
        STA.w AreaIndex ; What we wrote over
        STA.w FxAreaIndex
        ASL : TAX
        LDA.l SubAreaHandlers,X
        ADC.w RoomIndex : TAX
        LDA.l $DF0000,X
        PHA
        AND.w #$00F0 : BEQ +
                LSR #4
                STA.w FxAreaIndex
        +
        PLA
        AND.w #$000F : CMP.w SubAreaIndex : BEQ +
                INC.w HUDDrawFlag
        +
        STA.w SubAreaIndex
RTS
