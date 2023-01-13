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

macro AreaRoomTable(area, num_rooms)
<area>Rooms:
        .sub_areas : fillbyte $00 : fill <num_rooms>+1
        .room_flags : fillbyte $00 : fill <num_rooms>+1
        .room_patches : fillword NoPatch : fill (<num_rooms>*2)+2
endmacro

macro RoomEntry(area, id, sub_area, flags, patch)
pushpc
        org <area>Rooms_sub_areas+<id>
        db <sub_area>
        org <area>Rooms_room_flags+<id>
        db <flags>
        org <area>Rooms_room_patches+(<id>*2)
        dw <patch>
pullpc
endmacro

; Macro for defining a beam damage table.

macro beam_dmg(n,i,s,w,is,iw,ws,iws,p,ip,wp,iwp)
   dw <n>   ; None (aka Power)
   dw <w>   ; Wave
   dw <i>   ; Ice
   dw <iw>  ; Ice + wave
   dw <s>   ; Spazer
   dw <ws>  ; Spazer + wave
   dw <is>  ; Spazer + ice
   dw <iws> ; Spazer + ice + wave
   dw <p>   ; Plasma
   dw <wp>  ; Plasma + wave
   dw <ip>  ; Plasma + ice
   dw <iwp> ; Plasma + ice + wave
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
