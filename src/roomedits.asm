;------------------------------------------------------------------------------
; Room Patches
;------------------------------------------------------------------------------
; Patch format:
; Target [0x02]: Destination in bank $7F
; Encoding [0x02]: r w - - - - - -  l l l l l l l l
;                  r = Repeating | w = 16 bits if set
;                  l = Length of data minus one. If w is set, length is number
;                      of words.
; Data [variable]: Map data overwritten at target after vanilla map load.
; Terminating byte [0x02]: $FFFF
;------------------------------------------------------------------------------

Room_Patches:
Room_PreShaktool_Patch_01:
dw $0CCC, $C005
dw $00FF
dw $0D0E, $C004
dw $00FF
dw $1669, $0000
db $00
dw $2802, $0000
db $00
dw $FFFF

Room_Plasma_Patch_01:
dw $03B4, $0000
db $8D
dw $03EC, $0008
db $9C, $03, $89, $03, $83, $03, $83, $03
db $87
dw $042C, $0008
db $98, $03, $8C, $03, $82, $03, $82, $03
db $86
dw $046C, $0008
db $99, $03, $88, $03, $89, $03, $8A, $03
db $8B
dw $04AC, $4004
dw $038F, $00FF, $038C, $038D, $00FF
dw $04DC, $0002
db $9C, $03, $8B
dw $04EC, $4004
dw $00FF, $00FF, $0388, $038B, $00FF
dw $051C, $400C
dw $0398, $00FF, $00FF, $00FF, $0202, $8201, $8200, $8200
dw $8601, $0602, $00FF, $00FF, $00FF
dw $055C, $400C
dw $0399, $00FF, $00FF, $00FF, $1214, $8215, $8210, $8210
dw $8615, $1614, $00FF, $00FF, $00FF
dw $059C, $4000
dw $038F
dw $05A4, $4008
dw $1212, $8210, $8210, $8210, $8210, $1612, $00FF, $00FF
dw $00FF
dw $05E4, $4008
dw $8A0B, $8A07, $8A07, $8A07, $8A07, $8E0B, $00FF, $00FF
dw $00FF
dw $062C, $C004
dw $00FF
dw $066C, $C004
dw $00FF
dw $06AE, $C003
dw $00FF
dw $06EE, $C003
dw $00FF
dw $072E, $C003
dw $00FF
dw $076E, $C003
dw $00FF
dw $07AE, $C003
dw $00FF
dw $07EE, $C003
dw $8200
dw $0EB3, $4002
dw $001B, $0000, $5B00
dw $0ED3, $4002
dw $001C, $0000, $5C00
dw $FFFF

Room_Moat_Patch_01:
dw $059F, $0000
db $C0
dw $05DE, $4000
dw $D0BE
dw $061F, $0000
db $C0
dw $0AD0, $0000
db $02
dw $0AF0, $0000
db $FF
dw $FFFF

Room_PreSpazer_Patch_01:
dw $018E, $4000
dw $C1EB
dw $FFFF

Room_Dachora_Patch_01:
dw $6787, $C002
dw $0F0F
dw $F502, $0000
db $00
dw $FFFF

Room_Early_Supers_Patch_01:
dw $08BD, $0000
db $C1
dw $FFFF

Room_PreHiJump_Patch_01:
dw $015D, $0000
db $C5
dw $02B5, $0004
db $C3, $6B, $83, $6B, $C3
dw $1402, $0000
db $00
dw $FFFF

Room_FirstHeated_Patch_01:
dw $03AC, $4000
dw $00FF
dw $040C, $4002
dw $8106, $00FF, $00FF
dw $0DD7, $0000
db $00
dw $0E09, $0000
db $00
dw $1E02, $0000
db $00
dw $FFFF

Room_RedTower_Patch_01:
dw $0E64, $4003
dw $8101, $054B, $014B, $0169
dw $0E84, $4003
dw $8103, $072D, $00FF, $014A
dw $0EA4, $4003
dw $8103, $00FF, $00FF, $014B
dw $0EC4, $4003
dw $8121, $00FF, $00FF, $00FF
dw $0EE6, $4002
dw $8143, $00FF, $094B
dw $FFFF

