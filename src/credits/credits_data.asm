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

; Placeholder label for item locations inserted by the randomizer
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

CreditsNumbersTop:
    dw $0060, $0061, $0062, $0063, $0064, $0065, $0066, $0067, $0068, $0069, $006a, $006b, $006c, $006d, $006e, $006f
CreditsNumbersBottom:
    dw $0070, $0071, $0072, $0073, $0074, $0075, $0076, $0077, $0078, $0079, $007a, $007b, $007c, $007d, $007e, $007f


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
    dw SetScroll, $0003
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
    dw SetScroll, $0004

    ; Scroll all text off and end credits
    dw !set, $0017 : -
    %blank_row()
    dw !delay, -
    dw !end
