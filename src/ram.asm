;------------------------------------------------------------------------------
; RAM Assignments & Labels
;------------------------------------------------------------------------------
; See PJ Boy's dissassembly for further documentation of these addresses.
;------------------------------------------------------------------------------
pushpc

;------------------------------------------------------------------------------
; Bank $7E
;------------------------------------------------------------------------------
; $7E0000-$7E1FFF is mirrored up to bank $C0.
;------------------------------------------------------------------------------
MultiplyResult = $7E002A             ; 32-bit DP scratch space. Used by vanilla for multiplication result.
NMICounter = $7E05B8                 ;
DoubleJumpFlag = $7E0A14             ; Zeroed when Samus lands. Unused(?) debug value.
RoomIndex = $7E079D                  ;
AreaIndex = $7E079F                  ;
SamusPose = $7E0A1C                  ;
DamageFlashCounter = $7E0A48         ; Samus hurt flash counter
SamusPaletteFlags = $7E0A4A          ; Super special Samus palette flags.
SamusSubDamage = $7E0A4C             ; Only affected by SamusPeriodicDamage.
SamusPeriodicSubDamage = $7E0A4E     ; Periodic subdamage (to Samus)
SamusPeriodicDamage = $7E0A50        ; Periodic damage (to Samus). Adjusted by suit divisors
SamusKnockbackDirection  =  $7E0A52  ; Knockback direction
TimeFrozenFlag = $7E0A78             ;
SamusAnimationFrame = $7E0A96         ;
LiquidPhysicsType = $7E0AD2          ; $00 = Air | $01 = Water | $02 = Lava/Acid
ProjectileTypes = $7E0C18            ; 10 bytes.
ProjectileDamage = $7E0C2C           ; 10 bytes.
EnemyRam = $7E8000                   ; $07FF bytes.
BigRAMBuffer = $7EF4A0               ; Unused to end of bank.
ItemPLMBuffer = $7EFB00

;------------------------------------------------------------------------------
; Bank $7F
;------------------------------------------------------------------------------

pullpc
