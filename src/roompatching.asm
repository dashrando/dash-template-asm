;------------------------------------------------------------------------------
; Room Patching
;------------------------------------------------------------------------------
; Logic called after room decompression that patches the room data.
;------------------------------------------------------------------------------

PostRoomDecompression: 
        LDA.l AreaIndex : ASL : TAX
        JSR.w (PatchOffsets,X)
        CMP.w #NoPatch : BEQ .skip
                JSR.w PatchRoom
        .skip
        LDA.w $0000
RTS

PatchOffsets:
dw .crateria
dw .brinstar
dw .norfair
dw .wreckedship
dw .maridia
dw .tourian

.crateria
        LDA.l RoomIndex : ASL : TAX
        LDA.l CrateriaRooms_room_patches,X
        RTS
.brinstar
        LDA.l RoomIndex : ASL : TAX
        LDA.l BrinstarRooms_room_patches,X
        RTS
.norfair
        LDA.l RoomIndex : ASL : TAX
        LDA.l NorfairRooms_room_patches,X
        RTS
.wreckedship
        LDA.l RoomIndex : ASL : TAX
        LDA.l WreckedShipRooms_room_patches,X
        RTS
.maridia
        LDA.l RoomIndex : ASL : TAX
        LDA.l MaridiaRooms_room_patches,X
        RTS
.tourian
        LDA.l RoomIndex : ASL : TAX
        LDA.l TourianRooms_room_patches,X
        RTS

PatchRoom:
; In: A - 16-bit pointer to this room's patches
; See documentation of binary patch format in roomedits.asm
        PHP
        TAX
        .room_loop
        LDA.l Room_Patches&$FF0000,X : BMI .ret
                TAY
                INX #2
                LDA.l Room_Patches&$FF0000,X : BIT #$4000 : BEQ .byte_width
                        BMI .word_repeat
                                .word_copy
                                AND.w #$00FF : STA.b $00
                                ..loop
                                        INX #2
                                        LDA.l Room_Patches&$FF0000,X : STA.w $0000,Y
                                        INY #2
                                        DEC.b $00
                                BPL ..loop
                                INX #2
                                BRA .room_loop
                        .word_repeat
                        AND.w #$00FF : STA.b $00
                        INX #2
                        LDA.l Room_Patches&$FF0000,X
                        ..loop
                                STA.w $0000,Y
                                INY #2
                                DEC.b $00
                        BPL ..loop
                        INX #2
                        BRA .room_loop
                .byte_width
                BMI .byte_repeat
                        .byte_copy
                        AND.w #$00FF : STA.b $00
                        SEP #$20
                        INX
                        ..loop
                                INX
                                LDA.l Room_Patches&$FF0000,X : STA.w $0000,Y
                                INY
                                DEC.b $00
                        BPL ..loop
                        REP #$20
                        INX
                        BRA .room_loop
                .byte_repeat
                AND.w #$00FF : STA.b $00
                SEP #$20
                INX #2
                LDA.l Room_Patches&$FF0000,X
                ..loop
                        STA.w $0000,Y
                        INY
                        DEC.b $00
                BPL ..loop
                REP #$20
                INX
                BRA .room_loop
        .ret
        PLP
RTS
