; Bank $80

; Defines for the script and credits data
!speed = $f770
!set = $9a17
!delay = $9a0d
!draw = $0000
!end = $f6fe, $99fe
!blank = $1fc0
!row = $0040

!last_saveslot = $7fffe0
!timer_backup1 = $7fffe2
!timer_backup2 = $7fffe4
!softreset = $7fffe6
!scroll_speed = $7fffe8

; Patch soft reset to save the value of the RTA timer
patch_reset1:
    lda !softreset ; Check if we're softresetting
    cmp #$babe
    beq save_timer
    lda #$babe
    sta !softreset
    lda #$0000
    sta !timer_backup1
    sta !timer_backup2
    sta !last_saveslot
    bra skipsave
save_timer:
    lda !timer1
    sta !timer_backup1
    lda !timer2
    sta !timer_backup2
skipsave:
    ldx #$1ffe
    lda #$0000
-
    stz $0000,x
    dex
    dex
    bpl -
    lda !timer_backup1
    sta !timer1
    lda !timer_backup2
    sta !timer2
    jml $808455

patch_reset2:
    lda !timer1
    sta !timer_backup1
    lda !timer2
    sta !timer_backup2
    ldx #$1ffe
-
    stz $0000,x
    stz $2000,x
    stz $4000,x
    stz $6000,x
    stz $8000,x
    stz $a000,x
    stz $c000,x
    stz $e000,x
    dex
    dex
    bpl -

    ldx #$00df          ; clear temp variables
    lda #$0000
-
    sta $7fff00,x
    dex
    dex
    bpl -

    lda !timer_backup1
    sta !timer1
    lda !timer_backup2
    sta !timer2
    jml $8084af


; Patch load and save routines
pushpc
org $81ef20
patch_save:
    lda !timer1
    sta $7ffc00
    lda !timer2
    sta $7ffc02
    jsl save_stats
    lda $7e0952
    clc
    adc #$0010
    sta !last_saveslot
    ply
    plx
    clc
    plb
    plp
    rtl

patch_load:
    lda $7e0952
    clc
    adc #$0010
    cmp !last_saveslot      ; If we're loading the same save that's played last
    beq +                   ; don't restore stats from SRAM, only do this if
    jsl load_stats          ; a new save slot is loaded, or loading from hard reset
    lda $7ffc00
    sta !timer1
    lda $7ffc02
    sta !timer2
+
    ply
    plx
    clc
    plb
    rtl
pullpc
