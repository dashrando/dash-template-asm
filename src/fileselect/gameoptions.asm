;------------------------------------------------------------------------------
; Game File Options Screen
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Draw Game Hash Code
;------------------------------------------------------------------------------
DrawFileSelectHash:
        PHX
        LDA.w #$007F : STA.b $0A

        LDA.w #$C052 : STA.b $08
        LDA.l FileSelectCode : AND.w #$001F
        JSR.w WriteHashTiles

        LDA.w #$C060 : STA.b $08
        LDA.l FileSelectCode+$01 : AND.w #$001F
        JSR.w WriteHashTiles

        LDA.w #$C092 : STA.b $08
        LDA.l FileSelectCode+$02 : AND.w #$001F
        JSR.w WriteHashTiles

        LDA.w #$C0A0 : STA.b $08
        LDA.l FileSelectCode+$03 : AND.w #$001F
        JSR.w WriteHashTiles

        PLX
        LDX.w #$07FE
RTS

WriteHashTiles:
        ASL #3 : ADC.w #$0007 : TAX
        LDY.w #$000E
        -
                LDA.w WordTable,X : AND.w #$00FF
                ASL
                PHY : TAY
                LDA.w CharTable,Y
                PLY
                STA.b [$08],Y
                DEX : DEY #2
        BPL -
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

OnLoadGame: ; Pressing "START GAME"
        LDA.l GoalComplete : BNE .skip
                LDA.l FreshFileMarker : ORA.w #$0002 : STA.l FreshFileMarker
        .skip
        STZ.w ScreenFadeCounter ; What we wrote over
RTS
