;------------------------------------------------------------------------------
; Room Patching
;------------------------------------------------------------------------------
; Logic called after room decompression that patches the room data.
;------------------------------------------------------------------------------

PostRoomDecompression: 

   ; initialize our counter
   ldx.w #0

   ; If not more patches, jump to the end
-  LDA.l Room_Patches,x
   cmp.w #$ffff
   beq .ret

   ; Increment the counter
   inx #6

   ; Keep looping if the patch is not for the current room
   CMP.l RoomPointer
   bne -

   ; Check to see if the patch is enabled
   LDA.l Room_Patches-4,x
   beq -

   ; Set the patch to run after decompression
   LDA.l Room_Patches-2,x
   JSR PatchRoom 

.ret:

   LDA $0000
   RTS

PatchRoom:

php
tax

; Loop for processing patch hunks
.loop: {

   ; If no hunks left, jump to the end
   lda.l Room_Patches&$FF0000,x
   cmp.w #$ffff
   beq .ret

   ; Move the destination address to Y
   tay

   ; Load the number bytes to write
   inx #2
   lda.l Room_Patches&$FF0000,x
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
      lda.l Room_Patches&$FF0000,x
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
      lda.l Room_Patches&$FF0000,x

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
