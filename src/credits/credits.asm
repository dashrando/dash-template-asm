pushpc
incsrc "tracking.asm"
pullpc

draw_full_time:
    phx
    phb
    pea $7f7f : plb : plb
    tax
    lda $0000,x
    sta $16
    lda $0002,x
    sta $14
    lda #$003c
    sta $12
    lda #$ffff
    sta $1a
    jsr div32 ; frames in $14, rest in $16
    iny : iny : iny : iny : iny : iny ; Increment Y three positions forward to write the last value
    lda $14
    jsr draw_two
    tya
    sec
    sbc #$0010
    tay     ; Skip back 8 characters to draw the top three things
    lda $16
    jsr draw_time
    plb
    plx
    rts

; Draw time as xx:yy:zz
draw_time:
    phx
    phb
    dey : dey : dey : dey : dey : dey ; Decrement Y by 3 characters so the time count fits
    pea $7f7f : plb : plb
    sta $004204
    sep #$20
    lda #$ff
    sta $1a
    lda #$3c
    sta $004206
    pha : pla : pha : pla : rep #$20
    lda $004216 ; Seconds or Frames
    sta $12
    lda $004214 ; First two groups (hours/minutes or minutes/seconds)
    sta $004204
    sep #$20
    lda #$3c
    sta $004206
    pha : pla : pha : pla : rep #$20
    lda $004216
    sta $14
    lda $004214 ; First group (hours or minutes)
    jsr draw_two
    iny : iny ; Skip past separator
    lda $14 ; Second group (minutes or seconds)
    jsr draw_two
    iny : iny
    lda $12 ; Last group (seconds or frames)
    jsr draw_two
    plb
    plx
    rts

; Draw 5-digit value to credits tilemap
; A = number to draw, Y = row address
draw_value:
  phx
  phb
  pea $7f7f : plb : plb
  stz $1a     ; Leading zeroes flag

  ldx.w #100
  jsr integer_division

  lda $004216 ; Load the last two digits
  pha         ; Push last two digits onto the stack

  lda $004214 ; Load the top three digits
  jsr draw_three

  pla         ; Pull last two digits from the stack
  jsr draw_two

  plb
  plx
  rts

draw_three:
  ldx.w #100
  jsr integer_division

  lda $004214 ; Hundreds
  jsr draw_digit_without_padding
  iny : iny

  lda $004216
  ldx.w #10
  jsr integer_division

  lda $004214
  jsr draw_digit_without_padding
  iny : iny

  lda $004216
  jsr draw_digit_without_padding
  iny : iny
  rts

draw_two:
  ldx.w #10
  jsr integer_division

  lda $004214
  cmp $1a
  beq +
  jsr draw_digit : +
  iny : iny

  lda $004216
  jsr draw_digit
  iny : iny

  rts

; A = dividend, X = divisor
; $004214 = quotient, $004216 = remainder
integer_division:
  sta $004204
  sep #$20
  txa
  sta $004206
  pha : pla : pha : pla : rep #$20
  rts

draw_digit_without_padding:
  beq +

draw_digit:
  asl
  tax
  lda.l numbers_top,x
  sta $0034,y
  lda.l numbers_bot,x
  sta $0074,y
+ rts

; Loop through stat table and update RAM with numbers representing those stats
write_stats:
    phy
    phb
    php
    pea $dfdf : plb : plb
    rep #$30
    jsl load_stats      ; Copy stats back from SRAM
    ldx #$0000
    ldy #$0000

write_loop:
    ; Get pointer to table
    tya
    asl : asl : asl
    tax

    ; Load stat type
    lda.l stats+4,x
    beq write_end
    cmp #$0001
    beq write_number
    cmp #$0002
    beq write_time
    cmp #$0003
    beq write_fulltime
    jmp write_continue

write_number:
    ; Load statistic
    lda.l stats,x
    jsl load_stat
    pha

    ; Load row address
    lda.l stats+2,x
    tyx
    tay
    pla
    jsr draw_value
    txy
    jmp write_continue

write_time:
    ; Load statistic
    lda.l stats,x
    jsl load_stat
    pha

    ; Load row address
    lda.l stats+2,x
    tyx
    tay
    pla
    jsr draw_time
    txy
    jmp write_continue

