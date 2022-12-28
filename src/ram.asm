;------------------------------------------------------------------------------
; RAM Assignments & Labels
;------------------------------------------------------------------------------
; See PJ Boy's dissassembly for further documentation of these addresses.
;------------------------------------------------------------------------------
pushpc

MultiplyResult = $7E002A             ; 32-bit DP scratch space. Used by vanilla for multiplication result.
DoubleJumpFlag = $7E05C5             ; Zeroed when Samus lands. Unused(?) debug value.
SamusPose = $7E0A1C                  ;
DamageFlashCounter = $7E0A48         ; Samus hurt flash counter
SamusPaletteFlags = $7E0A4A          ; Super special Samus palette flags.
SamusSubDamage = $7E0A4C             ; Only affected by SamusPeriodicDamage.
SamusPeriodicSubDamage = $7E0A4E     ; Periodic subdamage (to Samus)
SamusPeriodicDamage = $7E0A50        ; Periodic damage (to Samus). Adjusted by suit divisors
SamusKnockbackDirection  =  $7E0A52  ; Knockback direction
TimeFrozenFlag = $7E0A78             ;
ItemPLMBuffer = $7FFB00

pullpc
