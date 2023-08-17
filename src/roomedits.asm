;------------------------------------------------------------------------------
; Room Patches
;------------------------------------------------------------------------------

Disable_Room_PLMs: {
dw $D340,$0001,$C571
dw $ffff
}


Room_Patches:
Room_PreShaktool_Patch_01:
dw $0ccc,$000c
db $ff,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $0d0e,$000a
db $ff,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $1669,$0001
db $00
dw $2802,$0001
db $00
dw $ffff

Room_Plasma_Patch_01:
dw $03b4,$0001
db $8d
dw $03ec,$0009
db $9c,$03,$89,$03,$83,$03,$83,$03,$87
dw $042c,$0009
db $98,$03,$8c,$03,$82,$03,$82,$03,$86
dw $046c,$0009
db $99,$03,$88,$03,$89,$03,$8a,$03,$8b
dw $04ac,$000a
db $8f,$03,$ff,$00,$8c,$03,$8d,$03,$ff,$00
dw $04dc,$0003
db $9c,$03,$8b
dw $04ec,$000a
db $ff,$00,$ff,$00,$88,$03,$8b,$03,$ff,$00
dw $051c,$001a
db $98,$03,$ff,$00,$ff,$00,$ff,$00,$02,$02,$01,$82,$00,$82,$00
db $82,$01,$86,$02,$06,$ff,$00,$ff,$00,$ff,$00
dw $055c,$001a
db $99,$03,$ff,$00,$ff,$00,$ff,$00,$14,$12,$15,$82,$10,$82,$10
db $82,$15,$86,$14,$16,$ff,$00,$ff,$00,$ff,$00
dw $059c,$0002
db $8f,$03
dw $05a4,$0012
db $12,$12,$10,$82,$10,$82,$10,$82,$10,$82,$12,$16,$ff,$00,$ff
db $00,$ff,$00
dw $05e4,$0012
db $0b,$8a,$07,$8a,$07,$8a,$07,$8a,$07,$8a,$0b,$8e,$ff,$00,$ff
db $00,$ff,$00
dw $062c,$000a
db $ff,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $066c,$000a
db $ff,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $06ae,$0008
db $ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $06ee,$0008
db $ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $072e,$0008
db $ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $076e,$0008
db $ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $07ae,$0008
db $ff,$00,$ff,$00,$ff,$00,$ff,$00
dw $07ee,$0008
db $00,$82,$00,$82,$00,$82,$00,$82
dw $0eb3,$0006
db $1b,$00,$00,$00,$00,$5b
dw $0ed3,$0006
db $1c,$00,$00,$00,$00,$5c
dw $ffff

Room_Moat_Patch_01:
dw $059F,$0001
db $C0
dw $05DE,$0002
db $BE,$D0
dw $061F,$0001
db $C0
dw $0AD0,$0001
db $02
dw $0AF0,$0001
db $FF
dw $FFFF

Room_PreSpazer_Patch_01:
dw $018e,$0002
db $eb,$c1
dw $ffff

Room_Dachora_Patch_01:
dw $6787,$8006
db $f
dw $f502,$0001
db $00
dw $ffff

Room_Early_Supers_Patch_01:
dw $08bd,$0001
db $c1
dw $ffff

Room_PreHiJump_Patch_01:
dw $015d,$0001
db $c5
dw $02b5,$0005
db $c3,$6b,$83,$6b,$c3
dw $1402,$0001
db $00
dw $ffff

Room_FirstHeated_Patch_01:
dw $03ac,$0002
db $ff,$00
dw $040c,$0006
db $06,$81,$ff,$00,$ff,$00
dw $0dd7,$0001
db $00
dw $0e09,$0001
db $00
dw $1e02,$0001
db $00
dw $ffff

Room_RedTower_Patch_01:
dw $0e64,$0008
db $01,$81,$4b,$05,$4b,$01,$69,$01
dw $0e84,$0008
db $03,$81,$2d,$07,$ff,$00,$4a,$01
dw $0ea4,$0008
db $03,$81,$ff,$00,$ff,$00,$4b,$01
dw $0ec4,$0008
db $21,$81,$ff,$00,$ff,$00,$ff,$00
dw $0ee6,$0006
db $43,$81,$ff,$00,$4b,$09
dw $ffff

