;------------------------------------------------------------------------------
; Credits script
;------------------------------------------------------------------------------
; The credits engine reads from this sequentially. Everything here is either a
; command, eg for setting the scroll speed, or a pointer to a row in the credits
; tile map that gets loaded after the Zebes escape cutscene.
;------------------------------------------------------------------------------


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

    dw SetScroll, $0002
    %row1(128)     ; # Randomizer staff #
    %row2(158,159) ; kipp
    %row2(151,152) ; masshesteria
    %row2(222,223) ; cassidymoen
    %row2(224,225) ; papaschmo
    %row2(226,227) ; tgderp
    %row2(230,231) ; kupppo
    ;%row2(160,161) ; rumbleminze
    %blank_row() : %blank_row()

    %blank_row() : %blank_row()
    %row1(140)     ; --- additional programming ---
    %row2(136,137) ; andreww leodox
    %row2(138,139) ; personitis smiley
    %row2(130,131) ; total

    %blank_row() : %blank_row()
    %row1(155)     ; --- Logo design ---
    %row2(153,154) ; minimemys

    %blank_row() : %blank_row()
    %row1(141)     ; # Special thanks to #
    %row1(228)     ; --- Original Randomizer ---
    %row2(132,133) ; dessyreqt
    %blank_row() : %blank_row()
    %row1(147)     ; --- Testers ---
    %row2(148,149) ; fbs maniacal
    %row2(162,163) ; osse sloaters
    %row2(134,135) ; tracie zeb
    %blank_row() : %blank_row()
    %row1(142)     ; --- Disassembly ---
    %row2(143,144) ; pjboy kejardon
    %blank_row() : %blank_row()
    %row1(164)     ; Metroid construction
    %row2(165,166) ; MetroidConstruction.com
    %blank_row() : %blank_row()
    %row1(167)     ; SRL
    %row2(232,233)
    %blank_row() : %blank_row()
    %row1(157)     ; Play this randomizer at
    %row2(168,169) ; dashrando.github.io

    %blank_row() : %blank_row()
    %blank_row() : %blank_row()
    %row1(170)  ; # Game play stats #
    %row1(171)  ; --- Doors ---
    %row2(172,173) ; Door transitions
    %row2(174,175) ; Time in doors
    %row2(176,177) ; Time aligning doors
    %blank_row() : %blank_row()
    %row1(178)     ; --- Time spent in ---
    %row2(179,180) ; Crateria
    %row2(181,182) ; Green Brinstar
    %row2(183,184) ; Red Brinstar
    %row2(185,186) ; Wrecked Ship
    %row2(187,188) ; Kraid's Lair
    %row2(189,190) ; Upper Norfair
    %row2(191,192) ; Lower Norfair
    %row2(193,194) ; Crocomire
    %row2(195,196) ; East Maridia
    %row2(197,198) ; West Maridia
    %row2(199,200) ; Tourian
    %blank_row() : %blank_row()
    %row1(201)     ; --- Shots and Ammo Fired ---
    %row2(202,203) ; Charged Shots
    %row2(204,205) ; Special Beam Attacks
    %row2(206,207) ; Missiles
    %row2(208,209) ; Supers
    %row2(210,211) ; PBs
    %row2(212,213) ; Bombs

    ; Draw item locations
    %blank_row() : %blank_row()
    %row1(229)     ; --- Major item locations ---
    %blank_row()
    dw SetScroll, $0003
    %row2(640,641) ; Morph
    %row2(642,643) ; Bombs
    %row2(644,645) ; Ice
    %row2(646,647) ; Wave
    %row2(648,649) ; Spazer
    %row2(650,651) ; Plasma
    %row2(652,653) ; Varia
    %row2(654,655) ; Gravity
    %row2(656,657) ; HJB
    %row2(658,659) ; Space Jump
    %row2(660,661) ; Speed
    %row2(662,663) ; Screw Attack
    %row2(664,665) ; Spring Ball
    %row2(666,667) ; X-ray
    %row2(668,669) ; Grapple
    %row2(670,671) ; Heat Shield
    %row2(672,673) ; Pressure Valve
    %row2(674,675) ; Double Jump
    %row2(676,677) ; Charge
    %row1(678) ; Charge Upgrade Location
    %row1(679) ; Charge Upgrade Location
    %row1(680) ; Charge Upgrade Location
    %row1(681) ; Charge Upgrade Location
    %row1(682) ; Charge Upgrade Location

    %row2(214,215) ; Menu time
    %row2(216,217) ; Lag time
    %row2(218,219) ; Final time
    %blank_row()
    %row2(220,221) ; Thanks for playing

    %blank_row() : %blank_row() : %blank_row()
    %blank_row() : %blank_row() : %blank_row()
    %blank_row() : %blank_row()

    dw SetScroll, $0003

    ; Scroll all text off and end credits
    dw !set, $0017 : -
    %blank_row()
    dw !delay, -
    dw !end