write_fulltime:
    lda.l stats,x        ; Get stat id
    asl
    clc
    adc #$fc00          ; Get pointer to value instead of actual value
    pha

    ; Load row address
    lda.l stats+2,x
    tyx
    tay
    pla
    jsr draw_full_time
    txy
    jmp write_continue

write_continue:
    iny
    jmp write_loop

write_end:
    plp
    plb
    ply
    rtl

; 32-bit by 16-bit division routine I found somewhere
div32:
    phy
    phx
    php
    rep #$30
    sep #$10
    sec
    lda $14
    sbc $12
    bcs uoflo
    ldx #$11
    rep #$10

ushftl:
    rol $16
    dex
    beq umend
    rol $14
    lda #$0000
    rol
    sta $18
    sec
    lda $14
    sbc $12
    tay
    lda $18
    sbc #$0000
    bcc ushftl
    sty $14
    bra ushftl
uoflo:
    lda #$ffff
    sta $16
    sta $14
umend:
    plp
    plx
    ply
    rts

numbers_top:
    dw $0060, $0061, $0062, $0063, $0064, $0065, $0066, $0067, $0068, $0069, $006a, $006b, $006c, $006d, $006e, $006f
numbers_bot:
    dw $0070, $0071, $0072, $0073, $0074, $0075, $0076, $0077, $0078, $0079, $007a, $007b, $007c, $007d, $007e, $007f

load_stats:
    phx
    pha
    ldx #$0000
    lda $7e0952
    bne +
-
    lda $701400,x
    sta $7ffc00,x
    inx
    inx
    cpx #$0300
    bne -
    jmp load_end
+
    cmp #$0001
    bne +
    lda $701700,x
    sta $7ffc00,x
    inx
    inx
    cpx #$0300
    bne -
    jmp load_end
+
    lda $701a00,x
    sta $7ffc00,x
    inx
    inx
    cpx #$0300
    bne -
    jmp load_end

load_end:
    pla
    plx
    rtl

save_stats:
    phx
    pha
    ldx #$0000
    lda $7e0952
    bne +
-
    lda $7ffc00,x
    sta $701400,x
    inx
    inx
    cpx #$0300
    bne -
    jmp save_end
+
    cmp #$0001
    bne +
    lda $7ffc00,x
    sta $701700,x
    inx
    inx
    cpx #$0300
    bne -
    jmp save_end
+
    lda $7ffc00,x
    sta $701a00,x
    inx
    inx
    cpx #$0300
    bne -
    jmp save_end

save_end:
    pla
    plx
    rtl

