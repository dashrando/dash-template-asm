;------------------------------------------------------------------------------
; Skip loading of PLMs based on settings
;------------------------------------------------------------------------------

LoadRoomPLM: {

   PHX
   LDX.w #0

-  LDA.l Disable_Room_PLMs,x
   cmp.w #$ffff
   beq .ret

   inx #6
   cmp.w RoomPointer
   bne -

   LDA.l Disable_Room_PLMs-4,x
   beq -

   LDA.l Disable_Room_PLMs-2,x
   cmp $01,s
   bne -

   plx
   txa
   clc
   adc #$0006
   tax
   jsr LoadRoomPLM ; Called recursively
   rts

.ret:
   PLX
   LDA.w $0000,X
   RTS
}