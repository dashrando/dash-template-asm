;------------------------------------------------------------------------------
; Game File Options Screen
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Draw Game Hash Code
;------------------------------------------------------------------------------
;TODO: Refactor
DrawFileSelectHash:
        PHA : PHX : PHP
        REP #$30
        
        LDA.l FileSelectCode : AND.w #$001F
        ASL #3 : TAY
        LDX.w #$0000
        -
        LDA.w WordTable,Y : AND.w #$00FF
        ASL
        PHX : TAX
        LDA.w CharTable,X
        PLX
        STA.l $7FC052,X
        INX #2 : INY
        CPX.w #$000E : BNE -
        
        LDA.l FileSelectCode+$01 : AND.w #$001F
        ASL #3 : TAY
        LDX.w #$0000
        -
        LDA.w WordTable,Y : AND.w #$00FF
        ASL
        PHX : TAX
        LDA.w CharTable,X
        PLX
        STA.l $7FC060,X
        INX #2 : INY
        CPX.w #$000E : BNE -
        
        LDA.l FileSelectCode+$02 : AND.w #$001F
        ASL #3 : TAY
        LDX.w #$0000
        -
        LDA.w WordTable,Y : AND.w #$00FF
        ASL
        PHX : TAX
        LDA.w CharTable,X
        PLX
        STA.l $7FC092,X
        INX #2 : INY
        CPX.w #$000E : BNE -

        LDA.l FileSelectCode+$03 : AND.w #$001F
        ASL #3 : TAY
        LDX.w #$0000
        -
        LDA.w WordTable,Y : AND.w #$00FF
        ASL
        PHX : TAX
        LDA.w CharTable,X
        PLX
        STA.l $7FC0A0,X
        INX #2 : INY
        CPX.w #$000E : BNE -
    
        PLP : PLX : PLA
        LDX.w #$07FE
RTS

CharTable:
; 0x00																				  	     0x0F
dw $000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F
; 0x10																				  	     0x0F
dw $000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F
; 0x20																				  	     0x0F
dw $000F,$0084,$002D,$000F,$000F,$000F,$000F,$0022,$008A,$008B,$000F,$0086,$0089,$0087,$0088,$000F

NumTable:
; 0x30																				  	     0x0F
dw $0060,$0061,$0062,$0063,$0064,$0065,$0066,$0067,$0068,$0069,$000F,$000F,$000F,$000F,$000F,$0085
; 0x40																				  	     0x0F
dw $000F,$006A,$006B,$006C,$006D,$006E,$006F,$0070,$0071,$0072,$0073,$0074,$0075,$0076,$0077,$0078
; 0x50																				  	     0x0F
dw $0079,$007A,$007B,$007C,$007D,$007E,$007F,$0080,$0081,$0082,$0083,$000F,$000F,$000F,$000F,$000F

WordTable:
    db "GEEMER  "
    db "RIPPER  "
    db "ATOMIC  "
    db "POWAMP  "
    db "SCISER  "
    db "NAMIHE  "
    db "PUROMI  "
    db "ALCOON  "
    db "BEETOM  "
    db "OWTCH   "
    db "ZEBBO   "
    db "ZEELA   "
    db "HOLTZ   "
    db "VIOLA   "
    db "WAVER   "
    db "RINKA   "
    db "BOYON   "
    db "CHOOT   "
    db "KAGO    "
    db "SKREE   "
    db "COVERN  "
    db "EVIR    "
    db "TATORI  "
    db "OUM     "
    db "PUYO    "
    db "YARD    "
    db "ZOA     "
    db "FUNE    "
    db "GAMET   "
    db "GERUTA  "
    db "SOVA    "
    db "BULL    "

InfoStr:
    db "TOURNAMENT SEED!"
