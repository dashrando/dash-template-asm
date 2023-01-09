
; -------------------------------
; HIJACKS
; -------------------------------


; -------------------------------
; FUNCTIONS
; -------------------------------



; -------------------------------
; CODE (using bank A1 free space)
; -------------------------------
org $a1ec00
; Helper function to add a time delta, X = stat to add to, A = value to check against
; This uses 4-bytes for each time delta
add_time: {
  sta !add_time_tmp
  lda !timer1
  sec
  sbc !add_time_tmp
  sta !add_time_tmp
  txa
  jsl load_stat
  clc
  adc !add_time_tmp
  bcc +
  jsl store_stat    ; If carry set, increase the high bits
  inx
  txa
  jsl inc_stat : +
  jsl store_stat
  rts
}