Room_Waterway_Patch_01:
dw $0803,$0003
db $f3,$50,$f3
dw $0815,$0009
db $f7,$4e,$fb,$4e,$f3,$4e,$f7,$50,$f3
dw $0833,$0013
db $f7,$4e,$ff,$4e,$f3,$4e,$f7,$4e,$f3,$4e,$f3,$4e,$ff,$4e,$fb
db $4e,$fb,$50,$f3
dw $08e3,$0003
db $f3,$50,$f3
dw $08f5,$0009
db $f7,$4e,$f3,$4e,$ff,$4e,$f3,$50,$f3
dw $0913,$0013
db $f7,$4e,$f7,$4e,$f3,$4e,$f3,$4e,$f3,$4e,$f7,$4e,$f7,$4e,$fb
db $4e,$f7,$50,$f3
dw $09c3,$0003
db $f3,$50,$f3
dw $09d5,$0009
db $f7,$4e,$f3,$4e,$f3,$4e,$f7,$50,$f3
dw $09f3,$0013
db $f7,$4e,$fb,$4e,$f3,$4e,$f3,$4e,$fb,$4e,$f3,$4e,$f3,$4e,$f3
db $4e,$fb,$50,$f3
dw $1202,$0002
db $09,$09
dw $120b,$8005
db $9
dw $121a,$800a
db $9
dw $1272,$0002
db $09,$09
dw $127b,$8005
db $9
dw $128a,$800a
db $9
dw $12e2,$0002
db $09,$09
dw $12eb,$8005
db $9
dw $12fa,$800a
db $9
dw $ffff

Room_PreBotwoon_Patch_01:
dw $05a1,$0001
db $f0
dw $05e3,$0001
db $f0
dw $05ed,$0001
db $f0
dw $0621,$0001
db $f3
dw $0663,$0001
db $f0
dw $066d,$0001
db $f8
dw $06a1,$0001
db $f0
dw $06e3,$0001
db $f8
dw $06ed,$0001
db $f0
dw $0ad1,$0001
db $09
dw $0af2,$0006
db $09,$00,$00,$00,$00,$09
dw $0b11,$0001
db $09
dw $0b32,$0006
db $09,$00,$00,$00,$00,$09
dw $0b51,$0001
db $09
dw $0b72,$0006
db $09,$00,$00,$00,$00,$09
dw $1402,$0001
db $00
dw $ffff

Room_WreckedShipReserve_Patch_02:
dw $05BE,$0010
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
dw $067E,$0010
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
dw $073E,$0010
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
db $ff,$00,$ff,$00
dw $053E,$0002
db $ff,$00
dw $32A0,$0002
db $00,$00
dw $ffff

Room_WreckedShipReserve_Patch_01:
dw $053E,$0002
db $11,$F1
dw $32A0,$0002
db $08,$00
dw $ffff

Room_Shaktool_Patch_01:
dw $02A2, $48
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF
dw $0322, $48
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF
dw $03A2, $48
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF
dw $0422, $48
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF
dw $04A2, $48
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF
dw $0522, $48
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF
dw $FFFF

Room_MissionImpossible_Patch_01:
dw $0686,$0002
dw $C05F
dw $FFFF

Room_KraidMissiles_Patch_01:
dw $064E,$0002
dw $C570
dw $FFFF

Room_BigPink_Patch_01:
dw $02B2,$0016
dw $8B28, $8B28, $8B28, $8B28, $8B28, $8B28, $8B28, $8B28
dw $8B28, $8B28, $8B29
dw $0352,$0016
dw $8B08, $8B08, $8B08, $8B08, $8B08, $8B08, $8B08, $8B08
dw $8B08, $8B08, $8B08
dw $03F2,$0018
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF
dw $0492,$0018
dw $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
dw $00FF, $00FF, $00FF, $00FF

dw $0542,$0002
dw $00FF
dw $FFFF

; Room $AD5E: Lower Norfair -> Bubble Norfair
Room_SingleChamber_Patch_01:
dw $05E0,$0004
db $FF,$00,$FF,$00
dw $06A0,$0004
db $FF,$00,$FF,$00
dw $0760,$0004
db $FF,$00,$FF,$00
dw $32F1,$0002
db $00,$00
dw $3351,$0002
db $00,$00
dw $33B1,$0002
db $00,$00
dw $7802,$0001
db $00
dw $FFFF

; Room $AD5E: Lower Norfair -> Bubble Norfair
Room_SingleChamber_Patch_02:
dw $05E0,$0004
db $FF,$00,$FF,$00
dw $061E,$0008
db $FF,$00,$FF,$00,$FF,$00,$FF,$00
dw $06A0,$0004
db $FF,$00,$FF,$00
dw $06DE,$0003
db $FF,$00,$0C
dw $06E2,$0002
db $1C,$81
dw $0760,$0004
db $FF,$00,$FF,$00
dw $079E,$0004
db $FF,$00,$05,$85
dw $085E,$0004
db $FF,$00,$05,$85
dw $091E,$0004
db $FF,$00,$05,$85
dw $09DE,$0004
db $FF,$00,$05,$85
dw $0A9E,$0002
db $0C,$81
dw $32F1,$0002
db $00,$00
dw $3351,$0002
db $00,$00
dw $33B1,$0002
db $00,$00
dw $7802,$0001
db $00
dw $FFFF