Room_Waterway_Patch_01:
dw $0803, $0002
db $F3, $50, $F3
dw $0815, $0008
db $F7, $4E, $FB, $4E, $F3, $4E, $F7, $50
db $F3
dw $0833, $4008
dw $4EF7, $4EFF, $4EF3, $4EF7, $4EF3, $4EF3, $4EFF, $4EFB
dw $50FB
dw $0845, $0000
db $F3
dw $08E3, $0002
db $F3, $50, $F3
dw $08F5, $0008
db $F7, $4E, $F3, $4E, $FF, $4E, $F3, $50
db $F3
dw $0913, $4008
dw $4EF7, $4EF7, $4EF3, $4EF3, $4EF3, $4EF7, $4EF7, $4EFB
dw $50F7
dw $0925, $0000
db $F3
dw $09C3, $0002
db $F3, $50, $F3
dw $09D5, $0008
db $F7, $4E, $F3, $4E, $F3, $4E, $F7, $50
db $F3
dw $09F3, $4008
dw $4EF7, $4EFB, $4EF3, $4EF3, $4EFB, $4EF3, $4EF3, $4EF3
dw $50FB
dw $0A05, $0000
db $F3
dw $1202, $4000
dw $0909
dw $120B, $8004
db $09
dw $121A, $C004
dw $0909
dw $1272, $4000
dw $0909
dw $127B, $8004
db $09
dw $128A, $C004
dw $0909
dw $12E2, $4000
dw $0909
dw $12EB, $8004
db $09
dw $12FA, $C004
dw $0909
dw $FFFF

Room_PreBotwoon_Patch_01:
dw $05A1, $0000
db $F0
dw $05E3, $0000
db $F0
dw $05ED, $0000
db $F0
dw $0621, $0000
db $F3
dw $0663, $0000
db $F0
dw $066D, $0000
db $F8
dw $06A1, $0000
db $F0
dw $06E3, $0000
db $F8
dw $06ED, $0000
db $F0
dw $0AD1, $0000
db $09
dw $0AF2, $4002
dw $0009, $0000, $0900
dw $0B11, $0000
db $09
dw $0B32, $4002
dw $0009, $0000, $0900
dw $0B51, $0000
db $09
dw $0B72, $4002
dw $0009, $0000, $0900
dw $1402, $0000
db $00
dw $FFFF

Room_WreckedShipReserve_Patch_02:
dw $05BE, $C007
dw $00FF
dw $067E, $C007
dw $00FF
dw $073E, $C007
dw $00FF
dw $053E, $4000
dw $00FF
dw $32A0, $4000
dw $0000
dw $FFFF

Room_WreckedShipReserve_Patch_01:
dw $053E, $4000
dw $F111
dw $32A0, $4000
dw $0008
dw $FFFF

Room_Shaktool_Patch_01:
dw $02A2, $C023
dw $00FF
dw $0322, $C023
dw $00FF
dw $03A2, $C023
dw $00FF
dw $0422, $C023
dw $00FF
dw $04A2, $C023
dw $00FF
dw $0522, $C023
dw $00FF
dw $FFFF

Room_MissionImpossible_Patch_01:
dw $0686, $4000
dw $C05F
dw $FFFF

Room_KraidMissiles_Patch_01:
dw $064E, $4000
dw $C570
dw $FFFF

Room_BigPink_Patch_01:
dw $02B2, $C009
dw $8B28
dw $02C6, $4000
dw $8B29
dw $0352, $C00A
dw $8B08
dw $03F2, $C00B
dw $00FF
dw $0492, $C00B
dw $00FF
dw $0542, $4000
dw $00FF
dw $FFFF

; Room $AD5E: Lower Norfair -> Bubble Norfair
Room_SingleChamber_Patch_01:
dw $05E0, $C001
dw $00FF
dw $06A0, $C001
dw $00FF
dw $0760, $C001
dw $00FF
dw $32F1, $4000
dw $0000
dw $3351, $4000
dw $0000
dw $33B1, $4000
dw $0000
dw $7802, $0001
db $00
dw $FFFF

;-------------------------------------------------
; Room $AD5E: Lower Norfair -> Bubble Norfair
;-------------------------------------------------
; Opens the back door to LN from within the
; Single Chamber room
;-------------------------------------------------
Room_SingleChamber_Patch_02:
dw $05E0, $C001
dw $00FF
dw $061E, $C003
dw $00FF
dw $06A0, $C001
dw $00FF
dw $06DE, $0002
db $FF, $00, $0C
dw $06E2, $4000
dw $811C
dw $0760, $C001
dw $00FF
dw $079E, $4001
dw $00FF, $8505
dw $085E, $4001
dw $00FF, $8505
dw $091E, $4001
dw $00FF, $8505
dw $09DE, $4001
dw $00FF, $8505
dw $0A9E, $4000
dw $810C
dw $32F1, $4000
dw $0000
dw $3351, $4000
dw $0000
dw $33B1, $4000
dw $0000
dw $7802, $0000
db $00
dw $FFFF

