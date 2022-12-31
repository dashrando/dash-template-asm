lorom

incsrc ram.asm
incsrc sram.asm
incsrc macros.asm
incsrc vanillalabels.asm
incsrc hooks.asm
incsrc defines.asm

incsrc generalbugfixes.asm
incsrc roomedits.asm
;incsrc newhud.asm

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
incsrc init.asm
incsrc save.asm
incsrc framehook.asm
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

org $8BF760
incsrc credits/creditsscroll.asm
warnpc $8C8000

org $8FEA00
incsrc doors.asm
warnpc $908000

org $90F63A
incsrc newitems.asm
incsrc suits.asm
warnpc $918000

org $93F620
incsrc startercharge.asm
warnpc $948000

org $DF8000
incsrc tables.asm ; Keep this first
incsrc credits/credits.asm
warnpc $E08000

incsrc debugmode.asm ; Commented out but can uncomment and insert whatever in
                      ; debugmode.asm for testing

