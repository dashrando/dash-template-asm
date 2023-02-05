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
    %font2("    RUMBLEMINZE    ZEB316       ", "white")   ; 134 + 135
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
    %font2("            TRACIEM             ", "white")   ; 160 + 161
    %font2("    OSSE101        SLOATERS27   ", "white")   ; 162 + 163
    %font1("      METROID CONSTRUCTION      ", "yellow")  ; 164
    %font2("    METROIDCONSTRUCTION.COM     ", "white")   ; 165 + 166
    %font1("  SUPER METROID SRL COMMUNITY   ", "yellow")  ; 167
    %font2("      DASHRANDO.GITHUB.IO       ", "white")   ; 168 + 169
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
    %font2("             TGDERP             ", "white")   ; 226 + 227
    %font1("      ORIGINAL RANDOMIZER       ", "yellow")  ; 228
    dw $dead                                              ; End of credits tilemap

CreditsNumbersTop:
    dw $0060, $0061, $0062, $0063, $0064, $0065, $0066, $0067, $0068, $0069, $006a, $006b, $006c, $006d, $006e, $006f
CreditsNumbersBottom:
    dw $0070, $0071, $0072, $0073, $0074, $0075, $0076, $0077, $0078, $0079, $007a, $007b, $007c, $007d, $007e, $007f