script:
    dw !set, $0002 : -
    dw !draw, !blank
    dw !delay, -

    ; Show a compact version of the original credits so we get time to add more
    %row1(0)       ; ## SUPER METROID STAFF ##

    %row1(4)       ; --- PRODUCER ---
    %row2(7,8)     ; MAKOTO KANOH

    %row1(9)       ; --- DIRECTOR ---
    %row2(10,11)   ; YOSHI SAKAMOTO

    %row1(12)      ; --- BACK GROUND DESIGNERS ---
    %row2(13,14)   ; HIROFUMI MATSUOKA
    %row2(15,16)   ; MASAHIKO MASHIMO
    %row2(17,18)   ; HIROYUKI KIMURA

    %row1(19)      ; --- OBJECT DESIGNERS ---
    %row2(20,21)   ; TOHRU OHSAWA
    %row2(22,23)   ; TOMOYOSHI YAMANE

    %row1(24)      ; --- SAMUS ORIGINAL DESIGNERS ---
    %row2(25,26)   ; HIROJI KIYOTAKE

    %row1(27)      ; --- SAMUS DESIGNER ---
    %row2(28,29)   ; TOMOMI YAMANE

    %row2(83,107)  ; --- SOUND PROGRAM AND SOUND EFFECTS ---
    %row2(84,85)   ; KENJI YAMAMOTO

    %row1(86)      ; --- MUSIC COMPOSERS ---
    %row2(84,85)   ; KENJI YAMAMOTO
    %row2(87,88)   ; MINAKO HAMANO

    %row1(30)      ; --- PROGRAM DIRECTOR ---
    %row2(31,64)   ; KENJI IMAI

    %row1(65)      ; --- SYSTEM COORDINATOR ---
    %row2(66,67)   ; KENJI NAKAJIMA

    %row1(68)      ; --- SYSTEM PROGRAMMER ---
    %row2(69,70)   ; YOSHIKAZU MORI

    %row1(71)      ; --- SAMUS PROGRAMMER ---
    %row2(72,73)   ; ISAMU KUBOTA

    %row1(74)      ; --- EVENT PROGRAMMER ---
    %row2(75,76)   ; MUTSURU MATSUMOTO

    %row1(77)      ; --- ENEMY PROGRAMMER ---
    %row2(78,79)   ; YASUHIKO FUJI

    %row1(80)      ; --- MAP PROGRAMMER ---
    %row2(81,82)   ; MOTOMU CHIKARAISHI

    %row1(101)     ; --- ASSISTANT PROGRAMMER ---
    %row2(102,103) ; KOUICHI ABE

    %row1(104)     ; --- COORDINATORS ---
    %row2(105,106) ; KATSUYA YAMANO
    %row2(63,96)   ; TSUTOMU KANESHIGE

    %row1(89)      ; --- PRINTED ART WORK ---
    %row2(90,91)   ; MASAFUMI SAKASHITA
    %row2(92,93)   ; YASUO INOUE
    %row2(94,95)   ; MARY COCOMA
    %row2(99,100)  ; YUSUKE NAKANO
    %row2(108,109) ; SHINYA SANO
    %row2(110,111) ; NORIYUKI SATO

    %row1(32)      ; --- SPECIAL THANKS TO ---
    %row2(33,34)   ; DAN OWSEN
    %row2(35,36)   ; GEORGE SINFIELD
    %row2(39,40)   ; MASARU OKADA
    %row2(43,44)   ; TAKAHIRO HARADA
    %row2(47,48)   ; KOHTA FUKUI
    %row2(49,50)   ; KEISUKE TERASAKI
    %row2(51,52)   ; MASARU YAMANAKA
    %row2(53,54)   ; HITOSHI YAMAGAMI
    %row2(57,58)   ; NOBUHIRO OZAKI
    %row2(59,60)   ; KENICHI NAKAMURA
    %row2(61,62)   ; TAKEHIKO HOSOKAWA
    %row2(97,98)   ; SATOSHI MATSUMURA
    %row2(122,123) ; TAKESHI NAGAREDA
    %row2(124,125) ; MASAHIRO KAWANO
    %row2(45,46)   ; HIRO YAMADA
    %row2(112,113) ; AND ALL OF R&D1 STAFFS

    %row1(114)     ; --- GENERAL MANAGER ---
    %row2(5,6)     ; GUMPEI YOKOI
    %blank_row() : %blank_row()

    ; Custom item randomizer credits text

    %row1(128)     ; # Randomizer staff #
    %blank_row()
    %row1(163)     ; --- Game balance ---
    %row2(165,166) ; kipp
    %blank_row()
    %row1(129)     ; --- Rando code ---
    %row2(130,131) ; total
    %row2(132,133) ; dessyreqt
    %blank_row()
    %row1(141)     ; --- ROM patches ---
    %row2(137,138) ; andreww
    %row2(146,147) ; leodox
    %row2(139,140) ; personitis
    %row2(142,143) ; smiley
    %row2(130,131) ; total
    %blank_row()
    %row1(162)     ; --- Logo design ---
    %row2(160,161) ; minimemys
    %blank_row()
    %row1(157)     ; --- Technical Support ---
    %row2(158,159) ; masshesteria
    %blank_row()
    %row1(148)     ; # Special thanks to #
    %row1(154)     ; --- Testers ---
    %row2(137,138) ; andreww
    %row2(155,156) ; fbs
    %row2(171,172) ; maniacal
    %row2(173,174) ; osse
    %row2(135,136) ; rumble
    %row2(144,145) ; sloaters
    %row2(167,168) ; tracie
    %row2(169,170) ; zeb
    %blank_row()
    %row1(149)     ; --- Disassembly ---
    %row2(150,151) ; pjboy
    %row2(152,153) ; kejardon
    %blank_row()
    %row1(175)     ; Metroid construction
    %row2(176,177) ; MetroidConstruction.com
    %blank_row()
    %row1(178)     ; SRL
    %row2(179,180) ; SRL Discord Invite
    %blank_row()
    %row1(164)     ; Play this randomizer at
    %row2(181,182) ; dashrando.github.io

    %blank_row()
    %row1(183)  ; # Game play stats #
    %blank_row()
    %row1(184)  ; --- Doors ---

    ; Set scroll speed to 3 frames per pixel
    dw set_scroll, $0003
    %row2(185,186) ; Door transitions
    %row2(187,188) ; Time in doors
    %row2(189,190) ; Time aligning doors
    %blank_row()
    %row1(191)     ; --- Time spent in ---
    %row2(192,193) ; Crateria
    %row2(194,195) ; Brinstar
    %row2(196,197) ; Norfair
    %row2(198,199) ; Wrecked Ship
    %row2(200,201) ; Maridia
    %row2(202,203) ; Tourian
    %blank_row()
    %row1(204)     ; --- Shots and Ammo Fired ---
    %row2(205,206) ; Charged Shots
    %row2(207,208) ; Special Beam Attacks
    %row2(209,210) ; Missiles
    %row2(211,212) ; Supers
    %row2(213,214) ; PBs
    %row2(215,216) ; Bombs

    ; Draw item locations
    %blank_row()
    %row1(640)     ; --- Major item locations ---
    %blank_row()
    %row2(641,642) ; Morph
    %row2(643,644) ; Bombs
    %row2(645,646) ; Charge
    %row2(647,648) ; Ice
    %row2(649,650) ; Wave
    %row2(651,652) ; Spazer
    %row2(653,654) ; Plasma
    %row2(655,656) ; Varia
    %row2(657,658) ; Gravity
    %row2(659,660) ; HJB
    %row2(661,662) ; Space Jump
    %row2(663,664) ; Speed
    %row2(665,666) ; Screw Attack
    %row2(667,668) ; Spring Ball
    %row2(669,670) ; X-ray
    %row2(671,672) ; Grapple

    %blank_row() : %blank_row() : %blank_row()
    %blank_row() : %blank_row()

    %row2(217,218) ; Final time
    %blank_row()
    %row2(219,220) ; Thanks for playing

    %blank_row() : %blank_row() : %blank_row()
    %blank_row() : %blank_row() : %blank_row()
    %blank_row() : %blank_row()

    ; Set scroll speed to 4 frames per pixel
    dw set_scroll, $0004

    ; Scroll all text off and end credits
    dw !set, $0017 : -
    %blank_row()
    dw !delay, -
    dw !end

