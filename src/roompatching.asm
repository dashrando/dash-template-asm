;------------------------------------------------------------------------------
; Room Patching
;------------------------------------------------------------------------------
; Logic called after room decompression that patches the room data.
;------------------------------------------------------------------------------

PostRoomDecompression: 
        LDA.l AreaIndex : ASL : TAX
        JSR.w (PatchOffsets,X)
        JSR.w PatchRoom 
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
php
tax
; Loop for processing patch hunks
.loop: {

   ; If no hunks left, jump to the end
   lda.l bank(Room_Patches)<<16,x
   cmp.w #$ffff
   beq .ret

   ; Move the destination address to Y
   tay

   ; Load the number bytes to write
   inx #2
   lda.l bank(Room_Patches)<<16,x
   inx #2

   ; Check the first bit of the length (0 = copy, 1 = repeat)
   bit #$8000

   ; If copying bytes, jump to that section
   beq .copy_bytes

   ; Clear the first bit and store the length in Y
   and #$7fff

   ; Jump to the repeating bytes section
   bra .repeat_byte

   .copy_bytes: {

      ; Check to see if we are done or only have one byte left
   -  cmp.w #$0001
      bcc .loop
      beq .repeat_byte

      ; Copy the specified number of bytes two at a time
      pha
      lda.l bank(Room_Patches)<<16,x
      sta $0000,y
      pla

      dec #2
      inx #2
      iny #2
      bra -
   }

   .repeat_byte: {
      
      phx
      pha

      ; Load the byte that will be repeated
      lda.l bank(Room_Patches)<<16,x

      plx

      ; Switch to 8-bit mode for the accumulator
      sep #$20

      ; Write the byte the specified number of times
   -  sta $0000,y
      iny
      dex
      bne -

      ; Restore 16-bit mode and move to the next hunk
      rep #$20
      plx
      inx
      bra .loop
   }
}

.ret:
   PLP
   RTS
