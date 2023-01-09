;------------------------------------------------------------------------------
; Room Edits
;------------------------------------------------------------------------------

Room_Patches: {
dw $d646,$0001,Room_PreShaktool_Patch_01
dw $d2aa,$0001,Room_Plasma_Patch_01
dw $95ff,$0001,Room_Moat_Patch_01
dw $A408,$0001,Room_PreSpazer_Patch_01
dw $9CB3,$0001,Room_Dachora_Patch_01
dw $9BC8,$0001,Room_Early_Supers_Patch_01
dw $AA41,$0001,Room_PreHiJump_Patch_01
dw $A7B3,$0001,Room_FirstHeated_Patch_01
dw $A253,$0001,Room_RedTower_Patch_01
dw $D617,$0001,Room_PreBotwoon_Patch_01
dw $A0D2,$0001,Room_Waterway_Patch_01
dw $C98E,$0000,Room_WreckedShipReserve_Patch_01
dw $C98E,$0001,Room_WreckedShipReserve_Patch_02
dw $D08A,$0001,Room_CrabTunnel_Patch_01
dw $ffff
}

Disable_Room_PLMs: {
dw $D340,$0001,$C571
dw $ffff
}

Disable_Room_Enemies: {
dw $D2AA,$0001
dw $ffff
}

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
dw $1e02,$0001
db $00
dw $ffff

Room_Moat_Patch_01:
dw $061f,$0001
db $c0
dw $ffff

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
dw $0154,$0002
db $06,$81
dw $03ac,$0002
db $ff,$00
dw $040c,$0006
db $06,$81,$ff,$00,$ff,$00
dw $052f,$0001
db $04
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
dw $053F,$0001
db $FF,$00
dw $32A0,$0001
db $00,$00
dw $ffff

Room_WreckedShipReserve_Patch_01:
dw $053F,$0001
db $F1
dw $32A0,$0001
db $08
dw $ffff

Room_CrabTunnel_Patch_01:
dw $039c,$0004
db $81,$19,$81,$19
dw $09cf,$0002
db $87,$87
dw $ffff


