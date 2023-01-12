;------------------------------------------------------------------------------
; Macros
;------------------------------------------------------------------------------
; They're ugly but they reduce boilerplate
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; This creates three new PLM table entries in our new PLM table which has the same
; size and shape as the vanilla item PLM table. One PLM for a visible item, one
; for chozo, and one for hidden. The entries point to two routines we also create
; here, ItemNameVLoad and ItemNameHLoad, which load the item ID then jumps to further
; item setup.
;------------------------------------------------------------------------------
macro ItemPLM(id, labelname)
pushpc
        !plm_offset = (<id>*4)   ; Size of PLM table entry
        !load_offset = (<id>*12) ; Size of visible and hidden loading instructions

        org DashItemPLMs_visible+!plm_offset
        dw <labelname>VLoad, ItemHandlers_visible
        
        org DashItemPLMs_chozo+!plm_offset
        dw <labelname>VLoad, ItemHandlers_chozo
        
        org DashItemPLMs_hidden+!plm_offset
        dw <labelname>HLoad, ItemHandlers_hidden

        org DashItemPLMs_loadid+!load_offset
        <labelname>VLoad:
                LDA.w #<id> : JMP.w VisibleItemSetup
        <labelname>HLoad:
                LDA.w #<id> : JMP.w HiddenItemSetup
pullpc
endmacro

macro DisableBoots(table, id)
pushpc
        org <table>+(<id>*2) : dw $0000
pullpc
endmacro

; Macros for encoding and decoding values from a beam damage table. This
; version stores damage in 16 bits so no decode logic is needed. It could
; be stored in 8 bits by dividing by 10 at encode and multiplying by 10
; at decode.

macro encode_dmg(value)
   dw <value>
endmacro

macro decode_dmg()
endmacro

; Macro for defining a beam damage table.

macro beam_dmg(n,i,s,w,is,iw,ws,iws,p,ip,wp,iwp)
   %encode_dmg(<n>)   ; None (aka Power)
   %encode_dmg(<w>)   ; Wave
   %encode_dmg(<i>)   ; Ice
   %encode_dmg(<iw>)  ; Ice + wave
   %encode_dmg(<s>)   ; Spazer
   %encode_dmg(<ws>)  ; Spazer + wave
   %encode_dmg(<is>)  ; Spazer + ice
   %encode_dmg(<iws>) ; Spazer + ice + wave
   %encode_dmg(<p>)   ; Plasma
   %encode_dmg(<wp>)  ; Plasma + wave
   %encode_dmg(<ip>)  ; Plasma + ice
   %encode_dmg(<iwp>) ; Plasma + ice + wave
endmacro


; Credits

macro row1(index)
    dw !draw, !row*<index>
    dw !draw, !blank
endmacro

macro row2(index_a,index_b)
    dw !draw, !row*<index_a>
    dw !draw, !row*<index_b>
    dw !draw, !blank
endmacro

macro blank_row()
    dw !draw, !blank
endmacro

macro font1(str,color)
    pushtable
    table "data/<color>_single.tbl",rtl
    dw "<str>"
    pulltable
endmacro

macro font2(str,color)
    pushtable
    table "data/<color>_double_top.tbl"
    dw "<str>"
    table "data/<color>_double_bottom.tbl"
    dw "<str>"
    pulltable
endmacro