stats:
    ; STAT ID, ADDRESS,    TYPE (1 = Number, 2 = Time, 3 = Full time), UNUSED
    dw 0,       !row*217,  3, 0    ; Full RTA Time
    dw 2,       !row*185,  1, 0    ; Door transitions
    dw 3,       !row*187,  3, 0    ; Time in doors
    dw 5,       !row*189,  2, 0    ; Time adjusting doors
    dw 7,       !row*192,  3, 0    ; Crateria
    dw 9,       !row*194,  3, 0    ; Brinstar
    dw 11,      !row*196,  3, 0    ; Norfair
    dw 13,      !row*198,  3, 0    ; Wrecked Ship
    dw 15,      !row*200,  3, 0    ; Maridia
    dw 17,      !row*202,  3, 0    ; Tourian
    dw 20,      !row*205,  1, 0    ; Charged Shots
    dw 21,      !row*207,  1, 0    ; Special Beam Attacks
    dw 22,      !row*209,  1, 0    ; Missiles
    dw 23,      !row*211,  1, 0    ; Super Missiles
    dw 24,      !row*213,  1, 0    ; Power Bombs
    dw 26,      !row*215,  1, 0    ; Bombs
    dw 0,              0,  0, 0    ; end of table

patch1:
    phb : pea.w $df00 : plb : plb
    jsr new_offset
    lda $0000,y
    bpl +
    plb
    jml $8b99a0
+
    plb
    jml $8b99aa

patch2:
    sta $0014
    phb : pea $df00 : plb : plb
    jsr new_offset
    lda $0002,y
    plb
    jml $8b99eb

patch3:
    phb : pea $df00 : plb : plb
    jsr new_offset
    lda $0000,y
    tay
    plb
    jml $8b9a0c

patch4:
    phb : pea $df00 : plb : plb
    jsr new_offset
    lda $0000,y
    plb
    sta $19fb
    jml $8b9a1f

new_offset:
    TYA : CMP #$D91B : BCC +
    SEC : SBC.w #$D91B
    ADC.w #script-1
    +
    TAY
RTS

; Copy custom credits tilemap data from $ceb240,x to $7f2000,x
copy:
    pha
    phx
    ldx #$0000
