LoadTitleLogo:
        LDX.w #$0FFE
        -
                LDA.l DashLogoSprite,X : STA.l $7F5000,X
                DEX #2
        BPL -


        LDA.w #$00 : STA.w $2116
        LDA.w #$60 : STA.w $2117
        LDA.w #$80 : STA.w $2115
        JSL.l $8091A9
        db $02, $01, $18
        dl $7F5000
        dw $1000
        LDA.w #$04 : STA.w $420B
        LDY.w #$E1A4
        JSL.l $8DC4E9 ; What we wrote over
RTL

pushpc
org $8C879D
TitleLogoSpriteMap:
dw $001D ; Length in tiles
dw $C3D8 : db $E8 : dw $3400
dw $C3E8 : db $E8 : dw $3402
dw $C3F8 : db $E8 : dw $3404
dw $C208 : db $E8 : dw $3406
dw $C218 : db $E8 : dw $3408
; 2nd row
dw $C3C8 : db $F8 : dw $340A
dw $C3D8 : db $F8 : dw $340C
dw $C3E8 : db $F8 : dw $340E
dw $C3F8 : db $F8 : dw $3420
dw $C208 : db $F8 : dw $3422
dw $C218 : db $F8 : dw $3424
; 3rd row
dw $C3B8 : db $08 : dw $3426
dw $C3C8 : db $08 : dw $3428
dw $C3D8 : db $08 : dw $342A
dw $C3E8 : db $08 : dw $342C
dw $C3F8 : db $08 : dw $342E
dw $C408 : db $08 : dw $3440
dw $C418 : db $08 : dw $3442
dw $C428 : db $08 : dw $3444
dw $C438 : db $08 : dw $3446
; 4th row
dw $C3B8 : db $18 : dw $3448
dw $C3C8 : db $18 : dw $344A
dw $C3D8 : db $18 : dw $344C
dw $C3E8 : db $18 : dw $344E
dw $C3F8 : db $18 : dw $3460
dw $C408 : db $18 : dw $3462
dw $C418 : db $18 : dw $3464
dw $C428 : db $18 : dw $3466
dw $C438 : db $18 : dw $3468
pullpc
