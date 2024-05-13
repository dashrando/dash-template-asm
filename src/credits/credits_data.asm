;------------------------------------------------------------------------------
; Credits Tilemaps
;------------------------------------------------------------------------------

CreditsTileData:
    ; Single line characters:
    ;   ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':!
    ; Double line characters:
    ;   ABCDEFGHIJKLMNOPQRSTUVWXYZ.^':%&
    ;   0123456789

    %font1("     DASH RANDOMIZER STAFF      ", "pink")    ; 128
    %font1("        RANDOMIZER CODE         ", "purple")  ; 129
    %font2("             TOTAL              ", "white")   ; 130 + 131
    %font2("           DESSYREQT            ", "white")   ; 132 + 133
    %font2("    TRACIEM        ZEB316       ", "white")   ; 134 + 135
    %font2("    ANDREWW        LEODOX       ", "white")   ; 136 + 137
    %font2("    PERSONITIS     SMILEY       ", "white")   ; 138 + 139
    %font1("     ADDITIONAL PROGRAMMING     ", "purple")  ; 140
    %font1("       SPECIAL THANKS TO        ", "cyan")    ; 141
    %font1("   SUPER METROID DISASSEMBLY    ", "yellow")  ; 142
    %font2("    PJBOY          KEJARDON     ", "white")   ; 143 + 144
    %font2("            KEJARDON            ", "white")   ; 145 + 146
    %font1("            TESTERS             ", "yellow")  ; 147
    %font2("    FRUITBATSALAD  MANIACAL     ", "white")   ; 148 + 149
    %font1("       TECHNICAL SUPPORT        ", "purple")  ; 150
    %font2("          MASSHESTERIA          ", "white")   ; 151 + 152
    %font2("           MINIMEMYS            ", "white")   ; 153 + 154
    %font1("          LOGO DESIGN           ", "purple")  ; 155
    %font1("          GAME BALANCE          ", "purple")  ; 156
    %font1("     PLAY THIS RANDOMIZER AT    ", "cyan")    ; 157
    %font2("              KIPP              ", "white")   ; 158 + 159
    %font2("          RUMBLEMINZE           ", "white")   ; 160 + 161
    %font2("    OSSE101        SLOATERS27   ", "white")   ; 162 + 163
    %font1("      METROID CONSTRUCTION      ", "yellow")  ; 164
    %font2("    METROIDCONSTRUCTION.COM     ", "white")   ; 165 + 166
    %font1("  SUPER METROID SRL COMMUNITY   ", "yellow")  ; 167
    %font2("         DASHRANDO.NET          ", "white")   ; 168 + 169
    %font1("      GAMEPLAY STATISTICS       ", "purple")  ; 170
    %font1("             DOORS              ", "green")   ; 171
    %font2(" DOOR TRANSITIONS               ", "white")   ; 172 + 173
    %font2(" TIME IN DOORS      00'00'00^00 ", "white")   ; 174 + 175
    %font2(" ALIGNING DOORS     00'00'00^00 ", "white")   ; 176 + 177
    %font1("         TIME SPENT IN          ", "green")   ; 178
    %font2(" CRATERIA           00'00'00^00 ", "white")   ; 179 + 180
    %font2(" GREEN BRINSTAR     00'00'00^00 ", "white")   ; 181 + 182
    %font2(" RED BRINSTAR       00'00'00^00 ", "white")   ; 183 + 184
    %font2(" WRECKED SHIP       00'00'00^00 ", "white")   ; 185 + 186
    %font2(" KRAID'S LAIR       00'00'00^00 ", "white")   ; 187 + 188
    %font2(" UPPER NORFAIR      00'00'00^00 ", "white")   ; 189 + 190
    %font2(" LOWER NORFAIR      00'00'00^00 ", "white")   ; 191 + 192
    %font2(" CROCOMIRE          00'00'00^00 ", "white")   ; 193 + 194
    %font2(" EAST MARIDIA       00'00'00^00 ", "white")   ; 195 + 196
    %font2(" WEST MARIDIA       00'00'00^00 ", "white")   ; 197 + 198
    %font2(" TOURIAN            00'00'00^00 ", "white")   ; 199 + 200
    %font1("      SHOTS AND AMMO FIRED      ", "green")   ; 201
    %font2(" CHARGED SHOTS                  ", "white")   ; 202 + 203
    %font2(" SPECIAL BEAM ATTACKS           ", "white")   ; 204 + 205
    %font2(" MISSILES                       ", "white")   ; 206 + 207
    %font2(" SUPER MISSILES                 ", "white")   ; 208 + 209
    %font2(" POWER BOMBS                    ", "white")   ; 210 + 211
    %font2(" BOMBS                          ", "white")   ; 212 + 213
    %font2(" MENU TIME          00'00'00^00 ", "white")   ; 214 + 215
    %font2(" LAG TIME           00'00'00^00 ", "white")   ; 216 + 217
    %font2(" FINAL TIME         00'00'00^00 ", "white")   ; 218 + 219
    %font2("       THANKS FOR PLAYING       ", "green")   ; 220 + 221
    %font2("          CASSIDYMOEN           ", "white")   ; 222 + 223
    %font2("           PAPASCHMO            ", "white")   ; 224 + 225
    %font2("            TGDERP              ", "white")   ; 226 + 227
    %font1("      ORIGINAL RANDOMIZER       ", "yellow")  ; 228
    %font1("      MAJOR ITEM LOCATIONS      ", "pink")    ; 229
    %font2("            KUPPPO              ", "white")   ; 230 + 231
    %font2("     DASHRANDO.NET/SMDISCORD    ", "white")   ; 232 + 233
    dw $dead                                              ; End of credits tilemap