-
    lda.l credits,x
    cmp #$dead
    beq +
    sta $7f2000,x
    inx
    inx
    jmp -
+

    ldx #$0000
-
    lda.l itemlocations,x
    cmp #$0000
    beq +
    sta $7fa000,x
    inx
    inx
    jmp -
+

    jsl write_stats
    lda #$0002
    sta !scroll_speed
    plx
    pla
    jsl $8b95ce
    rtl

clear_values:
    php
    rep #$30
    ; Do some checks to see that we're actually starting a new game
    ; Make sure game mode is 1f
    lda $7e0998
    cmp.w #$001f
    bne clear_value_ret

    ; Check if samus saved energy is 00, if it is, run startup code
    lda $7ed7e2
    bne clear_value_ret

    ldx #$0000
    lda #$0000
-
    jsl store_stat
    inx
    cpx #$0180
    bne -

    ; Clear RTA Timer
    lda #$0000
    sta !timer1
    sta !timer2

clear_value_ret:
    plp
    jsl $809a79
    rtl

; Game has ended, save RTA timer to RAM and copy all stats to SRAM a final time
game_end: {
  lda !timer1
  sta $7ffc00
  lda !timer2
  sta $7ffc02

  ; Subtract frames from pressing down at ship to this code running
  lda $7ffc00
  sec
  sbc #$013d
  sta $7ffc00
  lda #$0000  ; if carry clear this will subtract one from the high byte of timer
  sbc $7ffc02

  jsl save_stats
  lda #$000a
  jsl $90f084
  rtl
}

; Increment Statistic (A = ID of statistic)
inc_stat: {
  phx
  asl
  tax
  lda $7ffc00,x
  inc
  sta $7ffc00,x
  plx
  rtl
}

; Decrement Statistic (A = ID of statistic)
dec_stat: {
  phx
  asl
  tax
  lda $7ffc00,x
  dec
  sta $7ffc00,x
  plx
  rtl
}

; Store Statistic (value in A, stat in X)
store_stat: {
  phx
  pha
  txa
  asl
  tax
  pla
  sta $7ffc00,x
  plx
  rtl
}

; Load Statistic (stat in A, returns value in A)
load_stat: {
  phx
  asl
  tax
  lda $7ffc00,x
  plx
  rtl
}


