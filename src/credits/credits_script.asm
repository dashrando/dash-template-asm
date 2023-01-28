CreditsScript:
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
    %blank_row()
    ;%row2(179,180) ; SRL Discord Invite
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
    %row2(194,195) ; Green Brinstar
    %row2(196,197) ; Red Brinstar
    %row2(198,199) ; Wrecked Ship
    %row2(200,201) ; Kraid's Lair
    %row2(202,203) ; Upper Norfair
    %row2(204,205) ; Lower Norfair
    %row2(206,207) ; Crocomire
    %row2(208,209) ; East Maridia
    %row2(210,211) ; West Maridia
    %row2(212,213) ; Tourian
    %blank_row()
    %row1(214)     ; --- Shots and Ammo Fired ---
    %row2(215,216) ; Charged Shots
    %row2(217,218) ; Special Beam Attacks
    %row2(219,220) ; Missiles
    %row2(221,222) ; Supers
    %row2(223,224) ; PBs
    %row2(225,226) ; Bombs

    ; Draw item locations
    %blank_row()
    %row1(640)     ; --- Major item locations ---
    %blank_row()
    %row2(641,642) ; Morph
    %row2(643,644) ; Bombs
    %row2(645,646) ; Ice
    %row2(647,648) ; Wave
    %row2(649,650) ; Spazer
    %row2(651,652) ; Plasma
    %row2(653,654) ; Varia
    %row2(655,656) ; Gravity
    %row2(657,658) ; HJB
    %row2(659,660) ; Space Jump
    %row2(661,662) ; Speed
    %row2(663,664) ; Screw Attack
    %row2(665,666) ; Spring Ball
    %row2(667,668) ; X-ray
    %row2(669,670) ; Grapple
    %row2(671,672) ; Heat Shield
    %row2(673,674) ; Pressure Valve
    %row2(675,676) ; Double Jump
    %row1(677) ; Charge Item Text
    %row1(678) ; Charge Upgrade Location
    %row1(679) ; Charge Upgrade Location
    %row1(680) ; Charge Upgrade Location
    %row1(681) ; Charge Upgrade Location
    %row1(682) ; Charge Upgrade Location
    %row1(683) ; Charge Upgrade Location

    %blank_row() : %blank_row() : %blank_row()
    %blank_row() : %blank_row()

    %row2(227,228) ; Menu time
    %row2(229,230) ; Lag time
    %row2(231,232) ; Final time
    %blank_row()
    %row2(233,234) ; Thanks for playing

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