CreditsNumbersTop:
    dw $0060, $0061, $0062, $0063, $0064, $0065, $0066, $0067, $0068, $0069, $006a, $006b, $006c, $006d, $006e, $006f
CreditsNumbersBottom:
    dw $0070, $0071, $0072, $0073, $0074, $0075, $0076, $0077, $0078, $0079, $007a, $007b, $007c, $007d, $007e, $007f

CreditsItemNames:
    pushtable
    table "data/yellow_single.tbl",rtl
    dw "MORPH BALL     "
    dw "BOMBS          "
    dw "ICE BEAM       "
    dw "WAVE BEAM      "
    dw "SPAZER         "
    dw "PLASMA BEAM    "
    dw "VARIA SUIT     "
    dw "GRAVITY SUIT   "
    dw "HIJUMP BOOTS   "
    dw "SPACE JUMP     "
    dw "SPEED BOOSTER  "
    dw "SCREW ATTACK   "
    dw "SPRING BALL    "
    dw "XRAY SCOPE     "
    dw "GRAPPLING BEAM "
    dw "HEAT SHIELD    "
    dw "PRESSURE VALVE "
    dw "DOUBLE JUMP    "
    dw "CHARGE BEAM    "
    dw "CHARGE UPGRADES"
    pulltable

CreditsLocationNames:
    %font1(".....POWER BOMBS, LANDING SITE", "orange")
    %font1("........MISSILES, OCEAN BOTTOM", "orange")
    %font1(".................MISSILES, SKY", "orange")
    %font1("........MISSILES, OCEAN MIDDLE", "orange")
    %font1("................MISSILES, MOAT", "orange")
    %font1(".........ENERGY TANK, GAUNTLET", "orange")
    %font1("........MISSILES, MOTHER BRAIN", "orange")
    %font1(".........................BOMBS", "orange")
    %font1(".......ENERGY TANK, TERMINATOR", "orange")
    %font1("......MISSILES, GAUNTLET RIGHT", "orange")
    %font1(".......MISSILES, GAUNTLET LEFT", "orange")
    %font1(".................SUPERS, CLIMB", "orange")
    %font1("..............MISSILES, PARLOR", "orange")
    %font1(".........POWER BOMBS, ETECOONS", "orange")
    %font1("...........SUPERS, SPORE SPAWN", "orange")
    %font1("........MISSILES, EARLY BRIDGE", "orange")
    %font1("..........SUPERS, EARLY BRIDGE", "orange")
    %font1("........RESERVE TANK, BRINSTAR", "orange")
    %font1("......MISSILES, BRIN RESERVE B", "orange")
    %font1("......MISSILES, BRIN RESERVE A", "orange")
    %font1("............MISSILES, BIG PINK", "orange")
    %font1("..............MISSILES, CHARGE", "orange")
    %font1("...................CHARGE BEAM", "orange")
    %font1("..POWER BOMBS, MISN IMPOSSIBLE", "orange")
    %font1("...........MISSILES, BRIN TUBE", "orange")
    %font1(".................MORPHING BALL", "orange")
    %font1("............POWER BOMBS, MORPH", "orange")
    %font1("................MISSILES, BETA", "orange")
    %font1(".....ENERGY TANK, BRIN CEILING", "orange")
    %font1(".........ENERGY TANK, ETECOONS", "orange")
    %font1("..............SUPERS, ETECOONS", "orange")
    %font1(".........ENERGY TANK, WATERWAY", "orange")
    %font1("...............MISSILES, ALPHA", "orange")
    %font1("........ENERGY TANK, WAVE GATE", "orange")
    %font1("........MISSILES, BILLY MAYS A", "orange")
    %font1("........MISSILES, BILLY MAYS B", "orange")
    %font1("....................XRAY SCOPE", "orange")
    %font1(".............POWER BOMBS, BETA", "orange")
    %font1("............POWER BOMBS, ALPHA", "orange")
    %font1("...........MISSILES, ALPHA PBS", "orange")
    %font1("........................SPAZER", "orange")
    %font1("............ENERGY TANK, KRAID", "orange")
    %font1("...............MISSILES, KRAID", "orange")
    %font1("....................VARIA SUIT", "orange")
    %font1("...........MISSILES, CATHEDRAL", "orange")
    %font1("......................ICE BEAM", "orange")
    %font1(".......MISSILES, CRUMBLE SHAFT", "orange")
    %font1("........ENERGY TANK, CROCOMIRE", "orange")
    %font1("..................HIJUMP BOOTS", "orange")
    %font1(".........MISSILES, CROC ESCAPE", "orange")
    %font1(".................MISSILES, HJB", "orange")
    %font1("..............ENERGY TANK, HJB", "orange")
    %font1("........POWER BOMBS, CROCOMIRE", "orange")
    %font1("..............MISSILES, COSINE", "orange")
    %font1(".......MISSILES, INDIANA JONES", "orange")
    %font1("..................GRAPPLE BEAM", "orange")
    %font1(".........RESERVE TANK, NORFAIR", "orange")
    %font1("...MISSILES, NORFAIR RESERVE B", "orange")
    %font1("...MISSILES, NORFAIR RESERVE A", "orange")
    %font1(".....MISSILES, BUBBLE MOUNTAIN", "orange")
    %font1("...............MISSILES, SPEED", "orange")
    %font1(".................SPEED BOOSTER", "orange")
    %font1("................MISSILES, WAVE", "orange")
    %font1(".....................WAVE BEAM", "orange")
    %font1("..................MISSILES, GT", "orange")
    %font1("....................SUPERS, GT", "orange")
    %font1("........MISSILES, MICKEY MOUSE", "orange")
    %font1("................MISSILES, MAZE", "orange")
    %font1(".............POWER BOMBS, MAZE", "orange")
    %font1("............POWER BOMBS, SHAME", "orange")
    %font1("....MISSILES, THREE MUSKATEERS", "orange")
    %font1("...........ENERGY TANK, RIDLEY", "orange")
    %font1("..................SCREW ATTACK", "orange")
    %font1("........ENERGY TANK, FIREFLEAS", "orange")
    %font1("..............MISSILES, SPOOKY", "orange")
    %font1("....RESERVE TANK, WRECKED SHIP", "orange")
    %font1(".............MISSILES, BOWLING", "orange")
    %font1("...............MISSILES, ATTIC", "orange")
    %font1(".....ENERGY TANK, WRECKED SHIP", "orange")
    %font1("...............SUPERS, WS LEFT", "orange")
    %font1("..............SUPERS, WS RIGHT", "orange")
    %font1("..................GRAVITY SUIT", "orange")
    %font1("..........MISSILES, MAINSTREET", "orange")
    %font1("..................SUPERS, CRAB", "orange")
    %font1("......ENERGY TANK, MAMA TURTLE", "orange")
    %font1(".........MISSILES, MAMA TURTLE", "orange")
    %font1(".........SUPERS, WATERING HOLE", "orange")
    %font1(".......MISSILES, WATERING HOLE", "orange")
    %font1("...............MISSILES, BEACH", "orange")
    %font1("...................PLASMA BEAM", "orange")
    %font1(".......MISSILES, SAND PIT LEFT", "orange")
    %font1(".........RESERVE TANK, MARIDIA", "orange")
    %font1("......MISSILES, SAND PIT RIGHT", "orange")
    %font1("...POWER BOMBS, SAND PIT RIGHT", "orange")
    %font1("............MISSILES, AQUEDUCT", "orange")
    %font1("..............SUPERS, AQUEDUCT", "orange")
    %font1("...................SPRING BALL", "orange")
    %font1("............MISSILES, PRECIOUS", "orange")
    %font1("..........ENERGY TANK, BOTWOON", "orange")
    %font1("....................SPACE JUMP", "orange")
    %font1("...........VARIA SUIT, NORFAIR", "orange")
    %font1("......VARIA SUIT, WRECKED SHIP", "orange")
    %font1("...........VARIA SUIT, MARIDIA", "orange")
    %font1("..........SPACE JUMP, BRINSTAR", "orange")
    %font1("...........SPACE JUMP, NORFAIR", "orange")
    %font1("......SPACE JUMP, WRECKED SHIP", "orange")
    %font1(".........RIDLEY TANK, BRINSTAR", "orange")
    %font1(".....RIDLEY TANK, WRECKED SHIP", "orange")
    %font1("..........RIDLEY TANK, MARIDIA", "orange")
