; Code for injecting PLM's into rooms at runtime.
; This is done to minimize the amount of big room edits needed where a
; lot of room header information would need to be shuffled around otherwise.
; Hijack room loading to be able to inject arbitrary PLMs into a room

InjectPLMs:
    LDX.w #$0000 ; TODO: Custom PLMs
-
    ; Check if the PLM goes in this room, if the table is $0000 then exit
    LDA.l CustomPLMTable,X : BEQ .end
    CMP.w $079B : BNE .next
        PHX : TXA : CLC ; Ok, Spawn the PLM
        ADC.w CustomPLMTable+$2 : TAX
        LDA.w $0000,X
        JSL.l $84846A
        PLX
.next
    TXA : CLC
    ADC.w #$0008 : TAX
    BRA -
.end
    JSL.l $8FE8A3  ; Execute door ASM
    RTL