; Room $CF80: n00b tube east
Room_EastTunnel_Patch_01:
dw $070A, $0000
db $22
dw $070E, $0000
db $22
dw $078A, $0000
db $22
dw $078C, $0002
db $FF, $00, $22
dw $080A, $0004
db $22, $85, $FF, $00, $22
dw $088A, $0004
db $22, $85, $FF, $00, $22
dw $090A, $0004
db $22, $85, $FF, $00, $22
dw $098A, $0004
db $22, $85, $FF, $00, $22
dw $0A0A, $0004
db $22, $85, $FF, $00, $22
dw $0A8A, $0004
db $85, $8D, $FF, $00, $85
dw $2802, $0000
db $00
dw $FFFF

;-------------------------------------------------
; Room $A322: Red Brinstar -> Crateria elevator
;-------------------------------------------------
; Open the back entry to Maridia on the right
; wall near the elevator
;-------------------------------------------------
Room_RedBrinstarElevator_Patch_01:
dw $142C, $4000
dw $00FF
dw $145E, $0000
db $62
dw $1460, $0000
db $62
dw $14BE, $C001
dw $00FF
dw $151E, $0000
db $62
dw $1520, $0000
db $62
dw $157E, $0000
db $43
dw $1580, $0000
db $22
dw $7802, $0000
db $00
dw $FFFF

; Room $9E52: Brinstar diagonal room
Room_GreenHills_Patch_01:
dw $0F24, $4001
dw $816A, $816C
dw $36CA, $0000
db $78
dw $36CC, $0000
db $78
dw $37CC, $4000
dw $00FF
dw $FFFF

;-------------------------------------------------
; Room $9E52: Brinstar diagonal room
;-------------------------------------------------
; Flatten the ledge at the top of the room to
; allow easy access without HJB
;-------------------------------------------------
Room_GreenHills_Patch_02:
dw $0A2A, $4001
dw $00FF, $856C
dw $0B2A, $4000
dw $00FF
dw $4596, $0000
db $00
dw $FFFF

; Room $D08A: Maridia green gate hall
Room_CrabTunnel_Patch_01:
dw $039C, $0004
db $87, $1D, $94, $11, $A0
dw $09CF, $4000
dw $92D2
dw $FFFF

;-------------------------------------------------
; Room $94FD: Wrecked Ship back door
;-------------------------------------------------
; Add platforms to allow access to the ledge on
; the top right with just HJB
;-------------------------------------------------
Room_WreckedShipBackExit_Patch_01:
dw $4506, $4003
dw $8100, $8101, $8501, $8500
dw $45E6, $4003
dw $1120, $1121, $1521, $1520
dw $4876, $4003
dw $8100, $8101, $8501, $8500
dw $4956, $4003
dw $1120, $1121, $1521, $1520
dw $76F4, $4001
dw $9594, $D4D5
dw $78AC, $4001
dw $9594, $D4D5
dw $D202, $0000
db $00
dw $FFFF

;-------------------------------------------------
; Room $D5A7: Snail room
;-------------------------------------------------
; Allow screw attack and bombs to break the
; blocks near the front door of Aqueduct 
;-------------------------------------------------
Room_Aqueduct_Patch_01:
dw $1691, $0000
db $F0
dw $1693, $0000
db $F4
dw $18D1, $0000
db $F0
dw $18D3, $0000
db $F4
dw $2F49, $4000
dw $0404
dw $3069, $4000
dw $0404
dw $5A02, $0000
db $00
dw $FFFF

; Room $D6FD: Sand falls sand pit
Room_BelowBotwoonEnergyTank_Patch_01:
dw $01FE, $4001
dw $8A0E, $8210
dw $027E, $0002
db $0A, $82, $10
dw $02FE, $4001
dw $8A0B, $8A07
dw $037E, $4001
dw $C00C, $9040
dw $03FE, $4001
dw $D02C, $9060
dw $047E, $4001
dw $D82C, $9860
dw $04FE, $4001
dw $D80C, $9840
dw $057E, $0002
db $0B, $82, $07
dw $05FE, $4000
dw $820A
dw $0600, $0000
db $10
dw $067E, $0002
db $0E, $82, $10
dw $09C0, $4000
dw $0140
dw $0A00, $4000
dw $01FF
dw $0A40, $4000
dw $01FE
dw $0A80, $4000
dw $01FD
dw $1402, $0000
db $00
dw $FFFF

; Indicator for no patch
pushpc ; Put no-op room patch at the end of the bank
org (bank(Room_Patches)<<16)+$FFFE
NoPatch:
dw $FFFF
pullpc
