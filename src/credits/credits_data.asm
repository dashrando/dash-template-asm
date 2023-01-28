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
    %font2("                                ", "white")   ; 179 + 180
    %font2("      DASHRANDO.GITHUB.IO       ", "white")   ; 181 + 182
    %font1("      GAMEPLAY STATISTICS       ", "purple")  ; 183
    %font1("             DOORS              ", "orange")  ; 184
    %font2(" DOOR TRANSITIONS               ", "white")   ; 185 + 186
    %font2(" TIME IN DOORS      00'00'00^00 ", "white")   ; 187 + 188
    %font2(" ALIGNING DOORS     00'00'00^00 ", "white")   ; 189 + 190
    %font1("         TIME SPENT IN          ", "blue")    ; 191
    %font2(" CRATERIA           00'00'00^00 ", "white")   ; 192 + 193
    %font2(" GREEN BRINSTAR     00'00'00^00 ", "white")   ; 194 + 195
    %font2(" RED BRINSTAR       00'00'00^00 ", "white")   ; 196 + 197
    %font2(" WRECKED SHIP       00'00'00^00 ", "white")   ; 198 + 199
    %font2(" KRAID'S LAIR       00'00'00^00 ", "white")   ; 200 + 201
    %font2(" UPPER NORFAIR      00'00'00^00 ", "white")   ; 202 + 203
    %font2(" LOWER NORFAIR      00'00'00^00 ", "white")   ; 204 + 205
    %font2(" CROCOMIRE          00'00'00^00 ", "white")   ; 206 + 207
    %font2(" EAST MARIDIA       00'00'00^00 ", "white")   ; 208 + 209
    %font2(" WEST MARIDIA       00'00'00^00 ", "white")   ; 210 + 211
    %font2(" TOURIAN            00'00'00^00 ", "white")   ; 212 + 213
    %font1("      SHOTS AND AMMO FIRED      ", "green")   ; 214
    %font2(" CHARGED SHOTS                  ", "white")   ; 215 + 216
    %font2(" SPECIAL BEAM ATTACKS           ", "white")   ; 217 + 218
    %font2(" MISSILES                       ", "white")   ; 219 + 220
    %font2(" SUPER MISSILES                 ", "white")   ; 221 + 222
    %font2(" POWER BOMBS                    ", "white")   ; 223 + 224
    %font2(" BOMBS                          ", "white")   ; 225 + 226
    %font2(" MENU TIME          00'00'00^00 ", "white")   ; 227 + 228
    %font2(" LAG TIME           00'00'00^00 ", "white")   ; 229 + 230
    %font2(" FINAL TIME         00'00'00^00 ", "white")   ; 231 + 232
    %font2("       THANKS FOR PLAYING       ", "green")   ; 233 + 234
    dw $dead                                              ; End of credits tilemap

CreditsNumbersTop:
    dw $0060, $0061, $0062, $0063, $0064, $0065, $0066, $0067, $0068, $0069, $006a, $006b, $006c, $006d, $006e, $006f
CreditsNumbersBottom:
    dw $0070, $0071, $0072, $0073, $0074, $0075, $0076, $0077, $0078, $0079, $007a, $007b, $007c, $007d, $007e, $007f

