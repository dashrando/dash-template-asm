;------------------------------------------------------------------------------
; Room Patching
;------------------------------------------------------------------------------
; Logic called after room decompression that patches the room data.
;------------------------------------------------------------------------------

PostRoomDecompression: 
        LDA.l AreaIndex : ASL : TAX
        LDA.l RoomIndex : ASL : ADC.l PatchOffsets,X : TAX
        LDA.l $DF0000,X
        CMP.w #NoPatch : BEQ .skip
                JSR.w PatchRoom
        .skip
        LDA.w $0000
RTS

PatchOffsets:
dw CrateriaRooms_room_patches
dw BrinstarRooms_room_patches
dw NorfairRooms_room_patches
dw WreckedShipRooms_room_patches
dw MaridiaRooms_room_patches
dw TourianRooms_room_patches

warnpc $82FE78

;org $82FE78
;dw $FFFF    ; save state buttons
;dw $FFFF    ; load state buttons
;dw $FFFF    ; spin lock buttons
;dw $3030    ; quick reload buttons; L + R + Select + Start

org $82FE80

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
