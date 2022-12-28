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
