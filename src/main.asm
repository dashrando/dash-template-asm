lorom

incsrc ram.asm
incsrc sram.asm
incsrc macros.asm
incsrc vanillalabels.asm
incsrc hooks.asm

org $DF8000 : fillbyte $00 : fill $7FFF ; Zero out the whole damb bank
;------------------------------------------------------------------------------
; The higher banks don't have access to mirrored work RAM so we prefer to put
; our code in the lower banks. Each bank is generally limited in concerns
; so we can fit most specific code in one or two. This module will leave
; the PC at empty space at the end of a vanilla bank. But any sub-module can
; place code within empty/unused portions in the middle or in another bank with
; pushpc and pullpc.
;------------------------------------------------------------------------------
org $80CD90
; TODO: I forgot what I was going to put here but we could initialize some system
; stuff, RAM, save stuff, game state etc here.
incsrc init.asm
warnpc $80FFC0 ; SNES ROM Header

org $82F900
incsrc fileselect.asm
warnpc $838000

org $84EFE0
incsrc newplms.asm
incsrc plminject.asm
warnpc $858000

org $859643
incsrc messageboxes.asm
warnpc $868000

org $8FEA00
incsrc doors.asm
warnpc $908000

org $90F63A
incsrc newitems.asm
incsrc suits.asm
warnpc $918000

org $DF8000
incsrc tables.asm
warnpc $E08000

; TODO: SPC stuff. I think we may not even need the "common" spc_play.asm

;incsrc debugmode.asm ; Commented out but can uncomment and insert whatever in
                      ; debugmode.asm for testing