pushpc
; Relocated credits tilemap to free space in bank CE
org $ceb240
credits:
    ; Single line characters:
    ;   ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':!
    ; Double line characters:
    ;   ABCDEFGHIJKLMNOPQRSTUVWXYZ.^':%&
    ;   0123456789

    %font1("     DASH RANDOMIZER STAFF      ", "pink")    ; 128
    %font1("        RANDOMIZER CODE         ", "purple")  ; 129
    %font2("             TOTAL              ", "white")   ; 130 + 131
    %font2("           DESSYREQT            ", "white")   ; 132 + 133
    %font1("           SNES CODE            ", "purple")  ; 134
    %font2("          RUMBLEMINZE           ", "white")   ; 135 + 136
    %font2("            ANDREWW             ", "white")   ; 137 + 138
    %font2("           PERSONITIS           ", "white")   ; 139 + 140
    %font1("          ROM PATCHES           ", "purple")  ; 141
    %font2("             SMILEY             ", "white")   ; 142 + 143
    %font2("           SLOATERS27           ", "white")   ; 144 + 145
    %font2("             LEODOX             ", "white")   ; 146 + 147
    %font1("       SPECIAL THANKS TO        ", "cyan")    ; 148
    %font1("   SUPER METROID DISASSEMBLY    ", "yellow")  ; 149
    %font2("             PJBOY              ", "white")   ; 150 + 151
    %font2("            KEJARDON            ", "white")   ; 152 + 153
    %font1("            TESTERS             ", "yellow")  ; 154
    %font2("         FRUITBATSALAD          ", "white")   ; 155 + 156
    %font1("       TECHNICAL SUPPORT        ", "purple")  ; 157
    %font2("          MASSHESTERIA          ", "white")   ; 158 + 159
    %font2("           MINIMEMYS            ", "white")   ; 160 + 161
    %font1("          LOGO DESIGN           ", "purple")  ; 162
    %font1("          GAME BALANCE          ", "purple")  ; 163
    %font1("     PLAY THIS RANDOMIZER AT    ", "cyan")    ; 164
    %font2("              KIPP              ", "white")   ; 165 + 166
    %font2("            TRACIEM             ", "white")   ; 167 + 168
    %font2("             ZEB316             ", "white")   ; 169 + 170
    %font2("           MANIACAL42           ", "white")   ; 171 + 172
    %font2("            OSSE101             ", "white")   ; 173 + 174
    %font1("      METROID CONSTRUCTION      ", "yellow")  ; 175
    %font2("     METROIDCONSTRUCTION.COM    ", "white")   ; 176 + 177
    %font1("  SUPER METROID SRL COMMUNITY   ", "yellow")  ; 178
    %font2("    DISCORD INVITE : 6RYJM4M    ", "white")   ; 179 + 180
    %font2("      DASHRANDO.GITHUB.IO       ", "white")   ; 181 + 182
    %font1("      GAMEPLAY STATISTICS       ", "purple")  ; 183
    %font1("             DOORS              ", "orange")  ; 184
    %font2(" DOOR TRANSITIONS               ", "white")   ; 185 + 186
    %font2(" TIME IN DOORS      00'00'00^00 ", "white")   ; 187 + 188
    %font2(" TIME ALIGNING DOORS   00'00^00 ", "white")   ; 189 + 190
    %font1("         TIME SPENT IN          ", "blue")    ; 191
    %font2(" CRATERIA           00'00'00^00 ", "white")   ; 192 + 193
    %font2(" BRINSTAR           00'00'00^00 ", "white")   ; 194 + 195
    %font2(" NORFAIR            00'00'00^00 ", "white")   ; 196 + 197
    %font2(" WRECKED SHIP       00'00'00^00 ", "white")   ; 198 + 199
    %font2(" MARIDIA            00'00'00^00 ", "white")   ; 200 + 201
    %font2(" TOURIAN            00'00'00^00 ", "white")   ; 202 + 203
    %font1("      SHOTS AND AMMO FIRED      ", "green")   ; 204
    %font2(" CHARGED SHOTS                  ", "white")   ; 205 + 206
    %font2(" SPECIAL BEAM ATTACKS           ", "white")   ; 207 + 208
    %font2(" MISSILES                       ", "white")   ; 209 + 210
    %font2(" SUPER MISSILES                 ", "white")   ; 211 + 212
    %font2(" POWER BOMBS                    ", "white")   ; 213 + 214
    %font2(" BOMBS                          ", "white")   ; 215 + 216
    %font2(" FINAL TIME         00'00'00^00 ", "white")   ; 217 + 218
    %font2("       THANKS FOR PLAYING       ", "green")   ; 219 + 220
    dw $dead                              ; End of credits tilemap

warnpc $ceffff

; Placeholder label for item locations inserted by the randomizer
org $ded200
itemlocations:
    %font1("      MAJOR ITEM LOCATIONS      ", "pink") ; 640
    %font1("MORPH BALL                      ", "yellow")
    %font1("................................", "orange")
    %font1("BOMB                            ", "yellow")
    %font1("................................", "orange")
    %font1("CHARGE BEAM                     ", "yellow")
    %font1("................................", "orange")
    %font1("ICE BEAM                        ", "yellow")
    %font1("................................", "orange")
    %font1("WAVE BEAM                       ", "yellow")
    %font1("................................", "orange")
    %font1("SPAZER                          ", "yellow")
    %font1("................................", "orange")
    %font1("PLASMA BEAM                     ", "yellow")
    %font1("................................", "orange")
    %font1("VARIA SUIT                      ", "yellow")
    %font1("................................", "orange")
    %font1("GRAVITY SUIT                    ", "yellow")
    %font1("................................", "orange")
    %font1("HIJUMP BOOTS                    ", "yellow")
    %font1("................................", "orange")
    %font1("SPACE JUMP                      ", "yellow")
    %font1("................................", "orange")
    %font1("SPEED BOOSTER                   ", "yellow")
    %font1("................................", "orange")
    %font1("SCREW ATTACK                    ", "yellow")
    %font1("................................", "orange")
    %font1("SPRING BALL                     ", "yellow")
    %font1("................................", "orange")
    %font1("XRAY SCOPE                      ", "yellow")
    %font1("................................", "orange")
    %font1("GRAPPLING BEAM                  ", "yellow")
    %font1("................................", "orange")
    dd 0

pullpc
