; ---------------------------------------------------------------------
; TITLE SCREEN/MAIN MENU
; The order of these needs to stay the same for the bosses known info to be correct.
; ---------------------------------------------------------------------

BossKnownTiles:
dw #$0074 ; K | $00
dw #$0079 ; P | $02
dw #$006D ; D | $04
dw #$007B ; R | $06

.areas:
dw #$0074 ; K | $08
dw #$007B ; R | $0A

dw #$0080 ; W | $0C
dw #$007C ; S | $0E

dw #$006E ; E | $10
dw #$0076 ; M | $12

dw #$0075 ; L | $14
dw #$0077 ; N | $16

; ---------------------------------------------------------------------
;  PAUSE MENU
;  Using Palette 6 ($38xx) for the text, and Palette 2 ($28xx) for the boarder tiles.
;  Tile Optional flips: | $4000 (H-Flip), | $8000 (V-Flip), | $C000 (Both)
; ---------------------------------------------------------------------

TopTextRow:
    dw $38BF                ; 'Corner boarder tile '
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $383B                ; 'L'
    dw $383E                ; 'O'
    dw $3832                ; 'C'
    dw $38A3                ; ':'
    dw $383A                ; 'K'
    dw $3841                ; 'R'
    dw $384E                ; ' '
    dw $3846                ; 'W'
    dw $3842                ; 'S'
    dw $384E                ; ' '  
    dw $3834                ; 'E'
    dw $383C                ; 'M'
    dw $384E                ; ' '
    dw $383B                ; 'L'
    dw $383D                ; 'N'
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $38BF|$4000          ; 'Mirrored corner tile'
    dw $FFFF                ; End-of-string marker
    
MiddleTextRow:
    dw $38CF                ; 'vertical boarder line'
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $3831                ; 'B'
    dw $383E                ; 'O'
    dw $3842                ; 'S'
    dw $3842                ; 'S'
    dw $38A3                ; ':'
    dw $0000                ; Loop identifier for grabbing random boss letter.
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $0000                ; Loop identifier for grabbing random boss letter.
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $0000                ; Loop identifier for grabbing random boss letter.
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $0000                ; Loop identifier for grabbing random boss letter.
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $38CF|$4000          ; 'mirrored vertical boarder line'   
    dw $FFFF                ; End-of-string marker

BottomTextRow:
    dw $38CF                ; 'vertical boarder line'
    dw $384E                ; ' '
    dw $383E                ; 'O'
    dw $383F                ; 'P'
    dw $3834                ; 'E'
    dw $383D                ; 'N'    
    dw $3842                ; 'S'
    dw $38A3                ; ':'
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $384E                ; ' '
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $384E                ; ' '
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $384E                ; ' '
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $0000                ; Loop identifier for grabbing random location letters.
    dw $384E                ; ' '
    dw $384E                ; ' '
    dw $28CF|$4000          ; 'mirrored vertical boarder line'         
    dw $FFFF                ; End-of-string marker