;------------------------------------------------------------------------------
; Subareas
;------------------------------------------------------------------------------
; Determines subareas within the major areas
;------------------------------------------------------------------------------

DetermineSubArea: {

   ; Hijacked code (DO NOT MODIFY)
   STA.w $079F

   ; Use the builtin area as the default
   PHX
   STA.l SubAreaIndex

   ldx.w #0

   .OuterLoop {
      LDA.l SubAreaRooms,x
      inx : inx

      cmp.w #$dead
      beq +
      tay

      .InnerLoop {
         LDA.l SubAreaRooms,x
         inx : inx

         cmp.w #$dead
         beq .OuterLoop

         cmp.w $079b
         bne .InnerLoop
         tya
         sta.l SubAreaIndex
      }
   }

+  PLX
   RTS
}