; Room $CF80: n00b tube east
Room_EastTunnel_Patch_01:
dw $070A,$0001
db $22
dw $070E,$0001
db $22
dw $078A,$0001
db $22
dw $078C,$0003
db $FF,$00,$22
dw $080A,$0005
db $22,$85,$FF,$00,$22
dw $088A,$0005
db $22,$85,$FF,$00,$22
dw $090A,$0005
db $22,$85,$FF,$00,$22
dw $098A,$0005
db $22,$85,$FF,$00,$22
dw $0A0A,$0005
db $22,$85,$FF,$00,$22
dw $0A8A,$0005
db $85,$8D,$FF,$00,$85
dw $2802,$0001
db $00
dw $FFFF

; Room $A322: Red Brinstar -> Crateria elevator
Room_RedBrinstarElevator_Patch_01:
dw $142C,$0002
db $FF,$00
dw $145E,$0001
db $62
dw $1460,$0001
db $62
dw $14BE,$0004
db $FF,$00,$FF,$00
dw $151E,$0001
db $62
dw $1520,$0001
db $62
dw $157E,$0001
db $43
dw $1580,$0001
db $22
dw $7802,$0001
db $00
dw $FFFF

; Room $9E52: Brinstar diagonal room
Room_GreenHills_Patch_01:
dw $0F24,$0004
db $6A,$81,$6C,$81
dw $36CA,$0001
db $78
dw $36CC,$0001
db $78
dw $37CC,$0002
db $FF,$00
dw $FFFF

; Room $9E52: Brinstar diagonal room
Room_GreenHills_Patch_02:
dw $0A2A,$0004
db $FF,$00,$6C,$85
dw $0B2A,$0002
db $FF,$00
dw $4596,$0001
db $00
dw $FFFF

; Room $D08A: Maridia green gate hall
Room_CrabTunnel_Patch_01:
dw $039C,$0005
db $87,$1D,$94,$11,$A0
dw $09CF,$0002
db $D2,$92
dw $FFFF

; Room $94FD: Wrecked Ship back door
Room_WreckedShipBackExit_Patch_01:
dw $4506,$0008
db $00,$81,$01,$81,$01,$85,$00,$85
dw $45E6,$0008
db $20,$11,$21,$11,$21,$15,$20,$15
dw $4876,$0008
db $00,$81,$01,$81,$01,$85,$00,$85
dw $4956,$0008
db $20,$11,$21,$11,$21,$15,$20,$15
dw $76F4,$0004
db $94,$95,$D5,$D4
dw $78AC,$0004
db $94,$95,$D5,$D4
dw $D202,$0001
db $00
dw $FFFF

; Room $D5A7: Snail room
Room_Aqueduct_Patch_01:
dw $1691,$0001
db $F0
dw $1693,$0001
db $F4
dw $18D1,$0001
db $F0
dw $18D3,$0001
db $F4
dw $2F49,$0002
db $04,$04
dw $3069,$0002
db $04,$04
dw $5A02,$0001
db $00
dw $FFFF

; Room $D6FD: Sand falls sand pit
Room_BelowBotwoonEnergyTank_Patch_01:
dw $01FE,$0004
db $0E,$8A,$10,$82
dw $027E,$0003
db $0A,$82,$10
dw $02FE,$0004
db $0B,$8A,$07,$8A
dw $037E,$0004
db $0C,$C0,$40,$90
dw $03FE,$0004
db $2C,$D0,$60,$90
dw $047E,$0004
db $2C,$D8,$60,$98
dw $04FE,$0004
db $0C,$D8,$40,$98
dw $057E,$0003
db $0B,$82,$07
dw $05FE,$0003
db $0A,$82,$10
dw $067E,$0003
db $0E,$82,$10
dw $09C0,$0002
db $40,$01
dw $0A00,$0002
db $FF,$01
dw $0A40,$0002
db $FE,$01
dw $0A80,$0002
db $FD,$01
dw $1402,$0001
db $00
dw $FFFF

; Indicator for no patch
pushpc ; Put no-op room patch at the end of the bank
org (bank(Room_Patches)<<16)+$FFFE
NoPatch:
dw $ffff
pullpc
